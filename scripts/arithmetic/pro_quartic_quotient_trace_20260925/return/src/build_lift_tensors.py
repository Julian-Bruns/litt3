from exact import *
from lift import *
from pathlib import Path
import time,json,argparse
ROOT=Path(__file__).resolve().parents[1];D=np.load(ROOT/'data/matrices.npz')
parser=argparse.ArgumentParser();parser.add_argument('--coordinates',default='all');args=parser.parse_args()
js=list(range(19)) if args.coordinates=='all' else [int(j) for j in args.coordinates.split(',')]
t=time.monotonic()
# C[j,target,row,free], top_eta[j,target,top_row(na,nb),free]
for j in js:
 C=np.zeros((19,43,35),dtype=np.uint8);top=np.zeros((19,2,35),dtype=np.uint8);lo=np.zeros((4,35),dtype=np.uint8)
 z=np.zeros(19,dtype=np.uint8);z[j]=1
 for k in range(35):
  m=np.zeros(35,dtype=np.uint8);m[k]=1
  U,V,phi,res=recover_lower(D,z,m)
  a,q,r,f,g,h=phi;lo[:,k]=[evalp(p,*POINT) for p in (q,r,g,h)]
  for l,(u,v) in enumerate(COORDS):
   obs,row=top_column(D,U,V,phi,u,v);C[l,:,k]=obs;top[l,:,k]=[evalp(p,*POINT) for p in row[1:]]
  if k%10==0:print(f'{time.monotonic()-t:.2f}s coordinate {j} free {k}',flush=True)
 np.savez_compressed(ROOT/f'data/lift_part_{j:02d}.npz',C=C,top=top,lo=lo)
 print(f'{time.monotonic()-t:.2f}s saved coordinate {j}',flush=True)
# Source-independent n and a,f evaluation.
N0=np.zeros((19,35),dtype=np.uint8);AF=np.zeros((2,35),dtype=np.uint8)
for k,(f,a) in enumerate(FREE):
 AF[:,k]=[evalp(p,*POINT) for p in (a,f)]
 for l,(u,v) in enumerate(COORDS):N0[l,k]=evalp(plus(add(mul(u,a),mul(v,f))),*POINT)
TOPS=np.zeros((19,2,16),dtype=np.uint8)
zero_phi=({},{},{},{},{},{})
for j,(U,V) in enumerate(UV25):
 for k,mon in enumerate(NB):
  obs,row=top_column(D,U,V,zero_phi,{},{},s0={mon:1});assert np.array_equal(obs,D['Q'][j,:,k])
  TOPS[j,:,k]=[evalp(p,*POINT) for p in row[1:]]
np.savez_compressed(ROOT/'data/lift_common.npz',N0=N0,AF=AF,TOPS=TOPS,NS=np.array([evalp({mon:1},*POINT) for mon in NB],dtype=np.uint8),point=np.array(POINT))
print('completed requested coordinates',js,'seconds',time.monotonic()-t,flush=True)
