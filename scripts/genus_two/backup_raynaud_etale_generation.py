#!/usr/bin/env python3
"""Probe actual tame-character generation of the backup Raynaud bundle.

Uses the already proved four-square Cartier/cancellation presentation.
All matrices use scalar F125 elimination. Outputs belong outside litt3.
This is a one-endpoint experiment, not a common-cover test.
"""
from pathlib import Path
import sys, json, argparse
sys.path.insert(0, str(Path(__file__).resolve().parent / 'theta_exception'))
from geometry import (POINTS, BRANCHES, f, f0, jac_add, mumford_from_pts,
                      power, mul, add, sub, neg, inv, pmul, pmod, peval,
                      padd, pscale, trim, pxgcd, psub, pexact)
sys.path.insert(0, str(Path(__file__).resolve().parent / 'theta_intersection'))
from core import null, det, dot


ZERO = ([1], [])


def key(D):
    return tuple(D[0]), tuple(D[1])


def multiple(D, n):
    ans = ZERO
    while n:
        if n & 1:
            ans = jac_add(ans, D)
        D = jac_add(D, D)
        n >>= 1
    return ans


def tame_group():
    # The established group order is 14800=25*16*37. All two-torsion
    # is rational, so its prime-to-five part has exactly 16*37 points.
    two = {key(ZERO): ZERO}
    for a in BRANCHES:
        D = mumford_from_pts((a, 0))
        for E in list(two.values()):
            R = jac_add(D, E)
            two[key(R)] = R
    assert len(two) == 16
    generator = None
    for P in POINTS:
        R = multiple(mumford_from_pts(P), 400)
        if key(R) != key(ZERO):
            assert key(multiple(R, 37)) == key(ZERO)
            generator = R
            break
    assert generator is not None
    group = {}
    R = ZERO
    for j in range(37):
        for T in two.values():
            D = jac_add(R, T)
            group[key(D)] = D
        R = jac_add(R, generator)
    assert len(group) == 592 and key(R) == key(ZERO)
    return list(group.values())


F2 = pmul(f0, f0)
C = [[F2[j-i] if 0 <= j-i < len(F2) else 0 for i in range(7)]
     for j in (4, 9, 14)]
S = null(C)
assert len(S) == 4
RESIDUES = [[trim(pmul(A, F2)[r::5]) for r in range(4)] for A in S]


def section(D):
    U, V = D
    if len(U) != 3 or len(pxgcd(U, f)[0]) != 1:
        return None
    # Work on the certified open Mumford chart.
    V = V + [0] * (2-len(V))
    q0, q1 = V
    if not q0 and not q1:
        return None
    basis_remainders = [[pmod(h, U) + [0, 0] for h in rs]
                        for rs in RESIDUES]
    A = [[sub(mul(q1, basis_remainders[j][r][0]),
                  mul(q0, basis_remainders[j][r][1]))
          for j in range(4)] for r in range(4)]
    ker = null(A)
    if not ker:
        return None
    if len(ker) != 1:
        raise RuntimeError(('higher-dimensional actual section space', D, ker))
    c = ker[0]
    poly = [dot(c, [S[j][i] for j in range(4)]) for i in range(7)]
    product = pmul(poly, F2)
    assert not any(product[r] for r in range(4, len(product), 5))
    rs = [trim(product[r::5]) for r in range(4)]
    bs = []
    for h in rs:
        rem = pmod(h, U) + [0, 0]
        b = mul(rem[0], inv(q0)) if q0 else mul(rem[1], inv(q1))
        assert rem[0] == mul(q0, b) and rem[1] == mul(q1, b)
        bs.append(b)
    # Full original cancellation, not just determinant vanishing.
    BP = trim(bs)
    Vpower = [0] * 6
    Vpower[0], Vpower[5] = V
    U5 = [0] * 11
    for i, v in enumerate(U):
        U5[5*i] = v
    assert not pmod(padd(product, pscale(pmul(Vpower, BP), 4)), U5)
    return dict(U=U, V=V, A=trim(poly), B=BP, residues=rs)


def eval_column(s, P):
    x, y = P
    if not y or not peval(s['U'], x):
        return None
    bs = s['B'] + [0] * 4
    denominator = inv(mul(y, peval(s['U'], x)))
    return [mul(add(peval(h, x), mul(y, bs[r])), denominator)
            for r, h in enumerate(s['residues'])]


def pairmul(a, b):
    return (padd(pmul(a[0], b[0]), pmul(f, pmul(a[1], b[1]))),
            padd(pmul(a[0], b[1]), pmul(a[1], b[0])))


def minor_numerator(sections, inds):
    from itertools import permutations
    total = ([], [])
    for perm in permutations(range(4)):
        term = ([1], [])
        for row, col in enumerate(perm):
            s = sections[inds[col]]
            bs = s['B'] + [0] * 4
            term = pairmul(term, (s['residues'][row], [bs[row]]))
        sign = 4 if sum(perm[i] > perm[j] for i in range(4)
                        for j in range(i+1, 4)) % 2 else 1
        total = tuple(padd(a, pscale(b, sign)) for a, b in zip(total, term))
    # The rational exact-form frame has determinant divisor 2R-6O.
    # Each determinant numerator is divisible by f, removing its
    # compulsory order-two zero at the five finite branch points.
    return tuple(pexact(a, f) if a else [] for a in total)


def global_generation(sections):
    from itertools import combinations
    all_minors = [(inds, minor_numerator(sections, inds))
                  for inds in combinations(range(len(sections)), 4)]
    all_u = [1]
    for s in sections:
        all_u = pmul(all_u, s['U'])
    for inds, (a, b) in all_minors:
        if not a and not b:
            continue
        norm = psub(pmul(a, a), pmul(f, pmul(b, b)))
        divisor_u = [1]
        for i in inds:
            divisor_u = pmul(divisor_u, sections[i]['U'])
        residual = pexact(norm, divisor_u)
        if len(residual) != 5:
            continue
        residual = pscale(residual, inv(residual[-1]))
        if len(pxgcd(residual, pmul(f, all_u))[0]) != 1:
            continue
        derivative = [mul(i % 5, residual[i]) for i in range(1, len(residual))]
        if len(pxgcd(residual, derivative)[0]) != 1:
            continue
        gcd, binv, _ = pxgcd(b, residual)
        if gcd != [1]:
            continue
        yvalue = pmod(pscale(pmul(a, binv), 4), residual)
        assert not pmod(psub(pmul(yvalue, yvalue), f), residual)
        # All possible zeros of this determinant are now the four
        # reduced points (residual(x)=0, y=yvalue(x)). They avoid
        # every chosen twist divisor, the branch locus and infinity.
        for other, (c, d) in all_minors:
            test = pmod(padd(c, pmul(d, yvalue)), residual)
            gcd, s, t = pxgcd(residual, test)
            if gcd == [1]:
                assert padd(pmul(s, residual), pmul(t, test)) == [1]
                return dict(first_indices=inds, first_numerator=[a,b],
                            residual_quartic=residual, residual_y=yvalue,
                            second_indices=other, second_numerator=[c,d],
                            second_restriction=test, bezout=[s,t],
                            status='two determinant zero divisors disjoint')
    return None


def generator_subgroup(sections, witness):
    indices = sorted(set(witness['first_indices']) | set(witness['second_indices']))
    subgroup = {key(ZERO): ZERO}
    for i in indices:
        D = sections[i]['U'], sections[i]['V']
        assert key(multiple(D, 74)) == key(ZERO)
        assert key(multiple(D, 37)) != key(ZERO)
        assert key(multiple(D, 2)) != key(ZERO)
        old = list(subgroup.values())
        R = ZERO
        for j in range(74):
            for E in old:
                A = jac_add(R, E)
                subgroup[key(A)] = A
            R = jac_add(R, D)
        assert key(R) == key(ZERO)
    assert len(indices) == 5 and len(subgroup) == 296
    return dict(section_indices=indices, individual_orders=[74]*5,
                generated_subgroup_order=len(subgroup),
                trivializing_connected_abelian_cover_degree=len(subgroup))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('output', type=Path)
    args = parser.parse_args()
    group = tame_group()
    sections = []
    for D in group:
        s = section(D)
        if s:
            sections.append(s)
    print('tame characters', len(group), 'open-chart Raynaud sections', len(sections), flush=True)
    # One nonzero minor suffices only for generic rank. It does not prove
    # absence of a defect at all geometric points.
    from itertools import combinations
    witness = None
    max_rank = 0
    from core import rref
    for P in POINTS:
        columns = [(i, eval_column(s, P)) for i, s in enumerate(sections)]
        columns = [(i, c) for i, c in columns if c is not None]
        if not columns:
            continue
        matrix = [[c[r] for i, c in columns] for r in range(4)]
        _, piv = rref(matrix)
        max_rank = max(max_rank, len(piv))
        if len(piv) == 4:
            inds = [columns[j][0] for j in piv]
            square = [[columns[j][1][r] for j in piv] for r in range(4)]
            witness = dict(point=P, section_indices=inds, determinant=det(square))
            assert witness['determinant']
            break
    global_witness = global_generation(sections)
    assert global_witness is not None
    subgroup = generator_subgroup(sections, global_witness)
    out = dict(scope='one-endpoint tame-character generation only',
               field='F125, alpha^3+alpha+1', tame_characters=592,
               sections=sections, generic_rank_witness=witness,
               maximum_tested_rank=max_rank,
               global_generation_witness=global_witness,
               generating_characters=subgroup)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(out, indent=2)+'\n')
    print('maximum tested rank', max_rank, 'witness', witness, flush=True)
    print('global generation:', global_witness, flush=True)
    print('generating characters:', subgroup, flush=True)


if __name__ == '__main__':
    main()
