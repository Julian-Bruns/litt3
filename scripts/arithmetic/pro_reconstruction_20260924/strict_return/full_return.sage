# Full actual second-return equations, not a rank-drop substitute.
# Usage: sage full_return.sage 0
# The argument j chooses the projective chart z_j=1 (0 <= j < 19).
# Output: return_chart_j.sing and return_chart_j.sobj.
# This symbolic Sage generator was supplied but NOT executed in the session.
# The corresponding finite-field arithmetic, divisor-frame formulas, quotient
# tensor, and stability-section data have separately executed Python checks.
import sys, json
from pathlib import Path
ROOT=Path(__file__).resolve().parent
Fp=GF(5)
BB=PolynomialRing(Fp,'t'); t=BB.gen()
F=GF(25,name='a',modulus=t^2-t-3); a=F.gen()
def code(n):return F(n%5)+F(n//5)*a
names=['z%d'%i for i in range(19)]+['h%d'%i for i in range(402)]
S=PolynomialRing(F,names=names,order='degrevlex')
z=list(S.gens()[:19]); h=list(S.gens()[19:])
P={(i,0):S(code(c)) for i,c in enumerate((11,22,18,5,19,20,15,16,9,22,1))}
e={(-i,2):S(code(c)) for i,c in enumerate((2,16,16,7,1,2,7,1,24,11),1)}
def clean(p):return {m:c for m,c in p.items() if c!=0}
def add(*args):
 out={}
 for p in args:
  for m,c in p.items():out[m]=out.get(m,S.zero())+c
 return clean(out)
def neg(p):return {m:-c for m,c in p.items()}
def mono(i=0,j=0,c=1):return {(i,j):S(c)} if c!=0 else {}
def mul(p,q):
 out={}
 for (i,j),c in p.items():
  for (ii,jj),cc in q.items():
   if j+jj<3:
    m=(i+ii,j+jj);out[m]=out.get(m,S.zero())+c*cc
   else:
    for (l,_),d in P.items():
     m=(i+ii+l,j+jj-3);out[m]=out.get(m,S.zero())+c*cc*d
 return clean(out)
def power(p,n):
 out=mono()
 while n:
  if n%2:out=mul(out,p)
  n//=2
  if n:p=mul(p,p)
 return out
def pos(p):return {m:c for m,c in p.items() if m[0]>=0}
def tail(p):return {m:c for m,c in p.items() if m[0]<0}
def scale(c,p):return clean({m:c*d for m,d in p.items()})
def bas0(d):return [(i,j) for j in range(3) for i in range(max(0,(d-10*j)//3+1))]
def bas1(d):return [(i,j) for j in range(3) for i in range((d-10*j)//3+1,0)]
def linear(keys,cs):return add(*(mono(i,j,c) for (i,j),c in zip(keys,cs)))
uk=[(-1,1)]+[(i,2) for i in range(-5,0)]
vk=[(-2,0),(-1,0)]+[(i,1) for i in range(-5,0)]+[(i,2) for i in range(-6,0)]
u=linear(uk,z[:6]);v=linear(vk,z[6:])
E=power(e,25)
# Absolute Frobenius raises extension coefficients as well as functions.
U=add(*(scale(c^25,power(mono(*m),25)) for m,c in zip(uk,z[:6])))
V=add(*(scale(c^25,power(mono(*m),25)) for m,c in zip(vk,z[6:])))
# Five free groups, dimensions 23+12,123,112,16,116.
ff=linear(bas0(31),h[:23])
aa=add(pos(mul(e,ff)),linear(bas0(20),h[23:35]))
g0=linear(bas0(131),h[35:158])
q0=linear(bas0(120),h[158:270])
s0=linear(bas0(24),h[270:286])
t0=linear(bas0(124),h[286:402])
pp=add(aa,neg(mul(e,ff)))
uf=mul(U,ff);wt=tail(uf)
gg=add(g0,neg(pos(uf)))
cc=add(mul(e,g0),mul(e,wt),neg(mul(U,aa)))
qq=add(q0,pos(cc))
rhs_b=add(mul(E,add(g0,wt)),mul(V,ff))
hh=neg(pos(rhs_b))
rhs_a=add(neg(mul(e,hh)),mul(E,add(q0,neg(tail(cc)))),mul(V,pp))
rr=neg(pos(rhs_a))
ua_vf=add(mul(u,aa),mul(v,ff))
nn=add(s0,pos(ua_vf));nv=add(s0,neg(tail(ua_vf)))
w=add(mul(u,qq),mul(v,gg),neg(mul(U,nv)))
na=add(t0,pos(w))
rhs_n=add(neg(mul(u,rr)),neg(mul(v,hh)),mul(E,add(t0,neg(tail(w)))),mul(V,nv))
nb=neg(pos(rhs_n))
H=[[nn,na,nb],[aa,qq,rr],[ff,gg,hh]]
eqs=[p.get(m,S.zero()) for p,d in [(rhs_b,-144),(rhs_a,-155),(rhs_n,-151)] for m in bas1(d)]
assert len(eqs)==474
# P*=([5],[14]) is a fixed affine F25 point of X.
xx,yy=code(5),code(14)
def evaluate(p):
 assert all(i>=0 for i,j in p)
 return sum((c*xx^i*yy^j for (i,j),c in p.items()),S.zero())
assert sum((code(c)*xx^i for i,c in enumerate((11,22,18,5,19,20,15,16,9,22,1))),F.zero())==yy^3
HQ=matrix(S,3,3,[evaluate(H[i][j]) for i in range(3) for j in range(3)])
# Any invertible return can be rescaled to determinant 1 over the algebraic
# closure. Since 3 is prime to 5, this leaves exactly three normalized
# isomorphisms over each stable fixed point.
j=int(sys.argv[1]) if len(sys.argv)>1 else 0
assert 0<=j<19
eqs=eqs+[HQ.det()-1,z[j]-1]
# Stability is an additional REQUIRED open condition: z must not lie on Sigma.
# Its dual evaluation sections are supplied in stability_sections.json.
# No assertion of stability or of completeness of a solved root set is made
# merely from producing this ideal.
save({'ring':S,'equations':eqs,'H_U':H,'chart':j,
      'stability_required':'z outside the ruled surface parameterized in stability_sections.json'},str(ROOT/('return_chart_%d.sobj'%j)))
with open(ROOT/('return_chart_%d.sing'%j),'w') as out:
 out.write('ring r=(5,a),('+','.join(names)+'),dp;\nminpoly=a^2-a-3;\n')
 out.write('ideal I=\n'+',\n'.join(str(p) for p in eqs)+';\n')
 out.write('// Stability: exclude Sigma. This file constructs equations only.\n')
 out.write('// optional exhaustive step: ideal G=std(I); G;\n')
print('Constructed chart',j,': 474 morphism equations, det(H(P*))=1, z_j=1.')
print('Still required: solve geometrically and discard Sigma. No finite-field scan is exhaustive.')
