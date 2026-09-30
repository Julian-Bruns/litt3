#!/usr/bin/env python3
"""All balanced phases and epsilon in F25*mu29, with both fourth jets.

The incoming universal endpoint coefficient is F0+epsilon^-1*F1.
A phase xi changes its two terms by xi^17 and xi^4. The first
balanced phase is normalized to1 and the second is phi.
This is an exact necessary-condition test, never a curve search.
"""
import argparse
import json
from pathlib import Path
from verify_klein_four_reciprocal_f25 import F, MOD, product, power


def main(output):
    zp = [power([0, 1], j) for j in range(29)]

    def add(a, b):
        return F.padd(a, b)

    def sub(a, b):
        return F.psub(a, b)

    def frob(a, exponent):
        q = 5**exponent
        ans = []
        for i, c in enumerate(a):
            ans = add(ans, F.scale(zp[i*q % 29], F.power(c, q % 24)))
        return ans

    norm_one = []
    first, both = [], []
    checked = 0
    for phase in range(29):
        for d in range(29):
            for e in range(1, 25):
                epsilon = F.scale(zp[d], e)
                norm = F.mul(e, F.power(e, 5))
                rhs = sub(F.scale(zp[5*phase % 29], 17), F.scale([F.power(17, 5)], norm))
                rhs = sub(rhs, product(epsilon, sub([1], zp[-8*phase % 29])))
                if norm == 1:
                    if not rhs:
                        norm_one.append([phase, d, e])
                    continue
                ybar = F.scale(rhs, pow((1-norm) % 5, -1, 5))
                y = frob(ybar, 7)
                x = add(sub(zp[8*phase % 29], F.scale(epsilon, 17)), product(epsilon, y))
                assert product(epsilon, sub([1], frob(x, 7))) == sub(F.scale(zp[5*phase % 29], 17), ybar)
                assert product(epsilon, sub([17], y)) == sub(zp[8*phase % 29], x)
                checked += 1
                # epsilon*[12]+4 = [8]*(epsilon*M3-M_-1).
                a = sub(add(F.scale(epsilon, 12), [4]),
                        F.scale(sub(product(epsilon, frob(x, 4)), frob(ybar, 1)), 8))
                # [12]*phi^17+4*epsilon*phi^4 = [8]*(M_-3-epsilon*M1).
                b = sub(add(F.scale(zp[17*phase % 29], 12),
                            F.scale(product(epsilon, zp[4*phase % 29]), 4)),
                        F.scale(sub(frob(x, 11), product(epsilon, frob(y, 1))), 8))
                if not a:
                    row = [phase, d, e]
                    first.append(row)
                    if not b:
                        both.append(row)
    data = dict(scope='Necessary two old moments plus fourth-jet traces; all balanced phases and epsilon in F25*mu29',
                scalar_phase_cases=24*29*29,norm_one_compatible=norm_one,
                old_moment_solutions=checked,first_fourth_jet_survivors=first,
                both_fourth_jet_survivors=both,
                field_modulus=MOD,actual_curves_constructed=0)
    output.write_text(json.dumps(data,indent=2)+'\n')
    print('old moment cases',checked,'norm-one compatible',len(norm_one))
    print('first fourth-jet survivors',len(first),'both',len(both))
    print('survivors',both)


if __name__ == '__main__':
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output',type=Path,required=True)
    main(ap.parse_args().output)
