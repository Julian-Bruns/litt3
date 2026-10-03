#!/usr/bin/env sage
"""New norm quotient/Frobenius support data for the saved d=0 annihilator.

No Groebner calculation, point replay, divisor-class or source decision.
"""
import argparse
import json
from pathlib import Path
import signal
import time
parser=argparse.ArgumentParser()
parser.add_argument('--annihilator',required=True)
parser.add_argument('--output',required=True)
args=parser.parse_args()
signal.alarm(10)
start=time.monotonic()
R,Rx,G,H,ann,U,remainders=load(args.annihilator)
x=Rx.gen()
def normal(p):return Rx([c.reduce(G) for c in p.list()])
quotients=[]
for even,odd in ann[1:]:
    norm=normal(even^2-H*odd^2)
    quotient,remainder=norm.quo_rem(U)
    quotient=normal(quotient)
    remainder=normal(remainder)
    assert remainder==0
    assert normal(U*quotient-norm)==0
    quotients.append(quotient)
last=quotients[-1]
support=[j for j,c in enumerate(last.list()) if c]
fifth_support=all(j%5==0 for j in support)
RX=PolynomialRing(R,'X')
X=RX.gen()
descended=RX([last[5*j] for j in range(1+last.degree()//5)]) if fifth_support else None
if descended is not None:assert Rx(descended(x^5))==last
out=Path(args.output)
out.mkdir(parents=True,exist_ok=True)
save((R,Rx,G,H,ann,U,quotients,RX,descended),str(out/'norm_quotients.sobj'))
(out/'norm_quotients.txt').write_text('\n'.join('quotient['+str(i+1)+'] = '+str(z) for i,z in enumerate(quotients))+'\n'+
    'last x-support = '+str(support)+'\n'+
    'candidate relative-Y1 polynomial = '+str(descended)+'\n')
summary={'scope':'new norm-quotient shapes in existing d=0 necessary family only',
         'threads':1,'recomputed_groebner_basis':False,
         'quotient_degrees':[int(z.degree()) for z in quotients],
         'last_quotient_x_support':support,
         'last_quotient_has_only_fifth_powers':fifth_support,
         'candidate_Y1_polynomial_degree':None if descended is None else int(descended.degree()),
         'elapsed_seconds':time.monotonic()-start}
(out/'summary.json').write_text(json.dumps(summary,indent=2,default=int)+'\n')
print(json.dumps(summary,default=int))
