#!/usr/bin/env python3
"""Fixed six-point arithmetic for the remaining m6 rational root itinerary."""
import argparse,json,sys
from pathlib import Path
archive=Path('/Users/julian/Documents/litt3-computation-data/october01_audited_replies/nonzero_first_moment/nonzero_first_moment_audited')
sys.path.insert(0,str(archive/'src'))
from exact import Field,Poly,P_CODES,B0_CODES,L0_CODES
parser=argparse.ArgumentParser();parser.add_argument('--work',type=Path,required=True);args=parser.parse_args()
k=Field(args.work/'cache');p=Poly(k);q=[13,18,24];Z=p.sub(B0_CODES,L0_CODES)
quotient,remainder=p.divmod(p.mul(Z,q),P_CODES)
assert quotient==[22,15]
points=[]
for root in [12,16]:
    qi=p.eval(quotient,root);pi=p.eval(P_CODES,root);cube=k.power(qi,3)
    points.append({'x':root,'Q':qi,'P':pi,'Qcube':cube,'P_Qcube':k.mul(pi,cube)})
assert points==[{'x':12,'Q':5,'P':6,'Qcube':23,'P_Qcube':5},{'x':16,'Q':9,'P':1,'Qcube':23,'P_Qcube':23}]
report={'status':'PASS','q':q,'quotient':quotient,'remainder':remainder,'fiber_values':points,'scope':'fixed finite rational-critical-root numerator arithmetic only'}
(args.work/'data/m6_rational_root_fiber_itinerary.json').write_text(json.dumps(report)+'\n')
print(json.dumps(report))
