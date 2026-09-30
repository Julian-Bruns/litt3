#!/usr/bin/env sage-python
"""Independent degree-bounded specialization verification of pencil certificates.

Does not recompute rational-function row echelon forms. Polynomial minor
identities of degree<=19 are checked at all25 base-field elements. Every
tail minor of size s+1 has degree<=7, so its vanishing at all25 values
proves the generic tail-rank upper bound. All exceptional roots are then
checked over their exact residue fields.
"""
import argparse
import itertools
import json
from pathlib import Path
import time
import numpy as np
from sage.all import GF, PolynomialRing, matrix

p=argparse.ArgumentParser()
p.add_argument("archive",type=Path)
p.add_argument("certificate",type=Path)
a=p.parse_args();t0=time.monotonic()
R5=PolynomialRing(GF(5),"z");z=R5.gen()
F=GF(25,"b",modulus=z*z-z-3);b=F.gen()
R=PolynomialRing(F,"s");s=R.gen()
els=[F(i%5)+F(i//5)*b for i in range(25)]
T=np.load(a.archive/'data/tensors.npz')['T']
base=[matrix(F,80,19,lambda r,c:els[int(T[c,r,j])]) for j in range(35)]
data=json.loads(a.certificate.read_text())
assert data['pencils_checked']==595
assert [r['pair'] for r in data['records']]==[list(x) for x in itertools.combinations(range(35),2)]
for A in base:assert A.rank()-A[:,13:].rank()==13
factor_checks=0
for nr,rec in enumerate(data['records'],1):
    i,j=rec['pair'];r,rt=rec['generic_rank'],rec['generic_tail_rank']
    assert r-rt==13
    rows,cols=rec['rows'],rec['columns']
    assert len(rows)==len(set(rows))==len(cols)==len(set(cols))==r
    minor=R([els[c] for c in rec['minor']]);assert minor and minor.degree()<=r<=19
    for v in els:
        A=base[i]+v*base[j]
        assert A[:,13:].rank()<=rt
        assert A[rows,cols].determinant()==minor(v)
    product=R.one()
    for entry in rec['exceptional_factors']:
        f=R([els[c] for c in entry['factor']]);assert f.is_monic() and f.is_irreducible()
        m=entry['multiplicity'];assert m>0
        product*=f**m
        if f.degree()==1:E=F;q=-f[0]
        else:E=F.extension(f,"q");q=E.gen()
        A=base[i].change_ring(E)+q*base[j].change_ring(E)
        ar,tr=A.rank(),A[:,13:].rank()
        assert (ar,tr)==(entry['rank'],entry['tail_rank'])
        assert ar-tr==13
        factor_checks+=1
    assert product==minor.monic()
    if nr%100==0:print('PASS pencils',nr,'seconds',round(time.monotonic()-t0,2),flush=True)
print('PASS all595 geometric pencils,35 endpoints,',factor_checks,'exceptional residue-field checks;',round(time.monotonic()-t0,2),'seconds',flush=True)
print('Scope: quotient-map directions with at most two nonzero coordinates, not all maps or sources.',flush=True)
