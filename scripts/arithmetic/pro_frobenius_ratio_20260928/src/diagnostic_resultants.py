"""Exploratory test, NOT a geometric certificate.
Checks whether small sampled norms of the first-tail resultant have a
multiplicative relation supported on a specified list of boundary factors.
"""
from residual import *
from ff import *
import numpy as np

def resultant(f,g):
 f,g=EP(f),EP(g);ans=E(1)
 while g.degree()>0:
  m,n=f.degree(),g.degree()
  if m<n:f,g=g,f;ans=ans*(4 if m*n%2 else 1);continue
  r=f%g
  if not r:return E()
  ans=ans*(4 if m*n%2 else 1)*(g[n]**(m-r.degree()))
  f,g=g,r
 return ans*g[0]**f.degree()

def fit(A,y,p):
 aa=np.array([[(int(v)%p) for v in row]+[int(r)%p] for row,r in zip(A,y)],dtype=np.int64)
 row=0
 for j in range(aa.shape[1]-1):
  piv=next((i for i in range(row,len(aa)) if aa[i,j]),None)
  if piv is None:continue
  aa[[row,piv]]=aa[[piv,row]];aa[row]=aa[row]*pow(int(aa[row,j]),-1,p)%p
  for i in range(len(aa)):
   if i!=row:aa[i]=(aa[i]-aa[i,j]*aa[row])%p
  row+=1
 return not any(not r[:-1].any() and r[-1] for r in aa),row

def main():
 data={k:Poly(v) for k,v in RATIO.items()};a,b,c,e=[data[k] for k in ['a0','b','c','e']]
 dd2=c*c-4*b*e;dd3=b*b*c*c+a*c**3+b**3*e+3*a*a*e*e+3*a*b*c*e
 factors=[X]+[data[k] for k in ['a0','d','b','c','e','C']]+[dd2,dd3,X-10149,X-64426]
 rows=[];rhs=[]
 for qv in range(1,17):
  bv,cv,ev=[data[k].eval(qv) for k in ['b','c','e']]
  mod=Poly([mul(3,ev),mul(2,cv),bv]).monic();u=ext.context(mod);q=E(qv);check_open(q,u)
  _,A=residual(q,u);ts=Tails(A);f,g=ts.tail(71),ts.tail(72)
  r=resultant(f,g)
  rn=add(sub(mul(int(r.a[0]),int(r.a[0])),mul(mod[1],mul(int(r.a[0]),int(r.a[1])))),mul(mod[0],mul(int(r.a[1]),int(r.a[1]))))
  vals=[p.eval(qv) for p in factors]
  assert all(vals) and rn
  rows.append([1]+[LL[v]%313 for v in vals]);rhs.append(LL[rn]%313)
  ok,rank=fit(rows,rhs,313)
  print('sample',qv,'rank',rank,'consistent',ok,flush=True)
  if not ok:break
if __name__=='__main__':main()
