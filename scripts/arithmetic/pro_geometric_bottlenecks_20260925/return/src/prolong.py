"""Homogeneous ideal-membership rank certificates over arbitrary field extensions."""
from exact import *
import itertools,json,pathlib,time
ROOT=pathlib.Path(__file__).resolve().parents[1]

def monomial_tuples(n,d):return list(itertools.combinations_with_replacement(range(n),d))
def prolong_index(n,d):
 lower=monomial_tuples(n,d-1);upper=monomial_tuples(n,d);look={m:i for i,m in enumerate(upper)}
 return np.array([[look[tuple(sorted(m+(j,)))] for j in range(n)] for m in lower],dtype=np.int64),len(upper)

@njit(cache=True)
def matrix_prolong(T,support,indices,nm):
 # cols: all source 0..12 first, then 13..18, each with all w monomials
 M=np.zeros((T.shape[1]*len(indices),19*nm),dtype=np.uint8)
 for l in range(len(indices)):
  for h in range(len(support)):
   w=support[h];k=indices[l,h]
   for r in range(T.shape[1]):
    for z in range(19): M[T.shape[1]*l+r,z*nm+k]=ADD[M[T.shape[1]*l+r,z*nm+k],T[z,r,w]]
 return M

@njit(cache=True)
def run_scan(T,supports,indices,nm):
 out=np.empty((len(supports),2),dtype=np.uint16)
 for ii in range(len(supports)):
  M=matrix_prolong(T,supports[ii],indices,nm)
  out[ii,0]=rank(M);out[ii,1]=rank(M[:,13*nm:])
 return out

if __name__=='__main__':
 import argparse
 p=argparse.ArgumentParser();p.add_argument('size',type=int);p.add_argument('degree',type=int);args=p.parse_args()
 s=args.size;d=args.degree;T=np.load(ROOT/'data/pencils.npz')['T']
 if d==2:
  prev=np.load(ROOT/f'data/support_{s}.npz')
 else:prev=np.load(ROOT/f'data/prolong_{s}_{d-1}.npz')
 supp=prev['supports'][~prev['excluded']]
 indices,nm=prolong_index(s,d);t=time.time();R=run_scan(T,supp,indices,nm);ok=R[:,0].astype(int)-R[:,1]==13*nm
 np.savez_compressed(ROOT/f'data/prolong_{s}_{d}.npz',supports=supp,ranks=R,excluded=ok,indices=indices)
 out={'support_size':s,'w_degree':d,'tested':len(supp),'geometrically_forced_into_pure_v':int(ok.sum()),'criterion_inconclusive':int((~ok).sum()),'seconds':round(time.time()-t,2)}
 (ROOT/f'data/prolong_{s}_{d}_summary.json').write_text(json.dumps(out,indent=2)+'\n')
 print(out,flush=True);print('inconclusive first50',supp[~ok][:50].tolist(),flush=True)
