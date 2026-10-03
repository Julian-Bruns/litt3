#!/usr/bin/env bash
# Retained curve/auxiliary checks; --main-only omits the separate pole-support diagnostic.
set -euo pipefail
SOURCE="$(cd "$(dirname "$0")" && pwd)"
WORKSPACE="$(cd "$SOURCE/../../../.." && pwd)"
ROOT="$WORKSPACE/../litt3-computation-data/pole18_descent_reply_20260927/extracted/pole18_descent"
if [[ "${1:-}" != "" && "${1:-}" != "--main-only" ]]; then
  echo 'Usage: bash verify_all.sh [--main-only]' >&2
  exit 2
fi
cd "$ROOT"
sha256sum -c SHA256SUMS
python3 --version
python3 "$SOURCE/verify.py"
if [[ "${1:-}" != "--main-only" ]]; then
  "${CXX:-g++}" --version | head -1
  TMP="$(mktemp -d)"
  trap 'rm -rf "$TMP"' EXIT
  "${CXX:-g++}" -O3 -std=c++17 -fopenmp "$SOURCE/pole_support.cpp" -o "$TMP/pole_support"
  OMP_NUM_THREADS="${OMP_NUM_THREADS:-2}" "$TMP/pole_support" 3 9
fi
echo 'ALL REQUESTED RETAINED CHECKS PASSED'
