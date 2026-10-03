#!/usr/bin/env sage
"""Small exact same-fiber-zero necessary parameter resultants overGF5^8."""
import json,time,signal
from pathlib import Path
from itertools import permutations
started=time.monotonic()
def deadline(signum,frame):raise TimeoutError('20-second pair-resultant hard budget')
signal.signal(signal.SIGALRM,deadline);signal.setitimer(signal.ITIMER_REAL,20)
F=GF(5**8,'e');R=PolynomialRing(F,'x');x=R.gen();beta=(x*x-x-3).roots(multiplicities=False)[0]
def code(c):return F(c%5)+F(c//5)*beta
def poly(cs):return R([code(c) for c in cs])
P=poly([11,22,18,5,19,20,15,16,9,22,1]);A=poly([1,21,14,22,13]);Z=poly([15,19,24,12,10,19,3,24,18,16])
q3=poly([1,22,9,1]);q=poly([13,18,24]);K0,R0=(Z*q3).quo_rem(P);K1,R1=(Z*q).quo_rem(P)
L=PolynomialRing(F,'lam');lam=L.gen();S=PolynomialRing(L,'xx');xx=S.gen()
d=S(q3)+lam*S(q);K=S(K0)+lam*S(K1);G=K**3*S(P)
perms=list(permutations(range(3)))
signs=[(-1)**sum(t[i]>t[j] for i in range(3) for j in range(i+1,3)) for t in perms]
def determinant(m):return sum((sign*prod(m[i,t[i]] for i in range(3)) for t,sign in zip(perms,signs)),L.zero())
def multiplication(f):
 columns=[(xx**j*f)%d for j in range(3)]
 return matrix(L,[[columns[j][i] for j in range(3)] for i in range(3)])
MG=multiplication(G);identity=identity_matrix(L,3)
boundary={'discriminant':-determinant(multiplication(d.derivative())),
          'cubic_branch':determinant(multiplication(S(P))),
          'Kummer_zero':determinant(multiplication(K)),
          'selected_endpoint':determinant(multiplication(S(A)))}
def coords(v):return [int(a) for a in v.polynomial().list()]
def encode_poly(g):return [coords(v) for v in g.list()]
records=[];product_polynomial=L.one()
folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform');output=folder/'same_fiber_zero_parameter_resultants.json'
for s in A.roots(multiplicities=False):
 ps=P(s);rs=L(R0(s))+lam*R1(s);es=determinant(ps**2*MG+rs**3*identity)
 assert es and es[0] and es.degree()<=25
 es=es.monic();factors=list(es.factor())
 line=L(q3(s))+lam*q(s)
 record={'A_root':coords(s),'resultant_degree':int(es.degree()),'resultant':encode_poly(es),
         'factors':[{'degree':int(f.degree()),'multiplicity':int(m),'polynomial':encode_poly(f)} for f,m in factors],
         'endpoint_cubic_zero_factor':encode_poly(line.monic()),
         'boundary_gcd_degrees':{key:int(es.gcd(f).degree()) for key,f in boundary.items()}}
 records.append(record);product_polynomial*=es
 out={'scope':'Necessary same-fiber selected-zero pair parameter supports when c has singleton maximal pole support at an unramified critical fiber; not an actual-source decision.',
      'field_modulus':[int(c) for c in F.modulus().list()],'beta_coordinates':coords(beta),'records':records,
      'boundary_polynomials':{key:encode_poly(f) for key,f in boundary.items()},'seconds':time.monotonic()-started,'sage_version':version()}
 output.write_text(json.dumps(out,indent=2,default=int)+'\n')
 print('Aroot',len(records),'degree',es.degree(),'factors',[(f.degree(),m) for f,m in factors],'boundarygcds',record['boundary_gcd_degrees'],flush=True)
assert all(c**25==c for c in product_polynomial)
out.update(product_degree=int(product_polynomial.degree()),product_polynomial=encode_poly(product_polynomial),product_defined_over_F25=True,complete=True,seconds=time.monotonic()-started)
output.write_text(json.dumps(out,indent=2,default=int)+'\n');signal.setitimer(signal.ITIMER_REAL,0)
print('DONE productdegree',product_polynomial.degree(),'seconds',time.monotonic()-started)
