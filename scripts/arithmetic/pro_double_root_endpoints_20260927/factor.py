"""Deterministic-seeded factorization over the exact field K.
All outputs are verified by multiplication and irreducibility tests.
"""
from exact import *
import random,json
RNG=random.Random(10927)
ORDER=390625

def monic(f):return pc(f,inv(f[-1])) if f else []
def irreducible(f):
 f=monic(f);n=len(f)-1
 if n<=0:return False
 if n==1:return True
 x=[0,1];h=x
 for i in range(1,n+1):
  h=pmodpow(h,ORDER,f)
  if i<=n//2 and pgcd(ps(h,x),f)!=[1]:return False
 return h==x

def split_equal(f,d):
 n=len(f)-1
 if n==d:return [f]
 for _ in range(10000):
  a=[RNG.randrange(ORDER) for i in range(n)]
  g=pgcd(a,f)
  if 0<len(g)-1<n:return split_equal(g,d)+split_equal(pexact(f,g),d)
  h=ps(pmodpow(a,(ORDER**d-1)//2,f),[1]);g=pgcd(h,f)
  if 0<len(g)-1<n:return split_equal(g,d)+split_equal(pexact(f,g),d)
 raise RuntimeError('deterministic-seeded splitting did not finish')

def factor_squarefree(f):
 f=monic(f)
 if len(f)<=1:return []
 x=[0,1];h=x;parts=[];d=1
 while 2*d<=len(f)-1:
  h=pmodpow(h,ORDER,f);g=pgcd(ps(h,x),f)
  if len(g)>1:
   parts+=split_equal(g,d);f=pexact(f,g);h=prem(h,f) if len(f)>1 else []
  d+=1
 if len(f)>1:parts.append(f)
 return sorted(parts,key=lambda a:(len(a),a))

def factor(f):
 original=f;f=monic(f)
 if len(f)<=1:return []
 der=pder(f)
 if not der:
  root=[power(f[i],5**7) for i in range(0,len(f),5)]
  return [(g,5*m) for g,m in factor(root)]
 g=pgcd(f,der);w=pexact(f,g);i=1;out=[]
 while len(w)>1:
  y=pgcd(w,g);z=pexact(w,y)
  for a in factor_squarefree(z):out.append((a,i))
  w=y;g=pexact(g,y);i+=1
 if len(g)>1:
  root=[power(g[i],5**7) for i in range(0,len(g),5)]
  for a,m in factor(root):out.append((a,5*m))
 product=[1]
 for a,m in out:
  assert irreducible(a)
  product=pm(product,pp(a,m))
 assert product==f
 return sorted(out,key=lambda a:(len(a[0]),a))

if __name__=='__main__':
 b,c,e=[DATA[z] for z in ['b','c','e']]
 arrays={z:DATA[z] for z in ['a0','d','b','c','e','C']}
 arrays['leading_boundary']=pa(pp(c,2),pm(b,e))
 a=DATA['a0']
 arrays['zero_F_projection']=pa(pa(pm(pp(b,2),pp(c,2)),pm(a,pp(c,3))),pa(pm(pp(b,3),e),pa(pc(pm(pp(a,2),pp(e,2)),3),pc(pm(pm(pm(a,b),c),e),3))))
 out={}
 for z,poly in arrays.items():
  fs=factor(poly);out[z]={'polynomial':poly,'leading_scalar':poly[-1],'factors':fs}
  print(z,'degree',len(poly)-1,'factors',[(len(f)-1,m) for f,m in fs],flush=True)
  if all(len(f)==2 for f,m in fs):print('roots',[neg(f[0]) for f,m in fs],flush=True)
 for z in ['b','c']:
  print('gcd',z,'e',pgcd(DATA[z],e),flush=True)
 (ROOT/'evidence/ratio_factorizations.json').write_text(json.dumps(out,separators=(',',':'))+'\n')
