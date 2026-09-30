#!/usr/bin/env python3
"""Extend the returned exact exceptional-component calculation.

Use a generated full-verification workspace of degree140_residual_square_partial.
Only cases whose displayed cubic and quadratic split in its exact K are accepted
by the retained reconstruction. Every interpolation, Bezout identity and finite
exception must pass. This never substitutes a finite point search for emptiness.
All generated evidence remains outside the research source workspace.
"""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import time


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('workspace', type=Path)
    ap.add_argument('--case', type=int, required=True)
    args = ap.parse_args()
    work = args.workspace.resolve()
    if 'litt3-computation-data' not in work.parts:
        raise ValueError('Generated evidence must be in the computation-data tree.')
    for name in ('prepare_parametric.py', 'residual', 'extract_parametric.py',
                 'parametric_eval', 'interpolate', 'check_big.py',
                 'close_exceptional.py'):
        if not (work / 'src' / name).is_file():
            raise FileNotFoundError(name)
    records = []

    def run(cmd):
        start = time.monotonic()
        print('$ ' + ' '.join(map(str, cmd)), flush=True)
        subprocess.run(list(map(str, cmd)), cwd=work, check=True)
        records.append({'command': list(map(str, cmd)), 'exit_code': 0,
                        'seconds': round(time.monotonic() - start, 3)})

    i = args.case
    for sign in (0, 1):
        name = f'exceptional_param_{i}_{sign}'
        run([sys.executable, '-B', work/'src/prepare_parametric.py', i, sign])
        run([work/'src/residual', work/'data', work/'data'/f'{name}.txt',
             work/'data'/f'{name}.json'])
        run([sys.executable, '-B', work/'src/extract_parametric.py', name])
        prefix = work/'data'/f'parametric_values_{i}_{sign}'
        run([work/'src/parametric_eval', work/'data',
             work/'data'/f'{name}_coeffs.txt', 48828, prefix])
        run([work/'src/interpolate', work/'data', prefix.with_suffix('.bin'),
             48828, 384425, work/'certificates'/f'exceptional_branch_{i}_{sign}.json'])
        run([sys.executable, '-B', work/'src/check_big.py', i, sign])
        run([sys.executable, '-B', work/'src/close_exceptional.py', i, sign])
    closure_paths = [work/'certificates'/f'exceptional_closure_{i}_{s}.json' for s in (0,1)]
    closures = [json.loads(p.read_text()) for p in closure_paths]
    assert all(c['status'] == 'complete_exclusion_on_this_exceptional_H_branch_for_all_nonzero_R_and_lambda' for c in closures)
    out = {'status': 'complete_exceptional_exclusion_for_one_fixed_v',
           'case': i, 'root': closures[0]['root'],
           'geometric_components_excluded': 6,
           'unrestricted_parameters': ['kappa != 0', 'F6 != 0'],
           'not_claimed': 'Other exceptional components, generic pivot charts or an actual-cover decision.',
           'commands': records,
           'closure_sha256': {p.name: hashlib.sha256(p.read_bytes()).hexdigest() for p in closure_paths}}
    (work/'certificates'/f'local_extension_case_{i}.json').write_text(json.dumps(out, indent=2)+'\n')
    print('PASS: two full H branches, hence all six geometric exceptional components for this fixed v.', flush=True)


if __name__ == '__main__':
    main()
