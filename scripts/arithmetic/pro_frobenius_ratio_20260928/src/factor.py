"""Deterministic-seeded exact squarefree factorization over K (no external CAS)."""
import random
from ff import Poly,X
SIZE=390625

def factor_squarefree(f,seed=20260927):
 f=Poly(f).monic()
 assert f.gcd(f.derivative())==Poly(1)
 rng=random.Random(seed);blocks=[];h=X;d=0;r=f
 while r.degree()>0 and 2*(d+1)<=r.degree():
  d+=1;h=h.powmod(SIZE,r);g=(h-X).gcd(r)
  if g.degree()>0:
   blocks.append((g,d));r=r//g
   if r.degree()>0:h=h%r
 if r.degree()>0:blocks.append((r,r.degree()))
 out=[]
 def edf(g,d):
  if g.degree()==d:out.append(g.monic());return
  for attempt in range(1000):
   z=Poly([rng.randrange(SIZE) for _ in range(g.degree())])
   a=z.gcd(g)
   if not (0<a.degree()<g.degree()):a=(z.powmod((SIZE**d-1)//2,g)-1).gcd(g)
   if 0<a.degree()<g.degree():edf(a,d);edf(g//a,d);return
  raise RuntimeError('EDF retry bound exhausted')
 for g,d in blocks:edf(g,d)
 p=Poly(1)
 for g in out:p=p*g
 assert p==f
 return sorted(out,key=lambda p:(p.degree(),p.tolist()))

def irreducible(f):
 f=f.monic();n=f.degree()
 if n<1:return False
 if n==1:return True
 h=X
 for d in range(1,n+1):
  h=h.powmod(SIZE,f)
  if d<=n//2 and (h-X).gcd(f).degree()>0:return False
 return h==X%f
if __name__=='__main__':
 from boundary_cases import make_cases
 for name,p in make_cases():
  sf=p//p.gcd(p.derivative());fs=factor_squarefree(sf)
  assert all(irreducible(g) for g in fs)
  print(name,[g.degree() for g in fs])
