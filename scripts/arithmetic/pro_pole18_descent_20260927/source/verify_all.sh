#!/usr/bin/env bash
# Complete retained-evidence check; --main-only omits the independent pole-support certificate.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
if [[ "${1:-}" != "" && "${1:-}" != "--main-only" ]]; then
  echo 'Usage: bash source/verify_all.sh [--main-only]' >&2
  exit 2
fi
sha256sum -c SHA256SUMS
python3 --version
"${CXX:-g++}" --version | head -1
python3 source/verify.py
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
"${CXX:-g++}" -O3 -std=c++17 source/phase_sums.cpp -o "$TMP/phase_sums"
"$TMP/phase_sums"
if [[ "${1:-}" != "--main-only" ]]; then
  "${CXX:-g++}" -O3 -std=c++17 -fopenmp source/pole_support.cpp -o "$TMP/pole_support"
  OMP_NUM_THREADS=4 "$TMP/pole_support" 3 9
fi
echo 'ALL REQUESTED VERIFICATION COMMANDS PASSED'
