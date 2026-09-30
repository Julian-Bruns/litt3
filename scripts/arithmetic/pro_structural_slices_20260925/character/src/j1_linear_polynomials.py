from exact import *
import poly25 as pp
from pathlib import Path
import json
root=Path(__file__).resolve().parents[1]
B=np.load(root/'data/fonly_1B_independent.npz')['A']
C=np.load(root/'data/fonly_1C_independent.npz')['A']

def det(A):
 A=A.copy();n=len(A);out=1
 for j in range(n):
  nz=np.flatnonzero(A[j:,j])
  if not len(nz):return 0
  i=j+int(nz[0])
  if i!=j:A[[i,j]]=A[[j,i]];out=int(NEG[out])
  c=int(A[j,j]);out=int(MUL[out,c]);A[j]=MUL[INV[c],A[j]]
  for i in range(j+1,n):
   if A[i,j]:A[i]=SUB[A[i],MUL[A[i,j],A[j]]]
 return out

def det_poly(A):
 n=A.shape[0];vals=[det(ADD[A[:,:,0],MUL[x,A[:,:,1]]]) for x in range(n+1)]
 V=np.array([[pp.evaluate([0]*i+[1],x) for i in range(n+1)] for x in range(n+1)],dtype=np.uint8)
 R,p,H=rref(V,True);assert len(p)==n+1
 coeff=mm(H,np.array(vals,dtype=np.uint8)).tolist();coeff=pp.tr(coeff)
 for x in range(25):assert pp.evaluate(coeff,x)==det(ADD[A[:,:,0],MUL[x,A[:,:,1]]])
 return coeff
pb=det_poly(B);pc=det_poly(C);g=pp.gcd(pb,pc);sq=pp.gcd(pb,pp.derivative(pb))
print('Bdet',pb,'Cdet',pc,'gcd',g,'B repeated gcd',sq,flush=True)
info={'detB':pb,'detC':pc,'gcd':g,'B_repeated_gcd':sq,'B_at_infinity':det(B[:,:,1]),'C_at_infinity':det(C[:,:,1])}
if sq==[1]:
 fac=pp.factor_squarefree(pb);print('factors',fac,flush=True);info['factors_B']=fac
(root/'data/j1_linear_determinants.json').write_text(json.dumps(info,indent=2)+'\n')
