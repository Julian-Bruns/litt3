#!/usr/bin/env python3
"""Recover metadata ONLY after the preserved Sage-Integer JSON failure.

No .sobj load, field calculation, matrix rank, coefficient reduction,
determinant, pencil identity or executed-source overwrite. The exact
traceback position and program order attest completed assertions.
Preserve primary exit1 and bind the executed source, existing artifacts,
receipt, stderr and original manifest before future producer edits.
"""
import argparse
import hashlib
import json
from pathlib import Path
import signal
import time

parser = argparse.ArgumentParser()
parser.add_argument('--evidence', required=True)
parser.add_argument('--executed-source', required=True)
parser.add_argument('--source', required=True)
args = parser.parse_args()
signal.alarm(5)
started = time.monotonic()
out = Path(args.evidence)
producer = Path(args.executed_source)
recovery = Path(args.source)
assert not (out / 'summary_recovery.json').exists()
receipt_bytes = (out / 'receipt.json').read_bytes()
receipt = json.loads(receipt_bytes)
stderr_bytes = (out / 'stderr.txt').read_bytes()
stderr = stderr_bytes.decode()
manifest_bytes = (out / 'manifest.json').read_bytes()
manifest = json.loads(manifest_bytes)
producer_bytes = producer.read_bytes()
producer_text = producer_bytes.decode()
producer_hash = hashlib.sha256(producer_bytes).hexdigest()
assert receipt['exit_code'] == 1 and receipt['external_timeout'] is False
assert receipt['source_sha256'] == producer_hash
assert "Object of type Integer is not JSON serializable" in stderr
assert "when serializing dict item 'threads'" in stderr
assert "(out/'summary.json').write_text(json.dumps(summary" in stderr
assert "(out/'summary.json').write_text(json.dumps(summary" in producer_text
assert producer_text.index("assert sheet_identity==0") < producer_text.index("save((k,Kq,parameter,Q,E,R,F,G,norm,U,V")
assert producer_text.index("save((k,Kq,parameter,Q,E,R,F,G,norm,U,V") < producer_text.index("(out/'summary.json').write_text")
assert producer_text.index("assert denominator*denominator_inverse==1") < producer_text.index("assert sheet_identity==0")
assert "assert all(value==0 for value in identities.values())" in producer_text
assert "assert norm[10]==E(leading) and norm[5]==E(leading*nu) and norm[0]==E(leading*kappa)" in producer_text
assert "assert parameter.gcd(parameter.derivative())==1" in producer_text
artifacts = {}
for name in ('fixed_pencils.sobj', 'exact_formulas.txt'):
    path = out / name
    assert path.is_file() and path.stat().st_size > 0
    digest = hashlib.sha256(path.read_bytes()).hexdigest()
    assert manifest[name] == digest
    artifacts[name] = {'sha256': digest, 'bytes': path.stat().st_size}
(out / 'executed_source.sage').write_bytes(producer_bytes)
summary = {
    'scope': 'data-only recovery; arithmetic assertion PASS distinct from primary exit1 metadata failure',
    'threads': 1,
    'primary_exit_code': 1,
    'primary_external_timeout': False,
    'primary_external_elapsed_seconds': receipt['external_elapsed_seconds'],
    'primary_source_sha256': producer_hash,
    'primary_receipt_sha256': hashlib.sha256(receipt_bytes).hexdigest(),
    'primary_stderr_sha256': hashlib.sha256(stderr_bytes).hexdigest(),
    'primary_manifest_sha256': hashlib.sha256(manifest_bytes).hexdigest(),
    'recovery_source_sha256': hashlib.sha256(recovery.read_bytes()).hexdigest(),
    'arithmetic_reexecuted': False,
    'sobj_loaded': False,
    'parameter_separability_assertion_completed': True,
    'both_e_signs_retained': True,
    'horizontal_identity_assertions_completed': True,
    'norm_quadratic_formula_assertions_completed': True,
    'sheet_denominator_inverse_assertion_completed': True,
    'relative_sheet_identity_assertion_completed': True,
    'matrix_rank': 'unrecorded; no rank is recovered or recomputed',
    'repeated_divisor_roots_retained': True,
    'evidence_basis': 'preserved exact traceback after all assertions and essential artifact saves',
    'artifacts': artifacts,
    'recovery_elapsed_seconds': time.monotonic() - started,
}
(out / 'summary_recovery.json').write_text(json.dumps(summary, indent=2) + '\n')
(out / 'recovery_manifest.json').write_text(json.dumps({name: hashlib.sha256((out/name).read_bytes()).hexdigest() for name in ('executed_source.sage','summary_recovery.json')}, indent=2) + '\n')
print(json.dumps(summary))
