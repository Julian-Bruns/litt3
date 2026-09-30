"""Exact GEOMETRIC sufficient exclusions for lower-map support sets.
Not a finite-field point search: each rank test is invariant under field extension.
A failed rank criterion says nothing about existence.
"""
from exact import *
import itertools,json,pathlib,time
ROOT=pathlib.Path(__file__).resolve().parents[1]

@njit(cache=True)
def scan(T,supports):
 n=len(supports);s=supports.shape[1]
 result=np.empty((n,2),dtype=np.uint8)
 for j in range(n):
  M=np.zeros((80,19*s),dtype=np.uint8)
  C=np.zeros((80,6*s),dtype=np.uint8)
  for h in range(s):
   w=supports[j,h]
   for k in range(19):
    for i in range(80):M[i,19*h+k]=T[k,i,w]
   for k in range(6):
    for i in range(80):C[i,6*h+k]=T[k+13,i,w]
  result[j,0]=rank(M);result[j,1]=rank(C)
 return result

if __name__=='__main__':
 import argparse
 p=argparse.ArgumentParser();p.add_argument('size',type=int);args=p.parse_args()
 T=np.load(ROOT/'data/pencils.npz')['T'];s=args.size
 supports=np.array(list(itertools.combinations(range(35),s)),dtype=np.int16)
 t=time.time();R=scan(T,supports);ok=R[:,0].astype(int)-R[:,1]==13*s
 np.savez_compressed(ROOT/f'data/support_{s}.npz',supports=supports,ranks=R,excluded=ok)
 out={'support_size':s,'total':len(supports),'geometrically_forced_into_pure_v':int(ok.sum()),'criterion_inconclusive':int((~ok).sum()),'seconds':round(time.time()-t,2)}
 (ROOT/f'data/support_{s}_summary.json').write_text(json.dumps(out,indent=2)+'\n')
 print(out,flush=True)
 print('inconclusive supports:',supports[~ok][:50].tolist(),flush=True)
