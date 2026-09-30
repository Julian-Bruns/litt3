import numpy as np
import field as F
import linear_system as L

def restrict(K,rows):
 M=np.zeros((len(rows),K.shape[1]),dtype=np.int32)
 for i,r in enumerate(rows):
  for j,c in enumerate(r):
   if c:M[i]=F.add(M[i],F.mul(c,K[j]))
 kk,_=F.kernel(M)
 out=np.zeros((K.shape[0],kk.shape[1]),dtype=np.int32)
 for j in range(K.shape[1]):out=F.add(out,F.mul(K[:,j,None],kk[j,None,:]))
 return out

def coeffrow(key):return L.equation({key:1})

def subspace(K,d,pole2,pole3=None,pole4=None):
 rows=[]
 for i,a,y in L.VARS:
  p=3*a+10*y
  if i==0 and (y or a>d):rows.append(coeffrow((i,a,y)))
  if i==2 and p>20+3*d+pole2:rows.append(coeffrow((i,a,y)))
  if pole3 is not None and i==3 and p>30+3*d+pole3:rows.append(coeffrow((i,a,y)))
  if pole4 is not None and i==4 and p>40+3*d+pole4:rows.append(coeffrow((i,a,y)))
 return restrict(K,rows)

if __name__=='__main__':
 import json,pathlib
 root=pathlib.Path(__file__).resolve().parents[1]
 K=np.array(json.loads((root/'data/linear_system.json').read_text())['polynomial_v_kernel'],dtype=np.int32)
 for d,part,p2,p3,p4 in [(0,[4,4,2],12,16,17),(0,[3,3,2,1,1],10,14,17),(0,[2]*5,6,12,16),(1,[3,3,1],10,13,14)]:
  kk=subspace(K,d,p2,p3,p4)
  print('d',d,'part',part,'dim',kk.shape[1],'kappa?',np.any(kk[-1]),'v top?',np.any(kk[L.VARS.index((0,d,0))]))
  for key in [(3,12,1),(2,4,2),(2,11,0),(4,19,0)]:
   z=kk[L.VARS.index(key)];print(key,z.tolist())
