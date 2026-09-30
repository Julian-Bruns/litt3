"""Ascending univariate polynomials over the supplied encoded F25."""
import sys,itertools

from compute import ADD,MUL,NEG,INV,rref,np

def trim(a):
 a=list(map(int,a))
 while a and a[-1]==0:a.pop()
 return a

def pa(a,b):
 n=max(len(a),len(b));c=[0]*n
 for i in range(n):c[i]=int(ADD[a[i] if i<len(a) else 0,b[i] if i<len(b) else 0])
 return trim(c)
def ps(c,a):return trim([MUL[c,x] for x in a])
def pn(a):return ps(4,a)
def pm(a,b):
 c=[0]*max(0,len(a)+len(b)-1)
 for i,x in enumerate(a):
  if x:
   for j,y in enumerate(b):c[i+j]=int(ADD[c[i+j],MUL[x,y]])
 return trim(c)
def pd(a,b):
 a=trim(a);b=trim(b);assert b
 q=[0]*max(0,len(a)-len(b)+1)
 while len(a)>=len(b):
  i=len(a)-len(b);c=int(MUL[a[-1],INV[b[-1]]]);q[i]=c
  a=pa(a,[0]*i+ps(int(NEG[c]),b))
 return trim(q),a
def pg(a,b):
 while b:a,b=b,pd(a,b)[1]
 return ps(int(INV[a[-1]]),a) if a else []
def pxg(a,b):
 s0,s1,t0,t1=[1],[],[],[1]
 while b:
  q,r=pd(a,b);a,b=b,r
  s0,s1=s1,pa(s0,pn(pm(q,s1)));t0,t1=t1,pa(t0,pn(pm(q,t1)))
 if not a:return [],[],[]
 c=int(INV[a[-1]]);return ps(c,a),ps(c,s0),ps(c,t0)
def pe(a,x):
 r=0
 for v in reversed(a):r=int(ADD[MUL[r,x],v])
 return r
def pp(a,n,mod=None):
 r=[1]
 while n:
  if n&1:r=pm(r,a);r=pd(r,mod)[1] if mod else r
  n//=2
  if n:a=pm(a,a);a=pd(a,mod)[1] if mod else a
 return r
def deriv(a):return trim([MUL[i%5,a[i]] for i in range(1,len(a))])
def interp(xs,ys):
 out=[]
 for i,(x,y) in enumerate(zip(xs,ys)):
  p=[1];den=1
  for j,z in enumerate(xs):
   if i!=j:p=pm(p,[int(NEG[z]),1]);den=int(MUL[den,ADD[x,NEG[z]]])
  out=pa(out,ps(int(MUL[y,INV[den]]),p))
 return out

def det(a):
 a=np.array(a,dtype=np.uint8).copy();n=a.shape[0];assert a.shape==(n,n)
 v=1
 for j in range(n):
  k=j
  while k<n and a[k,j]==0:k+=1
  if k==n:return 0
  if k!=j:a[[j,k]]=a[[k,j]];v=int(NEG[v])
  v=int(MUL[v,a[j,j]])
  for i in range(j+1,n):
   if a[i,j]:
    c=int(NEG[MUL[a[i,j],INV[a[j,j]]]])
    a[i,j:]=ADD[a[i,j:],MUL[c,a[j,j:]]]
 return v

def pencilminor(C,rr,cc):
 d=len(rr);xs=list(range(d+1));ys=[det(ADD[C[0][np.ix_(rr,cc)],MUL[r,C[1][np.ix_(rr,cc)]]]) for r in xs]
 return interp(xs,ys)

def minorgcd(C,rank):
 rrall=list(itertools.combinations(range(C.shape[1]),rank));ccall=list(itertools.combinations(range(C.shape[2]),rank))
 records=[];g=[];bez=[]
 for rr in rrall:
  for cc in ccall:
   f=pencilminor(C,rr,cc)
   if not f:continue
   gg,s,t=pxg(g,f)
   bez=[pm(s,u) for u in bez]+[t];g=gg
   records.append({'rows':list(rr),'cols':list(cc),'poly':f})
   if len(g)==1:
    return {'gcd':g,'minors':records,'bezout':bez,'rank_infinity':len(rref(C[1])[1])}
 return {'gcd':g,'minors':records,'bezout':bez,'rank_infinity':len(rref(C[1])[1])}
