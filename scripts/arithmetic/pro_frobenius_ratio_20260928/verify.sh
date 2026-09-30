#!/usr/bin/env bash
# Full verification from a fresh extraction needs no excluded intermediate.
# The 625 coset files are restartable only with identical retained inputs.
set -euo pipefail
cd "$(dirname "$0")"
export OPENBLAS_NUM_THREADS=1
export PYTHONPATH=src
bash build.sh
python3 src/verify_all.py
python3 src/verify_a1.py
python3 src/check_endpoint_model.py --verify
python3 src/check_jet.py
python3 src/check_five.py
python3 src/verify_slopes.py
python3 src/check_scale_model.py
python3 src/check_fast_algorithms.py
# Regenerates and verifies the whole-curve model at all 625 defining nodes.
python3 src/check_global_zero.py
python3 src/check_resultant_bounds.py
python3 src/slope_companions.py --verify
python3 src/check_resultant_engine.py
python3 src/check_gmp_poly.py
python3 src/compute_resultant_samples.py --workers "${WORKERS:-4}"
python3 src/reconstruct_resultants.py
# This checks the retained Bezout witness; it does not rerun extended gcd.
python3 src/check_global_resultant_certificate.py
printf '%s\n' 'COMPLETE_ORIGINAL_ORDINARY_DOUBLE_ROOT_SQUARE_IDEAL_IS_UNIT'
