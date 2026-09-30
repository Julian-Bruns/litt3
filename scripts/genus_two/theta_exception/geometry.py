from field import *
from itertools import combinations,combinations_with_replacement
alpha=5
f0=[0,alpha,sub(4,alpha),add(1,alpha),sub(4,alpha),1]
f=[power(c,5) for c in f0]
SQRT={mul(i,i):i for i in range(125)}
POINTS=[(x,y) for x in range(125) for y in range(125) if mul(y,y)==peval(f,x)]
BRANCHES=[0,1,2,3,power(alpha,5)]

def polar(s,p):
 return add(add(add(mul(f[1],s),mul(mul(2,f[2]),p)),mul(f[3],mul(s,p))),add(mul(mul(2,f[4]),mul(p,p)),mul(s,mul(p,p))))

def kummer_pts(P,Q):
 if P is None and Q is None:return (0,0,0,1)
 if P is None:P,Q=Q,P
 if Q is None:
  x,y=P;return (0,1,x,mul(x,x))
 x,y=P;u,v=Q
 if x==u:
  if y==neg(v):return (0,0,0,1)
  return kummer(mumford_from_pts(P,Q))
 s=add(x,u);p=mul(x,u);disc=power(sub(x,u),2)
 return (1,s,p,div(sub(polar(s,p),mul(2,mul(y,v))),disc))

def mumford_from_pts(P,Q=None):
 if P is None:return ([1],[])
 x,y=P
 if Q is None:return ([neg(x),1],[y])
 u,v=Q
 if x==u:
  if y==neg(v):return ([1],[])
  yp=div(peval([mul(j%5,f[j]) for j in range(1,len(f))],x),mul(2,y))
  return (pmul([neg(x),1],[neg(x),1]),[sub(y,mul(yp,x)),yp])
 a=[mul(x,u),neg(add(x,u)),1];b1=div(sub(v,y),sub(u,x));b0=sub(y,mul(b1,x))
 return (a,[b0,b1])

def jac_add(D,E):
 # Cantor algorithm for y^2=f.
 a,b=D;c,d=E
 g,h1,h2=pxgcd(a,c)
 e,l1,l2=pxgcd(g,padd(b,d))
 s1=pmul(l1,h1);s2=pmul(l1,h2);s3=l2
 aa=pexact(pmul(a,c),pmul(e,e))
 bb=pmod(pexact(padd(padd(pmul(pmul(s1,a),d),pmul(pmul(s2,c),b)),pmul(s3,padd(pmul(b,d),f))),e),aa)
 while len(aa)>3:
  aa=pmonic(pexact(psub(f,pmul(bb,bb)),aa));bb=pmod(pneg(bb),aa)
 aa=pmonic(aa);bb=pmod(bb,aa)
 assert not pmod(psub(pmul(bb,bb),f),aa)
 return aa,bb

def jac_neg(D):return D[0],pneg(D[1])

def kummer(D):
 a,b=D
 if len(a)==1:return (0,0,0,1)
 if len(a)==2:
  x=neg(a[0]);return (0,1,x,mul(x,x))
 p=a[0];s=neg(a[1]);b=list(b)+[0]*(2-len(b));bb=add(add(mul(b[0],b[0]),mul(mul(b[0],b[1]),s)),mul(mul(b[1],b[1]),p))
 disc=sub(mul(s,s),mul(4,p))
 if disc:return (1,s,p,div(sub(polar(s,p),mul(2,bb)),disc))
 # double non-Weierstrass point. Formula using y' and f''
 x=mul(3,s);y=peval(b,x)
 fp=[mul(j%5,f[j]) for j in range(1,len(f))]
 fpp=[mul(j%5,fp[j]) for j in range(1,len(fp))]
 yp=div(peval(fp,x),mul(2,y))
 # expand pair x+epsilon, x-epsilon. k4 = y'^2 - f''/2 + (polar second coeff)/4?
 # polar(s,p) with s=2x, p=x^2-eps^2. denominator4eps^2
 # polar =2 f(x) - eps^2(2f2+f3*2x+4f4*x^2+4*x^3)
 polarder=add(add(mul(2,f[2]),mul(f[3],s)),add(mul(4,mul(f[4],p)),mul(mul(2,s),p)))
 # yy=f(x)+(f''/2-2yp^2)*eps^2
 out=div(sub(sub(mul(4,mul(yp,yp)),peval(fpp,x)),polarder),4)
 return (1,s,p,out)

# Alternating Wirtinger identification; see PROOF.md for its derivation.
def z_from_k(k):return (neg(k[3]),k[2],neg(k[1]),k[0])
def k_from_z(z):return (z[3],neg(z[2]),z[1],neg(z[0]))

# exact supplied Kummer polynomial in bundle coordinates
Gterms={}
def put(c,ex):Gterms[ex]=c
put(1,(2,0,2,0));put(3,(1,2,1,0));put(1,(0,4,0,0))
put(1,(2,1,0,1));put(107,(1,2,0,1));put(66,(1,1,1,1));put(66,(0,3,0,1));put(107,(0,2,1,1));put(106,(0,1,2,1))
put(107,(1,1,0,2));put(68,(1,0,1,2));put(14,(0,2,0,2));put(74,(0,1,1,2));put(37,(0,1,0,3));put(93,(0,0,0,4))
def G(z):
 r=0
 for ex,c in Gterms.items():
  for a,n in zip(z,ex):c=mul(c,power(a,n))
  r=add(r,c)
 return r

MON2=list(combinations_with_replacement(range(4),2))
def v2(z):return [mul(z[i],z[j]) for i,j in MON2]
