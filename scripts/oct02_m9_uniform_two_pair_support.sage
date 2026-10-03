#!/usr/bin/env sage
"""Stored pair-resultant support gcds and normalized two-pair linear equations."""
import json,time,signal
from pathlib import Path
from itertools import combinations,product
started=time.monotonic()
def expired(signum,frame):raise TimeoutError('two-pair hard10-second budget')
signal.signal(signal.SIGALRM,expired);signal.setitimer(signal.ITIMER_REAL,10)
folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform')
data=json.loads((folder/'same_fiber_zero_parameter_resultants.json').read_text())
R5=PolynomialRing(GF(5),'t');F=GF(5**8,'e',modulus=R5(data['field_modulus']))
beta=F(data['beta_coordinates']);R=PolynomialRing(F,'x');x=R.gen()
def code(c):return F(c%5)+F(c//5)*beta
P=R([code(c) for c in [11,22,18,5,19,20,15,16,9,22,1]])
Z=R([code(c) for c in [15,19,24,12,10,19,3,24,18,16]])
q3=R([code(c) for c in [1,22,9,1]]);q=R([code(c) for c in [13,18,24]])
K0,R0=(Z*q3).quo_rem(P);K1,R1=(Z*q).quo_rem(P)
L=PolynomialRing(F,'lam');lam=L.gen();roots=[F(v['A_root']) for v in data['records']]
supports=[L([F(c) for c in v['resultant']]) for v in data['records']]
pbase=P(roots[0]);ratios=[(x**3-P(s)/pbase).roots(multiplicities=False) for s in roots]
assert all(len(v)==3 for v in ratios)
def coords(v):return [int(c) for c in v.polynomial().list()]
def encoded(f):return [coords(c) for c in f.list()]
gcds=[];equations=[]
for i,j in combinations(range(4),2):
 g,a,b=supports[i].xgcd(supports[j]);assert g==1
 gcds.append({'root_indices':[i,j],'gcd':encoded(g),'bezout':[encoded(a),encoded(b)]})
 for yi,yj in product(ratios[i],ratios[j]):
  gi=-(L(R0(roots[i]))+lam*R1(roots[i]))*yi/P(roots[i])
  gj=-(L(R0(roots[j]))+lam*R1(roots[j]))*yj/P(roots[j])
  equation=gi-gj
  assert equation and equation.degree()<=1
  candidate=-equation[0]/equation[1] if equation.degree()==1 else None
  equations.append({'root_indices':[i,j],'remaining_normalized_y':[coords(yi),coords(yj)],
      'linear_equation':encoded(equation),'candidate_lambda':coords(candidate) if candidate is not None else None,
      'pair_support_values':[coords(supports[k](candidate)) for k in [i,j]] if candidate is not None else None})
out={'scope':'Two same-x selected-zero pairs at distinct A roots cannot both satisfy the necessary singleton-critical-support resultants. Conditional on an unramified critical C-singleton, not all critical itineraries.',
     'field_modulus':data['field_modulus'],'six_pairwise_resultant_gcds':gcds,'normalized_linear_equations':equations,
     'all_six_gcds_one':True,'all54_linear_equations_nonzero':True,'seconds':time.monotonic()-started,'sage_version':version()}
(folder/'two_pair_support_exclusion.json').write_text(json.dumps(out,indent=2,default=int)+'\n')
signal.setitimer(signal.ITIMER_REAL,0);print('PASS6Bezout gcds and54linear constraints; seconds',time.monotonic()-started)
