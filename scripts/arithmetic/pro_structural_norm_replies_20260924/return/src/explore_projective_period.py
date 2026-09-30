"""Exploratory exact Hom(F^2 K,K(12O)) computation; not a return test."""
from algebra import *
import numpy as np
E=powp(e,25); free=[('c',ij) for ij in L(143)]+[('alpha',ij) for ij in L(132)]
mat=[]; maps=[]
for kind,ij in free:
 c={ij:1} if kind=='c' else {}; a=plus(mul(e,c)) if kind=='c' else {ij:1}
 p=sub(a,mul(e,c)); D=mul(E,c); d=neg(plus(D)); B=add(neg(mul(e,d)),mul(E,p)); b=neg(plus(B))
 mat.append(np.concatenate([vec(D,forbidden(-132)),vec(B,forbidden(-143))])); maps.append((a,b,c,d))
M=np.stack(mat,axis=1); N=kernel(M)
print('matrix',M.shape,'kernel',N.shape[1])
for z in range(N.shape[1]):
 H=[{} for i in range(4)]
 for j in range(len(free)):
  for i in range(4): H[i]=add(H[i],scale(maps[j][i],int(N[j,z])))
 det=sub(mul(H[0],H[3]),mul(H[1],H[2])); print('basis map',z,'det',det)
