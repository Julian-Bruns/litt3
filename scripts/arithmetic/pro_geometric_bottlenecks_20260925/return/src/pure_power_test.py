"""Prove exclusions on f!=0 charts by z_i*f_j^d ideal membership (i<13)."""
from exact import *
from prolong import prolong_index,matrix_prolong,monomial_tuples
import pathlib,json,itertools,time
ROOT=pathlib.Path(__file__).resolve().parents[1]

@njit(cache=True)
def test_support(T,support,indices,nm,pure):
 M=matrix_prolong(T,support,indices,nm)
 R,piv=rref(M)
 unit=np.zeros(19*nm,dtype=np.bool_)
 for i in range(len(piv)):
  cnt=0
  for j in range(19*nm):
   if R[i,j]:cnt+=1
  if cnt==1:unit[piv[i]]=True
 yes=np.ones(len(support),dtype=np.bool_)
 for h in range(len(support)):
  if support[h]>=23:continue
  for z in range(13):
   if not unit[z*nm+pure[h]]:yes[h]=False
 return yes,len(piv)

@njit(cache=True)
def run(T,supports,indices,nm,pure):
 flags=np.empty(supports.shape,dtype=np.bool_);ranks=np.empty(len(supports),dtype=np.uint16)
 for i in range(len(supports)):flags[i],ranks[i]=test_support(T,supports[i],indices,nm,pure)
 return flags,ranks

if __name__=='__main__':
 import argparse
 p=argparse.ArgumentParser();p.add_argument('size',type=int);p.add_argument('degree',type=int);p.add_argument('--input',default='');args=p.parse_args()
 s=args.size;d=args.degree
 if args.input:prev=np.load(ROOT/args.input)
 else:prev=np.load(ROOT/f'data/prolong_{s}_{d}.npz')
 supp=prev['supports'][~prev['excluded']]
 indices,nm=prolong_index(s,d);upper=monomial_tuples(s,d);pure=np.array([upper.index((i,)*d) for i in range(s)],dtype=np.int64)
 T=np.load(ROOT/'data/pencils.npz')['T'];t=time.time();flags,ranks=run(T,supp,indices,nm,pure);ok=np.all(flags,axis=1)
 np.savez_compressed(ROOT/f'data/pure_{s}_{d}.npz',supports=supp,excluded=ok,flags=flags,ranks=ranks,indices=indices,pure=pure)
 out={'support_size':s,'w_degree':d,'tested':len(supp),'excluded_for_the_window':int(ok.sum()),'inconclusive':int((~ok).sum()),'seconds':round(time.time()-t,2)}
 (ROOT/f'data/pure_{s}_{d}_summary.json').write_text(json.dumps(out,indent=2)+'\n')
 print(out,flush=True);print('inconclusive first50',supp[~ok][:50].tolist(),flush=True)
