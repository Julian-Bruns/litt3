#!/usr/bin/env python3
"""Regenerate exact sweep inputs and optionally replay a final certificate.

Rebuild the exact sparse matrix in a temporary directory, compare its saved
hash, and run the independent scalar verifier. Successful temporary matrices
are removed; original inputs/certificates and compact new receipts remain.
Input-only mode checks regeneration for an unfinished job without claiming
a mathematical verdict. Restore mode also reinstalls missing matrix files.
This never launches a solver; a dual is only a bounded-span statement.
"""
import argparse
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
import time

ROOT = Path(__file__).resolve().parents[2]


def sha(path):
    digest = hashlib.sha256()
    with path.open('rb') as stream:
        for block in iter(lambda: stream.read(4 * 1024**2), b''):
            digest.update(block)
    return digest.hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--sweep', type=Path, required=True)
    parser.add_argument('--job', required=True)
    parser.add_argument('--out', type=Path, required=True)
    parser.add_argument('--input-only', action='store_true',
                        help='Check exact input regeneration; do not replay a certificate')
    parser.add_argument('--restore-input', action='store_true',
                        help='Input-only check, then restore missing matrix and degree files')
    args = parser.parse_args()
    args.input_only = args.input_only or args.restore_input
    sweep = args.sweep.resolve()
    state = json.loads((sweep / 'sweep.json').read_text())
    job = next(row for row in state['jobs'] if row['name'] == args.job)
    kinds = {'exact_bounded_dual': 'dual',
             'verified_original_polynomial_unit_certificate': 'primal'}
    kind = 'input' if args.input_only else kinds[job['status']]
    folder = sweep / job['name']
    old = json.loads((folder / 'input/matrix.json').read_text())
    assert not old.get('predecessor_reuse'), 'This command restores Lanczos sweep inputs'
    source = Path(job['tensor'])
    assert sha(source) == old['source_sha256']
    certificate = None
    if not args.input_only:
        certificate = folder / 'solve' / ('dual.bin' if kind == 'dual' else 'solution.bin')
        assert sha(certificate) == job['certificate_sha256']
    out = args.out.resolve()
    out.mkdir(parents=True, exist_ok=False)
    temporary = Path(tempfile.mkdtemp(prefix='matrix-', dir=out))
    started = time.monotonic()
    env = dict(os.environ, OMP_NUM_THREADS='1', OPENBLAS_NUM_THREADS='1', MKL_NUM_THREADS='1')
    common = ['sage', str(ROOT / 'scripts/atlases/mixed_atlas_certificate.sage'),
              '--tensor', str(source), '--atlas-input', job['charts'],
              '--representative', job['representative'], '--chart', str(job['chart']),
              '--v-degree', str(old['v_degree']), '--b-degree', str(old['b_degree'])]
    with (out / 'export.log').open('x') as log:
        subprocess.run(common + ['--output', str(temporary), '--export-only'],
                       check=True, env=env, stdout=log, stderr=subprocess.STDOUT)
    rebuilt = json.loads((temporary / 'matrix.json').read_text())
    for key in ['matrix_sha256', 'source_sha256', 'chart', 'v_degree', 'b_degree',
                'rows', 'columns', 'pure_b_start']:
        assert rebuilt[key] == old[key], ('regeneration mismatch', key)
    assert sha(temporary / 'matrix.bin') == old['matrix_sha256']
    degree_sha = sha(temporary / 'matrix.bin.degrees')
    regenerated_hashes = {'matrix.bin': old['matrix_sha256'],
                          'matrix.bin.degrees': degree_sha}
    for name in ['matrix.bin', 'matrix.bin.degrees']:
        original = folder / 'input' / name
        if original.exists():
            assert sha(original) == regenerated_hashes[name], ('original input mismatch', name)
    retention = folder / 'input/regeneration.json'
    if retention.exists():
        saved = json.loads(retention.read_text())
        assert saved['matrix_sha256'] == old['matrix_sha256']
        assert saved['source_sha256'] == old['source_sha256']
        assert saved['column_degrees_sha256'] == degree_sha
    if not args.input_only:
        with (out / 'scalar_replay.json').open('x') as log:
            subprocess.run([sys.executable, str(ROOT / 'scripts/atlases/algebra/verify_sparse_linear_certificate.py'),
                            str(temporary / 'matrix.bin'), str(certificate), '--kind', kind],
                           check=True, env=env, stdout=log)
        replay = json.loads((out / 'scalar_replay.json').read_text())
        assert replay['status'] == 'exact_certificate_replay_pass'
        assert replay['matrix_sha256'] == old['matrix_sha256']
        assert replay['certificate_sha256'] == job['certificate_sha256']
    if kind == 'primal':
        with (out / 'polynomial_replay.log').open('x') as log:
            subprocess.run(common + ['--output', str(temporary / 'proof'),
                                    '--verify-weights', str(certificate)],
                           check=True, env=env, stdout=log, stderr=subprocess.STDOUT)
        proof = json.loads((temporary / 'proof/original_polynomial_certificate.json').read_text())
        assert proof['identity_sum_original_rows_times_multipliers_equals_one_verified']
    size = (temporary / 'matrix.bin').stat().st_size
    restored = []
    if args.restore_input:
        for name in ['matrix.bin', 'matrix.bin.degrees']:
            target = folder / 'input' / name
            if target.exists():
                assert sha(target) == regenerated_hashes[name]
                continue
            # Link a fully checked file into place without overwriting a
            # concurrently created target. Both task folders are local.
            staging = target.with_name(name + '.restore-tmp')
            created = False
            try:
                with staging.open('xb') as output:
                    created = True
                    with (temporary / name).open('rb') as input_stream:
                        shutil.copyfileobj(input_stream, output, 4 * 1024**2)
                os.link(staging, target)
            finally:
                if created:
                    staging.unlink(missing_ok=True)
            restored.append(str(target))
    shutil.rmtree(temporary)
    result = {'status': ('PASS_regenerated_original_input' if args.input_only else
                         'PASS_regenerated_original_input_and_independent_certificate'),
              'job': job['name'], 'kind': kind, 'sweep': str(sweep),
              'matrix_sha256': old['matrix_sha256'], 'matrix_bytes': size,
              'column_degrees_sha256': degree_sha,
              'source_sha256': old['source_sha256'],
              'matrix_generator_sha256': sha(ROOT / 'scripts/atlases/mixed_atlas_certificate.sage'),
              'elapsed_seconds': time.monotonic() - started,
              'temporary_matrix_removed': True,
              'restored_files': restored,
              'scope': ('Input-only: exact regeneration, no existence or exclusion verdict.' if args.input_only else
                        'Dual: this bounded row span has no unit. Primal: actual selected rooted chart excluded. No whole-representative or common-cover claim.')}
    if certificate is not None:
        result['certificate_sha256'] = job['certificate_sha256']
    (out / 'receipt.json').write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps(result), flush=True)


if __name__ == '__main__':
    main()
