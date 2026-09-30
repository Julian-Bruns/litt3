"""Exact univariate operations over K, including reproducible factorization."""
from algebra import *
import random

def trim(f):
 f=list(f)
 while f and not f[-1]:f.pop()
 return f
def ua(f,g):
 h=f+[0]*max(0,len(g)-len(f))
 for i,c in enumerate(g):h[i]=add(h[i],c)
 return trim(h)
def un(f):return [neg(c) for c in f]
def us(f,g):return ua(f,un(g))
def uc(f,c):return trim([mul(a,c) for a in f])
def um(f,g):
 if not f or not g:return []
 h=[0]*(len(f)+len(g)-1)
 for i,a in enumerate(f):
  if a:
   for j,b in enumerate(g):
    if b:h[i+j]=add(h[i+j],mul(a,b))
 return trim(h)
def ud(f,g):
 assert g;f=trim(f);q=[0]*max(0,len(f)-len(g)+1);lc=inv(g[-1])
 while len(f)>=len(g):
  i=len(f)-len(g);a=mul(f[-1],lc);q[i]=a
  for j,b in enumerate(g):f[i+j]=sub(f[i+j],mul(a,b))
  f=trim(f)
 return trim(q),f
def ur(f,g):return ud(f,g)[1]
def monic(f):return uc(f,inv(f[-1])) if f else []
def ug(f,g):
 while g:f,g=g,ur(f,g)
 return monic(f)
def uxg(f,g):
 aa,bb=[1],[];cc,dd=[],[1]
 while g:
  q,r=ud(f,g);f,g=g,r;aa,cc=cc,us(aa,um(q,cc));bb,dd=dd,us(bb,um(q,dd))
 if f:
  s=inv(f[-1]);f,aa,bb=uc(f,s),uc(aa,s),uc(bb,s)
 return f,aa,bb
def up(f,e,mod=None):
 h=[1]
 while e:
  if e&1:h=um(h,f);h=ur(h,mod) if mod else h
  e//=2
  if e:f=um(f,f);f=ur(f,mod) if mod else f
 return h
def derivative(f):return trim([mul(f[i],i%5) for i in range(1,len(f))])
def factor_squarefree(f):
 f=monic(f);assert ug(f,derivative(f))==[1]
 remaining=f;v=[0,1];blocks=[];d=1
 while 2*d<=len(remaining)-1:
  v=up(v,N,remaining);g=ug(remaining,us(v,[0,1]))
  if len(g)>1:
   blocks.append((g,d));remaining=ud(remaining,g)[0];v=ur(v,remaining) if len(remaining)>1 else [];assert len(remaining)
  d+=1
 if len(remaining)>1:blocks.append((remaining,len(remaining)-1))
 rng=random.Random(29092026)
 def equal(g,d):
  if len(g)-1==d:return [g]
  for attempt in range(1000):
   u=[rng.randrange(N) for _ in range(len(g)-1)];h=ug(g,us(up(u,(N**d-1)//2,g),[1]))
   if 1<len(h)<len(g):return equal(h,d)+equal(monic(ud(g,h)[0]),d)
  raise RuntimeError('deterministic splitter exhausted')
 result=[]
 for g,d in blocks:result+=equal(g,d)
 result.sort(key=lambda f:(len(f),f));product=[1]
 for g in result:
  product=um(product,g)
  n=len(g)-1;assert ur(us(up([0,1],N**n,g),[0,1]),g)==[]
  for d in range(1,n//2+1):
   if n%d==0:assert ug(g,us(up([0,1],N**d,g),[0,1]))==[1]
 assert product==f
 return result
