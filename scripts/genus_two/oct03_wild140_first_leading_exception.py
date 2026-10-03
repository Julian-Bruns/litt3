#!/usr/bin/env -S sage -python
"""Exact small Q=T+1 Cartier exceptional branch and original-row lifts."""
import json
import signal
import sys
from pathlib import Path
from sage.all import GF, PolynomialRing, singular

R=PolynomialRing(GF(5),names=('B','S','T','Z'));B,S,T,Z=R.gens();Q=T+1
Rw=PolynomialRing(R,'w');w=Rw.gen();l=4*T
A=w**3+l*w**2+B*w-B*(l-T)+3*T*l**2+Q*T**3
Phi=w**5+Q*w**4+S;bb=w-T
H=(A**3+3*A*Phi*bb**2)*Phi**2
I=R.ideal([R(H[j]) for j in (14,9,4)]+[Z*Q*S*T-1])
target=R.ideal([Z**2-2,B-2*Z-1,S+2*Z,T-2])
out=Path('../litt3-computation-data/oct03_wild140_quotient_pseudo_remainder_gate')
path=out/'first_leading_exception_certificate.json'
if '--verify-only' in sys.argv:
    receipt=json.loads(path.read_text())
    assert [str(p) for p in I.gens()]==receipt['generators']
    for expected,column in zip(target.gens(),receipt['lift_columns']):
        assert sum(R(co)*gen for co,gen in zip(column,I.gens()))==expected
    assert all(p.reduce(target.groebner_basis())==0 for p in I.gens())
    print('Original-row lift and reverse containment PASS.')
    sys.exit(0)
signal.alarm(5)
gb=I.groebner_basis()
assert all(p.reduce(gb)==0 for p in target.gens())
assert all(p.reduce(target.groebner_basis())==0 for p in I.gens())
lift=singular.lift(singular(I),singular(target)).sage()
for j,expected in enumerate(target.gens()):
    assert sum(R(lift[i,j])*I.gens()[i] for i in range(4))==expected
signal.alarm(0)
receipt={'scope':'Q=T+1 Cartier exceptional branch ONLY',
         'generators':[str(p) for p in I.gens()],
         'target_generators':[str(p) for p in target.gens()],
         'basis':[str(p) for p in gb],
         'lift_columns':[[str(R(lift[i,j])) for i in range(4)] for j in range(4)],
         'checks':{'exact_original_row_lifts':True,'reverse_containment':True}}
out.mkdir(parents=True,exist_ok=True)
path.write_text(json.dumps(receipt,indent=2)+'\n')
print(json.dumps({'basis':receipt['basis'],'checks':receipt['checks']}))
