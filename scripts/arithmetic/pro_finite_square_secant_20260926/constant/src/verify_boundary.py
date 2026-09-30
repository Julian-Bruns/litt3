"""Independent sparse-Python verification of the C++ infinity certificate.
LP exponents in this module mean (q exponent, x exponent), not (h,w).
"""
from symbolic import LP,zero,one
from exact import *
import time

D=LP({(-1,i):c for i,c in enumerate(P) if c})
class C:
 def __init__(self,a=None):self.a=a if a is not None else [zero,zero,zero]
 @classmethod
 def num(cls,n):return cls([LP.c(n%5),zero,zero])
 def __add__(self,o):
  if not isinstance(o,C):o=C.num(o)
  return C([a+b for a,b in zip(self.a,o.a)])
 __radd__=__add__
 def __neg__(self):return C([-a for a in self.a])
 def __sub__(self,o):return self+-o
 def __mul__(self,o):
  if not isinstance(o,C):o=C.num(o)
  r=[zero,zero,zero]
  for i in range(3):
   for j in range(3):
    v=self.a[i]*o.a[j]
    if i+j>=3:v=v*D
    r[(i+j)%3]=r[(i+j)%3]+v
  return C(r)
 __rmul__=__mul__
 def __pow__(self,n):
  if n==5:return C([self.a[0]**5,(self.a[2]**5)*(D**3),(self.a[1]**5)*D])
  r=C.num(1);a=self
  while n:
   if n&1:r=r*a
   n//=2
   if n:a=a*a
  return r
 def __eq__(self,o):return isinstance(o,C) and self.a==o.a

def formula(a,b,c,d,Q,Cc,lam):
 E=a*d-b*c;Delta=b*b+a*c
 T=c**5-Q*b**5+Q**2*a**5
 U=2*Q*a**5-b**5
 V=-d*b**5-2*c**2*b**4-3*a*b**2*c**3-2*a**2*c**4+Q*(2*a**5*d-a**4*b*c+a**3*b**3)
 W=a**2*d**2-a*b*c*d+2*b**2*c**2+b**3*d+a*c**3
 M=U*(2*a*E+b*Delta)-a**2*V
 return lam**2*T**2+lam*(T*V+Cc*(U**2-2*a**5*T))+a**3*(T*W+Cc*M)+Cc**2*a**10

def from_certificate(row):return LP({(q,x):c for q,x,c in row})

def run():
 st=time.time();cert=json.loads((ROOT/'evidence/infinity_boundary.json').read_text())
 data=json.loads((ROOT/'evidence/normalized_sources.json').read_text())
 sources=[]
 for i,rows in enumerate(data['coefficients']):
  a=[zero,zero,zero]
  for h,q,y,x,c in rows:
   assert h<=1
   if (i<4 and h==1) or (i>=4 and h==0):a[y]=a[y]+LP({(q,x):c})
  sources.append(C(a))
 a,b,c,d=3*sources[0],2*sources[1],sources[2],sources[3];Qb=sources[4]
 vals=[formula(a,b,c,d,Qb,C.num(0),C.num(l)) for l in [0,1,4]]
 const=vals[0];lin=3*(vals[1]-vals[2]);quad=3*(vals[1]+vals[2]-2*vals[0])
 C0,C1,C2=[from_certificate(cert[n]) for n in ['C0','C1','C2']]
 assert const==C([zero,zero,C2])
 assert lin==C([C0,zero,zero])
 assert quad==C([zero,C1,zero])
 # Verify exact full-polynomial identities, not merely leading coefficients.
 AA,BB,CC=[from_certificate(cert[n]) for n in ['A','B','C']]
 tt=LP({(0,i):v for i,v in enumerate(t) if v});pp=LP({(0,i):v for i,v in enumerate(P) if v})
 assert AA*(tt**15)==LP({(-17,0):1})*(pp**2)*(C2**3)
 assert BB*(tt**15)==LP({(-15,0):1})*(C0**3)-LP({(-16,0):3})*pp*C0*C1*C2
 assert CC*(tt**15)==LP({(-16,0):1})*pp*(C1**3)
 for pol,n,term in zip([AA,BB,CC],[119,111,103],[(7,53870),(6,292517),(5,4)]):
  assert max(x for q,x in pol.d)==n
  assert {(q,x):c for (q,x),c in pol.d.items() if x==n}=={(term[0],n):term[1]}
 result={'status':'PASS','method':'independent sparse Python arithmetic; three exact mu evaluations of a degree-two resultant; complete Laurent polynomial identities','source_H_degree':1,'resultant_boundary_characters':['mu*C0','mu^2*C1','C2'],'degrees_x':[119,111,103],'leading_terms':[[7,119,53870],[6,111,292517],[5,103,4]],'exceptional_q_inverted':[],'seconds':time.time()-st}
 (ROOT/'evidence/boundary_independent_checks.json').write_text(json.dumps(result,indent=2)+'\n')
 print(json.dumps(result,sort_keys=True))

if __name__=='__main__':run()
