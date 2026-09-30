"""Check an invariant line inside the fixed bundle F^2 K."""
from algebra import *
from pathlib import Path
import json,numpy as np
ROOT=Path(__file__).resolve().parents[1]
def trim(a):
 a=list(a)
 while a and a[-1]==0:a.pop()
 return a
def rem(a,b):
 a=trim(a);b=trim(b)
 while len(a)>=len(b):
  shift=len(a)-len(b); co=int(MUL[a[-1],INV[b[-1]]])
  for i,v in enumerate(b): a[i+shift]=int(ADD[a[i+shift],NEG[MUL[co,v]]])
  a=trim(a)
 return a
def gcd(a,b):
 a=trim(a);b=trim(b)
 while b:a,b=b,rem(a,b)
 return [int(MUL[v,INV[a[-1]]]) for v in a] if a else []
def row(p,j):
 lo=min([i for i,jj in p if jj==j],default=0);hi=max([i for i,jj in p if jj==j],default=-1)
 assert lo>=0
 return [p.get((i,j),0) for i in range(hi+1)]
E=powp(e,25);bs=L(142);bad=forbidden(-133)
A=np.stack([vec(mul(E,{ij:1}),bad) for ij in bs],axis=1);N=kernel(A)
print('H0(F2K(-8O))',N.shape[1]); assert N.shape[1]==1
b=matpol(N[:,0],bs);a=plus(mul(E,b));p=sub(a,mul(E,b))
print('b characters',set(j for i,j in b),'a characters',set(j for i,j in a))
B=row(b,1);AA=row(a,0)
print('degrees',len(AA)-1,len(B)-1)
print('gcd(A,B)',gcd(AA,B));print('gcd(A,P)',gcd(AA,P_CODES))
print('order(a-Eb)',-max(3*i+10*j for i,j in p),'ord b',-max(3*i+10*j for i,j in b))
print('coefficient b at x^44 y',b.get((44,1),0))
assert gcd(AA,B)==[1] and gcd(AA,P_CODES)==[1]
assert b.get((44,1),0)!=0
out={'A':AA,'B':B,'bottom_leading':b.get((44,1),0),'normalization':'free column in L_142 kernel; a=A(x), b=y B(x)'}
(ROOT/'data'/'positive_line.json').write_text(json.dumps(out,indent=2)+'\n')
# Four dimensions in the character-one summand are s_8 times L_9.
Wdat=np.load(ROOT/'data'/'line_incidence.npz');W=Wdat['W'];basis=L(151)
M=np.stack([vec(mul(b,{(i,0):1}),basis) for i in range(4)],axis=1)
assert len(rref(M)[1])==4
assert len(rref(np.concatenate([W[:,4:],M],axis=1))[1])==7
print('s_8 * L_9 is a four-dimensional subspace of W1 verified')
