#!/usr/bin/env python3
"""Exact geometric support test for pole16, using linear Hermite conditions.

Run with Sage. Lower pole10/13 exclusions imply gcd(U,V)=1, hence at
most one occupied cubic sheet per marked x-fibre. Coefficients of U,V
remain arbitrary over the algebraic closure: field arithmetic computes
the rank of their linear system, not a finite parameter search.
"""
import argparse
import itertools
import json
import platform
import time
from pathlib import Path
from sage.all import GF, PolynomialRing, PowerSeriesRing, binomial, matrix
from sage.env import SAGE_VERSION

P_CODES = [11,22,18,5,19,20,15,16,9,22,1]
A_CODES = [1,21,14,22,13]

def compositions(n, length):
    if length == 1:
        yield (n,)
    else:
        for a in range(n+1):
            for b in compositions(n-a, length-1):
                yield (a,)+b

def orbit(v):
    return {v[i:]+v[:i] for i in range(4)}

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('output', type=Path)
    args = ap.parse_args()
    started = time.monotonic()
    K = GF(5**24, 'z')
    R = PolynomialRing(K, 'x'); x = R.gen()
    beta = (x*x-x-3).roots(multiplicities=False)[0]
    dec = lambda c: K(c%5)+K(c//5)*beta
    alpha = (x**4+dec(7)*x**3+dec(6)*x*x+dec(2)*x+dec(5)).roots(multiplicities=False)[0]
    P = R([dec(c) for c in P_CODES]); A = R([dec(c) for c in A_CODES])
    y0 = (x**3-P(alpha)).roots(multiplicities=False)[0]
    zeta = dec(11)
    roots = [alpha**(25**i) for i in range(4)]
    sheets = [y0**(25**i) for i in range(4)]
    assert len(set(roots)) == 4 and all(A(a)==0 and P(a)!=0 for a in roots)
    assert zeta != 1 and zeta**3 == 1
    assert all(y**3 == P(a) for a,y in zip(roots,sheets))
    code = lambda a: sum(int(c)*5**i for i,c in enumerate(K(a).polynomial().list()))

    S = PowerSeriesRing(K, 't', default_prec=16); t = S.gen()
    jets = []
    for a,y in zip(roots,sheets):
        norm = S(P(a+t)/P(a)).add_bigoh(16)
        # 3*17=1+2*25; a unit with constant1 has its 25th power1 mod t^16.
        local_y = y*norm**17
        assert (local_y**3-S(P(a+t))).valuation() >= 16
        phases = []
        for phase in range(3):
            columns = [S((a+t)**i) for i in range(6)]
            columns += [S(zeta**phase*local_y*(a+t)**j) for j in range(3)]
            phases.append([[f[k] for f in columns] for k in range(16)])
        jets.append(phases)

    all_weights = list(compositions(16,4))
    representatives = [v for v in all_weights if v == min(orbit(v))]
    assert len(all_weights)==969 and len(representatives)==245
    assert set().union(*(orbit(v) for v in representatives)) == set(all_weights)
    records=[]; survivors=[]
    for index, weights in enumerate(representatives):
        occupied = [i for i,m in enumerate(weights) if m]
        # Global y -> zeta*y fixes the first occupied sheet phase to zero.
        for remaining in itertools.product(range(3), repeat=len(occupied)-1):
            phases = [0]*4
            for i,s in zip(occupied[1:],remaining): phases[i]=s
            rows=[]
            for i,m in enumerate(weights): rows.extend(jets[i][phases[i]][:m])
            M=matrix(K,rows); assert M.nrows()==16 and M.ncols()==9
            pivots=list(M.transpose().pivots())
            if len(pivots)!=9:
                survivors.append(dict(weights=weights,phases=phases,rank=len(pivots),
                    kernel=[[code(c) for c in v] for v in M.right_kernel().basis()]))
                print('SURVIVOR',survivors[-1],flush=True)
                det=K(0)
            else:
                det=M.matrix_from_rows(pivots).determinant(); assert det
            records.append(dict(weights=weights,phases=phases,minor_rows=pivots,determinant=code(det)))
        if (index+1)%25==0:
            print(index+1,'orbits;',len(records),'systems;',len(survivors),'survivors;',
                  round(time.monotonic()-started,2),'seconds',flush=True)
    result=dict(scope='all geometric primitive pole16 functions U+Vy supported over A',
        field_modulus=[int(c) for c in K.modulus().list()],
        coefficient_encoding='base5 in the generator of the displayed degree24 modulus',
        beta=code(beta),alpha=code(alpha),y0=code(y0),zeta=code(zeta),
        roots=[code(a) for a in roots],sheets=[code(y) for y in sheets],
        compositions=969,rotation_orbits=245,systems=len(records),survivors=survivors,
        records=records,versions=dict(sage=SAGE_VERSION,python=platform.python_version()),
        elapsed_seconds=time.monotonic()-started)
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(result,separators=(',',':'))+'\n')
    print('COMPLETE',len(records),'systems;',len(survivors),'survivors',flush=True)

if __name__=='__main__': main()
