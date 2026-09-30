"""Exact computation of Cartier-persistent double-zero spaces."""
import itertools, json, time, warnings, argparse
from pathlib import Path
import numpy as np
from numba.core.errors import NumbaWarning
warnings.simplefilter('ignore',NumbaWarning)
import field as f

BASIS=[(i,j) for j,maxi in [(0,9),(1,6),(2,3)] for i in range(maxi+1)]

def ptrim(a):
 a=list(a)
 while len(a)>1 and a[-1]==0: a.pop()
 return a

def padd(a,b):
 c=[0]*max(len(a),len(b))
 for i in range(len(c)):
  c[i]=int(f.ADD25[a[i] if i<len(a) else 0,b[i] if i<len(b) else 0])
 return ptrim(c)

def pmul(a,b):
 c=[0]*(len(a)+len(b)-1)
 for i,x in enumerate(a):
  for j,y in enumerate(b): c[i+j]=int(f.ADD25[c[i+j],f.MUL25[x,y]])
 return ptrim(c)

def ppow(a,n):
 r=[1]
 while n:
  if n&1:r=pmul(r,a)
  a=pmul(a,a);n//=2
 return r

def pder(a,order=1):
 for _ in range(order):a=[int(f.MUL25[i%5,a[i]]) for i in range(1,len(a))]
 return ptrim(a or [0])

def cartier_matrix():
 A4=ppow(f.A_CODES,4); P3=ppow(f.P_CODES,3)
 out=np.zeros((21,21),dtype=np.int64)
 for j,(i,yexp) in enumerate(BASIS):
  h=[0]*i+A4
  if yexp==0: h=pmul(h,f.P_CODES); target=1
  elif yexp==1:h=pmul(h,P3);target=0
  else:target=2
  for n in range(4,len(h),5):
   row=BASIS.index(((n-4)//5,target))
   out[row,j]=f.power(h[n],5) # inverse Frobenius on F_25
 return out

def geometric_points():
 pts=[];r=25;s=f.BASE
 for i in range(12):
  assert f.polyval(np.array(f.A_CODES,dtype=np.int64),r)==0
  assert f.power(s,3)==f.polyval(np.array(f.P_CODES,dtype=np.int64),r)
  pts.append((int(r),int(s)))
  r=f.power(r,25);s=f.power(s,25)
 assert (r,s)==pts[0] and len(set(pts))==12
 return pts

def jets_at(r,s):
 P1=np.array(pder(f.P_CODES),dtype=np.int64)
 P2=np.array([f.MUL25[x,3] for x in pder(f.P_CODES,2)],dtype=np.int64) # 1/2=3
 s2=f.mul(s,s); den=f.mul(3,s2)
 y1=f.mul(f.polyval(P1,r),f.inv(den))
 y2=f.mul(f.sub(f.polyval(P2,r),f.mul(3,f.mul(s,f.mul(y1,y1)))),f.inv(den))
 yp=[(1,0,0),(s,y1,y2),(s2,f.mul(2,f.mul(s,y1)),f.add(f.mul(y1,y1),f.mul(2,f.mul(s,y2))))]
 out=np.zeros((3,21),dtype=np.int64)
 for col,(i,j) in enumerate(BASIS):
  xx=[f.power(r,i),f.mul(i%5,f.power(r,i-1)) if i>=1 else 0,
      f.mul((i*(i-1)//2)%5,f.power(r,i-2)) if i>=2 else 0]
  for a in range(3):
   for b in range(a+1):out[a,col]=f.add(out[a,col],f.mul(xx[b],yp[j][a-b]))
 return out

def all_jets(pts):
 jets=[jets_at(*p) for p in pts]
 inf=np.zeros((3,21),dtype=np.int64)
 for i,v in enumerate([(9,0),(6,1),(3,2)]):inf[i,BASIS.index(v)]=1
 jets.append(inf)
 return jets

def rot(mask,j):
 return sum(1<<((i+j)%12) for i in range(12) if mask>>i&1) | (mask & (1<<12))

def masks_and_orbits():
 masks=[sum(1<<i for i in cc) for cc in itertools.combinations(range(13),6)]
 result={}
 for mask in masks:
  rep=min(rot(mask,j) for j in range(12))
  shift=next(j for j in range(12) if rot(rep,j)==mask)
  result[mask]=(rep,shift)
 return result

def run(output=None):
 t=time.time();M=cartier_matrix();pts=geometric_points();jets=all_jets(pts)
 orbits=masks_and_orbits(); reps=sorted(set(r for r,s in orbits.values()))
 print('field generator',f.GENERATOR,'cube',f.CUBE,'orbit representatives',len(reps),flush=True)
 records=[]
 for ix,mask in enumerate(reps):
  inds=[i for i in range(13) if mask>>i&1]
  J=np.vstack([jets[i] for i in inds])
  K=f.kernel(J); dims=[int(K.shape[1])]; stages=[]
  # Each stage intersects the old kernel with the inverse Cartier image
  # of the old kernel. The row constraints accumulate as R -> [R;(RM)^5].
  R=J
  for it in range(21):
   if K.shape[1]==0:break
   nextrows=f.mpow_entries(f.matmul(R,M),5)
   test=f.matmul(nextrows,K)
   _,piv=f.row_reduce(test.T)
   newK=f.kernel(test)
   stages.append({'kernel':K.tolist(),'test_row_pivots':piv.tolist()})
   K=f.matmul(K,newK)
   dims.append(int(K.shape[1]))
   if dims[-1]==dims[-2]:break
   R=np.vstack((R,nextrows))
   # Keep an independent row basis to limit matrix sizes.
   rr,pp=f.row_reduce(R)
   R=rr[:len(pp)]
  full=np.vstack((J,f.mpow_entries(f.matmul(J,M),5)))
  _, selected=f.row_reduce(full.T)
  assert len(selected)==21
  records.append({'representative':mask,'missed_points':inds,'dimensions':dims,
                  'full_rank_rows':selected.tolist(),'stages':stages})
  print(ix+1,mask, dims,'seconds',round(time.time()-t,1),flush=True)
 result={'field':{'base_order':f.BASE,'field_order':f.ORDER,'generator':f.GENERATOR,'cube':f.CUBE},
 'basis':BASIS,'cartier_matrix':M.tolist(),'points':pts,
 'point_12':'O', 'all_masks':{str(m):{'representative':r,'shift':s} for m,(r,s) in orbits.items()},
 'records':records}
 output=Path(output) if output else Path(__file__).resolve().parents[1]/'certificates'/'cartier_spaces.json'
 with open(output,'w') as fp:
  json.dump(result,fp,indent=2)
 print('DONE dimensions',sorted(set(tuple(r['dimensions']) for r in records)),flush=True)

if __name__=='__main__':
 parser=argparse.ArgumentParser(description=__doc__)
 parser.add_argument('--output')
 args=parser.parse_args()
 run(args.output)
