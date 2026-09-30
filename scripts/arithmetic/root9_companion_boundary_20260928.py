#!/usr/bin/env python3
"""Exact full-scale exclusions on the unramified companion discriminant.

The input arithmetic/source circuit is the retained frobenius_ratio archive.
No finite-field parameter search is used: each q factor is a complete
coefficient field and the scale remains a polynomial indeterminate.
Certificates and output belong outside the research workspace.
"""
from pathlib import Path
import argparse
import json
import sys
import time


def main():
    p = argparse.ArgumentParser()
    p.add_argument('--archive-root', required=True)
    p.add_argument('--output', required=True)
    p.add_argument('--verify', action='store_true')
    args = p.parse_args()
    root = Path(args.archive_root).resolve()
    out = Path(args.output).resolve()
    out.mkdir(parents=True, exist_ok=True)
    sys.path.insert(0, str(root / 'src'))
    from ff import Poly
    from factor import factor_squarefree, irreducible
    import ext
    from ext import EP, Element as E
    from residual import RATIO, peval, Tails, residual
    from residual_jet import residual_jet

    b, c, e = [Poly(RATIO[k]) for k in ('b', 'c', 'e')]
    delta2 = c*c - 4*b*e
    C = c*c - 3*b*e
    gcd_ec, ge, gc = e.xgcd(c)
    assert gcd_ec == 1 and ge*e + gc*c == 1
    assert delta2.degree() == 14 and delta2.gcd(delta2.derivative()) == 1
    assert delta2.gcd(c*e*C) == 1
    assert b.gcd(b.derivative()) == 1 and b.gcd(c*e*C) == 1
    descriptions = [('delta2', delta2, (1,)), ('b_zero', b, (4, 3))]
    coverage = {'gcd_e_c': [ge.tolist(), gc.tolist()],
                'delta2': delta2.tolist(), 'b': b.tolist(), 'factors': {}}
    blocks = []
    for name, polynomial, ratios in descriptions:
        factors = factor_squarefree(polynomial)
        product = Poly(1)
        for f in factors:
            assert irreducible(f)
            product *= f
        assert product == polynomial.monic()
        coverage['factors'][name] = [f.tolist() for f in factors]
        for j, f in enumerate(factors):
            for ratio in ratios:
                start = time.time()
                q = ext.context(f)
                aa, dd, bb, cc, ee = [peval(RATIO[k], q)
                                     for k in ('a0', 'd', 'b', 'c', 'e')]
                u = ratio*ee/cc
                J = (cc*cc - 4*bb*ee)*u*u + 3*cc*ee*u + 2*ee*ee
                g = bb*u*u + 2*cc*u + 3*ee
                assert J == 0 and g.inverse()*g == 1
                V = aa*u**3 + bb*u*u + cc*u + ee
                original_units = [q, u, dd, q-10149, q-118020,
                                  q-64426, V]
                key = f'{name}_{j}_{ratio}'
                if any(not v for v in original_units):
                    blocks.append({'case': key, 'degree': f.degree(),
                                   'status': 'outside original open'})
                    print(json.dumps(blocks[-1]), flush=True)
                    continue
                for v in original_units:
                    assert v.inverse()*v == 1
                _, A = residual_jet(q, u, 74)
                ts = Tails(A, max_n=74)
                tails = [ts.tail(n) for n in range(71, 75)]
                dst = out / (key + '.json')
                if args.verify:
                    cert = json.loads(dst.read_text())
                    assert cert['modulus'] == f.tolist()
                    assert cert['u_formula_ratio'] == ratio
                    multipliers = [EP([E(row) for row in rows])
                                   for rows in cert['bezout_coefficients']]
                else:
                    gcd = tails[0]
                    multipliers = [EP(1)]
                    for tail in tails[1:]:
                        gcd, s, t = gcd.xgcd(tail)
                        multipliers = [s*w for w in multipliers] + [t]
                        if gcd == 1:
                            break
                    assert gcd == 1, (key, 'requires additional equations',
                                      gcd.serialize())
                    cert = {'case': key, 'modulus': f.tolist(),
                            'u_formula_ratio': ratio,
                            'u_formula': 'ratio*e(q)/c(q)',
                            'tail_indices': list(range(71, 71+len(multipliers))),
                            'tail_degrees': [t.degree() for t in tails[:len(multipliers)]],
                            'bezout_coefficients': [m.serialize() for m in multipliers],
                            'identity': 'sum multipliers[n]*C_n=1'}
                    dst.write_text(json.dumps(cert, separators=(',', ':'))+'\n')
                assert sum((m*t for m, t in zip(multipliers, tails)), EP()) == 1
                # A separate full residual path checks the jets in each
                # largest coefficient field, not only the optimized jets.
                if f.degree() == max(z.degree() for z in factors):
                    _, full = residual(q, u)
                    assert all(full[i] == A[i] for i in range(75))
                blocks.append({'case': key, 'degree': f.degree(),
                               'status': 'exact polynomial identity 1',
                               'tail_indices': cert['tail_indices'],
                               'seconds': round(time.time()-start, 3)})
                print(json.dumps(blocks[-1]), flush=True)
    summary = {'scope': 'companion J=0: entire delta2=0 and b=0 divisors',
               'geometric_ratio_count': sum(b['degree'] for b in blocks),
               'blocks': blocks, 'coverage': coverage,
               'mode': 'multiplication replay' if args.verify else 'generation',
               'other_q_values': 'not decided'}
    (out / ('verification.json' if args.verify else 'generation.json')).write_text(
        json.dumps(summary, indent=2)+'\n')
    print('COMPANION_BOUNDARIES_COMPLETE', summary['geometric_ratio_count'], flush=True)


if __name__ == '__main__':
    main()
