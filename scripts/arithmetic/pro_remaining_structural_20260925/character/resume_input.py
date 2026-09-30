"""Build a membership-preserving continuation input from recorded DAG members.
No removed generator is asserted redundant: a unit found in any subset of
certified members is enough for exclusion. Absence of a unit proves nothing.
"""
import json,argparse
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
pa=argparse.ArgumentParser();pa.add_argument('name');pa.add_argument('--minimal',action='store_true');a=pa.parse_args();p=ROOT/f'certificates/{a.name}.dag';gs=[]
with open(p) as f:
 head=f.readline().split();nv,nc,ns=map(int,head[1:])
 while line:=f.readline():
  h=line.split()
  if h[0] in ['STOP','END']:break
  if h[0]=='INIT':idx,nt=map(int,h[1:]);nr=0
  elif h[0]=='ADD':idx,i,j,sc,nt,nr=map(int,h[1:])
  else:raise AssertionError(h)
  terms=[f.readline()[2:] for _ in range(nt)]
  for _ in range(nr):assert f.readline().startswith('R ')
  lead=tuple(map(int,terms[0].split()[:-1]));assert idx==len(gs);gs.append((lead,nt,''.join(terms)))
ids=list(range(len(gs)))
if a.minimal:
 def divides(a,b):return a[0]==b[0] and all(x<=y for x,y in zip(a[1:],b[1:]))
 ids=[i for i,(m,nt,text) in enumerate(gs) if not any(j!=i and divides(n,m) and (n!=m or (nsz,j)<(nt,i)) for j,(n,nsz,_) in enumerate(gs))]
ids=list(reversed(ids));name=a.name+('_minimal' if a.minimal else '_resume')
with open(ROOT/f'data/{name}.txt','w') as f:
 f.write(f'{nv} {nc} {len(ids)}\n')
 for i in ids:f.write(str(gs[i][1])+'\n'+gs[i][2])
(ROOT/f'data/{name}_provenance.json').write_text(json.dumps(dict(parent_dag=f'certificates/{a.name}.dag',parent_input=f'data/{a.name}.txt',selected_node_ids=ids,claim='Every selected generator is a certified member; no discarded generator is claimed redundant.'),indent=2)+'\n')
print('Parent nodes',len(gs),'selected',len(ids),'terms',sum(gs[i][1] for i in ids),'input',name,flush=True)
