#!/usr/bin/env python3
"""Small exact arithmetic for the marked divisor Frobenius module."""
import argparse,json
from pathlib import Path
from sage.all import GF,ZZ,PolynomialRing,gcd,xgcd
p=argparse.ArgumentParser();p.add_argument('output',type=Path);args=p.parse_args()
R=PolynomialRing(GF(5),'b');b=R.gen();B=GF(25,'b',modulus=b*b-b-3);b=B.gen()
dec=lambda n:B(n%5)+B(n//5)*b
R=PolynomialRing(B,'a');E=B.extension(R([dec(n) for n in [5,2,6,7,1]]),'a');a=E.gen()
R=PolynomialRing(E,'x');x=R.gen()
P=R([dec(n) for n in [11,22,18,5,19,20,15,16,9,22,1]])
phase=P(a)**((5**8-1)//3);assert phase==dec(11)
R=PolynomialRing(ZZ,'T');T=R.gen()
Pi=(T**18-2*T**17-29*T**16+57*T**15-124*T**14+3716*T**13+3083*T**12
 -94215*T**11+141450*T**10+601875*T**9+3536250*T**8-58884375*T**7
 +48171875*T**6+1451562500*T**5-1210937500*T**4+13916015625*T**3
 -177001953125*T**2-305175781250*T+3814697265625)
Q=T**8+T**4+1;res=Pi.resultant(Q);assert res%5
F=PolynomialRing(GF(5),'T');Pi5=F(Pi);Q5=F(Q)
g,U,V=xgcd(Pi5,Q5);assert g==1 and U*Pi5+V*Q5==1
record={'scope':'marked divisor subgroup, not all Jacobian torsion',
 'cubic_phase_code':11,'annihilator':[int(n) for n in Q],
 'weil_polynomial':[int(n) for n in Pi], 'resultant':str(res),
 'resultant_mod_5':int(res%5),
 'bezout_mod_5':{'U':[int(n) for n in U],'V':[int(n) for n in V]},
 'checks':{'phase':True,'prime_to_five_annihilator':True,'bezout':True}}
args.output.parent.mkdir(parents=True,exist_ok=True)
args.output.write_text(json.dumps(record,indent=2)+'\n')
print('PASS: marked support has prime-to-five annihilator; resultant mod5 =',res%5)
