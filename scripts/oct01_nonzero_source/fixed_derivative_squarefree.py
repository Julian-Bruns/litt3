#!/usr/bin/env python3
"""Tiny exact squarefreeness certificate for the fixed curve derivative."""
import argparse,json,sys
from pathlib import Path
ARCHIVE=Path('/Users/julian/Documents/litt3-computation-data/october01_audited_replies/nonzero_first_moment/nonzero_first_moment_audited')
sys.path.insert(0,str(ARCHIVE/'src'))
from exact import Field,Poly,P_CODES
from shifted_concentrated_projection import extended_gcd
ap=argparse.ArgumentParser();ap.add_argument('--work',type=Path,required=True);args=ap.parse_args();k=Field(args.work/'cache');p=Poly(k);dp=p.derivative(P_CODES);ddp=p.derivative(dp);g,a,b=extended_gcd(p,dp,ddp)
assert p.add(p.mul(a,dp),p.mul(b,ddp))==g
assert all(k.power(c,25)==c for c in dp+ddp+g+a+b)
out={'scope':'fixed curve Pprime squarefreeness over F25','P':P_CODES,'Pprime':dp,'Pdoubleprime':ddp,'gcd':g,'bezout_Pprime':a,'bezout_Pdoubleprime':b,'literal_identity_verified':True,'squarefree':g==[1]};(args.work/'data/fixed_derivative_squarefree.json').write_text(json.dumps(out,separators=(',',':'))+'\n');print(json.dumps(out))
