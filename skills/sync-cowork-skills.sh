#!/usr/bin/env bash
# Synchronize bundled vault skills with Claude/Cowork skill locations.
#
# This script does not create files inside the vault. It creates or updates:
# - symlinks in ~/.claude/skills for host-side Claude tools;
# - physical copies in the Claude Desktop local-agent skills cache for Cowork.
#
# Usage:
#   ./skills/sync-cowork-skills.sh
#   ./skills/sync-cowork-skills.sh --dry-run
#   ./skills/sync-cowork-skills.sh --status
#   ./skills/sync-cowork-skills.sh --budget
#
# Optional configuration:
#   VAULT_SKILLS_DIR=/path/to/vault/skills
#   CLAUDE_SKILLS_DIR="$HOME/.claude/skills"
#   COWORK_SKILLS_PLUGIN_ROOT="$HOME/Library/Application Support/Claude/local-agent-mode-sessions/skills-plugin"
#   COWORK_SKILLS="research parking resume"

set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VAULT_ROOT="${VAULT_ROOT:-$(cd "$SCRIPT_DIR/.." && pwd)}"
VAULT_SKILLS_DIR="${VAULT_SKILLS_DIR:-$VAULT_ROOT/skills}"
CLAUDE_SKILLS_DIR="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"
COWORK_SKILLS_PLUGIN_ROOT="${COWORK_SKILLS_PLUGIN_ROOT:-$HOME/Library/Application Support/Claude/local-agent-mode-sessions/skills-plugin}"
DESCRIPTION_BUDGET="${DESCRIPTION_BUDGET:-16000}"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { printf "%bINFO%b %s\n" "$BLUE" "$NC" "$1"; }
log_ok() { printf "%bOK%b   %s\n" "$GREEN" "$NC" "$1"; }
log_warn() { printf "%bWARN%b %s\n" "$YELLOW" "$NC" "$1"; }
log_error() { printf "%bERR%b  %s\n" "$RED" "$NC" "$1"; }

split_configured_skills() {
    printf "%s\n" "$COWORK_SKILLS" | tr ',' ' ' | tr ' ' '\n' | awk 'NF'
}

discover_vault_skills() {
    find "$VAULT_SKILLS_DIR" -mindepth 2 -maxdepth 2 -name SKILL.md -type f \
        -exec dirname {} \; | xargs -n 1 basename | sort
}

load_include_skills() {
    if [ -n "${COWORK_SKILLS:-}" ]; then
        split_configured_skills
    else
        discover_vault_skills
    fi
}

is_in_include_list() {
    local name="$1"
    local skill
    for skill in "${INCLUDE_SKILLS[@]}"; do
        if [ "$name" = "$skill" ]; then
            return 0
        fi
    done
    return 1
}

discover_cowork_skill_dirs() {
    if [ ! -d "$COWORK_SKILLS_PLUGIN_ROOT" ]; then
        return 0
    fi
    find "$COWORK_SKILLS_PLUGIN_ROOT" -mindepth 3 -maxdepth 3 -type d -name skills 2>/dev/null
}

check_prerequisites() {
    if [ ! -d "$VAULT_SKILLS_DIR" ]; then
        log_error "Skills directory not found: $VAULT_SKILLS_DIR"
        exit 1
    fi
    if ! command -v rsync >/dev/null 2>&1; then
        log_error "rsync is required"
        exit 1
    fi
}

status_symlink_dir() {
    local label="$1"
    local target_dir="$2"
    local synced=0 stale=0 missing=0

    echo ""
    echo "=== Status: vault -> $label ==="
    echo "$target_dir"
    echo ""

    if [ ! -d "$target_dir" ]; then
        log_info "Directory not found"
        return
    fi

    local skill vault_path target_path target
    for skill in "${INCLUDE_SKILLS[@]}"; do
        vault_path="$VAULT_SKILLS_DIR/$skill"
        target_path="$target_dir/$skill"

        if [ ! -d "$vault_path" ]; then
            log_warn "$skill is not present in the vault"
            missing=$((missing + 1))
        elif [ -L "$target_path" ]; then
            target="$(readlink "$target_path")"
            if [ "$target" = "$vault_path" ]; then
                log_ok "$skill symlink"
                synced=$((synced + 1))
            else
                log_warn "$skill symlink points to $target"
                stale=$((stale + 1))
            fi
        elif [ -e "$target_path" ]; then
            log_warn "$skill exists but is not a symlink"
            stale=$((stale + 1))
        else
            log_info "$skill is not synchronized"
            missing=$((missing + 1))
        fi
    done

    echo ""
    echo "Summary: $synced synced, $stale stale, $missing missing"
}

status_copy_dir() {
    local label="$1"
    local target_dir="$2"
    local synced=0 stale=0 missing=0

    echo ""
    echo "=== Status: vault -> $label ==="
    echo "$target_dir"
    echo ""

    if [ ! -d "$target_dir" ]; then
        log_info "Directory not found"
        return
    fi

    local skill vault_path target_path target
    for skill in "${INCLUDE_SKILLS[@]}"; do
        vault_path="$VAULT_SKILLS_DIR/$skill"
        target_path="$target_dir/$skill"

        if [ ! -d "$vault_path" ]; then
            log_warn "$skill is not present in the vault"
            missing=$((missing + 1))
        elif [ -L "$target_path" ]; then
            target="$(readlink "$target_path")"
            log_warn "$skill is a symlink to $target; Cowork needs a physical copy"
            stale=$((stale + 1))
        elif [ -d "$target_path" ]; then
            if diff -qr -x .DS_Store "$vault_path" "$target_path" >/dev/null; then
                log_ok "$skill copy"
                synced=$((synced + 1))
            else
                log_warn "$skill copy differs"
                stale=$((stale + 1))
            fi
        elif [ -e "$target_path" ]; then
            log_warn "$skill exists but is not a directory"
            stale=$((stale + 1))
        else
            log_info "$skill is not synchronized"
            missing=$((missing + 1))
        fi
    done

    echo ""
    echo "Summary: $synced synced, $stale stale, $missing missing"
}

sync_symlink_dir() {
    local label="$1"
    local target_dir="$2"
    local dry_run="${3:-false}"
    local created=0 updated=0 removed=0 skipped=0

    echo ""
    if [ "$dry_run" = true ]; then
        echo "=== DRY RUN: vault -> $label ==="
    else
        echo "=== Sync: vault -> $label ==="
    fi
    echo "$target_dir"
    echo ""

    if [ ! -d "$target_dir" ]; then
        if [ "$dry_run" = true ]; then
            log_info "Would create directory: $target_dir"
        else
            mkdir -p "$target_dir"
            log_ok "Created directory: $target_dir"
        fi
    fi

    local skill vault_path target_path target entry name
    for skill in "${INCLUDE_SKILLS[@]}"; do
        vault_path="$VAULT_SKILLS_DIR/$skill"
        target_path="$target_dir/$skill"

        if [ ! -f "$vault_path/SKILL.md" ]; then
            log_warn "$skill has no SKILL.md; skipped"
            skipped=$((skipped + 1))
            continue
        fi

        if [ -L "$target_path" ]; then
            target="$(readlink "$target_path")"
            if [ "$target" = "$vault_path" ]; then
                skipped=$((skipped + 1))
                continue
            fi
            if [ "$dry_run" = true ]; then
                log_info "Would update symlink: $skill -> $vault_path"
            else
                rm "$target_path"
                ln -s "$vault_path" "$target_path"
                log_ok "Updated symlink: $skill"
            fi
            updated=$((updated + 1))
        elif [ -e "$target_path" ]; then
            if [ "$dry_run" = true ]; then
                log_info "Would replace existing path with symlink: $skill"
            else
                rm -rf "$target_path"
                ln -s "$vault_path" "$target_path"
                log_ok "Replaced with symlink: $skill"
            fi
            updated=$((updated + 1))
        else
            if [ "$dry_run" = true ]; then
                log_info "Would create symlink: $skill -> $vault_path"
            else
                ln -s "$vault_path" "$target_path"
                log_ok "Created symlink: $skill"
            fi
            created=$((created + 1))
        fi
    done

    for entry in "$target_dir"/*; do
        [ -e "$entry" ] || continue
        [ -L "$entry" ] || continue
        name="$(basename "$entry")"
        is_in_include_list "$name" && continue
        target="$(readlink "$entry")"
        case "$target" in
            "$VAULT_SKILLS_DIR"/*)
                if [ "$dry_run" = true ]; then
                    log_info "Would remove orphan symlink: $name"
                else
                    rm "$entry"
                    log_ok "Removed orphan symlink: $name"
                fi
                removed=$((removed + 1))
                ;;
        esac
    done

    echo ""
    echo "Summary: $created created, $updated updated, $removed removed, $skipped skipped"
}

sync_copy_dir() {
    local label="$1"
    local target_dir="$2"
    local dry_run="${3:-false}"
    local created=0 updated=0 skipped=0

    echo ""
    if [ "$dry_run" = true ]; then
        echo "=== DRY RUN: rsync vault -> $label ==="
    else
        echo "=== Rsync: vault -> $label ==="
    fi
    echo "$target_dir"
    echo ""

    if [ ! -d "$target_dir" ]; then
        if [ "$dry_run" = true ]; then
            log_info "Would create directory: $target_dir"
        else
            mkdir -p "$target_dir"
            log_ok "Created directory: $target_dir"
        fi
    fi

    local skill vault_path target_path
    for skill in "${INCLUDE_SKILLS[@]}"; do
        vault_path="$VAULT_SKILLS_DIR/$skill"
        target_path="$target_dir/$skill"

        if [ ! -f "$vault_path/SKILL.md" ]; then
            log_warn "$skill has no SKILL.md; skipped"
            skipped=$((skipped + 1))
            continue
        fi

        if [ -L "$target_path" ]; then
            if [ "$dry_run" = true ]; then
                log_info "Would replace symlink with copy: $skill"
            else
                rm "$target_path"
                mkdir -p "$target_path"
                rsync -a --delete --exclude .DS_Store "$vault_path/" "$target_path/"
                log_ok "Replaced symlink with copy: $skill"
            fi
            updated=$((updated + 1))
        elif [ -d "$target_path" ]; then
            if diff -qr -x .DS_Store "$vault_path" "$target_path" >/dev/null; then
                skipped=$((skipped + 1))
                continue
            fi
            if [ "$dry_run" = true ]; then
                log_info "Would update copy: $skill"
            else
                rsync -a --delete --exclude .DS_Store "$vault_path/" "$target_path/"
                log_ok "Updated copy: $skill"
            fi
            updated=$((updated + 1))
        elif [ -e "$target_path" ]; then
            if [ "$dry_run" = true ]; then
                log_info "Would replace existing path with copy: $skill"
            else
                rm -rf "$target_path"
                mkdir -p "$target_path"
                rsync -a --delete --exclude .DS_Store "$vault_path/" "$target_path/"
                log_ok "Replaced existing path with copy: $skill"
            fi
            updated=$((updated + 1))
        else
            if [ "$dry_run" = true ]; then
                log_info "Would create copy: $skill"
            else
                mkdir -p "$target_path"
                rsync -a --delete --exclude .DS_Store "$vault_path/" "$target_path/"
                log_ok "Created copy: $skill"
            fi
            created=$((created + 1))
        fi
    done

    echo ""
    echo "Summary: $created created, $updated updated, $skipped skipped"
}

description_length() {
    local skill_dir="$1"
    local skill_md="$skill_dir/SKILL.md"

    if [ ! -f "$skill_md" ]; then
        echo 0
        return
    fi

    awk '
        /^---$/ { fm++; next }
        fm == 1 && in_description && /^[[:space:]]+/ {
            sub(/^[[:space:]]+/, "")
            printf "%s ", $0
            next
        }
        fm == 1 && in_description { exit }
        fm == 1 && /^description:[[:space:]]*[>|]/ {
            in_description=1
            next
        }
        fm == 1 && /^description:/ {
            sub(/^description:[[:space:]]*/, "")
            gsub(/^"/, "")
            gsub(/"$/, "")
            print
            exit
        }
        fm > 1 { exit }
    ' "$skill_md" | wc -c | tr -d ' '
}

cmd_status() {
    status_symlink_dir "~/.claude/skills" "$CLAUDE_SKILLS_DIR"

    local found=false
    local dir
    while IFS= read -r dir; do
        found=true
        status_copy_dir "Claude Desktop Cowork skills cache" "$dir"
    done < <(discover_cowork_skill_dirs)

    if [ "$found" = false ]; then
        echo ""
        log_info "Cowork skills cache not found under: $COWORK_SKILLS_PLUGIN_ROOT"
    fi
}

cmd_budget() {
    local total=0
    local skill len

    echo ""
    echo "=== Skill description budget: $DESCRIPTION_BUDGET chars ==="
    echo ""

    for skill in "${INCLUDE_SKILLS[@]}"; do
        len="$(description_length "$VAULT_SKILLS_DIR/$skill")"
        total=$((total + len))
        printf "  %-36s %5d chars\n" "$skill" "$len"
    done

    echo ""
    if [ "$total" -le "$DESCRIPTION_BUDGET" ]; then
        log_ok "Total: $total / $DESCRIPTION_BUDGET chars"
    else
        log_error "Budget exceeded: $total / $DESCRIPTION_BUDGET chars"
        exit 1
    fi
}

cmd_sync() {
    local dry_run="${1:-false}"
    sync_symlink_dir "~/.claude/skills" "$CLAUDE_SKILLS_DIR" "$dry_run"

    local found=false
    local dir
    while IFS= read -r dir; do
        found=true
        sync_copy_dir "Claude Desktop Cowork skills cache" "$dir" "$dry_run"
    done < <(discover_cowork_skill_dirs)

    if [ "$found" = false ]; then
        echo ""
        log_info "Cowork skills cache not found under: $COWORK_SKILLS_PLUGIN_ROOT"
        log_info "Open a Cowork session first, then run this script again if cache copies are needed."
    fi
}

cmd_list() {
    printf "%s\n" "${INCLUDE_SKILLS[@]}"
}

usage() {
    cat <<'EOF'
Usage: ./skills/sync-cowork-skills.sh [--dry-run|--status|--budget|--list|--help]

Commands:
  no flag    Synchronize skills
  --dry-run  Show planned changes
  --status   Show current sync state
  --budget   Check total description budget
  --list     Print included skills
  --help     Show this help

By default the script includes every bundled skill with a SKILL.md file.
To restrict the list:

  COWORK_SKILLS="research parking resume" ./skills/sync-cowork-skills.sh
EOF
}

check_prerequisites
INCLUDE_SKILLS=()
while IFS= read -r skill_name; do
    [ -n "$skill_name" ] || continue
    INCLUDE_SKILLS+=("$skill_name")
done <<EOF
$(load_include_skills)
EOF

case "${1:-}" in
    "")
        cmd_sync false
        ;;
    --dry-run)
        cmd_sync true
        ;;
    --status)
        cmd_status
        ;;
    --budget)
        cmd_budget
        ;;
    --list)
        cmd_list
        ;;
    --help|-h)
        usage
        ;;
    *)
        log_error "Unknown flag: $1"
        usage
        exit 1
        ;;
esac
