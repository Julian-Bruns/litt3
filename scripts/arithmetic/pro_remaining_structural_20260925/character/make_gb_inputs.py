"""Create exact affine-chart inputs for the necessary 66x32 pencil."""
from pathlib import Path
import numpy as np
from exact import *
ROOT=Path(__file__).resolve().parents[1]
def chart_input(N,chart,path):
 nr,nc,ns=N.shape;nv=ns-1;rem=[i for i in range(ns) if i!=chart]
 mons=[]
 for comp in range(nc):
  for i in range(nv):
   ex=[0]*nv;ex[i]=1;mons.append((comp,)+tuple(ex))
  mons.append((comp,)+(0,)*nv)
 O=lambda m:(sum(m[1:]),tuple(-e for e in m[:0:-1]),-m[0])
 mons=sorted(mons,key=O,reverse=True);mi={m:i for i,m in enumerate(mons)}
 A=np.zeros((nr,len(mons)),dtype=np.uint8)
 for r in range(nr):
  for comp in range(nc):
   A[r,mi[(comp,)+(0,)*nv]]=N[r,comp,chart]
   for i,j in enumerate(rem):
    ex=[0]*nv;ex[i]=1;A[r,mi[(comp,)+tuple(ex)]]=N[r,comp,j]
 R,piv,H=rref(A,True)
 lines=[f'{nv} {nc} {len(piv)}']
 for row in R[:len(piv)]:
  terms=[list(m)+[int(c)] for m,c in zip(mons,row) if c];lines.append(str(len(terms)));lines.extend(' '.join(map(str,x)) for x in terms)
 path.write_text('\n'.join(lines)+'\n')
 np.savez_compressed(path.with_suffix('.npz'),row_transform=H,affine_matrix=A,monomials=np.array(mons),rank=len(piv))
if __name__=='__main__':
 N=np.load(ROOT/'data/necessary_tensor.npz')['N']
 for j in range(6):chart_input(N[:,:,j:],0,ROOT/('data/N_chart0.txt' if j==0 else f'data/N_stratum{j}.txt'))
 A=np.load(ROOT/'data/unmatched.npz')['A'];N=A[:,:10,:15].transpose(0,2,1)
 for j in range(10):chart_input(N[:,:,j:],0,ROOT/('data/matched_chart0.txt' if j==0 else f'data/matched_stratum{j}.txt'))
