#!/usr/bin/env python3
"""Forced endpoint character jets over the 29th-root coefficient field.

Construct equations saying that A_i/B_i and its first derivative lie in
F_(25^7), inside the compositum F_(25^28). Generated exact data go outside
the source workspace. This is a finite label test, not a curve search.
"""
import argparse
import itertools
import json
from pathlib import Path
import klein_four_constant_character_jet as J

F = J.F


def conjugate(p):
    # The 25^7 Frobenius fixes zeta and acts by 25^3 on F_(25^4).
    return {e:F.ep(c,25**3) for e,c in p.items()}


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output',type=Path,required=True)
    args=ap.parse_args()
    old=F.construct_data()
    roots=list(map(tuple,old['alpha_roots']))
    bases=list(map(tuple,old['B_base']))
    C=[];L=[]
    for a in roots:
        apv=F.ev(F.f.der(F.f.A),a)
        cv=F.es(F.ei(apv),F.f.A[-1])
        lv=F.em(cv,F.ea(F.em(F.ev(F.f.der(F.f.P),a),F.ei(F.ev(F.f.P,a))),
                         F.en(F.em(F.ev(F.f.der(F.f.der(F.f.A)),a),F.ei(apv)))))
        C.append(cv);L.append(lv)
    tags=[(0,1,2,3)]+[(0,0,i,j) for i,j in itertools.combinations(range(1,4),2)]
    tags += [(0,0,0,i) for i in range(1,4)]
    tags += [(0,0,i,i) for i in range(1,4)]+[(0,0,0,0)]
    cases=[]
    for tag in tags:
        al=[{J.EXP0:roots[t]} for t in tag]
        bs=[J.monomial(i,1,bases[t]) for i,t in enumerate(tag)]
        aa=[J.monomial(i,4,F.em(C[t],F.ep(bases[t],4))) for i,t in enumerate(tag)]
        cc=[J.monomial(i,5,F.em(L[t],F.ep(bases[t],5))) for i,t in enumerate(tag)]
        polys=[]
        for signs in J.SIGNS:
            a,b,da,db=[J.fourier(arr,signs) for arr in (al,bs,aa,cc)]
            numer=J.sub(J.mul(da,b),J.mul(a,db))
            q0=J.sub(J.mul(conjugate(a),b),J.mul(a,conjugate(b)))
            q1=J.sub(J.mul(conjugate(numer),J.mul(b,b)),
                     J.mul(numer,conjugate(J.mul(b,b))))
            polys += [b,q0,q1]
        cases.append({'roots':tag,'polynomials':[J.serialize(p) for p in polys]})
    out={'scope':'First two coefficients of each nonzero-leading character ratio over F25^7.',
         'root_data':old,'cases':cases,
         'coverage':'All five alpha multiplicity partitions modulo branch permutation and coefficient Frobenius; common zeta scaling normalizes exponent0.'}
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(out,separators=(',',':'))+'\n')
    with args.output.with_suffix('.dat').open('w') as f:
        print(*F.D7,file=f);print(len(cases),file=f)
        for case in cases:
            print(*case['roots'],file=f);print(len(case['polynomials']),file=f)
            for p in case['polynomials']:
                print(len(p),file=f)
                for term in p:print(*term,file=f)
    print('Constructed',len(cases),'root-pattern cases, each with three character tests.')


if __name__=='__main__':main()
