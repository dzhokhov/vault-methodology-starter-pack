#!/usr/bin/env python3
"""Check local Markdown links inside a vault-like folder."""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path


LINK_RE = re.compile(r"\[[^\]]+\]\(([^)]+\.md(?:#[^)]+)?)\)")
IGNORED_TARGETS = {
    "./relative-path.md",
    "./abs-path-to-SKILL.md",
}


def iter_markdown_files(root: Path):
    for path in root.rglob("*.md"):
        if ".git" in path.parts:
            continue
        yield path


def should_ignore(path: Path, target: str) -> bool:
    if "meta/templates" in path.as_posix():
        return True
    if target.startswith(("http://", "https://", "mailto:")):
        return True
    if "<" in target or "..." in target:
        return True
    if target in IGNORED_TARGETS:
        return True
    return False


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("root", nargs="?", default=".", help="Vault root, default: current directory")
    args = parser.parse_args()

    root = Path(args.root).resolve()
    broken: list[tuple[Path, str]] = []

    for path in iter_markdown_files(root):
        text = path.read_text(encoding="utf-8", errors="ignore")
        for match in LINK_RE.finditer(text):
            target = match.group(1).split("#", 1)[0]
            if should_ignore(path, target):
                continue
            resolved = (path.parent / target).resolve()
            try:
                resolved.relative_to(root)
            except ValueError:
                continue
            if not resolved.exists():
                broken.append((path.relative_to(root), target))

    if broken:
        print(f"BROKEN_LINKS {len(broken)}")
        for path, target in broken:
            print(f"{path} -> {target}")
        return 1

    print("OK links")
    return 0


if __name__ == "__main__":
    sys.exit(main())
