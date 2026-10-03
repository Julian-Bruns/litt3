#!/usr/bin/env python3
"""Recompute the uniform Q frame over the full noninvariant oper algebra.

Run: sage -python scripts/atlases/verify_cubic_oper_frame.py
The default run checks the retained determinant and Bezout certificate.
Use --output PATH to write a freshly generated certificate.
"""
import argparse
import hashlib
import itertools
import json
from copy import copy
from pathlib import Path

from sage.all import GF, PolynomialRing, matrix
from sage.rings.polynomial.polynomial_quotient_ring import PolynomialQuotientRing_generic

ROOT = Path(__file__).resolve().parents[2]
k = GF(25, name='a', modulus=PolynomialRing(GF(5), 'z')([2, 4, 1]))
a = k.gen()
cols = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,16,17,18,
        21,22,26,27,31,32,36,37,41,42,46,47,51,52]


def monomials(bound):
    return sorted(((i,j) for j in range(3) for i in range(bound//3+1)
                   if 3*i+10*j <= bound), key=lambda m: 3*m[0]+10*m[1])


mons64, mons112 = monomials(64), monomials(112)
rows = [i for i in range(len(mons112)-1,-1,-1)
        if 36 <= 3*mons112[i][0]+10*mons112[i][1] <= 112
        and (3*mons112[i][0]+10*mons112[i][1]) % 5 in (1,2)]
assert len(rows) == len(cols) == 32


def make_minor(field, ahat_values, b_values, chat_values, lam):
    R = PolynomialRing(field, 'x')
    x = R.gen()
    aa = field(a)
    F = (x**10+(4*aa+2)*x**9+(aa+4)*x**8+(3*aa+1)*x**7
         +3*aa*x**6+4*aa*x**5+(3*aa+4)*x**4+aa*x**3
         +(3*aa+3)*x**2+(4*aa+2)*x+2*aa+1)
    fp = F.derivative()
    zero = R.zero()
    add = lambda v, w: tuple(f+g for f, g in zip(v, w))
    scale = lambda c, v: tuple(c*f for f in v)
    def delta(v):
        ans = [zero, zero, zero]
        for j, p in enumerate(v):
            ans[(j+2)%3] += p.derivative()*F**((j+2)//3)
            if j: ans[j-1] += 2*j*p*fp
        return tuple(ans)
    def mul(v, w):
        ans = [zero, zero, zero]
        for j, f in enumerate(v):
            for h, g in enumerate(w):
                ans[(j+h)%3] += f*g*F**((j+h)//3)
        return tuple(ans)
    apart = (R(ahat_values), zero, zero)
    bpart = (zero, R(b_values)+2*x**8, zero)
    cpart = (zero, zero, R(chat_values))
    dapart, dbpart, dcpart = map(delta, [apart, bpart, cpart])
    def potential_term(p, dp, h, dh):
        return add(mul(p, dh), scale(3, mul(dp, h)))
    columns = []
    for index in cols:
        i, j = mons64[index]
        h = [zero, zero, zero]
        h[j] = x**i
        h = tuple(h)
        dh = delta(h)
        value = add(delta(delta(dh)), potential_term(bpart, dbpart, h, dh))
        ac = lam if j >= 1 else field.one()
        cc = lam if j == 2 else field.one()
        value = add(value, scale(ac, potential_term(apart, dapart, h, dh)))
        value = add(value, scale(cc, potential_term(cpart, dcpart, h, dh)))
        columns.append([value[mons112[r][1]][mons112[r][0]] for r in rows])
    return matrix(field, columns).transpose()


def constant_elimination(g, specialized, embed):
    """Apply identical constant-pivot operations before and after specialization."""
    g, specialized = copy(g), copy(specialized)
    factor = k.one()
    for step in range(32):
        candidates = [(int(g[i,j].total_degree()), i, j)
                      for i in range(step,32) for j in range(step,32) if g[i,j]]
        degree, row, column = min(candidates)
        if degree > 0:
            assert step == 26 and factor == -1
            h = g[step:,step:]
            assert max(c.total_degree() for c in h.list() if c) <= 9
            return h, specialized[step:,step:], factor
        if row != step:
            g.swap_rows(row,step); specialized.swap_rows(row,step)
            factor = -factor
        if column != step:
            g.swap_columns(column,step); specialized.swap_columns(column,step)
            factor = -factor
        pivot = k(g[step,step].constant_coefficient())
        factor *= pivot
        inverse = 1/pivot
        assert specialized[step,step]*embed(inverse) == 1
        for j in range(step+1,32):
            g[step,j] *= inverse
            specialized[step,j] *= embed(inverse)
        for i in range(step+1,32):
            entry, specialized_entry = g[i,step], specialized[i,step]
            for j in range(step+1,32):
                g[i,j] -= entry*g[step,j]
                specialized[i,j] -= specialized_entry*specialized[step,j]
            g[i,step] = 0
            specialized[i,step] = 0
    raise AssertionError('Expected a six-by-six residual matrix')


def determinant(h):
    """Division-free subset expansion, checked by the permutation formula."""
    ring, n = h.base_ring(), h.nrows()
    minors = {0:ring.one()}
    for mask in range(1,1<<n):
        row = mask.bit_count()-1
        value = ring.zero()
        for column in range(n):
            if mask & (1<<column):
                sign = (-1)**(row+(mask & ((1<<column)-1)).bit_count())
                value += sign*minors[mask-(1<<column)]*h[row,column]
        minors[mask] = value
    direct = ring.zero()
    for permutation in itertools.permutations(range(n)):
        inversions = sum(permutation[i]>permutation[j]
                         for i in range(n) for j in range(i+1,n))
        term = ring((-1)**inversions)
        for i in range(n):
            term *= h[i,permutation[i]]
        direct += term
    assert direct == minors[(1<<n)-1]
    return direct


def verify(census_path, certificate_path, output=None):
    census = json.loads(census_path.read_text())
    certificate = json.loads(certificate_path.read_text())
    assert certificate['column_indices'] == cols
    assert certificate['row_indices'] == rows
    source_hash = hashlib.sha256(census_path.read_bytes()).hexdigest()
    assert source_hash == certificate['census_source_sha256']
    names = (['a%d'%i for i in range(10)]+['b%d'%i for i in range(8)]
             +['c%d'%i for i in range(4)]+['lam'])
    polynomial = PolynomialRing(k, names=names, order='degrevlex')
    parameters = list(polynomial.gens())
    g = make_minor(polynomial, parameters[:10]+[1], parameters[10:18],
                   parameters[18:22]+[1], parameters[22])

    PR = PolynomialRing(GF(5), 'T', implementation='FLINT')
    P = PR(census['P'])
    assert P.degree() == 19290
    algebra = PolynomialQuotientRing_generic(PR,P,('alpha',))
    coefficient_a = algebra(PR(census['coordinates']['zeta']))
    assert coefficient_a**2+4*coefficient_a+2 == 0
    def embed(c):
        return algebra(int(k(c)[0]))+int(k(c)[1])*coefficient_a
    values = [algebra(PR(census['coordinates']['a%d'%i])) for i in range(10)]
    values += [algebra(PR(c)) for c in census['B']]
    values += [algebra(PR(census['coordinates']['c%d'%i])) for i in range(4)]
    values += [algebra(PR(census['lambda']))]
    monomial_cache = {}
    def specialize(f):
        result = algebra.zero()
        for powers,c in f.dict().items():
            powers = tuple(powers)
            if powers not in monomial_cache:
                value = algebra.one()
                for i,power in enumerate(powers):
                    if power:
                        value *= values[i]**power
                monomial_cache[powers] = value
            result += embed(c)*monomial_cache[powers]
        return result
    specialized = matrix(algebra, [[specialize(c) for c in row] for row in g.rows()])
    h, h_specialized, factor = constant_elimination(g,specialized,embed)
    d = PR((embed(factor)*determinant(h_specialized)).lift())
    assert d == PR(certificate['determinant_mod_census'])
    inverse = PR(certificate['determinant_inverse_mod_census'])
    multiplier = PR(certificate['determinant_modulus_multiplier'])
    assert d*inverse+P*multiplier == 1
    print('PASS: universal26 constant pivots; six-by-six residual of degree<=9;')
    print('both exact determinants match; retained Bezout identity is1 on the full census.')
    if output:
        gcd, inverse, multiplier = d.xgcd(P)
        assert gcd == 1 and d*inverse+P*multiplier == 1
        fresh = dict(certificate)
        for key, value in [('determinant_mod_census',d),
                           ('determinant_inverse_mod_census',inverse),
                           ('determinant_modulus_multiplier',multiplier)]:
            fresh[key] = [int(c) for c in value.list()]
        fresh['generator_source_sha256'] = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
        fresh.pop('seconds',None)
        fresh.pop('source_minor_sha256',None)
        output.write_text(json.dumps(fresh,indent=2)+'\n')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--census',type=Path,
        default=ROOT/'../litt3-computation-data/legacy_workspace_computations/normalized_oper_algebra_certificate.json')
    parser.add_argument('--certificate',type=Path,
        default=ROOT/'../litt3-computation-data/legacy_workspace_computations/uniform_q_frame_certificate.json')
    parser.add_argument('--output',type=Path)
    args = parser.parse_args()
    verify(args.census,args.certificate,args.output)
