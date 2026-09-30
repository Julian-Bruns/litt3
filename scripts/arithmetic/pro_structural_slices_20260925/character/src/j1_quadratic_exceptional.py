"""Eliminate simultaneous B rank loss and extra C kernel for p2=1.
Produces a literal Nullstellensatz certificate, not a finite-point search.
"""
from exact import *
from pathlib import Path
import json,itertools
root=Path(__file__).resolve().parents[1]
B=np.load(root/'data/fonly_1B_independent.npz')['A'][:,:,:3]
C=np.load(root/'data/fonly_1C_independent.npz')['A'][:,:5,:3]

def det(A):
 A=A.copy();n=len(A);out=1
 for j in range(n):
  nz=np.flatnonzero(A[j:,j])
  if not len(nz):return 0
  i=j+int(nz[0])
  if i!=j:A[[i,j]]=A[[j,i]];out=int(NEG[out])
  c=int(A[j,j]);out=int(MUL[out,c]);A[j]=MUL[INV[c],A[j]]
  A[j+1:]=SUB[A[j+1:],MUL[A[j+1:,j,None],A[j]]]
 return out

def mons(d):return [(a,b) for total in range(d+1) for a in range(total+1) for b in [total-a]]
def power(a,n):
 out=1
 for _ in range(n):out=int(MUL[out,a])
 return out

def interpolate_det(A,degree):
 basis=mons(degree);nodes=[(a,b) for a in range(degree+1) for b in range(degree+1-a)]
 V=np.array([[MUL[power(a,i),power(b,j)] for i,j in basis] for a,b in nodes],dtype=np.uint8)
 R,p,H=rref(V,True);assert len(p)==len(basis)
 vals=np.array([det(ADD[ADD[MUL[a,A[:,:,0]],MUL[b,A[:,:,1]]],A[:,:,2]]) for a,b in nodes],dtype=np.uint8)
 coeff=mm(H,vals)
 # Degree bound + invertible evaluation matrix makes this exact interpolation.
 return {m:int(c) for m,c in zip(basis,coeff) if c}
polys=[interpolate_det(np.delete(C,r,axis=0),5) for r in range(6)]+[interpolate_det(B,10)]
(root/'data/j1_quadratic_rankdrop_polynomials.json').write_text(json.dumps({'variables':['p0','p1'],'normalization':'p2=1','polynomials':[[[i,j,c] for (i,j),c in p.items()] for p in polys]},indent=2)+'\n')
print('polynomial term counts',list(map(len,polys)),flush=True)
for D in range(10,16):
 bas=mons(D);ind={m:i for i,m in enumerate(bas)};rows=[];labels=[]
 for g,p in enumerate(polys):
  degree=max(sum(m) for m in p)
  for mmu in mons(D-degree):
   row=np.zeros(len(bas),dtype=np.uint8)
   for (i,j),c in p.items():row[ind[(i+mmu[0],j+mmu[1])]]=c
   rows.append(row);labels.append((g,mmu))
 M=np.array(rows,dtype=np.uint8);R,piv,H=rref(M,True)
 found=0 in piv and np.count_nonzero(R[piv.index(0)])==1
 print('D',D,'matrix',M.shape,'rank',len(piv),'unit',found,flush=True)
 if found:
  coeff=H[piv.index(0)];assert np.array_equal(mm(coeff,M),np.eye(1,M.shape[1],0,dtype=np.uint8)[0])
  cert={'degree_bound':D,'shape':list(M.shape),'rank':len(piv),'multipliers':[[int(g),int(mon[0]),int(mon[1]),int(c)] for (g,mon),c in zip(labels,coeff) if c]}
  (root/'certificates/j1_quadratic_rankdrop_unit.json').write_text(json.dumps(cert,indent=2)+'\n')
  break
