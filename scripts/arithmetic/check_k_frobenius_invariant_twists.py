#!/usr/bin/env python3
"""Independent prime-field ranks on specified invariant-twist matrices.

The complete19683-class coverage is the separate Sage enumeration.
Here literal fifth-power multiplication and restriction of scalars
check16 specified cases for F_abs^*K(O), with their full32-by23 maps.
"""
import argparse
import json
from pathlib import Path
import random
from sage.all import GF, PolynomialRing, matrix

def main():
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('receipt',type=Path)
    p.add_argument('--output',type=Path,required=True);args=p.parse_args()
    data=json.loads(args.receipt.read_text());assert data['tested']==19683 and not data['nonzero_cases']
    assert data['O_shift']==1
    assert data['source_line_degree']==31 and data['target_line_degree']==-24
    f5=GF(5);base=PolynomialRing(f5,'b')
    k=GF(5**8,'b',modulus=base(data['field_modulus']));b=k.gen()
    def lift(v):return sum(k(a)*b**i for i,a in enumerate(v))
    alpha=lift(data['F25_generator']);assert alpha**2==alpha+3
    decode=lambda n:k(n%5)+(n//5)*alpha
    R=PolynomialRing(k,'x');x=R.gen()
    P=R([decode(n) for n in data['curve_P_codes']]);roots=list(map(lift,data['ordered_roots']))
    assert len(set(roots))==10 and all(P(r)==0 for r in roots)
    C=R([decode(n) for n in reversed((2,16,16,7,1,2,7,1,24,11))])
    # Multiply the whole polynomial, rather than replacing coefficients
    # by their fifth powers as in the enumeration.
    literal=C*C*C*C*C
    rng=random.Random(2609265)
    tests=[(0,)*9,(1,)*9,(2,)*9]+[tuple(int(i==j) for i in range(9)) for j in range(3)]
    tests += [tuple(rng.randrange(3) for _ in range(9)) for _ in range(10)]
    checks=[]
    for digits in tests:
        s=digits+(0,);A=R.one();B=R.one()
        for root,exponent in zip(roots,s):
            if exponent==1:A*=x-root
            elif exponent==2:B*=x-root
        den=[R.one(),B,A*B];weight=sum(s);blocks=[]
        for j in range(3):
            target=(j+10)%3
            numerator=literal*P**((j+10)//3)*den[target]
            polynomial,rem=numerator.quo_rem(den[j]);assert not rem
            upper=(data['source_line_degree']-weight-10*j+3*den[j].degree())//3
            lower=(data['target_line_degree']-weight-10*target+3*den[target].degree())//3
            ncols=max(0,int(upper)+1);rows=list(range(int(lower)+1,0))
            field_matrix=[[polynomial[n-i+50] if n-i+50>=0 else k.zero() for i in range(ncols)] for n in rows]
            expanded=matrix(f5,8*len(rows),8*ncols)
            for ri,row in enumerate(field_matrix):
                for ci,entry in enumerate(row):
                    for col in range(8):
                        value=(entry*b**col).polynomial()
                        for digit in range(8):expanded[8*ri+digit,8*ci+col]=value[digit]
            rank=int(expanded.rank());assert rank==8*ncols
            blocks.append([len(rows),ncols,rank])
        assert sum(t[0] for t in blocks)==32 and sum(t[1] for t in blocks)==23
        checks.append({'digits':s,'prime_field_blocks':blocks})
    args.output.write_text(json.dumps({'status':'PASS','scope':'16 independent implementation checks by literal polynomial powers and F5 elimination; the separate complete enumeration supplies all19683-class coverage.',
                                      'checks':checks},indent=2)+'\n')
    print('PASS:',len(checks),'full invariant-twist maps, literal fifth powers and F5 rank184 each.')

if __name__=='__main__':main()
