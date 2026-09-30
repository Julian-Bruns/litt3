#!/usr/bin/env sage
"""Focused exact check of the new critical-norm exclusion certificate.

Checks the coefficient bridge, all retained tail rows, projection Bezout
identity and original units. Independently reconstructs fixed Sylvester
determinants at extra nodes. Degree-certified interpolation is justified
by the native algorithm, not by these additional controls alone.
"""
import json,sys,time
from pathlib import Path
d=Path(sys.argv[1]);start=time.time();s=load(str(d/'tails.sobj'))
R=s['tails'][0].parent();H,q=R.gens();K=R.base_ring();a=K.gen()
beta=-(a**4+2*a**3+a**2+2*a)/(a**3+a**2+1)
def elt(c):
 z=K(0)
 for i in range(4):
  digit=c%25;c//=25;z+=(digit%5+(digit//5)*beta)*a**i
 return z
native=json.load(open(d/'native_tails.json'))
for tail,rows in zip(s['tails'],native['rows']):assert tail==sum(elt(c)*H**i*q**j for i,j,c in rows)
rec=load(str(d/'resultant_projection.sobj'));p1,p2=rec['polys'];U=p1.parent();z=U.gen()
g,u,v=p1.xgcd(p2);assert u*p1+v*p2==g
factor=U(1)
for f,e in g.factor():factor*=f**e
assert factor==g
# Every projection factor must divide the original cleared coefficient
# denominator. This proves they are units on its domain, without removing
# an arbitrary newly discovered polynomial.
den=s['denominator'];assert den.degree(H)==0
denq=U([den[0,j] for j in range(den.degree(q)+1)])
boundary_count=0
for idx,(f,e) in enumerate(g.factor()):
 if denq%f==0:continue
 b=load(str(d/('boundary_identity_%02d.sobj'%idx)))
 assert b['factor']==f
 assert sum(c*p for c,p in zip(b['multipliers'],b['tail_values']))==b['gcd']
 assert b['gcd']==b['gcd'].parent().gen()**b['gcd'].valuation()
 boundary_count+=1
LH=PolynomialRing(K,'h');hh=LH.gen();checks=[]
for qq in [a+1,a**2+2,a**3+3]:
 pol=[]
 for t in s['tails'][:3]:pol.append(LH([sum(c*qq**j for (i0,j),c in t.dict().items() if i0==i) for i in range(t.degree(H)+1)]))
 for k,expected in enumerate([p1,p2],1):
  m=s['tails'][0].degree(H);n=s['tails'][k].degree(H)
  mat=matrix(K,m+n)
  for i in range(n):
   for j in range(m+1):mat[i,i+j]=pol[0][m-j]
  for i in range(m):
   for j in range(n+1):mat[n+i,i+j]=pol[k][n-j]
  assert mat.det()==expected(qq)
  checks.append((k,str(qq)))
save({'gcd':g,'multipliers':[u,v],'resultants':[p1,p2],'original_denominator':denq},str(d/'projection_bezout.sobj'))
receipt={'status':'PASS','scope':'Critical quadratic norm never square on the original allowed ratio chart; not a specialized residual-square exclusion.','degrees':[int(p1.degree()),int(p2.degree())],'gcd_degree':int(g.degree()),'gcd_factors':[(str(f),int(e)) for f,e in g.factor()],'all_factors_original_units':boundary_count==0,'retained_boundary_identities':boundary_count,'literal_univariate_bezout':True,'all_exported_tail_rows_checked':True,'extra_sylvester_checks':len(checks),'seconds':time.time()-start}
(d/'verified_exclusion.json').write_text(json.dumps(receipt,indent=2,default=int)+'\n');print(json.dumps(receipt,indent=2,default=int),flush=True)
