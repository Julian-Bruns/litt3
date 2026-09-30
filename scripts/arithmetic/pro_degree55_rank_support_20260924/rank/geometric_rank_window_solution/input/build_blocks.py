#!/usr/bin/env python3
"""Rebuild only the two requested linear matrices directly from the Cech class.

Constant row-space equivalence with the retained tensors proves equality
of their rank loci over every field extension, not only tested points.
"""
from pathlib import Path
import sys,json
import numpy as np
ROOT=Path(__file__).resolve().parent;sys.path.insert(0,str(ROOT/'src'))
import compute as F
br=[(i,0) for i in range(-47,0)]
ar=[(i,2) for i in range(-58,0)]
qr=[(i,2) for i in range(-56,0)]
def lower(f,alpha,g,q,V):
 p=F.add(alpha,F.neg(F.tail(F.mul(F.e,f))))
 B=F.add(F.mul(F.E,g),F.mul(V,f));h=F.neg(F.pos(B))
 qbar=F.add(q,F.neg(F.tail(F.mul(F.e,g))))
 A=F.add(F.neg(F.mul(F.e,h)),F.mul(F.E,qbar),F.mul(V,p))
 return np.concatenate([F.vec(B,br),F.vec(A,ar)])
def left_null(A,cols):
 R,piv=F.rref(np.column_stack([A,np.eye(len(A),dtype=np.uint8)]),cols)
 assert len(piv)==cols
 L=R[cols:,cols:];assert not F.matmul(L,A).any()
 assert len(F.rref(L)[1])==len(L)
 return L
A=np.column_stack([lower({},{},F.mono(i,1),{},{}) for i in range(41)]+
                  [lower({},{},{},F.mono(i,0),{}) for i in range(41)])
assert A.shape==(105,82);L=left_null(A,82)
AQ=np.column_stack([F.vec(F.mul(F.E,F.mono(i,0)),qr) for i in range(42)])
assert AQ.shape==(56,42);LQ=left_null(AQ,42)
T=[];Q=[]
for j in range(6):
 V=F.power(F.mono(j-6,2),25)
 B=np.column_stack([lower(F.mono(i,1),{},{},{},V) for i in range(8)]+
                   [lower({},F.mono(i,0),{},{},V) for i in range(7)])
 T.append(F.matmul(L,B))
 BQ=np.column_stack([F.vec(F.mul(V,F.mono(i,0)),qr) for i in range(9)])
 Q.append(F.matmul(LQ,BQ))
T=np.array(T,np.uint8);Q=np.array(Q,np.uint8)
stored=json.loads((ROOT/'data/invariant_blocks.json').read_text())
def row_space(A):
 B=np.transpose(A,(1,0,2)).reshape(A.shape[1],-1)
 R,piv=F.rref(B);return R[:len(piv)]
for name,value in [('T',T),('Q',Q)]:
 original=np.array(stored[name],np.uint8)
 assert original.shape==value.shape
 assert np.array_equal(row_space(value),row_space(original)),name
 print('PASS: exact constant polynomial-row equivalence for',name,value.shape)
np.savez_compressed(ROOT/'data/direct_blocks.npz',T=T,Q=Q,
                    lower_constant=A,lower_left_null=L,
                    upper_constant=AQ,upper_left_null=LQ)
print('PASS: both constant eliminations rebuilt; all geometric rank loci agree.')
print('OPEN: the geometric rank-window decision; no support ideal solved.')
