#!/usr/bin/env python3
"""Fresh replay of the returned fifth certificate, preserving distributed files."""
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

p = argparse.ArgumentParser(description=__doc__)
p.add_argument('original', type=Path)
p.add_argument('--receipt', type=Path, required=True)
a = p.parse_args()
original = a.original.resolve()
manifest = json.loads((original/'MANIFEST.json').read_text())['files']
def sha(p): return hashlib.sha256(p.read_bytes()).hexdigest()
assert all(sha(original/name) == row['sha256'] for name,row in manifest.items())
parent = Path(tempfile.mkdtemp(prefix='rank25-w5-fresh-replay-20260911-', dir=original.parent.parent))
copy = parent/original.name
shutil.copytree(original, copy)
print('FRESH_COPY', copy, flush=True)
env = dict(os.environ, OPENBLAS_NUM_THREADS='1', OMP_NUM_THREADS='1', VECLIB_MAXIMUM_THREADS='1')
start = time.monotonic()
log = parent/'fresh_full_replay.log'
with log.open('w') as f:
    proc = subprocess.run([sys.executable, '-u', 'reconstruction/replay.py'], cwd=copy,
                          env=env, stdout=f, stderr=subprocess.STDOUT)
assert proc.returncode == 0, f'Fresh replay failed: {log}'
def compare(old, new, path=''):
    if isinstance(old, dict):
        assert isinstance(new, dict) and old.keys() <= new.keys(), path
        for k,v in old.items():
            if k not in {'seconds', 'core_receipt_sha256'}:
                compare(v, new[k], path+'/'+k)
    elif isinstance(old, list):
        assert isinstance(new, list) and len(old) == len(new), path
        for i,(v,w) in enumerate(zip(old,new)): compare(v,w,path+f'/{i}')
    else:
        assert old == new, (path, old, new)
names = ['reconstructed_fourth_digit.json', 'relative_operator_2400_0.json',
         'relative_operator_4200_1.json', 'fifth_regular_constant_3600_0.json',
         'fifth_regular_constant_4200_1.json', 'fifth_direct_beta_check.json',
         'fifth_riccati_trace.json', 'fifth_constant_3600_0.json', 'fifth_locus_certificate.json']
comparisons = {}
for n in names:
    op, np = original/'reconstruction'/n, copy/'reconstruction'/n
    compare(json.loads(op.read_text()), json.loads(np.read_text()), n)
    comparisons[n] = {'all_recorded_mathematical_values_equal': True, 'fresh_sha256': sha(np)}
assert all(sha(original/name) == row['sha256'] for name,row in manifest.items())
assert all(sha(copy/name) == row['sha256'] for name,row in manifest.items()
           if name.endswith('.py') or name.startswith('supplied/'))
out = {'status':'PASS', 'original':str(original), 'fresh_copy':str(copy), 'log':str(log),
       'manifest_files':len(manifest), 'original_preserved':True,
       'source_and_inputs_unchanged':True, 'wall_seconds':time.monotonic()-start,
       'comparisons':comparisons,
       'scope':'Full new Laurent computation, all-nine relative operator, two precisions/Frobenius choices, independent Riccati and finite audit. Geometric interpretation separately audited.'}
a.receipt.write_text(json.dumps(out, indent=2)+'\n')
print(json.dumps(out, indent=2))
