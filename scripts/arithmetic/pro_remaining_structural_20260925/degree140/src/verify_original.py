"""Independent direct checks of original equations and fixed Sylvester resultants."""
import math,json
from reconstruct import *

def cpole(F):return max([3*i+10*j for j,p in enumerate(F) for i,c in enumerate(p) if c]+[-10**6])
def cyeval(F,x,y):return sumf(mul(peval(p,x),powf(y,j)) for j,p in enumerate(F))
def ydivisible(F,j):
 return all(not pmod(F[l],ppow(P,max(0,(j-l+2)//3))) for l in range(3))
def verify_original(vec,root,kappa=1):
 H,k=unpack(vec);assert k==1
 v=[1] if root is None else [neg(root),1]
 Ns={i:zero() for i in range(11)};Ns[0]=cone(v)
 for i in range(2,6):Ns[i]=cscale(H[i],kappa)
 Ns[5]=cadd(Ns[5],cone(pmul(v,Q)))
 for j in range(1,6):
  E=zero()
  for i in range(j+1):
   E=cadd(E,cscale(cxmul(Ns[i],ppow(pscale(B0,4),j-i)),math.comb(5-i,j-i)%5))
  assert ydivisible(E,j),('equation1',j)
 for j in range(5):
  E=zero()
  for i in range(6-j):
   E=cadd(E,cscale(cxmul(Ns[i],ppow(pscale(L0,4),5-i-j)),math.comb(5-i,j)%5))
  E=cxmul(E,psub(Q,ppow(L0,5)))
  if j==0:E=cadd(E,cscale(ty10,kappa))
  assert all(not pmod(p,ppow(t,5-j)) for p in E),('equation2',j)
 for j in range(11):
  E=Ns[j]
  if j>=5:E=cadd(E,cxmul(Ns[j-5],Q))
  if j==10:E=cadd(E,cscale(ty10,kappa))
  assert cpole(E)<=10+12*j-max(0,j-5),('equation3',j,cpole(E))
 for i,d in [(2,34),(3,46),(4,57),(5,70)]:assert cpole(Ns[i])<=d
 D2=zero()
 for (n,i,j),z in zip(slots,vec):
  if n==2:D2=cadd(D2,cscale(cmon(i,j),mul(int(z),kappa)))
 assert Ns[2]==cmul(D2,cmon(0,2))
 assert cpole(D2)==(12 if root is None else 13)
 if root is not None:assert peval(D2[0],root)==0
 aa=int(vec[slots.index((2,4,0) if root is None else (2,1,1))]);aa=mul(aa,kappa)
 b=mul(int(vec[slots.index((3,12,1))]),kappa);c=mul(int(vec[slots.index((3,15,0))]),kappa)
 d=mul(int(vec[slots.index((4,19,0))]),kappa);e=mul(int(vec[slots.index((4,12,2))]),kappa);f=mul(int(vec[slots.index((5,16,2))]),kappa)
 z=div(mul(2,d),b)
 U=add(mul(mul(8,kappa),powf(z,5)),mul(24,add(div(mul(d,d),b),f)))
 V=add(mul(eta,kappa),mul(24,add(mul(c,mul(z,z)),mul(e,z))))
 assert aa and b and d and not U and not V
 return Ns

def sylvester_det(f,g,m=10,n=2):
 fd=list(f)+[0]*max(0,m+1-len(f));gd=list(g)+[0]*max(0,n+1-len(g))
 fd=fd[:m+1][::-1];gd=gd[:n+1][::-1]
 M=[]
 for i in range(n):M.append([0]*i+fd+[0]*(n-1-i))
 for i in range(m):M.append([0]*i+gd+[0]*(m-1-i))
 A=np.array(M,dtype=np.int32);det=1
 for i in range(m+n):
  nz=np.flatnonzero(A[i:,i])
  if not len(nz):return 0
  q=i+int(nz[0])
  if q!=i:A[[i,q]]=A[[q,i]];det=neg(det)
  p=int(A[i,i]);det=mul(det,p)
  for j in range(i+1,m+n):
   if A[j,i]:A[j,i:]=vsub(A[j,i:],vmul(div(int(A[j,i]),p),A[i,i:]))
 return det

def test_resultant(H,v,data,points=3):
 rs=data['resultant_coefficients'];Rl=data['lambda_coefficients'];zet=EXP[390624//3];count=0
 for x in range(1,200):
  px=peval(P,x)
  if not px or LOG[px]%3 or not peval(t,x) or not peval(v,x):continue
  y=EXP[LOG[px]//3]
  for lam in [0,1,7]:
   pro=1
   for twist in range(3):
    yy=mul(y,powf(zet,twist));hh={i:cyeval(H[i],x,yy) for i in range(2,6)};q=peval(Q,x);vv=peval(v,x);q0=mul(powf(peval(t,x),3),powf(yy,10))
    f=[0]*11;f[10]=mul(lam,vv);f[8]=hh[2];f[7]=hh[3];f[6]=hh[4];f[5]=add(hh[5],mul(mul(2,lam),mul(vv,q)));f[3]=mul(q,hh[2]);f[2]=mul(q,hh[3]);f[1]=mul(q,hh[4]);f[0]=add(add(mul(q,hh[5]),q0),mul(lam,mul(vv,mul(q,q))))
    g=[hh[4],mul(2,hh[3]),mul(3,hh[2])]
    direct=sylvester_det(f,g)
    formula=sumf(mul(powf(lam,j),cyeval(rs[j],x,yy)) for j in range(3))
    assert direct==formula,('resultant formula',x,lam,twist,direct,formula)
    pro=mul(pro,direct)
   numerator=mul(sumf(mul(powf(lam,j),peval(p,x)) for j,p in enumerate(Rl)),mul(powf(px,40),mul(powf(peval(t,x),15),powf(peval(v,x),3))))
   assert numerator==pro,('norm residual',x,lam)
  count+=1
  if count==points:break
 assert count==points
 return count*9
