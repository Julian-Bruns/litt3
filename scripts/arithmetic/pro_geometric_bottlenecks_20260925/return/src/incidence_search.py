"""BOUNDED exploration of linear source fibers over exact map directions."""
from exact import *
import pathlib,json,time
ROOT=pathlib.Path(__file__).resolve().parents[1]

@njit(cache=True)
def rand_scan(T,Q,W,coeff):
 TW=T.transpose(2,1,0).copy()
 hist=np.zeros(20,dtype=np.int64)
 for ii in range(len(coeff)):
  w=mm(W,coeff[ii].reshape(-1,1)).reshape(-1)
  if not np.any(w):continue
  M=pencil(TW,w)
  r=rank(M);hist[r]+=1
  if r<18:
   R,p=rref(M)
   for j in range(19):
    isfree=True
    for k in p:
     if j==k:isfree=False
    if not isfree:continue
    z=np.zeros(19,dtype=np.uint8);z[j]=1
    for k in range(len(p)):z[p[k]]=NEG[R[k,j]]
    outside=False
    for k in range(13):
     if z[k]:outside=True
    if outside:
     return ii,w,z,hist
 return -1,np.zeros(35,dtype=np.uint8),np.zeros(19,dtype=np.uint8),hist

if __name__=='__main__':
 import argparse
 ap=argparse.ArgumentParser();ap.add_argument('--batch',type=int,default=0);ap.add_argument('--count',type=int,default=10000);args=ap.parse_args()
 a=np.load(ROOT/'data/pencils.npz');T=a['T'];Q=a['Q']
 zlist=[kernel(T[:,:,j].T)[:,-1] for j in [11,12,28,29]]
 rng=np.random.default_rng(1000+args.batch)
 results=[]
 for iz,z in enumerate(zlist):
  W=kernel(pencil(T,z));coef=rng.integers(0,25,(args.count,W.shape[1]),dtype=np.uint8)
  t=time.time();i,w,zz,h=rand_scan(T,Q,W,coef)
  out={'seed':1000+args.batch,'iz':iz,'source':z.tolist(),'kernel_dim':W.shape[1],'examined':int(h.sum()),'histogram':h.tolist(),'hit_index':int(i)}
  if i>=0:
   out['w']=w.tolist();out['z']=zz.tolist();out['ranks']=[rank(pencil(T,zz)),rank(pencil(Q,zz))]
   (ROOT/'data/search_hit.json').write_text(json.dumps(out,indent=2)+'\n')
  print(out,'seconds',round(time.time()-t,2),flush=True)
  results.append(out)
 (ROOT/f'data/bounded_scan_{args.batch}.json').write_text(json.dumps(results,indent=2)+'\n')
