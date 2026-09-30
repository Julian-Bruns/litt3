"""Regression checks for the implemented complete 70-generator criterion,
including nonreduced coefficient algebras and the T^125 correction.
These tests complement, but do not replace, the universal proof supplied
as an input in the question.
"""
from residual import *
from ff import Poly,X
import random,json,time

def power_trunc(a,n,length):
 r=EP(1)
 while n:
  if n&1:r=r.mullow(a,length)
  n//=2
  if n:a=a.mullow(a,length)
 return r

def run_checks():
 start=time.time();rng=random.Random(927125)
 # K[delta]/delta^2: genuinely nonreduced, not a field.
 delta=ext.context(Poly([0,0,1]));assert delta and delta*delta==0
 coeff=[E(1)]+[E([rng.randrange(390625),rng.randrange(390625)]) for _ in range(140)]
 a=EP(coeff);ts=Tails([EP(c) for c in coeff]);true=power_trunc(a,313,141)
 for n in range(141):
  got=ts.C(n)+(2*ts.a1f125*ts.C(n-125) if n>=125 else EP())
  assert got==EP(true[n])
 bc=[E(1)]+[E([rng.randrange(390625),rng.randrange(390625)]) for _ in range(70)]
 B=EP(bc);a=B*B;ts=Tails([EP(a[n]) for n in range(141)])
 assert all(ts.C(n)==EP(B[n]) for n in range(71))
 assert all(not ts.tail(n) for n in range(71,141))
 aa=[EP(1)]+[EP() for _ in range(140)];aa[125]=EP(1);ts=Tails(aa)
 assert ts.tail(125)==3
 aa=[EP(1),EP(1)]+[EP() for _ in range(139)];ts=Tails(aa)
 assert not ts.C(125) and ts.tail(125)==2
 return {'coefficient_algebra':'K[delta]/(delta^2)','seed':927125,'all_141_corrected_coefficients_match_a313':True,'positive_degree70_root_recovered':True,'all_70_positive_tails_zero':True,'a_1_plus_T125_tail125':3,'a_1_plus_T_tail125_corrected':2,'elapsed_seconds':round(time.time()-start,3)}
if __name__=='__main__':
 out=run_checks();(ROOT/'checks'/'frobenius_check.json').write_text(json.dumps(out,indent=2)+'\n');print(json.dumps(out,indent=2))
