"""Replay the exact ratio-annihilator continuation from a clean extraction.

The default includes the inherited suite. --new-only replays only the new
normalization/circuit/independent-source checks. --full-prefix additionally
regenerates the inherited 1375 complete-algebra prefix samples.
No test here decides the common determinant-zero square scheme.
"""
from pathlib import Path
import argparse
import json
import subprocess
import sys
import time

ROOT = Path(__file__).resolve().parent.parent
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--new-only', action='store_true')
parser.add_argument('--full-prefix', action='store_true')
args = parser.parse_args()
if args.new_only and args.full_prefix:
    parser.error('--full-prefix requires the inherited suite; omit --new-only')

commands = [['g++', '-O3', '-std=c++17', '-fPIC', '-shared',
             'src/field.cpp', '-o', 'src/libfield.so']]
if not args.new_only:
    inherited = [sys.executable, 'src/verify_differential_continuation.py']
    if args.full_prefix:
        inherited.append('--full-prefix')
    commands.append(inherited)
commands += [
    [sys.executable, 'src/ratio_eliminant_data.py', '--verify'],
    [sys.executable, 'src/ratio_eliminant.py', '--verify'],
    [sys.executable, 'src/verify_ratio_eliminant.py', '--fresh'],
]
records = []
start = time.time()
for cmd in commands:
    tic = time.time()
    print('\n$', ' '.join(cmd), flush=True)
    subprocess.run(cmd, cwd=ROOT, check=True)
    records.append({'command': ' '.join(cmd), 'status': 'passed',
                    'seconds': round(time.time() - tic, 3)})
result = {
    'status': 'passed',
    'python': sys.version,
    'compiler': subprocess.check_output(['g++', '--version'], text=True).splitlines()[0],
    'commands': records,
    'seconds': round(time.time() - start, 3),
    'inherited_suite_replayed': not args.new_only,
    'old_prefix_1375_samples_freshly_regenerated': args.full_prefix,
    'new_normalized_coefficients_verified': 987,
    'fresh_actual_source_algebras_u_codes': [25, 27],
    'exact_nonzero_determinants_and_scale_identities': 3,
    'matrix_shape': [710, 836],
    'determinants_expanded_globally': False,
    'determinants_representation': 'fully specified exact arithmetic circuits',
    'exceptional_ratio_algebra_K_length_upper_bound': 598243,
    'bound_is_actual_length_or_point_count': False,
    'exceptional_common_zero_scheme_decided': False,
    'global_square_locus_decision': 'unresolved',
    'new_global_result': 'ratio-only annihilators in the actual square ideal; '
        'all-scale exclusion on their explicit dense-open complement, with '
        'every exceptional ratio fibre retained in an explicit finite algebra',
}
logs = ROOT / 'logs'
logs.mkdir(exist_ok=True)
(logs / 'ratio_eliminant_continuation_checks.json').write_text(
    json.dumps(result, indent=2) + '\n')
lines = [
    '# Executed ratio-eliminant continuation checks', '',
    '**All listed checks passed. The global square-locus decision is unresolved.**', '',
    'Executed versions: ' + result['python'].splitlines()[0] + '; ' + result['compiler'] + '.', '',
    '| Command | Outcome | Seconds |', '|---|---|---:|',
]
for rec in records:
    lines.append('| `' + rec['command'] + '` | ' + rec['status'] + ' | ' + str(rec['seconds']) + ' |')
lines += ['',
    'The inherited suite was ' + ('replayed.' if not args.new_only else 'not replayed in this invocation.'),
    'The inherited 1375 prefix samples were ' + ('freshly regenerated.' if args.full_prefix else
        'not freshly regenerated; the inherited default verifies their archived digests.'),
    'Every one of the 987 normalized x/scale coefficients was divided exactly in the global rank-nine ratio algebra.',
    'All three column lists, nonzero point determinants, cubic polynomial-scale certificates and integral degree duals were freshly reconstructed.',
    'An independent check multiplied the complete scale identities, checked the selected determinants with a separate routine, and checked every degree-dual inequality.',
    'The genuine source/resultant/norm was freshly reconstructed in the complete u=<25> and u=<27> algebras, followed by comparison of all987 coefficients at the determinant witnesses.',
    'The universal global adjugate identity and actual-ideal membership are proved in REPORT30; no computational certificate is needed for that identity.',
    'Global determinant expansions, their gcd/common zero scheme, and a global unit-ideal decision were NOT executed.',
    'The length bound598243 is a rigorous upper bound, not a computed length or a finite-field census.',
    'All original open conditions, arbitrary geometric scale, nilpotents and all seventy square equations remain in the stated finite exceptional problem.', '',
]
(logs / 'RATIO_ELIMINANT_EXECUTED_CHECKS.md').write_text('\n'.join(lines))
print('ALL RATIO-ELIMINANT CONTINUATION CHECKS PASSED', json.dumps(result), flush=True)
