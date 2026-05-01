#!/usr/bin/env python3
"""Print a compact inventory for a vault-like folder."""

from __future__ import annotations

import argparse
from pathlib import Path


SKIP_PARTS = {".git", "__pycache__"}


def human_size(size: int) -> str:
    units = ["B", "KB", "MB", "GB"]
    value = float(size)
    for unit in units:
        if value < 1024 or unit == units[-1]:
            if unit == "B":
                return f"{int(value)} {unit}"
            return f"{value:.1f} {unit}"
        value /= 1024
    return f"{size} B"


def iter_files(root: Path):
    for path in root.rglob("*"):
        if not path.is_file():
            continue
        if any(part in SKIP_PARTS for part in path.parts):
            continue
        yield path


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("root", nargs="?", default=".", help="Vault root, default: current directory")
    args = parser.parse_args()

    root = Path(args.root).resolve()
    files = list(iter_files(root))
    total_size = sum(path.stat().st_size for path in files)

    print(f"root: {root}")
    print(f"files: {len(files)}")
    print(f"size: {human_size(total_size)}")
    print("top-level:")
    for child in sorted(root.iterdir()):
        if child.name.startswith("."):
            continue
        kind = "dir" if child.is_dir() else "file"
        print(f"- {child.name} ({kind})")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
