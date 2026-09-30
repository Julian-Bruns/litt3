"""Exact ascending F25 polynomials, coefficients a+5b, beta^2=beta+3."""
import random
ADD=[[ (a%5+b%5)%5+5*((a//5+b//5)%5) for b in range(25)] for a in range(25)]
MUL=[[ ((a%5)*(b%5)+3*(a//5)*(b//5))%5+5*(((a%5)*(b//5)+(a//5)*(b%5)+(a//5)*(b//5))%5) for b in range(25)] for a in range(25)]
NEG=[next(b for b in range(25) if ADD[a][b]==0) for a in range(25)]
INV=[0]+[next(b for b in range(1,25) if MUL[a][b]==1) for a in range(1,25)]
def trim(a):
 a=list(a)
 while a and not a[-1]:a.pop()
 return a
def add(a,b):
 r=list(a)+[0]*max(0,len(b)-len(a))
 for i,c in enumerate(b):r[i]=ADD[r[i]][c]
 return trim(r)
def scale(a,c):return trim([MUL[x][c] for x in a])
def sub(a,b):return add(a,scale(b,4))
def mul(a,b):
 if not a or not b:return []
 r=[0]*(len(a)+len(b)-1)
 for i,x in enumerate(a):
  if x:
   mx=MUL[x]
   for j,y in enumerate(b):
    if y:r[i+j]=ADD[r[i+j]][mx[y]]
 return trim(r)
def divmodp(a,b):
 a=trim(a);b=trim(b)
 if not b:raise ZeroDivisionError
 q=[0]*max(0,len(a)-len(b)+1)
 bi=INV[b[-1]]
 while a and len(a)>=len(b):
  j=len(a)-len(b);c=MUL[a[-1]][bi];q[j]=c;neg=MUL[NEG[c]]
  for i,x in enumerate(b):a[i+j]=ADD[a[i+j]][neg[x]]
  a=trim(a)
 return trim(q),a
def mod(a,b):return divmodp(a,b)[1]
def monic(a):return scale(a,INV[a[-1]]) if a else []
def gcd(a,b):
 while b:a,b=b,mod(a,b)
 return monic(a)
def powmod(a,n,f):
 r=[1];a=mod(a,f)
 while n:
  if n&1:r=mod(mul(r,a),f)
  n>>=1
  if n:a=mod(mul(a,a),f)
 return r
def deriv(a):return trim([MUL[i%5][c] for i,c in enumerate(a)][1:])
def egcd(a,b):
 r0,r1=a,b;s0,s1=[1],[];t0,t1=[],[1]
 while r1:
  q,r=divmodp(r0,r1);r0,r1=r1,r;s0,s1=s1,sub(s0,mul(q,s1));t0,t1=t1,sub(t0,mul(q,t1))
 c=INV[r0[-1]];return scale(r0,c),scale(s0,c),scale(t0,c)
def invmod(a,f):
 g,u,_=egcd(a,f)
 if g!=[1]:raise ZeroDivisionError('nonunit')
 return mod(u,f)
def factor_squarefree(f,seed=1):
 """Distinct/equal degree factorization. Input monic and squarefree."""
 assert f==monic(f) and gcd(f,deriv(f))==[1]
 rng=random.Random(seed);fs=[];d=1;h=[0,1]
 while 2*d<=len(f)-1:
  h=powmod(h,25,f);g=gcd(sub(h,[0,1]),f)
  if len(g)>1:
   fs.append((g,d));f=divmodp(f,g)[0];h=mod(h,f)
  d+=1
 if len(f)>1:fs.append((f,len(f)-1))
 def split(f,d):
  if len(f)-1==d:return [f]
  while True:
   a=[rng.randrange(25) for _ in range(len(f)-1)]
   g=gcd(f,sub(powmod(a,(25**d-1)//2,f),[1]))
   if 1<len(g)<len(f):return split(g,d)+split(divmodp(f,g)[0],d)
 return sorted([x for f,d in fs for x in split(f,d)],key=lambda a:(len(a),a))
def irreducible(f):
 n=len(f)-1
 if n<=0 or f[-1]!=1:return False
 h=[0,1]
 for i in range(1,n+1):
  h=powmod(h,25,f)
  if i<=n//2 and n%i==0 and gcd(sub(h,[0,1]),f)!=[1]:return False
 return mod(sub(h,[0,1]),f)==[]
