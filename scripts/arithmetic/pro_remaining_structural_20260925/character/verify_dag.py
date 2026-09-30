"""Check membership certificates without trusting a Groebner-basis algorithm.
Each ADD is checked as a polynomial identity in the original generators.
For a completed exclusion the constant members must span the full module.
"""
import argparse,json,time,sys
from pathlib import Path
import numpy as np
from exact import ADD,MUL,NEG,INV,rank
A=ADD.tolist();M=MUL.tolist();N=NEG.tolist()
ROOT=Path(__file__).resolve().parents[1]
def order(m):return (sum(m[1:]),tuple(-e for e in m[:0:-1]),-m[0])
def terms(f,n,nv):
 r={}
 for _ in range(n):
  row=f.readline().split();assert row[0]=='T';m=tuple(map(int,row[1:-1]));c=int(row[-1]);assert len(m)==nv+1 and 0<c<25 and m not in r;r[m]=c
 return r
def subtract_shift(a,b,shift,c):
 for m,v in b.items():
  key=(m[0],)+tuple(x+y for x,y in zip(m[1:],shift));z=A[a.get(key,0)][N[M[c][v]]]
  if z:a[key]=z
  elif key in a:del a[key]
def read_input(path):
 with open(path) as f:
  nv,nc,ns=map(int,f.readline().split());polys=[]
  for _ in range(ns):
   nt=int(f.readline());g={}
   for _ in range(nt):
    row=list(map(int,f.readline().split()));g[tuple(row[:-1])]=row[-1]
   polys.append(g)
 return nv,nc,polys
def verify(dag,input_path,allow_incomplete=False):
 nv,nc,initial=read_input(input_path);gs=[];start=time.time();last=start;status=None
 with open(dag) as f:
  head=f.readline().split();assert head==['MODULE_DAG_V1',str(nv),str(nc),str(len(initial))]
  while line:=f.readline():
   h=line.split()
   if h[0]=='INIT':
    idx,nt=map(int,h[1:]);assert idx==len(gs);g=terms(f,nt,nv);expected=initial[idx];lc=expected[max(expected,key=order)];expected={m:M[int(INV[lc])][c] for m,c in expected.items()};assert g==expected;gs.append(g)
   elif h[0]=='ADD':
    idx,i,j,scale,nt,nr=map(int,h[1:]);assert idx==len(gs) and i<idx and j<idx and 0<scale<25
    target=terms(f,nt,nv);mi=max(gs[i],key=order);mj=max(gs[j],key=order);assert mi[0]==mj[0] and gs[i][mi]==gs[j][mj]==1
    lcm=tuple(max(a,b) for a,b in zip(mi[1:],mj[1:]));si=tuple(a-b for a,b in zip(lcm,mi[1:]));sj=tuple(a-b for a,b in zip(lcm,mj[1:]))
    actual={};subtract_shift(actual,gs[i],si,4);subtract_shift(actual,gs[j],sj,1)
    for _ in range(nr):
     row=f.readline().split();assert row[0]=='R';ri=int(row[1]);shift=tuple(map(int,row[2:-1]));c=int(row[-1]);assert ri<idx and len(shift)==nv and all(e>=0 for e in shift) and 0<c<25;subtract_shift(actual,gs[ri],shift,c)
    actual={m:M[scale][c] for m,c in actual.items()};assert actual==target,('incorrect identity',idx);gs.append(target)
   elif h[0] in ['END','STOP']:status=h;break
   else:raise AssertionError('Bad certificate record')
   now=time.time()
   if now-last>10:print('verified nodes',len(gs),'seconds',round(now-start,2),flush=True);last=now
 const=[]
 for g in gs:
  if all(not any(m[1:]) for m in g):
   row=np.zeros(nc,dtype=np.uint8)
   for m,c in g.items():row[m[0]]=c
   const.append(row)
 cr=rank(np.array(const,dtype=np.uint8)) if const else 0
 complete=status is not None and status[0]=='END' and cr==nc and int(status[1])==nc
 if not allow_incomplete:assert complete,('no full-module certificate',status,cr)
 print('DAG VERIFIED',dag.name,'nodes',len(gs),'constant rank',cr,'complete exclusion',complete,'seconds',round(time.time()-start,2),flush=True)
 return dict(file=dag.name,nodes=len(gs),constant_rank=cr,complete_exclusion=complete,seconds=time.time()-start)
if __name__=='__main__':
 pa=argparse.ArgumentParser();pa.add_argument('name');pa.add_argument('--allow-incomplete',action='store_true');args=pa.parse_args()
 name=args.name;res=verify(ROOT/f'certificates/{name}.dag',ROOT/f'data/{name}.txt',args.allow_incomplete)
 (ROOT/f'logs/{name}_verification.json').write_text(json.dumps(res,indent=2)+'\n')
