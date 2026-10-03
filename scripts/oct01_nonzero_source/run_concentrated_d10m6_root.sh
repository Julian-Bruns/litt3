#!/bin/bash
# Sequential one-core whole-slope certificate pipeline; no concurrent jobs.
set -eu
export OMP_NUM_THREADS=1 OPENBLAS_NUM_THREADS=1 VECLIB_MAXIMUM_THREADS=1
task_work=$1
task_root=$2
task_start=${3:-1}
task_wait_pid=${4:-0}
task_data="$task_work/data"
task_native="$task_data/native_uncleared_module_$task_root"
if [ "$task_wait_pid" != 0 ]; then
  while kill -0 "$task_wait_pid" 2>/dev/null; do sleep 2; done
fi
if [ "$task_start" -le 1 ]; then
  printf 'ROOT %s STAGE fixed_twist\n' "$task_root"
  python3 scripts/oct01_nonzero_source/twisted_concentrated_setup.py --work "$task_work" --root "$task_root" > "$task_data/twisted_concentrated_setup_$task_root.log" 2>&1
fi
if [ "$task_start" -le 2 ]; then
  printf 'ROOT %s STAGE source_auxiliary\n' "$task_root"
  sage scripts/oct01_nonzero_source/twisted_d10m6_incidence_setup.sage --work "$task_work" --root "$task_root" > "$task_data/twisted_d10m6_incidence_setup_$task_root.log" 2>&1
fi
if [ "$task_start" -le 3 ]; then
  printf 'ROOT %s STAGE global_top_kernel\n' "$task_root"
  sage scripts/oct01_nonzero_source/twisted_d10m6_global_top_kernel.sage --work "$task_work" --root "$task_root" > "$task_data/twisted_d10m6_global_top_kernel_$task_root.log" 2>&1
fi
if [ "$task_start" -le 4 ]; then
  printf 'ROOT %s STAGE uncleared_matrix\n' "$task_root"
  sage scripts/oct01_nonzero_source/twisted_d10m6_incidence_matrix.sage --work "$task_work" --root "$task_root" --compact-only --uncleared-auxiliary > "$task_data/twisted_d10m6_uncleared_matrix_$task_root.log" 2>&1
fi
if [ "$task_start" -le 5 ]; then
  printf 'ROOT %s STAGE independent_columns\n' "$task_root"
  sage scripts/oct01_nonzero_source/verify_twisted_d10m6_uncleared_compact.sage --work "$task_work" --root "$task_root" > "$task_data/twisted_d10m6_uncleared_verification_$task_root.log" 2>&1
fi
if [ "$task_start" -le 6 ]; then
  printf 'ROOT %s STAGE native_export\n' "$task_root"
  sage scripts/oct01_nonzero_source/export_native_d10m6_module.sage --work "$task_work" --root "$task_root" --uncleared-auxiliary > "$task_data/native_uncleared_module_export_$task_root.log" 2>&1
fi
if [ "$task_start" -le 7 ]; then
  printf 'ROOT %s STAGE native_exact_module\n' "$task_root"
  cp scripts/oct01_nonzero_source/native_d10m6_module.cpp "$task_native/native_source.cpp"
  clang++ -std=c++17 -O3 -DAUXILIARIES=15 scripts/oct01_nonzero_source/native_d10m6_module.cpp -o "$task_native/native_module"
  "$task_native/native_module" "$task_native" 1800 35 > "$task_native/run.log" 2>&1
fi
if [ "$task_start" -le 8 ]; then
  printf 'ROOT %s STAGE exact_targets\n' "$task_root"
  python3 scripts/oct01_nonzero_source/extract_native_module_certificate.py "$task_native" > "$task_native/extract.log" 2>&1
  sage scripts/oct01_nonzero_source/verify_native_module_targets.sage "$task_native" > "$task_native/independent_ntl_verification.log" 2>&1
fi
printf 'ROOT %s COMPLETE\n' "$task_root"
