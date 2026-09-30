#!/usr/bin/env python3
"""Independent Fourier constants and all four exceptional scalar formulas."""
import argparse,json
from pathlib import Path
from sage.all import GF,PolynomialRing

def main():
    ap=argparse.ArgumentParser();ap.add_argument('output',type=Path);args=ap.parse_args()
    R=PolynomialRing(GF(5),'b');b=R.gen();B=GF(25,'b',modulus=b*b-b-3);b=B.gen()
    dec=lambda c:B(c%5)+B(c//5)*b
    code=lambda c:int(B(c)[0])+5*int(B(c)[1])
    R=PolynomialRing(B,'x');x=R.gen();E=B.extension(R([dec(c) for c in [5,2,6,7,1]]),'a');a=E.gen()
    roots=[a**(25**i) for i in range(4)]
    def parts(row):
        f=R([dec(c) for c in row]);return [4*sum((E(pow(2,(-l*i)%4,5))*f(z) for i,z in enumerate(roots)),E.zero()) for l in range(4)]
    aa=parts([20,12,13,8]);bb=parts([21,21,20,2]);cc=parts([22,7,9,23])
    assert all(aa[i] for i in [1,2,3]) and cc[1] and cc[3]
    assert aa[2]**2==E(dec(9)) and aa[2]*aa[1]/aa[3]==E(dec(19)) and aa[2]*aa[3]/aa[1]==E(dec(14))
    assert bb[1]==-E(dec(10))*aa[1] and bb[3]==0
    r,d,e=dec(10),dec(19),dec(14);cases=[]
    for tau in range(1,5):
        av=r/(1-e/d*tau*tau);bv=-av*tau/d;norm=av*av-dec(9)*bv*bv
        assert norm and norm/av==r
        ai,bi=av/norm,-bv/norm;ti=-bi*d/ai
        li=ai+bi*e*ti
        assert ti==-B(tau) and li==1/av and li!=r
        cases.append(dict(tau=tau,a=code(av),b=code(bv),inverse_lambda=code(li)))
    result=dict(status='PASS',a2_square=9,a2_a1_over_a3=19,a2_a3_over_a1=14,
                first_trace_odd_components_nonzero=True,exceptional_unpaired_cases=cases)
    args.output.write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result))

if __name__=='__main__':main()
