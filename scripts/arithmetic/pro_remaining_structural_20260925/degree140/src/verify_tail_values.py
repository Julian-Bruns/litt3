"""Supplementary independent fixed-Sylvester checks of retained tail resultants.
These bounded checks audit the implementation; global validity additionally uses
full interpolation, degree bounds, and the full verification workflow.
"""
import json
from ff import *
from verify_original import sylvester_det

def tail_errors(Rlambda,r,leadconstant):
 coeff=[[0]*141 for _ in range(7)]
 for l,p in enumerate(Rlambda):
  for ix,c in enumerate(p):
   if c:
    e,x=divmod(ix,1024)
    coeff[l][x]=add(coeff[l][x],mul(c,powf(r,e)))
 rr=[]
 for n in range(74):
  rr.append(pscale(trim([p[140-n] for p in coeff]),div(powf(r,3*n-3),leadconstant)))
 assert rr[0]==[1]
 J=[[1]]
 for n in range(1,71):
  p=[]
  for i in range(1,n):p=padd(p,pmul(J[i],J[n-i]))
  J.append(pscale(psub(rr[n],p),3))
 errors=[]
 for n in range(71,74):
  p=[]
  for i in range(n-70,71):p=padd(p,pmul(J[i],J[n-i]))
  errors.append(psub(rr[n],p))
 return errors

def main():
 for sign in [0,1]:
  R=json.loads((ROOT/'data'/f'exceptional_param_3_{sign}.json').read_text())['lambda_coefficients']
  vals=json.loads((ROOT/'data'/f'parametric_values_3_{sign}.json').read_text());N=vals['N'];omega=vals['omega']
  c=R[0][3*1024+140]
  for ix in [0,1,313]:
   errors=tail_errors(R,powf(omega,ix),c)
   for jj,(a,b) in enumerate([(0,1),(0,2),(1,2)]):
    d=sylvester_det(errors[a],errors[b],[53,54,54][a],[53,54,54][b])
    assert d==vals['pair_major_values'][jj*N+ix],(sign,ix,jj)
   print('Independent tail Sylvester checks:',sign,'sample index',ix,'three determinants passed',flush=True)
 print('18 SUPPLEMENTARY TAIL SYLVESTER DETERMINANTS PASSED.',flush=True)
if __name__=='__main__':main()
