#!/usr/bin/env python3
"""Check the repeated-pair-independent necessary rank condition exactly.

This is a rank reduction, not a shared-moment incidence decision.
"""
import argparse
import json
import random
import sys
from itertools import combinations_with_replacement
from pathlib import Path

sys.path.insert(0, '/Users/julian/Documents/litt3-computation-data/october01_audited_replies/mixed_span_incidence/src')
from field import K, BINV, ba, bm, bn, ksum, mat_inv, mat_vec, transpose
from incidence import PHASES, endpoint, f5rank, phase_polynomials, rank_graph

PAIR_LOOKUP = {K.add(PHASES[5*j % 29], PHASES[5*k % 29]): (j, k)
               for j, k in combinations_with_replacement(range(29), 2)}
assert len(PAIR_LOOKUP) == 435


def recover_repeated_pair(B, R, S):
    """Return the only possible opposite repeated pair, or a rejection stage.

    B must have the actual target character identities, including Z2=gamma2*rho(D2).
    Final source support, rank, scalar graph and SAME-moment checks remain.
    """
    if R == S:
        return None, 'equal-unrepeated-pairs'
    fixed = endpoint((R, R, R, S))
    C, E, U, V = (fixed[n] for n in ('C', 'E1', 'U', 'V'))
    D, G, W, Z = (B[n] for n in ('C', 'E1', 'U', 'V'))
    if D[3] == K.zero:
        return None, 'target-third-support'
    a = K.div(U[3], C[3])
    r = K.sub(U[1], K.mul(a, C[1]))
    assert r != K.zero
    q = K.div(W[3], D[3])
    s = K.div(K.add(Z[1], K.mul(q, E[1])), r)
    if s == K.zero:
        return None, 'zero-null-parameter'
    if K.sub(W[1], K.mul(q, D[1])) != K.mul(s, K.add(V[1], K.mul(a, G[1]))):
        return None, 'unrepeated-pair-condition'
    v2 = K.sub(K.div(K.sub(W[2], K.mul(q, D[2])), s), K.mul(a, G[2]))
    c2 = K.pow(K.scale(v2, BINV[7]), 5**6)
    cR = K.add(PHASES[5*R[0] % 29], PHASES[5*R[1] % 29])
    cS = K.add(PHASES[5*S[0] % 29], PHASES[5*S[1] % 29])
    cP = K.scale(ksum((K.scale(c2, BINV[9]), cR, cS)), 3)
    pair = PAIR_LOOKUP.get(cP)
    return pair, 'unique-pair' if pair is not None else 'not-genuine-pair'


def reduction(A, B):
    C, E, U, V = (A[n] for n in ('C', 'E1', 'U', 'V'))
    D, G, W, Z = (B[n] for n in ('C', 'E1', 'U', 'V'))
    a = K.div(U[3], C[3])
    r = K.sub(U[1], K.mul(a, C[1]))
    q = K.div(W[3], D[3])
    s = K.div(K.add(Z[1], K.mul(q, E[1])), r)
    necessary = K.sub(K.mul(r, K.sub(W[1], K.mul(q, D[1]))),
                      K.mul(K.add(Z[1], K.mul(q, E[1])),
                            K.add(V[1], K.mul(a, G[1]))))
    n0 = K.sub(K.mul(C[2], U[3]), K.mul(C[3], U[2]))
    n1 = K.sub(K.mul(C[3], U[1]), K.mul(C[1], U[3]))
    det = K.add(K.mul(E[1], n0), K.mul(E[2], n1))
    N0 = K.add(K.mul(n0, Z[1]), K.mul(n1, Z[2]))
    common = K.sub(K.mul(E[1], Z[2]), K.mul(E[2], Z[1]))
    N1 = K.mul(U[3], common)
    N2 = K.neg(K.mul(C[3], common))
    sr, rr, kr = [], [], []
    residuals = []
    for l in (1, 2, 3):
        inner = K.add(K.mul(U[3], G[l]), K.mul(C[3], V[l]))
        sr.append(K.add(K.mul(D[l], Z[1]), K.mul(W[l], E[1])))
        rr.append(K.sub(K.mul(W[l], n1), K.mul(Z[1], inner)))
        kr.append(K.mul(Z[2], K.add(K.mul(D[l], n1), K.mul(E[1], inner))))
        residuals.append(ksum((K.mul(D[l], N0), K.mul(G[l], N1),
                               K.neg(K.mul(V[l], N2)), K.mul(W[l], det))))
        assert residuals[-1] == ksum((K.mul(sr[-1], n0), K.mul(rr[-1], E[2]), kr[-1]))
    delta = K.sub(K.mul(sr[0], rr[2]), K.mul(sr[2], rr[0]))
    assert delta == K.neg(K.mul(K.mul(K.mul(Z[1], D[3]), C[3]), necessary))
    inverse = mat_inv(transpose((E[1:], C[1:], U[1:])))
    h = mat_vec(inverse, Z[1:])
    assert (N0, N1, N2) == tuple(K.mul(det, value) for value in h)
    return dict(a=a, r=r, q=q, s=s, necessary=necessary, delta=delta,
                det=det, n0=n0, n1=n1, residuals=residuals, matrix=(sr, rr, kr))


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    rng = random.Random(105)
    count = 0
    for _ in range(12):
        six = rng.sample(range(29), 6)
        P, R, S = [tuple(sorted(six[2*i:2*i+2])) for i in range(3)]
        ep = (P, R, P, S)
        A = endpoint(ep)
        assert f5rank(phase_polynomials(ep)) == 2
        assert A['C'][3] == K.neg(K.scale(K.div(A['C'][1], K.elt(3)), 2))
        g1 = K.div(A['U'][1], K.elt(24))
        a = K.div(A['U'][3], A['C'][3])
        r = K.sub(A['U'][1], K.mul(a, A['C'][1]))
        assert r == K.scale(g1, 5) and r != K.zero
        for _ in range(2):
            target = [tuple(sorted(rng.sample(range(29), 2))) for i in range(4)]
            B = endpoint(target)
            if B['C'][3] == K.zero:
                continue
            out = reduction(A, B)
            count += 1
            # Whenever the 2x2 matrix is invertible, its only solution has
            # degenerate source determinant. This branch cannot be retained.
            if out['delta'] != K.zero:
                sr, rr, kr = out['matrix']
                values = mat_vec(mat_inv(((sr[0], rr[0]), (sr[2], rr[2]))),
                                 (K.neg(kr[0]), K.neg(kr[2])))
                assert K.add(K.mul(A['E1'][1], values[0]), K.mul(values[1], out['n1'])) == K.zero
        # Build an arbitrary actual-rank-three row tuple from its null vector.
        # These are synthetic graph points, not genuine endpoint witnesses.
        q, s, d3 = [K.decode(rng.randrange(1, 5**14)) for i in range(3)]
        G = [K.zero] + [K.decode(rng.randrange(1, 5**14)) for i in range(2)] + [K.zero]
        Z = [K.zero] + [K.sub(K.mul(s, K.sub(A['U'][l], K.mul(a, A['C'][l]))),
                              K.mul(q, A['E1'][l])) for l in (1, 2)] + [K.zero]
        D = [K.zero] + [K.pow(K.scale(Z[l], BINV[c]), 5**6)
                       for l, c in ((1, 17), (2, 7))] + [d3]
        W = [K.zero] + [K.add(K.mul(q, D[l]),
                              K.mul(s, K.add(A['V'][l], K.mul(a, G[l])))) for l in (1, 2)] + [K.mul(q, d3)]
        B = dict(C=tuple(D), E1=tuple(G), U=tuple(W), V=tuple(Z))
        assert rank_graph(A, B)[0]
        out = reduction(A, B)
        assert out['necessary'] == out['delta'] == K.zero
        assert out['residuals'] == [K.zero]*3
        assert out['s'] == s
        assert recover_repeated_pair(B, R, S) == (P, 'unique-pair')
    # The constant in r=(u1-u3*c1/c3) Q1(xi^17) is beta, code 5.
    assert ba(24, bn(bm(11, bm(3, BINV[2])))) == 5
    meta = dict(genuine_source_samples=12, genuine_target_residual_checks=count,
                synthetic_rank_three_checks=12,
                synthetic_positive_recovery_checks=12,
                r_constant_code=5,
                scope='necessary opposite-repeat source rank condition independent of repeated pair; no global exclusion')
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(meta, indent=2)+'\n')
    print(json.dumps(meta))


if __name__ == '__main__':
    main()
