#!/usr/bin/env python3
"""Fixed F25 Hasse jet obstruction to v order at least five at A-points."""
import argparse,json,sys
from pathlib import Path
ARCHIVE=Path('/Users/julian/Documents/litt3-computation-data/october01_audited_replies/nonzero_first_moment/nonzero_first_moment_audited')
sys.path.insert(0,str(ARCHIVE/'src'))
from exact import Field,Poly,P_CODES,A_CODES
from shifted_concentrated_projection import extended_gcd
def main():
    ap=argparse.ArgumentParser();ap.add_argument('--work',type=Path,required=True);args=ap.parse_args();k=Field(args.work/'cache');p=Poly(k)
    square=p.power(P_CODES,2);C3=[k.power(square[i],5) for i in (4,9,14,19)]
    gcd,a,b=extended_gcd(p,A_CODES,C3);assert gcd==[1] and p.add(p.mul(a,A_CODES),p.mul(b,C3))==[1]
    assert all(k.power(c,25)==c for c in C3+a+b)
    out={'scope':'fixed genus-nine curve; fifth-root coefficients of Hasse D4 y numerator','P':P_CODES,'A':A_CODES,'P_squared':square,'C3':C3,'gcd':gcd,'bezout_A':a,'bezout_C3':b,'literal_identity_verified':True,'F25_codes':True}
    (args.work/'data/fivejet_v_boundary.json').write_text(json.dumps(out,separators=(',',':'))+'\n');print(json.dumps(out))
if __name__=='__main__':main()
