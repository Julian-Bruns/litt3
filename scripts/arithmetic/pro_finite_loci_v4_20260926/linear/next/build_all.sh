#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p build
for name in fibre_equations fibre_resultants res_strip fibre_gcd gcd_analyze quotient_fibre verify_certificates fast_dft_test fast_poly_test fast_poly_edge_test resultant_test; do
  g++ -std=c++17 -O3 -pthread "next/$name.cpp" -o "build/$name"
done
