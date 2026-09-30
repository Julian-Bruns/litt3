#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
# Atomic replacement avoids changing a library mapped by another verifier.
build_shared() {
  local source="$1" output="$2"; shift 2
  local temporary="${output}.$$.tmp"
  g++ -O3 -std=c++17 -shared -fPIC "$source" "$@" -o "$temporary"
  mv "$temporary" "$output"
}
build_shared src/field.cpp src/field.so
build_shared src/global_interpolate.cpp src/global_interpolate.so
build_shared src/fast_poly.cpp src/fast_poly.so
build_shared src/fast_tails.cpp src/fast_tails.so
build_shared src/gmp_poly.cpp src/gmp_arith.so -lgmp
