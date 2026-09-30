#!/usr/bin/env python3
"""Accelerated exact verification, including a direct check of all 1716 subsets."""
import argparse
import collections
import json
import platform
import time
import warnings
from pathlib import Path
import numpy as np
import numba
import llvmlite
from numba.core.errors import NumbaWarning
warnings.simplefilter('ignore',NumbaWarning)
import field as f
import cartier_test as ct
ROOT=Path(__file__).resolve().parents[1]

def pdiv(a,b):
 a=ct.ptrim(a);b=ct.ptrim(b)
 if b==[0]:raise ZeroDivisionError()
 q=[0]*max(1,len(a)-len(b)+1)
 while a!=[0] and len(a)>=len(b):
  d=len(a)-len(b);c=int(f.MUL25[a[-1],f.INV25[b[-1]]]);q[d]=c
  for i,v in enumerate(b):a[d+i]=int(f.ADD25[a[d+i],f.NEG25[f.MUL25[c,v]]])
  a=ct.ptrim(a)
 return ct.ptrim(q),a

def pgcd(a,b):
 while b!=[0]:a,b=b,pdiv(a,b)[1]
 return [int(f.MUL25[x,f.INV25[a[-1]]]) for x in a]

def main(all_subsets=False,write_degree_seven=False):
 start=time.perf_counter()
 print('Python',platform.python_version(),'NumPy',np.__version__,'Numba',numba.__version__,'llvmlite',llvmlite.__version__,flush=True)
 inp=json.loads((ROOT/'data/input.json').read_text())
 assert inp['P']==list(f.P_CODES) and inp['A']==list(f.A_CODES) and inp['Q']==list(f.Q_CODES)
 assert ct.pder(f.Q_CODES)==ct.pmul(f.P_CODES,ct.ppow(f.A_CODES,2))
 assert pgcd(list(f.P_CODES),ct.pder(f.P_CODES))==[1]
 assert pgcd(list(f.A_CODES),ct.pder(f.A_CODES))==[1]
 assert pgcd(list(f.A_CODES),list(f.P_CODES))==[1]
 assert len(set(int(a) for a in f.EXP[:f.BASE-1]))==f.BASE-1
 print("PASS: Q'=P A^2; P,A squarefree and coprime; exhaustive base-field multiplicative cycle.",flush=True)
 M=ct.cartier_matrix();points=ct.geometric_points();jets=ct.all_jets(points)
 assert all(points[i][0]==points[i+4][0]==points[i+8][0] for i in range(4))
 data=json.loads((ROOT/'certificates/cartier_spaces.json').read_text())
 assert M.tolist()==data['cartier_matrix'] and [list(p) for p in points]==data['points']
 mapping=ct.masks_and_orbits();records={r['representative']:r for r in data['records']}
 assert len(mapping)==1716 and len(records)==146
 dims=collections.Counter()
 todo=sorted(mapping if all_subsets else records)
 for mask in todo:
  ids=[i for i in range(13) if mask>>i&1]
  J=np.vstack([jets[i] for i in ids]);K=f.kernel(J)
  T=f.matmul(f.mpow_entries(f.matmul(J,M),5),K)
  assert f.kernel(T).shape[1]==0
  dims[K.shape[1]]+=1
  rep=mapping[mask][0]
  assert records[rep]['dimensions']==[K.shape[1],0]
 for mask,r in records.items():
  J=np.vstack([jets[i] for i in r['missed_points']])
  full=np.vstack((J,f.mpow_entries(f.matmul(J,M),5)))
  _,piv=f.row_reduce(full[r['full_rank_rows']])
  assert len(piv)==21
  K=np.array(r['stages'][0]['kernel'],dtype=np.int64)
  assert not np.any(f.matmul(J,K))
  assert K.shape[1]==r['dimensions'][0]
 print('PASS: direct Cartier-intersection checks:',len(todo),'dimension counts',dict(sorted(dims.items())),flush=True)
 print('PASS: all archived rank minors and nullspace certificates match.',flush=True)
 # Exact norm-divisor test for actual covering degree seven: 2 B ~ 14 O.
 # L(14 O) has basis 1,x,x^2,x^3,x^4,y,xy.
 cols=[ct.BASIS.index((i,0)) for i in range(5)]+[ct.BASIS.index((0,1)),ct.BASIS.index((1,1))]
 surviving=[];counter=collections.Counter()
 for Dmask in sorted(mapping):
  Bmask=((1<<13)-1)^Dmask
  rows=[jets[i][j,cols] for i in range(12) if Bmask>>i&1 for j in (0,1)]
  if Bmask>>12&1:
   rr=np.zeros(7,dtype=np.int64);rr[-1]=1;rows.append(rr)
  ker=f.kernel(np.array(rows,dtype=np.int64))
  counter[ker.shape[1]]+=1
  if ker.shape[1]:
   assert ker.shape[1]==1
   bpoints=[i for i in range(13) if Bmask>>i&1]
   assert 12 in bpoints
   used={i%4 for i in bpoints if i!=12}
   assert len(used)==2 and all(sum(i%4==u for i in bpoints if i!=12)==3 for u in used)
   surviving.append({'missed_mask':Dmask,'support_mask':Bmask,'support_points':bpoints,
                     'norm_test_function':ker[:,0].tolist()})
 assert len(surviving)==6
 output={'test':'2*B linearly equivalent to 14*O, B a reduced seven-subset of R_X',
 'status':'exact necessary-condition classification, NOT a witness classification',
 'function_basis':['1','x','x^2','x^3','x^4','y','x*y'],
 'tested_subsets':1716,'kernel_dimension_counts':dict(sorted(counter.items())),
 'surviving':surviving}
 path=ROOT/'certificates/degree_seven_norm.json'
 if write_degree_seven:path.write_text(json.dumps(output,indent=2)+'\n')
 assert output==json.loads(path.read_text()) or json.dumps(output,sort_keys=True)==json.dumps(json.loads(path.read_text()),sort_keys=True)
 print('PASS: degree-seven norm-divisor test: 1710 impossible; six one-dimensional solution spaces.',flush=True)
 # Small integer sanity check, not used instead of the elementary proof.
 for m in range(1,301):
  feasible=(m>=7 and m<=7*(m//5))
  assert feasible==(m==7 or m>=10)
  if m%5:assert feasible==(m==7 or m>=11)
 print('PASS: auxiliary integer criterion checked for 1 <= m <= 300 (bounded sanity check only).',flush=True)
 print('Elapsed seconds:',round(time.perf_counter()-start,3),flush=True)
 print('STATUS: all claimed finite computations passed; no cover or embedded-line witness constructed.',flush=True)

if __name__=='__main__':
 parser=argparse.ArgumentParser(description=__doc__)
 parser.add_argument('--all-subsets',action='store_true')
 parser.add_argument('--write-degree-seven',action='store_true')
 args=parser.parse_args();main(args.all_subsets,args.write_degree_seven)
