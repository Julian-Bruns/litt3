#!/usr/bin/env -S sage -python
"""Original-generator witnesses for the two new universal Cartier gates."""
import json
import signal
import sys
from pathlib import Path
from sage.all import GF, PolynomialRing, singular

out=Path('../litt3-computation-data/oct03_wild140_normalized_subresultants')
data=json.loads((out/'raw_degree3_receipt.json').read_text())
boundary=json.loads((out/'common_zero_receipt.json').read_text())
R=PolynomialRing(GF(5),names=('Q','B','S','T','Z'))
Q,B,S,T,Z=R.gens();Rw=PolynomialRing(R,'w');w=Rw.gen()
l=3+2*Q+2*T
A=w**3+l*w**2+B*w-B*(l-T)+3*T*l**2+Q*T**3
Phi=w**5+Q*w**4+S;H=(A**3+3*A*Phi*(w-T)**2)*Phi**2
generators=[R(H[j]) for j in (14,9,4)]+[Z*Q*S*T-1]
assert [str(p) for p in generators]==data['cartier_generators']
certificate_path=out/'original_generator_certificates.json'
if '--verify-only' in sys.argv:
    cert=json.loads(certificate_path.read_text())
    for entry in cert['ideals']:
        gens=[R(p) for p in entry['generators']]
        for target,column in zip(entry['basis'],entry['lift_columns']):
            assert sum(R(c)*g for c,g in zip(column,gens))==R(target)
    gb=[R(p) for p in data['groebner_basis']]
    assert R(data['lower_raw_subresultants']['0'][0]).reduce(gb)==0
    print('Original-generator identities and resultant normal form PASS.')
    sys.exit(0)
signal.alarm(30)
certificate={'scope':'universal shifted cubic gates, original Cartier rows',
             'ideals':[]}
for gens,targets in [(generators,data['groebner_basis']),
                     (generators+[R(A(T))],boundary['basis'])]:
    targets=[R(p) for p in targets]
    lift=singular.lift(singular(R.ideal(gens)),singular(R.ideal(targets))).sage()
    columns=[]
    for j,target in enumerate(targets):
        column=[R(lift[i,j]) for i in range(len(gens))]
        assert sum(c*g for c,g in zip(column,gens))==target
        columns.append([str(c) for c in column])
    certificate['ideals'].append({'generators':[str(p) for p in gens],
                                 'basis':[str(p) for p in targets],
                                 'lift_columns':columns})
    certificate_path.write_text(json.dumps(certificate,indent=2)+'\n')
    print(json.dumps({'original_generator_basis_witnesses':len(targets)}),flush=True)
signal.alarm(0)
