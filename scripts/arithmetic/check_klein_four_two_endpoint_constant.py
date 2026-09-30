#!/usr/bin/env python3
"""Direct polynomial reconstruction of the two-endpoint constant-word test."""
import argparse
import json
import random
import re
from pathlib import Path
import check_klein_four_constant_pencils as P
T, Z, O = P.T, P.Z, P.O


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('root', type=Path)
    args = ap.parse_args()
    zs = [P.power((0, 1, 0, 0, 0, 0, 0), i) for i in range(29)]
    log = (args.root/'two_endpoint_constant.log').read_text()
    targets = json.loads((args.root/'linear_pencil_targets.json').read_text())['targets']
    targets = [[tuple(v) for v in row] for row in targets]

    def data(mask):
        c = [O]
        jp = [O]
        for i in range(29):
            if mask>>i&1:
                jp = P.pm(jp, [T.neg(zs[i]), O])
            else:
                c = P.pm(c, [T.neg(zs[i]), O])
        assert len(c) == 15 and len(jp) == 16
        quotient, _ = P.divide([Z]*22+[O], c)
        alpha = T.mul(c[1], T.inv(c[0]))
        gamma = c[13]
        prod = T.inv(c[0])
        e7, e8 = T.neg(jp[8]), jp[7]
        assert quotient[0] == e8 and quotient[1] == T.neg(e7)
        return c, quotient, alpha, gamma, prod, e7, e8

    rng = random.Random(26092629)
    for _ in range(64):
        mask = sum(1<<i for i in rng.sample(range(29), 15))
        c, q, alpha, gamma, prod, e7, e8 = data(mask)
        r, s = zs[rng.randrange(29)], P.scale(zs[rng.randrange(29)], 22)
        a = T.sub(T.mul(r, prod), P.scale(q[0], 2))
        b = T.sub(T.mul(T.sub(s, T.mul(alpha, r)), prod), P.scale(q[1], 2))
        inner = [P.scale(v, 2) for v in q]
        inner[0] = T.add(inner[0], a)
        inner[1] = T.add(inner[1], b)
        word = P.pm(c, inner)
        assert word[0] == r and word[1] == s
        assert word[22] == P.scale(O, 2) and all(v == Z for v in word[16:22])
        ri = T.add(T.mul(prod, T.sub(s, T.mul(alpha, r))), P.scale(e7, 2))
        si = T.add(T.sub(T.mul(prod, r), P.scale(e8, 2)), T.mul(gamma, ri))
        assert (ri, si) == (word[15], word[14])

    def rational(index):
        fr, phase = divmod(index, 29)
        r = P.scale(zs[-phase % 29], P.F.f.powf(22, 5**fr))
        s = P.scale(zs[3*phase % 29], P.F.f.powf(8, 5**fr))
        return r, s

    rationals = re.findall(r'^RATIONAL J_mask=(\d+) first=(\d+) second=(\d+) same_coefficient_conjugate=(\d+)$', log, re.M)
    assert len(rationals) == 3
    for mask, i, j, consistent in rationals:
        mask, i, j = int(mask), int(i), int(j)
        c, q, alpha, gamma, prod, e7, e8 = data(mask)
        r, s = rational(i)
        ri = T.add(T.mul(prod, T.sub(s, T.mul(alpha, r))), P.scale(e7, 2))
        si = T.add(T.sub(T.mul(prod, r), P.scale(e8, 2)), T.mul(gamma, ri))
        assert (ri, si) == rational(j)
        assert i//29 != j//29 and consistent == '0'

    jets = re.findall(r'^AFFINE_JETS J_mask=(\d+) first=(\d+) second=(\d+)$', log, re.M)
    assert len(jets) == 3
    for mask, i, j in jets:
        mask, i, j = int(mask), int(i), int(j)
        c, q, alpha, gamma, prod, e7, e8 = data(mask)
        lam, nu, tr, con = targets[i]
        lp, np, tp, cp = targets[j]
        k = T.mul(prod, T.sub(lam, alpha))
        l = T.add(T.mul(prod, nu), P.scale(e7, 2))
        assert T.mul(T.sub(lp, gamma), T.sub(lam, alpha)) == O
        assert np == T.sub(T.mul(T.sub(gamma, lp), l), P.scale(e8, 2))
        assert tp != T.add(T.mul(k, tr), P.scale(l, 2))

    zeros = re.findall(r'^ZERO_SLOPE J_mask=(\d+) first=(\d+)$', log, re.M)
    assert len(zeros) == 2
    for mask, i in zeros:
        c, q, alpha, gamma, prod, e7, e8 = data(int(mask))
        lam, nu, tr, con = targets[int(i)]
        assert lam == alpha
        assert T.add(T.mul(prod, nu), P.scale(e7, 2)) != Z

    assert ('normalized_subsets=40116600 representatives=191280 covered=40116600' in log
            and 'slope_pairs=8859 jet_pairs=3 trace_pairs=0 full_pairs=0 rational_pairs=3 rational_consistent=0 zero_potential=2 zero_matches=0' in log)
    planes = (args.root/'two_endpoint_all.log').read_text()
    assert 'tested=2560845' in planes and 'affine_nonrational=1116 affine_checked=1116' in planes
    assert 'ambiguous_planes=0 different_direction_rows=0' in planes
    out = {'status': 'PASS', 'scope': '64 direct polynomial reconstructions and all retained endpoint candidates; exhaustive coverage is in the C++ logs.',
           'direct_polynomial_checks': 64,
           'rational_pairs_excluded_by_different_coefficient_conjugates': rationals,
           'affine_pairs_excluded_by_trace': jets, 'zero_endpoint_candidates_excluded': zeros,
           'symmetry': 'Parameter rotation t->a*t transforms the first jet by (a^22,a^21) and the opposite jet by (a^7,a^8). Coefficient Frobenius acts on both jets together.'}
    (args.root/'two_endpoint_constant_independent.json').write_text(json.dumps(out, indent=2)+'\n')
    print('PASS:64 direct polynomial checks,3 incompatible rational conjugates,3 quadratic-trace exclusions,2 zero-endpoint exclusions.')


if __name__ == '__main__':
    main()
