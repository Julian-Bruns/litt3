"""Reconstruct the entire affine-six source from the user's congruences.
No stored source arrays are required.  Output coefficients are affine in
(1,h,w,e,f,k1,k2); the two kernel coordinates are explicitly identified.
"""
from exact import *
from math import comb
import time, hashlib

def basis(d):return [(i,j) for j in range(3) for i in range(max(-1,(d-10*j)//3)+1)]
VARS=[(2,i,j) for i,j in basis(14)]+[(n,i,j) for n,d in [(3,46),(4,57),(5,70)] for i,j in basis(d)]
NV=len(VARS)

def source_columns():
 out=[]
 ns=[czero() for _ in range(6)];ns[0]=cp(v);ns[5]=cp(pm(v,Q));out.append(ns)
 for n,i,j in VARS:
  ns=[czero() for _ in range(6)];ns[n]=cmn(i,j+2) if n==2 else cmn(i,j);out.append(ns)
 return out

def constraints(verbose=False):
 cols=source_columns(); rows=[]; blocks=[]
 def emit(values,tag,moduli=None,minpole=None):
  start=len(rows);entries={}
  for z,F in enumerate(values):
   for j in range(3):
    f=F[j]
    if moduli is not None:
     if moduli[j] is None:continue
     f=prem(f,moduli[j])
    for i,a in enumerate(f):
     if minpole is not None and 3*i+10*j<=minpole:continue
     if a:
      key=(i,j)
      if key not in entries:entries[key]=[0]*(NV+1)
      entries[key][z]=a
  for key in sorted(entries):
   v0=entries[key];rows.append(v0[1:]+[neg(v0[0])])
  blocks.append([tag,len(rows)-start])
 for j in range(1,6):
  vals=[]
  factors=[pc(pp(pn(B0),j-i),comb(5-i,j-i)%5) if i<=j else [] for i in range(6)]
  for ns in cols:
   F=czero()
   for i in range(j+1):F=ca(F,cx(ns[i],factors[i]))
   vals.append(F)
  mods=[pp(P,(j-a+2)//3) if j>a else None for a in range(3)]
  emit(vals,f'(1):j={j}',mods)
 ql=ps(Q,pp(L0,5));yt=cx(cmn(0,10),pp(t,3))
 for j in range(5):
  factors=[pm(ql,pc(pp(pn(L0),5-i-j),comb(5-i,j)%5)) if 5-i>=j else [] for i in range(6)]
  vals=[]
  for z,ns in enumerate(cols):
   F=czero()
   for i in range(6):F=ca(F,cx(ns[i],factors[i]))
   if z==0 and j==0:F=ca(F,yt)
   vals.append(F)
  emit(vals,f'(2):j={j}',[pp(t,5-j)]*3)
 for j in range(11):
  vals=[]
  for z,ns in enumerate(cols):
   F=ns[j] if j<=5 else czero()
   if 5<=j<=10:F=ca(F,cx(ns[j-5],Q))
   if z==0 and j==10:F=ca(F,yt)
   vals.append(F)
  emit(vals,f'(3):j={j}',minpole=10+12*j-max(0,j-5))
 row=[0]*(NV+1)
 for k,(n,i,j) in enumerate(VARS):
  if n==2 and j==0:row[k]=power(r,i)
 rows.append(row);blocks.append(['D2(r,0)',1])
 if verbose:print('variables',NV,'rows',len(rows),'blocks',blocks,flush=True)
 return rows,blocks

def reconstruct():
 start=time.time();rows,blocks=constraints(True)
 rr,piv=rref(rows,NV);rank=len(piv)
 for row in rr[rank:]:assert not any(row)
 free=[j for j in range(NV) if j not in piv]
 assert len(free)==6,(rank,NV,free)
 particular=[0]*NV;null=[[0]*6 for _ in range(NV)]
 for k,j in enumerate(free):null[j][k]=1
 for row,j in zip(rr,piv):
  particular[j]=row[NV]
  null[j]=[neg(row[c]) for c in free]
 top_indices=[VARS.index(z) for z in [(2,1,1),(4,19,0),(4,12,2),(5,16,2)]]
 top=[null[i] for i in top_indices]
 rt,pt=rref(top,6);assert len(pt)==4
 kernel=[j for j in range(6) if j not in pt]
 T=top+[[int(i==j) for i in range(6)] for j in kernel]
 rhs0=[neg(particular[i]) for i in top_indices]+[0,0]
 mat=[T[i]+[rhs0[i]]+[int(i==j) for j in range(6)] for i in range(6)]
 mi,pi=rref(mat,6);assert pi==list(range(6))
 U=[row[6:] for row in mi]
 aff=[]
 for i in range(NV):
  row=[particular[i]]+[0]*6
  for j in range(6):
   for k in range(7):row[k]=add(row[k],mul(null[i][j],U[j][k]))
  aff.append(row)
 for i,idx in enumerate(top_indices):assert aff[idx]==[int(j==i+1) for j in range(7)]
 assert aff[VARS.index((3,12,1))]==[epsilon]+[0]*6
 assert aff[VARS.index((3,15,0))]==[0,Ca,Cd,0,0,0,0]
 # All original affine equations hold coefficientwise, including multiplicities.
 for row in rows:
  for k in range(7):
   z=0
   for i in range(NV):z=add(z,mul(row[i],aff[i][k]))
   assert z==(row[NV] if k==0 else 0)
 result={'variable_order':VARS,'coefficients':aff,'coordinate_order':['1','h','w','e','f','k1','k2'],
  'kernel_coordinates':[VARS[free[j]] for j in kernel],
  'nvariables':NV,'nrows':len(rows),'rank':rank,'pivots':piv,'blocks':blocks}
 (ROOT/'evidence/source_affine.json').write_text(json.dumps(result,separators=(',',':'))+'\n')
 print('source reconstructed; affine dimension 6, rank',rank,'kernel',result['kernel_coordinates'],flush=True)
 print('all source equations checked coefficientwise; elapsed',round(time.time()-start,3),'seconds',flush=True)
 return result

if __name__=='__main__':reconstruct()
