"""Exact genus-two boundary necessary-condition certificate."""
from ff25 import *
from collections import Counter
A=[1,21,14,22,13]
P=[11,22,18,5,19,20,15,16,9,22,1]
MOD=pmonic(A)
def kmul(a,b):return pdivmod(pmul(a,b),MOD)[1]
def kpow(a,n):return ppowmod(a,n,MOD)
def ksub(a,b):return psub(a,b)
def as4(p):return p+[0]*(4-len(p))
def rref(M):
 M=[list(r) for r in M];row=0;piv=[]
 for c in range(len(M[0])):
  n=next((i for i in range(row,len(M)) if M[i][c]),None)
  if n is None:continue
  M[row],M[n]=M[n],M[row]
  z=inv(M[row][c]);M[row]=[mul(z,x) for x in M[row]]
  for i in range(len(M)):
   if i!=row and M[i][c]:
    z=M[i][c];M[i]=[sub(x,mul(z,y)) for x,y in zip(M[i],M[row])]
  piv.append(c);row+=1
  if row==len(M):break
 return M,piv

def boundary_data():
 H=pdivmod(pmul(ppow(pder(A),3),ppow(P,2)),MOD)[1]
 C=div(3,power(A[4],3))
 h=kpow(pscale(H,C),pow(29,-1,25**4-1))
 roots=[kpow([0,1],25**i) for i in range(4)]
 hs=[kpow(h,25**i) for i in range(4)]
 cases=[]
 for i in range(4):
  for j in range(4):
   if i==j:continue
   for k in range(4):
    for l in range(4):
     if k==l:continue
     coeff=[kmul(hs[i],hs[k]),pneg(kmul(hs[i],hs[l])),pneg(kmul(hs[j],hs[k])),kmul(hs[j],hs[l]),pneg(kmul(ksub(roots[i],roots[j]),ksub(roots[k],roots[l])))]
     M=list(map(list,zip(*(as4(v) for v in coeff))))
     rr,piv=rref(M)
     cases.append(dict(indices=[i,j,k,l],matrix=M,rref=rr,pivots=piv,rank=len(piv)))
 return dict(H=H,C=C,h=h,roots=roots,h_roots=hs,cases=cases)

def certify():
 """Return and validate the complete 144-case rank certificate."""
 from functools import reduce
 d=boundary_data()
 for case in d['cases']:
  M=case['matrix']
  case['row_sums']=[reduce(add,row,0) for row in M]
  if not any(case['row_sums']):
   raise AssertionError("all-ones vector unexpectedly in kernel")
  if case['rank']==4:
   continue
  if case['rank']!=3:
   raise AssertionError("unexpected rank")
  aug=[row+[0] for row in M]+[[1,0,0,0,0,1]]
  rr,piv=rref(aug)
  if 5 in piv:
   case['inconsistent_affine_system']=True
   continue
  free=[i for i in range(5) if i not in piv]
  if len(free)!=1:raise AssertionError("affine system is not a line")
  f=free[0];polys=[[0] for _ in range(5)];polys[f]=[0,1]
  for row,p in zip(rr,piv):polys[p]=[row[5],neg(row[f])]
  eq=psub(polys[3],pmul(polys[1],polys[2]))
  if eq==[0]:raise AssertionError("Segre equation vanishes identically")
  case['affine_parameter_column']=f
  case['affine_coordinate_polynomials']=polys
  case['segre_polynomial']=eq
 return d

if __name__=='__main__':
 import json
 from pathlib import Path
 d=certify()
 root=Path(__file__).resolve().parents[1]
 (root/'data/genus2_boundary_certificate.json').write_text(json.dumps(d,indent=2))
 print('PASS: 144 genus-two root-pair matrices; ranks',dict(Counter(c['rank'] for c in d['cases'])))
 print('PASS: no all-ones kernel; all 24 rank-three affine lines have a nonzero quadratic constraint')
