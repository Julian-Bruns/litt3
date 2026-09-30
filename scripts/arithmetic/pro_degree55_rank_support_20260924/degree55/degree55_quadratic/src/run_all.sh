#!/usr/bin/env bash
# Run both implementations without changing the pinned archive files.
set -euo pipefail
root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
work="$(mktemp -d)"
trap 'rm -rf -- "$work"' EXIT
mkdir "$work/certificates"
"${CXX:-g++}" -O2 -std=c++17 -Wall -Wextra -Werror -pedantic \
  "$root/src/explore.cpp" -o "$work/secondary"
(cd "$work" && ./secondary 12)
cmp "$work/certificates/exploration.json" "$root/certificates/exploration.json"
printf '%s\n' 'PASS: secondary certificate reproduced byte for byte'
"${PYTHON:-python3}" "$root/src/verify.py"
