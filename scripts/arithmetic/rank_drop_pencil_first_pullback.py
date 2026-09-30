#!/usr/bin/env python3
"""Check first-Frobenius negative line maps on the entire new pencil.

The independent arithmetic module is retained source, not tensor arithmetic.
This checks two exact identities; fifth-power semilinearity then proves the
all-geometric-parameter assertion. It is not a finite-field point search.
"""
from pathlib import Path
import argparse
import importlib.util
import json


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--archive', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    source = Path(__file__).parent / 'pro_rational_rankdrop_20260924/rankdrop/src/verify_independent.py'
    spec = importlib.util.spec_from_file_location('rankdrop_exact_arithmetic', source)
    ar = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(ar)
    data = json.loads((args.archive / 'certificates/linear_fiber.json').read_text())
    bases = json.loads((args.archive / 'data/bases.json').read_text())
    e = {(-m, 2): c for m, c in enumerate(ar.C_ROW, 1)}
    results = []
    for z, aux in zip(data['z_basis'], data['auxiliary_basis']):
        assert not any(z[:13])
        gdim = len(bases['g0'])
        assert not any(aux[:gdim])
        q0 = {tuple(m): c for m, c in zip(bases['q0'], aux[gdim:]) if c}
        assert all(j == 0 and i % 5 == 0 for i, j in q0)
        H = {(i // 5, 0): ar.powc(c, 5) for (i, _), c in q0.items()}
        assert ar.power(H, 5) == q0
        v = {}
        for c, (kind, i, j) in zip(z, bases['extensions']):
            if c:
                assert kind == 'v'
                v = ar.plusadd(v, ar.term(i, j, c))
        rhs = ar.plusadd(ar.times(ar.power(e, 5), H), ar.power(v, 5))
        finite = ar.negative(ar.positive(rhs))
        infinity = ar.minus(rhs)
        assert ar.upper_bound(H, 24)
        assert ar.upper_bound(infinity, -31)
        assert ar.plusadd(infinity, ar.negative(rhs)) == finite
        # The row (1,H,finite) / (1,H,infinity) defines F*R -> O(-O).
        # For xi=s*xi1+t*xi2, combine H and the last entries with s^5,t^5.
        results.append({'xi':z,'H':[[i,j,c] for (i,j),c in sorted(H.items())],
                        'finite_last':[[i,j,c] for (i,j),c in sorted(finite.items())],
                        'infinity_last':[[i,j,c] for (i,j),c in sorted(infinity.items())],
                        'infinity_weights':[0, ar.pole_weight(H), ar.pole_weight(infinity)],
                        'allowed_weights':[4,24,-31]})
    report = {'status':'PASS','scope':'Two exact first-Frobenius line maps; semilinearity gives every geometric pencil member. Image degree is negative even if an infinity zero occurs. Thus no pencil member has any strict positive Frobenius period, using supplied semistability of R_xi.',
              'point_search':False,'basis_maps':results}
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(report,indent=2)+'\n')
    print('PASS: both first-pullback maps, coefficient Frobenius and infinity bounds.')
    print('Every geometric pencil member has a negative-degree line quotient after one pullback.')


if __name__ == '__main__':
    main()
