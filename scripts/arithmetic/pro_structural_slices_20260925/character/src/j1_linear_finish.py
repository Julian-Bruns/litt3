"""Geometric certificate on all linear p, via finite residue fields of det B.
This is NOT a bounded finite-field point search: the determinant's complete
geometric zero set is covered by exact irreducible factors.
"""
from exact import *
from macaulay import monomials
import poly25 as pp
from pathlib import Path
import json,time
root=Path(__file__).resolve().parents[1];T=np.load(root/'data/pencils.npz')['T'];info=json.loads((root/'data/j1_linear_determinants.json').read_text());g=json.loads((root/'data/grades.json').read_text());zA,zB,zC=g['z_groups']
B=np.load(root/'data/fonly_1B_independent.npz')['A'];C=np.load(root/'data/fonly_1C_independent.npz')['A']

def matspecial(A,K):return [[K.elt([int(A[r,z,0]),int(A[r,z,1])]) for z in range(A.shape[1])] for r in range(A.shape[0])]
def expand_rows(M,K):
 nr=len(M);nc=len(M[0]);d=K.degree;out=np.zeros((nr*d,nc*d),dtype=np.uint8)
 for i,row in enumerate(M):
  for j,c in enumerate(row):
   for a in range(d):
    v=K.mul((0,)*a+(1,),c)
    out[i*d+a,j*d:j*d+len(v)]=v
 return out

results=[]
for h in info['factors_B']:
 start=time.time();K=pp.Extension(h);bker=pp.kernel_extension(matspecial(B,K),K);cker=pp.kernel_extension(matspecial(C,K),K)
 assert len(bker)==1
 bases=[]
 for idx,ks in [(zB,bker),(zC,cker)]:
  for v in ks:
   z=[K.zero]*19
   for i,c in zip(idx,v):z[i]=c
   bases.append(z)
 nz=len(bases);nw=13;TT=[]
 for r in range(80):
  row=[]
  for z in bases:
   coeff=[]
   for w in range(nw):
    indices=[11,12] if w==0 else [22+w]
    vals=[K.one,K.elt([0,1])] if w==0 else [K.one]
    val=K.zero
    for i,c in enumerate(z):
     if not c:continue
     for index,v in zip(indices,vals):val=K.add(val,K.mul(c,K.mul(K.scalar(int(T[i,r,index])),v)))
    coeff.append(val)
   row+=coeff
  TT.append(row)
 RR,p=pp.rref_extension(TT,K);RR=RR[:len(p)];nr=len(RR)
 print('field',h,'Bkernel',len(bker),'Ckernel',len(cker),'tensor row rank',nr,flush=True)
 degree=None
 for d in [1,2,3]:
  mons=monomials(nw,d);prev=monomials(nw,d-1);index={m:i for i,m in enumerate(mons)};nd=len(mons)
  M=[]
  for m in prev:
   im=[index[tuple(sorted(m+(w,)))] for w in range(nw)]
   for rr in RR:
    row=[K.zero]*(nz*nd)
    for z in range(nz):
     for w in range(nw):row[z*nd+im[w]]=rr[z*nw+w]
    M.append(row)
  big=expand_rows(M,K);R,piv=rref(big)
  target=mons.index((0,)*d)*K.degree
  yes=target in piv and np.count_nonzero(R[piv.index(target)])==1
  print(' degree',d,'F25 matrix',big.shape,'rank',len(piv),'zB*f^d membership',yes,'seconds',round(time.time()-start,2),flush=True)
  if yes:
   degree=d
   data={'field_polynomial':h,'B_kernel':bker,'C_kernel':cker,'source_basis':bases,'tensor_equations':RR,'degree':d,'F25_matrix_shape':list(big.shape),'F25_matrix_rank':len(piv),'target_column':target,'target_proved':True,'variables':'w0=fscale; w1..w12 are alpha in its original ordered basis'}
   (root/f'certificates/j1_linear_factor_{len(results)}.json').write_text(json.dumps(data,indent=2)+'\n')
   break
 results.append({'factor':h,'B_kernel_dim':len(bker),'C_kernel_dim':len(cker),'degree':degree,'success':degree is not None})
(root/'data/j1_linear_finish_results.json').write_text(json.dumps(results,indent=2)+'\n')
print('ALL FACTORS',all(r['success'] for r in results),flush=True)
