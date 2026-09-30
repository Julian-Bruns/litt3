#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd -- "$(dirname -- "$0")/.." && pwd)"
cd "$ROOT"
BUILD="$(mktemp -d)"
trap 'rm -rf "$BUILD"' EXIT
CXX="${CXX:-g++}"
PYTHON="${PYTHON:-python3}"
for program in reconstruct chart fibers; do
    printf '\n=== %s ===\n' "$program"
    "$CXX" -O3 -std=c++17 "src/$program.cpp" -o "$BUILD/$program"
    "$BUILD/$program"
done
printf '\n=== independent Python verification ===\n'
"$PYTHON" src/verify_evidence.py
printf '\nAll implemented checks passed. The global decision remains UNRESOLVED.\n'
