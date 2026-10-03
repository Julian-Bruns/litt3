#!/usr/bin/env -S sage -python
"""Exact original reduced-row unit witness for the fixed-origin completion gate."""
import json
import signal
import sys
from pathlib import Path
from sage.all import GF, PolynomialRing, singular

out=Path('../litt3-computation-data/oct03_wild140_fixed_origin_cubic_cartier')
data=json.loads((out/'completion_probe_receipt.json').read_text())
S=PolynomialRing(GF(5),names=('L','v','d','Z'))
gens=[S(p) for p in data['remaining_generators']]
path=out/'completion_unit_certificate.json'
if '--verify-only' in sys.argv:
    cert=json.loads(path.read_text())
    assert cert['generators']==data['remaining_generators']
    # Reconstruct from the true norm congruence, rather than trusting saved rows.
    R0=PolynomialRing(GF(5),names=('L','a','b','d','m'))
    pL,pa,pb,pd,pm=R0.gens();Rw=PolynomialRing(R0,'w');w=Rw.gen()
    N=-w**7+2*pL*w**3-pL*w**2+pL**2
    D=w**5+2*pL*w+pL
    raw=((2*D**2+pa+pb*w**5+pd*w**10)**2-pm*D**5).quo_rem(N)[1]
    R=PolynomialRing(GF(5),names=('L','u','v','d','M','Z'))
    L,u,v,d,M,Z=R.gens();hom=R0.hom([L,L**2*u,L*v,d,M/L],R.fraction_field())
    rows=[R(hom(R0(raw[j]))/L**e) for j,e in enumerate((4,4,4,4,4,3,3))]
    assert rows[1]+rows[2]+rows[4]==L+d**2-2*d+L*v*(2*d-1)+2*u+3*v-1
    up=3*(-L-d**2+2*d-L*v*(2*d-1)-3*v+1)
    em=L*(3*d**2-3*d+1)-1+4*v*d+v**2-3*u*d-2*u+2*u*v-3*M
    assert rows[5]+rows[6]==em
    mp=R((2*(em+3*M)).subs({u:up}))
    reduced=[R(p.subs({u:up,M:mp})) for p in rows]
    assert all(p.degree(u)==0 and p.degree(M)==0 for p in reduced+[mp])
    sL,sv,sd,sZ=S.gens();drop=R.hom([sL,S(0),sv,sd,S(0),sZ],S)
    expected=[drop(p) for p in reduced]+[sZ*sL*(sL+1)*drop(mp)*(sd-3)-1]
    assert expected==gens
    assert sum(S(c)*g for c,g in zip(cert['witness'],gens))==1
    print('Original congruence reconstruction, analytical eliminations and unit witness PASS.')
    sys.exit(0)
signal.alarm(6)
lift=singular.lift(singular(S.ideal(gens)),singular(S.ideal([1]))).sage()
witness=[S(lift[i,0]) for i in range(len(gens))]
assert sum(c*g for c,g in zip(witness,gens))==1
signal.alarm(0)
cert={'scope':'fixed-origin common-completion original reduced-row unit identity',
      'generators':data['remaining_generators'],
      'witness':[str(p) for p in witness],
      'identity':'sum witness[i]*original_reduced_generator[i] = 1',
      'checks':{'exact_original_reduced_rows':True}}
path.write_text(json.dumps(cert,indent=2)+'\n')
print(json.dumps({'checks':cert['checks'],
                  'witness_terms':sum(len(p.monomials()) for p in witness)}))
