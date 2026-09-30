#!/usr/bin/env python3
"""Build the capped optional input ZIP for the geometric rank-window request."""
from pathlib import Path
import hashlib, json, zipfile
import numpy as np
ROOT=Path(__file__).resolve().parents[2]
EXT=ROOT.parent/'litt3-computation-data/structural_triplet_replies_20260924'
OUT=EXT/'outgoing';OUT.mkdir(exist_ok=True)
files={'requirements.txt':b'numpy==2.3.5\nnumba==0.65.1\n',
       'src/compute.py':(ROOT/'scripts/arithmetic/pro_degree6_actual_return_20260924/return/src/compute.py').read_bytes()}
for n in ['build_blocks.py','verify_input.py']:
 files[n]=(ROOT/'scripts/arithmetic/pro_rank_window_request'/n).read_bytes()
d=np.load(EXT/'originals/return/strict_second_return/data/equivariant.npz',allow_pickle=False)
obj={'field':'F5[beta]/(beta^2-beta-3)','code':'a+5*b means a+b*beta',
     'convention':'T=sum v_i T[i], Q=sum v_i Q[i]; ranks over algebraic closure',
     'T':d['T'].tolist(),'Q':d['Q'].tolist()}
files['data/invariant_blocks.json']=(json.dumps(obj,separators=(',',':'))+'\n').encode()
files['README.md']=b'''# Geometric rank-window input

The separate prompt gives the complete mathematical problem. This ZIP has
exact T,Q arrays and a short direct reconstruction, not a solved support ideal.
Variables range over the entire algebraic closure, not just F25.

Requirements: Python3, NumPy2.3.5, Numba0.65.1; checked with Python3.14.7.
Run:
  python3 -m pip install -r requirements.txt
  python3 -B verify_input.py
  python3 -B build_blocks.py

The first test checks hashes, schema and two reference rank pairs. The second
reconstructs both constant eliminations directly from the Cech class printed
in the prompt. It verifies constant polynomial-row-space equivalence with
both stored matrices, hence equality of all geometric rank loci. Choices
of annihilator bases can change displayed entries without changing ranks.
The reconstructed matrices and elimination witnesses go to data/direct_blocks.npz.
No expensive nineteen-parameter or mixed-return tensor rebuild is needed.

File map: data/invariant_blocks.json contains six23x15 and six14x9 arrays;
entries are F25 codes a+5*b for a+b*beta, beta^2=beta+3, NOT integers mod25.
src/compute.py supplies unchanged checked finite-field and Laurent arithmetic.
build_blocks.py implements equations5--7 of the prompt. verify_input.py gives
small integrity checks. MANIFEST.sha256 hashes every original payload file.
No geometric support or Frobenius return is claimed by this package.
'''
files['MANIFEST.sha256']=''.join(f'{hashlib.sha256(v).hexdigest()}  {n}\n' for n,v in sorted(files.items())).encode()
p=OUT/'geometric_rank_window_inputs.zip'
with zipfile.ZipFile(p,'w',zipfile.ZIP_DEFLATED,compresslevel=9) as z:
 for n,v in sorted(files.items()):z.writestr(n,v)
with zipfile.ZipFile(p) as z:
 assert z.testzip() is None
 assert all(z.read(n)==v for n,v in files.items())
assert p.stat().st_size<=20000
meta={'path':str(p),'compressed_bytes':p.stat().st_size,
      'uncompressed_bytes':sum(map(len,files.values())),
      'files':len(files),'sha256':hashlib.sha256(p.read_bytes()).hexdigest()}
(OUT/'package_metadata.json').write_text(json.dumps(meta,indent=2)+'\n')
print(json.dumps(meta,indent=2))
