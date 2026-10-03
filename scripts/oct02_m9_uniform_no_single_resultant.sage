#!/usr/bin/env sage
"""New affine-cube interpolation lambda support; hard10 seconds, one core."""
import json,time,signal
from pathlib import Path
from itertools import permutations
started=time.monotonic()
def expired(signum,frame):raise TimeoutError('no-single resultant hard10-second budget')
signal.signal(signal.SIGALRM,expired);signal.setitimer(signal.ITIMER_REAL,10)
R5=PolynomialRing(GF(5),'z');z=R5.gen();F=GF(25,'beta',modulus=z*z-z-3);beta=F.gen()
def code(c):return F(c%5)+F(c//5)*beta
L=PolynomialRing(F,'lam');lam=L.gen();S=PolynomialRing(L,'x');x=S.gen()
def poly(cs):return S([code(c) for c in cs])
P=poly([11,22,18,5,19,20,15,16,9,22,1]);Z=poly([15,19,24,12,10,19,3,24,18,16])
q3=poly([1,22,9,1]);q=poly([13,18,24]);delta=q3+lam*q;K,rem=(Z*delta).quo_rem(P)
gg=(-8*K**3*P)%delta;g0,g1,g2=[gg[i] for i in range(3)];d0,d1,d2=[delta[i] for i in range(3)]
T=PolynomialRing(L,'t');t=T.gen()
f=g1*(3*t-d2)-g2*(3*t*t-d1)
h=g0*(3*t-d2)-g2*(t**3-d0)
matrix_sylvester=f.sylvester_matrix(h)
def determinant(m):
 n=m.nrows();out=L.zero()
 for perm in permutations(range(n)):
  sign=(-1)**sum(perm[i]>perm[j] for i in range(n) for j in range(i+1,n))
  out+=sign*prod(m[i,perm[i]] for i in range(n))
 return out
resultant=determinant(matrix_sylvester);assert resultant
primitive,extra=resultant.quo_rem(g2**2);assert not extra
assert primitive
support=resultant.radical().monic()
def multiplication(f):
 cols=[(x**j*f)%delta for j in range(3)]
 return matrix(L,[[cols[j][i] for j in range(3)] for i in range(3)])
boundary={'discriminant':-determinant(multiplication(delta.derivative())),
      'cubic_branch':determinant(multiplication(P)), 'Kummer_zero':determinant(multiplication(K)),
      'selected_endpoint':determinant(multiplication(poly([1,21,14,22,13])))}
def encode(c):
 cs=c.polynomial().list();return int(cs[0] if cs else 0)+(5*int(cs[1]) if len(cs)>1 else 0)
def encoded(g):return [encode(c) for c in g.list()]
out={'scope':'Necessary lambda support for simple unramified no-C-singleton/b-singleton all3 fibers, actual affine D1 slope nonzero. All g2/leading-t degeneracies retained via raw resultant support.',
    'field_modulus':[int(c) for c in F.modulus().list()], 'g_coefficients':[encoded(g) for g in [g0,g1,g2]],
    'raw_resultant':encoded(resultant),'raw_degree':int(resultant.degree()),'primitive_after_g2_squared':encoded(primitive),
    'primitive_degree':int(primitive.degree()),'g2_drop':encoded(g2),'squarefree_support':encoded(support),
    'support_degree':int(support.degree()),'factors':[{'degree':int(a.degree()),'multiplicity':int(m),'polynomial':encoded(a)} for a,m in support.factor()],
    'boundary_gcd_degrees':{key:int(support.gcd(v).degree()) for key,v in boundary.items()},
    'primitive_boundary_gcd_degrees':{key:int(primitive.gcd(v).degree()) for key,v in boundary.items()},
    'primitive_at_zero':encode(primitive[0]),'seconds':time.monotonic()-started,'sage_version':version()}
folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform')
(folder/'no_single_affine_cube_parameter_support.json').write_text(json.dumps(out,indent=2,default=int)+'\n')
signal.setitimer(signal.ITIMER_REAL,0)
print('NOsingle resultant degrees raw/primitive/support',resultant.degree(),primitive.degree(),support.degree(),'factors',[(a.degree(),m) for a,m in support.factor()],'boundary',out['boundary_gcd_degrees'],'seconds',time.monotonic()-started)
