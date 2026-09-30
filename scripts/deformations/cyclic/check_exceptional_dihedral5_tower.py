#!/usr/bin/env sage-python
"""Independent nested-polynomial verification of the exact coefficient tower."""
import argparse
import hashlib
import json
import random
import sys
from pathlib import Path
from sage.all import Zmod, PolynomialRing

ap=argparse.ArgumentParser(description=__doc__)
ap.add_argument('--input',required=True);ap.add_argument('--output',required=True)
args0=ap.parse_args();config=Path(args0.input).resolve()
sys.path.insert(0,str(Path(__file__).resolve().parents[3]))
sys.argv=[sys.argv[0],'--input',str(config),'--precision','3500']
from scripts.deformations.cyclic import exceptional_dihedral5_tower_witt as w
import numpy as np

data=json.loads(config.read_text());R=PolynomialRing(Zmod(625),'a')
A=R.quotient(R([3,4,1,4,1]),'t');t=A.gen()
S=PolynomialRing(A,'b');B=S.quotient(S([A(R(row)) for row in data['extension_polynomial']]),'l');l=B.gen()
def decode(cc):
    return sum((sum((int(cc[4*j+i])*t**i for i in range(4)),A(0))*l**j for j in range(3)),B(0))
def encode(c):
    p=B(c).lift()
    return np.array([int(p[j].lift()[i]) for j in range(3) for i in range(4)],dtype=np.int64)
sig_t=decode(w.SIGT);sig_l=decode(w.SIGGEN)
def sigma(c):
    cc=encode(c)
    return sum((int(cc[4*j+i])*sig_t**i*sig_l**j for j in range(3) for i in range(4)),B(0))
assert encode(t).tolist()==w.T.tolist()
rng=random.Random(20260921)
for _ in range(40):
    aa=np.array([rng.randrange(625) for i in range(12)],dtype=np.int64)
    bb=np.array([rng.randrange(625) for i in range(12)],dtype=np.int64)
    a,b=decode(aa),decode(bb)
    assert np.array_equal(encode(a*b),w.cm(aa,bb))
    assert np.array_equal(encode(sigma(a)),w.SIGMAT@aa%625)
    if np.any(aa%5):assert a*decode(w.ci(aa))==1
    current=aa.copy()
    for j in range(12):current=w.SIGMAT@current%625
    assert np.array_equal(current,aa)
    assert np.array_equal(w.SIGMAT@w.cm(aa,bb)%625,w.cm(w.SIGMAT@aa%625,w.SIGMAT@bb%625))
result=dict(status='PASS independent nested polynomial arithmetic and coefficient Frobenius',
            comparisons=40,modulus=625,total_residue_degree=12,
            basis=data['coefficient_basis'],input_sha256=hashlib.sha256(config.read_bytes()).hexdigest())
Path(args0.output).write_text(json.dumps(result,indent=2)+'\n')
print(result['status'])
