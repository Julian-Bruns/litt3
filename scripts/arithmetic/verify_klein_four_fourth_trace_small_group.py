#!/usr/bin/env python3
"""Independent expanded fourth-trace obstruction in F5[zeta] of degree14.

This checks a sparse polynomial consequence, without reconstructing the
moments or sharing the degree-seven field implementation of the first run.
"""
import json
from pathlib import Path
import argparse
import klein_four_reciprocal_f25 as F


def main(path):
    cert = json.loads(path.read_text())
    zp = [F.power(F.ZETA, j) for j in range(29)]
    emb = [F.add(F.scale(F.ONE, c % 5), F.scale(F.BETA, c//5)) for c in range(25)]
    table = {(c,j):F.mul(emb[c],zp[j]) for c in range(25) for j in range(29)}

    def evaluate(terms):
        ans = F.ZERO
        for c,j in terms:
            ans = F.add(ans,table[c,j % 29])
        return ans

    zeros, boundaries = [], []
    for p in range(29):
        for d in range(29):
            for e in range(1,25):
                N = F.m25(e,F.bar25(e))
                if N == 1:
                    terms=[(17,5*p),(F.s25(0,e),d),(e,d-8*p),(F.s25(0,F.bar25(17)),0)]
                    if evaluate(terms)==F.ZERO:boundaries.append([p,d,e])
                    continue
                # Multiply the endpoint-trace difference by1-N.
                # Its degree626 polynomial is displayed in the mathematical note.
                e5=F.bar25(e);e626=F.m25(e,e)
                outer=[(F.m25(F.m25(12,e),(1-N)%5),d),((4*(1-N))%5,0)]
                inner=[(e,d+12*p),
                       (F.m25(e626,F.bar25(17)),17*d+7*p),
                       (F.s25(0,F.m25(e626,17)),17*d),
                       (F.s25(0,F.m25(e,N)),d),
                       (F.s25(0,F.bar25(17)),25*p),
                       (e5,5*d),(F.s25(0,e5),5*d+18*p),
                       (F.m25(N,17),0)]
                terms=outer+[(F.s25(0,F.m25(8,c)),j) for c,j in inner]
                if evaluate(terms)==F.ZERO:zeros.append([p,d,e])
    assert boundaries==cert['norm_one_compatible']==[]
    assert zeros==cert['first_fourth_jet_survivors']==[]
    print('PASS: all20184 scalar/phase pairs; norm-one boundaries and expanded first fourth-jet obstruction.')
    print('No candidate survives anywhere in epsilon^696=1, irrespective of pole mass.')


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('certificate',type=Path)
    main(p.parse_args().certificate)
