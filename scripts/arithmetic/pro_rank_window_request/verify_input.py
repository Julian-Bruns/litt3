#!/usr/bin/env python3
"""Hash, schema and two rank checks; not a geometric support certificate."""
from pathlib import Path
import sys, json, hashlib
import numpy as np
ROOT=Path(__file__).resolve().parent;sys.path.insert(0,str(ROOT/'src'))
import compute as F
for line in (ROOT/'MANIFEST.sha256').read_text().splitlines():
 h,n=line.split('  ',1);assert hashlib.sha256((ROOT/n).read_bytes()).hexdigest()==h,n
D=json.loads((ROOT/'data/invariant_blocks.json').read_text())
T=np.array(D['T'],np.uint8);Q=np.array(D['Q'],np.uint8)
assert T.shape==(6,23,15) and Q.shape==(6,14,9)
assert int(T.max())<25 and int(Q.max())<25
def rank(A,v):
 B=np.zeros(A.shape[1:],np.uint8)
 for a,c in zip(A,v):B=F.ADD[B,F.MUL[c,a]]
 return len(F.rref(B)[1])
assert (rank(T,[1,10,15,16,5,8]),rank(Q,[1,10,15,16,5,8]))==(14,8)
assert (rank(T,[1,0,0,0,0,0]),rank(Q,[1,0,0,0,0,0]))==(15,9)
print('PASS: manifest, F25 schema, both reference rank pairs.')
print('This input check is not an all-geometric decision or a tensor rebuild.')
