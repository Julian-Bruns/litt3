"""Exact reduction of the a_1 numerator on the ramification curve."""
from ff import *
from residual import RATIO
import json
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]

def main(save=True):
 raw=json.loads((ROOT/'data/a1_model.json').read_text())
 rows=[Poly(p) for p in raw['a1_numerator_q_rows_ascending_u']]
 a0,b,c,e,d=[Poly(RATIO[n]) for n in ['a0','b','c','e','d']]
 n=len(rows)-1;D=max(0,n-1)
 bp=[Poly(1)]
 for _ in range(D):bp.append(bp[-1]*b)
 A0=rows[0]*bp[D];A1=rows[1]*bp[D]
 r0,r1=Poly(),Poly(1)
 for j in range(2,n+1):
  r0,r1=2*e*r1,b*r0+3*c*r1
  A0=A0+rows[j]*r0*bp[D-j+1]
  A1=A1+rows[j]*r1*bp[D-j+1]
 gcd=A0.gcd(A1);A0=A0//gcd;A1=A1//gcd
 norm=b*A0*A0+3*c*A0*A1+3*e*A1*A1
 print('reduced degrees',A0.degree(),A1.degree(),'common',gcd.degree(),'raw norm',norm.degree(),flush=True)
 dd2=c*c-4*b*e;dd3=b*b*c*c+a0*c**3+b**3*e+3*a0*a0*e*e+3*a0*b*c*e
 # Old boundary theorem and original chart allow removal of these entire
 # q-divisors, but C=0 is already outside the ordinary-double-root chart.
 old=X*d*(X-10149)*(X-64426)*b*c*e*dd2*dd3*Poly(RATIO['C'])
 clean=lambda f:remove(f,old)
 nc,removed=clean(norm);cg,cgr=clean(gcd)
 qq=nc.gcd(nc.derivative());nc_sf=nc//qq
 print('norm after old units',nc.degree(),'squarefree',nc_sf.degree(),'new common',cg.degree(),'leading drop gcd',nc_sf.gcd(A1).degree(),flush=True)
 out={'A0':A0.tolist(),'A1':A1.tolist(),'common_q_factor':gcd.tolist(),'b_denominator_power':D,'norm_numerator':norm.tolist(),
 'norm_after_old_units':nc.tolist(),'norm_removed_old_factors':removed.tolist(),'norm_squarefree':nc_sf.tolist(),
 'new_common_factor':cg.tolist(),'common_removed_old_factors':cgr.tolist(),'old_unit_product':old.tolist(),
 'status':'exact complete a1=0 divisor model; exclusion evidence is in a1_certificates'}
 if save:
  from factor import factor_squarefree,irreducible
  factors=factor_squarefree(nc_sf)
  assert all(irreducible(f) for f in factors)
  out['factorization']=[f.tolist() for f in factors]
  (ROOT/'data/a1_reduced.json').write_text(json.dumps(out,indent=2)+'\n')
 return out

def remove(f,unit):
 removed=Poly(1)
 while True:
  a=f.gcd(unit)
  if a.degree()<=0:break
  f=f//a;removed=removed*a
 if f:
  removed=removed*f[f.degree()];f=f.monic()
 return f,removed
if __name__=='__main__':main()
