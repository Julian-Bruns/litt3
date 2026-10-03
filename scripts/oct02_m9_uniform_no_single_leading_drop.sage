#!/usr/bin/env sage
"""Stored no-single resultant leading coefficient drop, hard5s."""
import json,time,signal
from pathlib import Path
started=time.monotonic()
def expired(signum,frame):raise TimeoutError('no-single leading-drop hard5-second budget')
signal.signal(signal.SIGALRM,expired);signal.setitimer(signal.ITIMER_REAL,5)
folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform')
data=json.loads((folder/'no_single_affine_cube_parameter_support.json').read_text())
R5=PolynomialRing(GF(5),'z');z=R5.gen();F=GF(25,'beta',modulus=R5(data['field_modulus']));beta=F.gen()
def code(c):return F(c%5)+F(c//5)*beta
L=PolynomialRing(F,'lam');lam=L.gen()
g0,g1,g2=[L([code(c) for c in row]) for row in data['g_coefficients']]
d0=code(1)+lam*code(13);d1=code(22)+lam*code(18);d2=code(9)+lam*code(24)
drop=g0*(d2**2/F(3)-d1)-g1*(d2**3/F(27)-d0)
gg,a,b=g2.xgcd(drop)
def encoded(g):
 out=[]
 for c in g.list():
  cs=c.polynomial().list();out.append(int(cs[0] if cs else 0)+(5*int(cs[1]) if len(cs)>1 else 0))
 return out
primitive=L([code(c) for c in data['primitive_after_g2_squared']])
out={'scope':'Necessary actual finite-t condition at g2=0, with exact polynomial gcd; no coefficient boundary silently discarded.',
     'g2':encoded(g2),'drop_condition':encoded(drop),'gcd':encoded(gg),'gcd_degree':int(gg.degree()),
     'bezout':[encoded(a),encoded(b)],'primitive_factors':[{'degree':int(f.degree()),'polynomial':encoded(f)} for f,m in primitive.factor()],
     'seconds':time.monotonic()-started,'sage_version':version()}
(folder/'no_single_leading_drop_exclusion.json').write_text(json.dumps(out,indent=2,default=int)+'\n')
signal.setitimer(signal.ITIMER_REAL,0);print('leadingdrop gcddegree',gg.degree(),'primitivefactors',[(f.degree(),m) for f,m in primitive.factor()],'seconds',time.monotonic()-started)
