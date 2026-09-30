"""Portable certificate generation/verification for finite boundary cases."""
from genus1_boundary import *
import argparse

def orbit_representatives():
 """Represent orbits under Frobenius 25^4, which fixes K and sends zeta to zeta^24."""
 reps=[]
 for u in range(29):
  for t in range(29):
   for v in range(29):
    a=(u,t,v);b=a;orbit=[a]
    for _ in range(6):
     b=tuple(24*x%29 for x in b);orbit.append(b)
    if a==min(orbit):reps.append(a)
 if len(reps)!=3485:raise AssertionError('orbit count')
 return np.array(reps,dtype=np.int16)

def genus1_records(verbose=True):
 data=locdata();lm,zp,ta,tm,_=setup_evaluator();grid=orbit_representatives()
 records=bytearray();summary=[]
 for j in range(4):
  for k in range(4):
   for l in range(4):
    polys=case_polynomials(data,0,j,k,l)
    mask=np.ones(len(grid),dtype=bool)
    if j==0:mask&=grid[:,0]!=0
    if k==l:mask&=grid[:,1]!=0
    initial=np.flatnonzero(mask);ids=initial.copy()
    witness=np.full((len(grid),4),255,dtype=np.uint8)
    for pn,poly in enumerate(polys):
     terms=[(np.array(e,dtype=np.int16),as4(c)) for e,c in sorted(poly.items())]
     for a in range(4):
      active=[(e,c[a]) for e,c in terms if c[a]]
      for b in range(7):
       if not len(ids):break
       rows=grid[ids];values=np.zeros(len(ids),dtype=np.uint8)
       for e,c in active:
        powers=(rows@e)%29
        values=ta[values,tm[c,zp[powers,b]]]
       bad=values!=0
       witness[ids[bad],0]=pn;witness[ids[bad],1]=a;witness[ids[bad],2]=b;witness[ids[bad],3]=values[bad]
       ids=ids[~bad]
      if not len(ids):break
     if not len(ids):break
    if len(ids):raise AssertionError(f'genus-one survivors {(j,k,l)}: {grid[ids].tolist()}')
    for idx in initial:
     u,t,v=map(int,grid[idx]);w=map(int,witness[idx]);records.extend(bytes([j,k,l,u,t,v,*w]))
    summary.append(dict(indices=[0,j,k,l],tested=len(initial),survivors=0))
    if verbose:print(f'genus1 case 0 {j} {k} {l}: {len(initial)} orbit representatives, all excluded')
 if len(records)!=219188*10:raise AssertionError('genus-one record count')
 return bytes(records),summary

if __name__=='__main__':
 p=argparse.ArgumentParser();p.add_argument('mode',choices=['write','verify']);p.add_argument('path',type=Path);args=p.parse_args()
 records,summary=genus1_records()
 if args.mode=='write':
  args.path.write_bytes(records)
  (ROOT/'data/genus1_certificate_summary.json').write_text(json.dumps(summary,indent=2))
 else:
  if args.path.read_bytes()!=records:raise AssertionError('genus-one certificate mismatch')
 print(f'PASS: 219188 genus-one orbit certificates {args.mode}; 1534100 geometric boundary tuples covered before orbit reduction')
