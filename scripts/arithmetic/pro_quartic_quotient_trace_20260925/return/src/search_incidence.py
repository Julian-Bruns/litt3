"""Explicitly bounded F25 search, NOT a geometric emptiness test."""
from exact import *
from pathlib import Path
import itertools,json,time
ROOT=Path(__file__).resolve().parents[1];D=np.load(ROOT/'data/matrices.npz')
T,Q,S,J=[D[n] for n in ['T','Q','S','J']]
Aidx=[0,6,7];Bidx=list(range(1,6))+list(range(8,13));Cidx=list(range(13,19))

def proj(d):
 for lead in range(d):
  for tail in itertools.product(range(25),repeat=d-lead-1):yield np.array([0]*lead+[1]+list(tail),dtype=np.uint8)

def Sw(w):return np.column_stack([dot(s,w) for s in S])
def record(w,tag):
 M=Sw(w);ker=kernel(M)
 if ker.shape[1]==0:return
 for c in proj(ker.shape[1]):
  z=dot(ker,c);z=MUL[INV[z[np.flatnonzero(z)[0]]],z]
  key=tuple(int(v) for v in z)
  if key in seen:continue
  seen.add(key)
  t=rank(evaluate(T,z));q=rank(evaluate(Q,z));s=rank(evaluate(S,z))
  ans={'tag':tag,'z':list(key),'w':[int(v) for v in w],'T_rank':t,'Q_rank':q,'S_rank':s,'Jw':[int(v) for v in dot(J,w)]}
  out.append(ans)
  print('candidate',len(out),t,q,s,tag,list(key),flush=True)

t=time.monotonic();out=[];seen=set();count=0
for wa in proj(4):
 w=np.zeros(11,dtype=np.uint8);w[:4]=wa
 MB=np.column_stack([dot(s[:, :4],wa)[7:18] for s in S[Bidx]])
 if rank(MB)<10:record(w,'all F25 W_A')
 count+=1
 if count%2000==0:print('progress',count,'sec',time.monotonic()-t,flush=True)
print('WA complete',count,len(out),flush=True)
rng=np.random.default_rng(20260924)
for i in range(2000):
 w=np.zeros(11,dtype=np.uint8);w[4:]=rng.integers(0,25,7,dtype=np.uint8)
 if not np.any(w):continue
 record(w,'2000 seeded W_B samples')
print('finished',time.monotonic()-t,len(out),flush=True)
json.dump({'scope':'All 16276 F25 projective W_A points tested for B-block rank loss, plus 2000 seeded W_B samples. This does not exhaust any geometric parameter space.','candidates':out},open(ROOT/'data/incidence_search.json','w'),indent=2)
