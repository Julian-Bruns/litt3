import sys,time,json

from compute import *

def build_negative(q=5,d=-1):
 E0=power(e,q); b=bas0(d+q); bb=bas0(d+5*q); obs=bas1(d-6*q)
 A=np.column_stack([vec(mul(E0,mono(*m)),obs) for m in bb])
 R,piv=rref(np.column_stack([A,np.eye(len(obs),dtype=np.uint8)]),len(bb)); assert len(piv)==len(bb)
 S=R[:len(bb),len(bb):];L=R[len(bb):,len(bb):]
 B=[]
 for j,m in enumerate(u_keys+v_keys):
  U,V=(power(mono(*m),q),{}) if j<6 else ({},power(mono(*m),q))
  B.append(np.column_stack([vec(add(mul(E0,tail(mul(U,mono(*n)))) , mul(V,mono(*n))),obs) for n in b]))
 B=np.array(B);Q=np.array([matmul(L,Bi) for Bi in B]);print('negative',q,d,'A',A.shape,'Q',Q.shape,flush=True)
 return A,B,Q,S,L
