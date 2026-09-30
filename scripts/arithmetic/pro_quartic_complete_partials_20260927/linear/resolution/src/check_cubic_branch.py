"""Exact geometry and finite-algebra certificates for the coordinate-cubic branch.

These are source RATIO points, not square witnesses.  A separate program may
check residual squareness on this complete fourteen-point stratum.
"""
from __future__ import annotations
import json,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path[:0]=[str(ROOT/'src'),str(ROOT/'intersection/src'),str(ROOT/'resolution/src')]
import field as F,poly as U
from critical_cover import xgcd
from check_auxiliary_curves import powmod
F.init()

def cert(p,q):
 g,s,t=xgcd(p,q); assert g==[1]
 assert U.add(U.mul(s,p),U.mul(t,q))==[1]
 return {'s':s,'t':t,'identity':'s*p+t*q=1'}

def split_linear(f):
 if len(f)<=2:return [f]
 # A deterministic bounded splitter; the identity of the final factors,
 # not the bound or a random success rate, is the certificate.
 for k in range(1,201):
  h=U.sub(powmod([k,1],(F.ORDER-1)//2,f),[1]);g=U.gcd(f,h)
  if 1<len(g)<len(f):return split_linear(g)+split_linear(U.exactdiv(f,g))
 raise RuntimeError('Auxiliary splitting bound reached without a certificate')

def main():
 if sys.flags.optimize:raise RuntimeError('Assertions must be enabled')
 D=json.loads((ROOT/'resolution/data/critical_coordinates.json').read_text()); cf=D['cubic_f']
 a0,d,b,c,e=[cf[k] for k in ['a0','d','b','c','e']]
 C=U.sub(U.powp(c,2),U.scale(U.mul(b,e),3)); monic=U.scale(C,F.inv(C[-1]))
 assert len(C)==15
 D0,D1,D2=D['discriminant']['s_rows_ascending_q']
 assert U.sub(U.powp(D1,2),U.scale(U.mul(D0,D2),4))==U.mul(U.powp(d,2),U.powp(C,3))
 assert U.gcd(U.gcd(D0,D1),D2)==[1]
 old=[0,1]
 for r in [10149,118020,64426]:old=U.mul(old,[F.neg(r),1])
 snum=U.sub(U.mul(a0,c),U.scale(U.powp(b,2),2))
 certificates={n:cert(monic,p) for n,p in [
  ('squarefree',U.deriv(monic)),('b_unit',b),('c_unit',c),('e_unit',e),
  ('d_unit',d),('old_q_open',old),('s_nonzero',snum)]}
 for s in [360225,272625,246025]:
  certificates['away_from_s_'+str(s)]=cert(monic,U.sub(snum,U.scale(U.mul(d,c),s)))
 def red(p):return U.rem(p,monic)
 def mul(a,b):return red(U.mul(a,b))
 def inv(p):
  g,s,t=xgcd(p,monic);assert g==[1];return red(s)
 q=[0,1];u0=U.neg(mul(c,inv(b)));sv=mul(snum,inv(U.mul(d,c)))
 H=mul(u0,inv(q));av=red(U.sub(a0,mul(d,sv)))
 # f(U)=a(U-u0)^3 over the ENTIRE reduced fourteen-dimensional algebra.
 triple=[U.neg(mul(av,mul(mul(u0,u0),u0))),U.scale(mul(av,mul(u0,u0)),3),U.scale(mul(av,u0),2),av]
 assert triple==[red(e),red(c),red(b),av]
 # Distinct-degree factorization, then splitting the degree-one part.
 remaining=monic;v=[0,1];degree=1;factors=[]
 while 2*degree<=len(remaining)-1:
  v=powmod(v,F.ORDER,remaining);g=U.gcd(remaining,U.sub(v,[0,1]))
  if len(g)>1:
   if degree==1:factors.extend(split_linear(g))
   else:
    assert len(g)-1==degree, 'Unexpected equal-degree batch; no unverified factor splitting'
    factors.append(g)
   remaining=U.exactdiv(remaining,g);v=U.rem(v,remaining)
  degree+=1
 if len(remaining)>1:factors.append(remaining)
 factors.sort(key=lambda p:(len(p),p))
 product=[1];records=[]
 for f in factors:
  product=U.mul(product,f);n=len(f)-1
  assert 1<=n<=4
  irreducible={'degree':n}
  if n>=2:
   test_degree=2 if n==4 else 1
   rem=powmod([0,1],F.ORDER**test_degree,f)
   irreducible.update({'frobenius_degree':test_degree,'frobenius_remainder':rem,
     'no_factor_of_degree_at_most_half':cert(f,U.sub(rem,[0,1]))})
  records.append({'q_minpoly_monic_K_codes':f,'irreducibility':irreducible})
 assert product==monic
 crt=[];total=[]
 for f in factors:
  m=U.exactdiv(monic,f);g,v,t=xgcd(m,f);assert g==[1]
  idem=U.rem(U.mul(m,v),monic)
  assert U.rem(U.sub(U.powp(idem,2),idem),monic)==[]
  for old_idem in crt:assert U.rem(U.mul(idem,old_idem),monic)==[]
  crt.append(idem);total=U.add(total,idem)
 assert U.rem(total,monic)==[1]
 assert [len(p)-1 for p in factors]==[1,1,1,1,1,2,3,4]
 result={'scope':'Coordinate-cubic ramification geometry and all fourteen triple-root source ratios; not square witnesses.',
  'C_q_ascending':C,'C_q_monic':monic,
  'discriminant_identity':'D1^2-4*D0*D2=d^2*(c^2-3*b*e)^3',
  'content_of_D_in_s':1,'exact_coprimality_certificates':certificates,
  'branch_normalization':{'equation':'xi^2=C(q)','genus':6,
   'birational_map':'xi=(2*D2*s+D1)/(d*C)',
   'proof':'REPORT.md: coordinate-cubic ramification section; not inferred from diagnostic points.'},
  'triple_ratio_algebra':{'base':'K[q]/C_monic','dimension':14,
   'u0_mod_C':u0,'H_mod_C':H,'s_mod_C':sv,'a_mod_C':av,
   'triple_root_factorization_checked':True,'all_old_ratio_units':True,
   'disjoint_from_three_infinity_levels':True,'residual_square_test_in_this_program':False},
  'q_factors':records,'complete_factor_product_checked':True,
  'CRT_idempotents_mod_C':crt,'CRT_orthogonality_and_sum_one_checked':True,
  'square_locus_decision':'UNRESOLVED'}
 (ROOT/'resolution/data/cubic_branch.json').write_text(json.dumps(result,indent=2)+'\n')
 print(json.dumps({'status':'PASS','critical_polynomial_degree':14,'squarefree':True,
   'branch_normalization_genus':6,'allowed_triple_root_ratios':14,
   'q_residue_degrees':[len(p)-1 for p in factors],
   'no_square_claim_from_these_checks':True},indent=2))
if __name__=='__main__':main()
