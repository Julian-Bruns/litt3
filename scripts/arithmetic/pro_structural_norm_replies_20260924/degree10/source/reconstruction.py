"""Exact linear reconstruction over F_25, then F_25[rho]/(A)."""
from ff25 import *
import numpy as np
add=np.array(ADD,dtype=np.int16); mul=np.array(MUL,dtype=np.int16); neg=np.array(NEG,dtype=np.int16)
PPOW=[ppow(P,n) for n in range(5)]
VARS=[(i,r,a) for i in range(6) for r in range(3) for a in range((10+12*i-10*r)//3+1)]
assert len(VARS)==195

def rref25(M):
 M=np.array(M,dtype=np.int16).copy(); row=0; piv=[]
 for col in range(M.shape[1]):
  nz=np.nonzero(M[row:,col])[0]
  if not len(nz):continue
  k=row+int(nz[0]); M[[row,k]]=M[[k,row]]
  M[row]=mul[INV[int(M[row,col])],M[row]]
  factors=M[:,col].copy();factors[row]=0
  M=add[M,neg[mul[factors[:,None],M[row][None,:]]]]
  piv.append(col);row+=1
  if row==M.shape[0]:break
 return M,piv

def null25(M):
 R,piv=rref25(M);free=[j for j in range(R.shape[1]) if j not in piv]
 K=np.zeros((R.shape[1],len(free)),dtype=np.int16)
 for t,j in enumerate(free):
  K[j,t]=1
  for r,k in enumerate(piv):K[k,t]=neg[R[r,j]]
 assert not np.any(matmul25(np.array(M,dtype=np.int16),K))
 return K,piv

def matmul25(A,B):
 C=np.zeros((A.shape[0],B.shape[1]),dtype=np.int16)
 for j in range(A.shape[1]):C=add[C,mul[A[:,j,None],B[None,j,:]]]
 return C

def matrix4():
 rows=[]
 for j in range(1,6):
  for r in range(min(3,j)):
   mod=ppow(P,(j-r+2)//3)
   for a in range(len(mod)-1):rows.append((j,r,a))
 indexes={t:n for n,t in enumerate(rows)}
 M=np.zeros((150,195),dtype=np.int16)
 for col,(i,r,a) in enumerate(VARS):
  for j in range(max(1,i),6):
   if r>=j:continue
   c=math.comb(5-i,j-i)%5
   if not c:continue
   poly=[0]*a+pscale(ppow(pneg(B0),j-i),c)
   rem=pmod(poly,ppow(P,(j-r+2)//3))
   for d,u in enumerate(rem):M[indexes[(j,r,d)],col]=u
 return M

# E=F25[rho]/A, code n0+25n1+625n2+15625n3.
AM=pscale(A,INV[A[-1]])
DIG=np.array([[n//25**j%25 for n in range(390625)] for j in range(4)],dtype=np.int16)

def enc(c):
 return sum(int(c[j])*25**j for j in range(4))

def eadd(a,b):return enc(add[DIG[:,a],DIG[:,b]])
def eneg(a):return enc(neg[DIG[:,a]])
def esub(a,b):return eadd(a,eneg(b))
def emul(a,b):
 if a==0 or b==0:return 0
 aa=[int(x) for x in DIG[:,a]];bb=[int(x) for x in DIG[:,b]]
 c=[0]*7
 for i in range(4):
  if aa[i]:
   for j in range(4):
    if bb[j]:c[i+j]=ADD[c[i+j]][MUL[aa[i]][bb[j]]]
 for i in range(6,3,-1):
  if c[i]:
   for j in range(4):c[i-4+j]=ADD[c[i-4+j]][NEG[MUL[c[i]][AM[j]]]]
 return sum(c[j]*25**j for j in range(4))

def epow(a,n):
 o=1
 while n:
  if n&1:o=emul(o,a)
  a=emul(a,a);n//=2
 return o
def einv(a):
 if not a:raise ZeroDivisionError
 return epow(a,390623)

def epadd(a,b):return trim([eadd(a[i] if i<len(a) else 0,b[i] if i<len(b) else 0) for i in range(max(len(a),len(b)))])
def epneg(a):return [eneg(t) for t in a]
def epsub(a,b):return epadd(a,epneg(b))
def epscale(a,c):return trim([emul(t,c) for t in a])
def epmul(a,b):
 if not a or not b:return []
 o=[0]*(len(a)+len(b)-1)
 for i,t in enumerate(a):
  if t:
   for j,u in enumerate(b):
    if u:o[i+j]=eadd(o[i+j],emul(t,u))
 return trim(o)
def eppow(a,n):
 o=[1]
 while n:
  if n&1:o=epmul(o,a)
  a=epmul(a,a);n//=2
 return o
def epdivmod(a,b):
 a=trim(a);b=trim(b)
 if not b:raise ZeroDivisionError
 ib=einv(b[-1]);o=[0]*max(0,len(a)-len(b)+1)
 while a and len(a)>=len(b):
  i=len(a)-len(b);t=emul(a[-1],ib);o[i]=t
  for j,u in enumerate(b):a[i+j]=esub(a[i+j],emul(t,u))
  a=trim(a)
 return trim(o),a
def epmod(a,b):return epdivmod(a,b)[1]

def evmul(A,B):
 # first dimension four; numpy broadcasting for other dimensions
 c=np.zeros((7,)+np.broadcast_shapes(A.shape[1:],B.shape[1:]),dtype=np.int16)
 for i in range(4):
  for j in range(4):c[i+j]=add[c[i+j],mul[A[i],B[j]]]
 for i in range(6,3,-1):
  for j in range(4):c[i-4+j]=add[c[i-4+j],neg[mul[c[i],AM[j]]]]
 return c[:4]

def rrefE(M):
 M=M.copy();row=0;piv=[]
 for col in range(M.shape[2]):
  nz=np.nonzero(np.any(M[:,row:,col],axis=0))[0]
  if not len(nz):continue
  k=row+int(nz[0]);M[:,[row,k],:]=M[:,[k,row],:]
  inv=DIG[:,einv(enc(M[:,row,col]))]
  M[:,row,:]=evmul(inv[:,None],M[:,row,:])
  factors=M[:,:,col].copy();factors[:,row]=0
  M=add[M,neg[evmul(factors[:,:,None],M[:,row,None,:])]]
  piv.append(col);row+=1
  if row==M.shape[1]:break
 return M,piv

def nullE(M):
 R,piv=rrefE(M);free=[j for j in range(R.shape[2]) if j not in piv]
 K=np.zeros((4,R.shape[2],len(free)),dtype=np.int16)
 for t,j in enumerate(free):
  K[0,j,t]=1
  for r,k in enumerate(piv):K[:,k,t]=neg[R[:,r,j]]
 assert not np.any(matmulE(M,K))
 return K,piv

def matmulE(A,B):
 C=np.zeros((4,A.shape[1],B.shape[2]),dtype=np.int16)
 for j in range(A.shape[2]):
  if np.any(A[:,:,j]) and np.any(B[:,j,:]):C=add[C,evmul(A[:,:,j,None],B[:,None,j,:])]
 return C

def extra_matrix(rho=25):
 tB,rem=epdivmod(AM,[eneg(rho),1]);assert rem==[]
 tB2=eppow(tB,2); tB3=eppow(tB,3)
 J,rem=epdivmod(psub(Q,ppow(L,5)),tB3);assert rem==[]
 M=np.zeros((4,30,196),dtype=np.int16)
 # C0=(D(-L)); J*C0 + kappa*y^10 modulo tB^2; C1=D'(-L) mod tB.
 for col,(i,r,a) in enumerate(VARS):
  C0=[0]*a+ppow(pneg(L),5-i)
  rem=epmod(epmul(J,C0),tB2)
  for d,u in enumerate(rem):M[:,6*r+d,col]=DIG[:,u]
  if i<5 and (5-i)%5:
   C1=[0]*a+pscale(ppow(pneg(L),4-i),(5-i)%5)
   rem=epmod(C1,tB)
   for d,u in enumerate(rem):M[:,18+3*r+d,col]=DIG[:,u]
 rem=epmod(ppow(P,3),tB2)
 for d,u in enumerate(rem):M[:,6+d,195]=DIG[:,u]
 for row,var in [(27,(4,1,16)),(28,(5,0,23)),(29,(5,1,20))]:M[0,row,VARS.index(var)]=1
 M[0,29,VARS.index((5,1,20))]=Q[-1]
 M[0,29,195]=1
 return M,tB

def reconstruct(verbose=False):
 M4=matrix4();K4,p4=null25(M4)
 if verbose: print('matrix4 rank',len(p4),'nullity',K4.shape[1],flush=True)
 J=np.zeros((4,196,48),dtype=np.int16);J[0,:195,:47]=K4;J[0,195,47]=1
 M,tB=extra_matrix()
 MJ=matmulE(M,J);Kadd,padd_=nullE(MJ)
 K=matmulE(J,Kadd)
 if verbose: print('extra rank',len(padd_),'full nullity',K.shape[2],flush=True)
 if verbose: print('kappa values',K[:,195,:].T.tolist(),flush=True)
 # all four Frobenius-conjugate supports are obtained by 25-power of coefficients.
 return M4,K4,M,MJ,K,tB

