"""Exact reconstruction/evaluation over F25. Symbolic tensor identities extend to k.

Integer codes a+5*b represent a+b*beta, beta**2=beta+3. They are not Z/25.
Source variables eta are separate from target v in reconstruct_independent().
Only the convenience functions regularity(v) and reconstruct(v,...) specialize
eta=v, valid for v in F25; no geometric claim is based on eta=v outside F25.
"""
from pathlib import Path
import sys
import numpy as np
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'upstream'/'src'))
import compute as F
from geometry import combine,evaluate,determinant3
D=dict(np.load(ROOT/'data'/'pure_v_return.npz'))
EQ=dict(np.load(ROOT/'data'/'equivariant.npz'))
SPACES=[F.bas0(d) for d in (31,20,131,120,24,124)]
VKEYS=F.v_keys[-6:]
VMONS=[F.mono(*m) for m in VKEYS]
VPOWERS=[F.power(p,25) for p in VMONS]
M=np.array([[17,8,18,15,24,10],[17,12,7,22,17,1],[17,12,19,21,19,8],
 [12,5,5,20,9,11],[2,1,1,19,5,0],[7,24,0,15,4,1]],np.uint8)
MINV=F.rref(np.column_stack((M,np.eye(6,dtype=np.uint8))),6)[0][:,6:]

def lin(tensor,coeff):
 out=np.zeros(tensor.shape[1:],np.uint8)
 for x,z in zip(coeff,tensor):out=F.ADD[out,F.MUL[int(x),z]]
 return out

def mix(tensor,v,eta):return lin(lin(tensor,v),eta)

def regularity_independent(v,eta,equivariant=False):
 Z=EQ if equivariant else D
 t=lin(Z['T'],eta);q=lin(Z['Q'],eta);z=mix(Z['C'],v,eta)
 return np.block([[t,np.zeros((len(t),q.shape[1]),np.uint8)],[z,q]])

def regularity(v,equivariant=False):
 """F25 ONLY: eta_j=v_j**25=v_j in this finite field."""
 return regularity_independent(v,v,equivariant)

def embed(c,s):
 cc=np.zeros(35,np.uint8);ss=np.zeros(16,np.uint8)
 cc[EQ['c_indices']]=c;ss[EQ['s_indices']]=s
 return cc,ss

def expand(space,co):return combine([F.mono(*m) for m in space],co)

def reconstruct_independent(v,eta,c,s):
 """Formula (5) with independent target v and source eta, returning all (6)."""
 v=np.asarray(v,np.uint8);eta=np.asarray(eta,np.uint8)
 c=np.asarray(c,np.uint8);s=np.asarray(s,np.uint8)
 gq=F.matmul(lin(D['lower_recovery'],eta),c[:,None])[:,0]
 tc=F.matmul(mix(D['t_recovery_c'],v,eta),c[:,None])[:,0]
 ts=F.matmul(lin(D['t_recovery_s'],eta),s[:,None])[:,0]
 t=F.ADD[tc,ts]
 f,alpha,g,q,s0,t0=[expand(b,z) for b,z in zip(SPACES,[c[:23],c[23:],gq[:123],gq[123:],s,t])]
 vp=combine(VMONS,v);V=combine(VPOWERS,eta)
 a=F.add(F.pos(F.mul(F.e,f)),alpha);p=F.add(a,F.neg(F.mul(F.e,f)))
 chi=F.mul(F.e,g);qp=F.add(q,F.pos(chi))
 Bs=F.add(F.mul(F.E,g),F.mul(V,f));h=F.neg(F.pos(Bs))
 As=F.add(F.neg(F.mul(F.e,h)),F.mul(F.E,F.add(q,F.neg(F.tail(chi)))),F.mul(V,p));r=F.neg(F.pos(As))
 vf=F.mul(vp,f);n=F.add(s0,F.pos(vf));nv=F.add(s0,F.neg(F.tail(vf)))
 vg=F.mul(vp,g);na=F.add(t0,F.pos(vg))
 Ns=F.add(F.neg(F.mul(vp,h)),F.mul(F.E,F.add(t0,F.neg(F.tail(vg)))),F.mul(V,nv));nb=F.neg(F.pos(Ns))
 H=[[n,na,nb],[a,qp,r],[f,g,h]]
 residual=np.concatenate((F.vec(Bs,F.bm144),F.vec(As,F.bm155),F.vec(Ns,F.bas1(-151))))
 return H,residual,{'f':f,'alpha':alpha,'g0':g,'q0':q,'s0':s0,'t0':t0}

def reconstruct(v,c,s):return reconstruct_independent(v,v,c,s)

def point_matrix(v,eta,c,s):
 H=np.zeros((3,3),np.uint8)
 H[0,0]=F.ADD[F.matmul(D['top_first_s'][None,:],s[:,None])[0,0], F.matmul(lin(D['top_first_c'],v)[None,:],c[:,None])[0,0]]
 H[1:,0]=F.matmul(D['first_at_point'],c[:,None])[:,0]
 low=F.matmul(lin(D['lower_at_point'],eta),c[:,None])[:,0]
 H[2,1],H[1,1],H[2,2],H[1,2]=low
 upper=F.ADD[F.matmul(lin(D['top_other_s'],eta),s[:,None]),F.matmul(mix(D['top_other_c'],v,eta),c[:,None])][:,0]
 H[0,1:]=upper
 return H

def det(H):
 a=0
 for i,j,k,sign in [(0,1,2,1),(1,2,0,1),(2,0,1,1),(2,1,0,-1),(1,0,2,-1),(0,2,1,-1)]:
  z=F.MUL[F.MUL[H[0,i],H[1,j]],H[2,k]]
  a=F.ADD[a,z if sign==1 else F.NEG[z]]
 return int(a)

def on_scroll(v):
 z=F.matmul(MINV,np.array(v,np.uint8)[:,None])[:,0]
 a=z[[0,1,3,4]];b=z[[1,2,4,5]]
 return all(F.MUL[a[i],b[j]]==F.MUL[a[j],b[i]] for i in range(4) for j in range(i+1,4))

def poly_json(p):return [[i,j,int(a)] for (i,j),a in sorted(p.items(),key=lambda z:(z[0][1],z[0][0]))]
def matrix_json(H):return [[poly_json(p) for p in row] for row in H]

def univariate(row):return {(i,0):a for i,a in enumerate(row) if a}
def pdiv(a,b):
 if not b:raise ZeroDivisionError
 a=dict(a);q={};d=max(i for i,j in b);bc=b[(d,0)]
 while a and max(i for i,j in a)>=d:
  m=max(i for i,j in a);coef=int(F.MUL[a[(m,0)],F.INV[bc]])
  t=F.mono(m-d,0,coef);q=F.add(q,t);a=F.add(a,F.neg(F.mul(t,b)))
 return q,a

def pgcd(a,b):
 while b:a,b=b,pdiv(a,b)[1]
 if not a:return a
 return F.scale(int(F.INV[a[(max(i for i,j in a),0)]]),a)

BROWS=[]
for i,(x6,x7) in enumerate([(23,0),(16,3),(4,0),(3,23),(10,8),(5,10)]):
 row=[0]*8;row[5-i]=1;row[6]=x6;row[7]=x7;BROWS.append(row)
BPOLYS=[univariate(b) for b in BROWS]

def stability_gcd(v):
 j=next(i for i,z in enumerate(v) if z)
 g=F.P.copy()
 for i in range(6):g=pgcd(g,F.add(F.scale(int(v[j]),BPOLYS[i]),F.neg(F.scale(int(v[i]),BPOLYS[j]))))
 return g

