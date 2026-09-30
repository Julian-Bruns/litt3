#!/usr/bin/env python3
"""Redundant exact checks of REPORT Sections 5, 7-9; not a geometric search."""
from __future__ import annotations

import sympy as sp


def main() -> None:
    n, g, m, z, q = sp.symbols('n g m z q')
    M = 4*n - 4
    N = 7*n - 3*g + 15 + 3*m
    cap = n + 12
    base = (n-12)*(n-13)/2
    pa = (n-1)**2
    assert sp.expand(z*(z-1)/2 - q*z + q*(q+1)/2
                     - (z-q)*(z-q-1)/2) == 0
    constants = []
    for qs, wanted, coeffs, R in [
        ((20,23,2,5), 5532, (14,16), (-n*n+227*n-11016)/2),
        ((29,34,3,8), 12180, (23,25), (-n*n+353*n-24358)/2),
    ]:
        c = sum(k*v*(v+1)//2 for k,v in zip((4,12,10,90),qs))
        assert c == wanted
        gap = qs[1]-qs[0]
        assert gap == qs[3]-qs[2]
        grid = qs[1]*M + qs[3]*N - c - gap*cap
        a,b = coeffs
        assert sp.expand(g+base+m+grid-pa - (R-a*g+b*m)) == 0
        constants.append(c)
    def r1(v: int) -> int:
        assert (-v*v+227*v-11016) % 2 == 0
        return (-v*v+227*v-11016)//2
    def r2(v: int) -> int:
        assert (-v*v+353*v-24358) % 2 == 0
        return (-v*v+353*v-24358)//2
    assert (r1(92),r1(93),r1(94),r1(133)) == (702,723,743,743)
    assert (r2(111),r2(182)) == (1252,3382)
    assert 378+12*29 == 1190-16*29 == 726
    assert 621+21*29 == 1955-25*29 == 1230
    checked = 0
    for nn in range(92,183):
        for mm in range((nn-12)//3+1):
            for gg in range(min(85,27+2*mm)+1):
                assert (14*gg-16*mm < r1(nn)
                        or 23*gg-25*mm < r2(nn))
                checked += 1
    remaining91 = [(mm,gg) for mm in range(27)
                   for gg in range(min(85,27+2*mm)+1)
                   if 14*gg-16*mm >= r1(91)]
    assert remaining91 == [(26,79)]
    t, eps, H, R, li, lj, ni, nj = sp.symbols('t eps H R li lj ni nj', nonzero=True)
    Ui, Uj = li*(ni-H/eps), lj*(nj-H/eps)
    Vi, Vj = li*(eps*t**7*ni+R), lj*(eps*t**7*nj+R)
    E = t**7*H+R
    assert sp.expand(Vi-eps*t**7*Ui-li*E) == 0
    assert sp.expand(Ui*Vj-Uj*Vi-li*lj*E*(ni-nj)) == 0
    J1,J2,J3,H1,H2,H3,l1,l2,l3 = sp.symbols('J1 J2 J3 H1 H2 H3 l1 l2 l3', nonzero=True)
    F1 = l2**2*H3*J2-l3**2*H2*J3
    F2 = l3**2*H1*J3-l1**2*H3*J1
    F3 = l1**2*H2*J1-l2**2*H1*J2
    w2sq = l2**2*H1*H3/(t**6*J1*J3)
    w3sq = l3**2*H1*H2/(t**6*J1*J2)
    assert sp.cancel(w2sq-w3sq-H1*F1/(t**6*J1*J2*J3)) == 0
    assert sp.expand(l1**2*J1*F1+l2**2*J2*F2+l3**2*J3*F3) == 0
    assert ((-39*sp.Symbol('h')+48*4) - (sp.Symbol('h')+2)).expand() == -40*sp.Symbol('h')+190
    print('PASS: integer supporting-line identity; constants', constants)
    print('PASS: two necessary quadratics and interval endpoints')
    print('PASS: redundant finite arithmetic check of', checked, '(n,m,g) triples in 92..182')
    print('PASS: n=91 first-certificate survivors (m,g):', remaining91)
    print('PASS: saturated U,V representation and determinant identity')
    print('PASS: companion-square identity and cyclic syzygy')
    print('PASS: characteristic-five simple-pole contact coefficient h+2')
    print('SymPy', sp.__version__)
    print('The interval theorem has a theoretical proof; these are redundant checks.')
    print('No geometric coefficient or endpoint-cover search was executed.')

if __name__ == '__main__':
    main()
