#!/usr/bin/env python3
"""Prepare an exact first-jet test for the remaining g=n+1 V4 case.

Uses the previously checked endpoint field and jets, then independently
constructs the three-by-three determinant forced by constant T_i and
constant numerator differences. The search concerns finite forced labels,
not arbitrary curve coefficients. Output data belong outside the workspace.
"""
from pathlib import Path
import argparse
import importlib.util
import itertools
import json
import sys

BASE = Path(__file__).resolve().parent/'pro_pivot_secant_20260925/secant/previous/src'
sys.path.insert(0, str(BASE))
import local_checks as F

ZERO = F.ZERO
ONE = F.ONE
EXP0 = (0, 0, 0, 0)


def add(a, b):
    out = dict(a)
    for m, c in b.items():
        out[m] = F.ea(out.get(m, ZERO), c)
        if out[m] == ZERO:
            del out[m]
    return out


def scale(a, s):
    return {m: F.es(c, s) for m, c in a.items() if F.es(c, s) != ZERO}


def sub(a, b):
    return add(a, scale(b, 4))


def mul(a, b):
    out = {}
    for ma, ca in a.items():
        for mb, cb in b.items():
            m = tuple(i+j for i, j in zip(ma, mb))
            out[m] = F.ea(out.get(m, ZERO), F.em(ca, cb))
            if out[m] == ZERO:
                del out[m]
    return out


def det3(rows):
    out = {}
    for p in itertools.permutations(range(3)):
        term = {EXP0: ONE}
        for i, j in enumerate(p):
            term = mul(term, rows[i][j])
        sign = 4 if sum(p[i] > p[j] for i in range(3) for j in range(i+1, 3))%2 else 1
        out = add(out, scale(term, sign))
    return out


SIGNS = [(1,1,4,4), (1,4,1,4), (1,4,4,1)]


def monomial(i, degree, c):
    e = [0]*4
    e[i] = degree
    return {tuple(e): c} if c != ZERO else {}


def fourier(data, signs):
    out = {}
    for value, sign in zip(data, signs):
        out = add(out, scale(value, sign))
    return out


def rows_for(tags, roots, bases, C, L):
    al = [{EXP0: roots[t]} for t in tags]
    bs = [monomial(i,1,bases[t]) for i,t in enumerate(tags)]
    aa = [monomial(i,4,F.em(C[t],F.ep(bases[t],4))) for i,t in enumerate(tags)]
    cc = [monomial(i,5,F.em(L[t],F.ep(bases[t],5))) for i,t in enumerate(tags)]
    fs = [[fourier(arr, signs) for arr in (al,bs,aa,cc)] for signs in SIGNS]
    rows = [[mul(b,b),mul(a,b),sub(mul(da,b),mul(a,db))] for a,b,da,db in fs]
    den = [b for a,b,da,db in fs]
    distinct = [sub(mul(fs[i][0],fs[j][1]),mul(fs[j][0],fs[i][1]))
                for i,j in itertools.combinations(range(3),2)]
    return det3(rows), den+distinct


def serialize(poly):
    return [[*e,*c] for e,c in sorted(poly.items())]


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output',type=Path,required=True)
    args = ap.parse_args()
    old = F.construct_data()
    roots = list(map(tuple,old['alpha_roots']))
    bases = list(map(tuple,old['B_base']))
    C, L = [], []
    for a in roots:
        apv = F.ev(F.f.der(F.f.A),a)
        cv = F.es(F.ei(apv),F.f.A[-1])
        lv = F.em(cv,F.ea(F.em(F.ev(F.f.der(F.f.P),a),F.ei(F.ev(F.f.P,a))),
                         F.en(F.em(F.ev(F.f.der(F.f.der(F.f.A)),a),F.ei(apv)))))
        C.append(cv);L.append(lv)
    tags = [(0,1,2,3)] + [(0,0,i,j) for i,j in itertools.combinations(range(1,4),2)] + [(0,0,0,i) for i in range(1,4)]
    cases = []
    for tag in tags:
        determinant, opens = rows_for(tag,roots,bases,C,L)
        assert all(sum(e)==8 for e in determinant)
        assert len(opens)==6
        cases.append({'roots':tag,'determinant':serialize(determinant),
                      'nonzero_conditions':[serialize(p) for p in opens]})
    out={'scope':'Forced first jets for constant-character, constant-difference V4 profiles.',
         'coefficient_field':'F25[alpha]/A_monic, with F25 beta^2=beta+3',
         'root_of_unity_field':'D7 over F25; compositum degree28 over F25',
         'A_monic':F.AMONIC,'D7':F.D7,'root_data':old,'cases':cases,
         'coverage':'Four distinct labels; 2+1+1; 3+1. Normalize repeated root by coefficient Frobenius, branch permutation, and first omega exponent to0. The 4 and 2+2 root patterns violate nonzero pairwise character-ratio differences.'}
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(out,separators=(',',':'))+'\n')
    dat=args.output.with_suffix('.dat')
    with dat.open('w') as f:
        print(*F.D7,file=f)
        print(len(cases),file=f)
        for case in cases:
            print(*case['roots'],file=f)
            polys=[case['determinant']]+case['nonzero_conditions']
            print(len(polys),file=f)
            for p in polys:
                print(len(p),file=f)
                for term in p: print(*term,file=f)
    print(json.dumps({'cases':len(cases),'determinant_terms':[len(c['determinant']) for c in cases],
                      'candidate_exponent_triples_per_case':29**3,'data':str(dat)}))


if __name__=='__main__':
    main()
