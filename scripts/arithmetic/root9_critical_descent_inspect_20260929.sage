#!/usr/bin/env sage
import sys
from pathlib import Path
d=Path(sys.argv[1]);src=load(str(d/'actual_delta.sobj'));dc=src['delta'];P=src['P'];X=P.parent();x=X.gen();F=X.base_ring();R=F.ring();h,w=R.gens();K=R.base_ring()
lead=dc[2][4];assert lead.numerator().is_constant() and lead.denominator().is_constant()
print('LEADING_SQUARE_ROOTS',(lead.numerator().constant_coefficient()/lead.denominator().constant_coefficient()).sqrt(all=True),flush=True)
for j in range(3):
 for i in range(max(0,dc[j].degree()-3),dc[j].degree()+1):
  c=dc[j][i];print('COEF',j,i,'NUM_DEG',[c.numerator().degree(v) for v in [h,w]],'DEN_DEG',[c.denominator().degree(v) for v in [h,w]],'TERMS',len(c.numerator().dict()),flush=True)
  if len(c.numerator().dict())<12:print(c,flush=True)
KP=PolynomialRing(K,'x');pk=KP([c.numerator().constant_coefficient()/c.denominator().constant_coefficient() for c in P]);print('P_ROOTS',len(pk.roots(multiplicities=False)),flush=True)
