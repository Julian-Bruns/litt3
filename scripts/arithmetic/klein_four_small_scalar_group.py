#!/usr/bin/env python3
"""Exact balanced moment minimum for epsilon in F25* mu29.

Normalize the first endpoint phase to1. All29 remaining endpoint phases
and all24*29 scalars are retained. Norm-one boundary compatibility is
tested before division. No actual parameter curve is constructed.
"""
import argparse
import json
from pathlib import Path
import klein_four_reciprocal_f25 as F


def main(path):
    zp = [F.power(F.ZETA, i) for i in range(29)]
    emb = [F.add(F.scale(F.ONE, i % 5), F.scale(F.BETA, i // 5)) for i in range(25)]

    def template(start, val):
        mom = [F.ZERO]*29
        j, z = start, emb[val]
        for _ in range(14):
            mom[j] = z
            j, z = 5*j % 29, F.power(z, 5)
        out = []
        for i in range(29):
            w = F.ZERO
            for j, z in enumerate(mom):
                w = F.add(w, F.mul(z, zp[-i*j % 29]))
            w = F.scale(w, 4)
            assert w[1:] == (0,)*13
            out.append(w[0])
        return out

    templates = {(start, val): template(start, val) for start in [2, 6] for val in [1, 5]}

    def poly(terms):
        r = F.ZERO
        for a, j in terms:
            r = F.add(r, F.mul(emb[a], zp[j % 29]))
        return r

    def combine(terms, start):
        out = [0]*29
        inv = pow(start, -1, 29)
        for a, j in terms:
            shift = j*inv % 29
            for i in range(29):
                out[i] += a % 5*templates[start, 1][(i-shift) % 29] + a//5*templates[start, 5][(i-shift) % 29]
        return [v % 5 for v in out]

    norms = [F.m25(e, F.bar25(e)) for e in range(25)]
    cases, boundary, minima = [], [], []
    minimum = 1000
    for phase in range(29):
        for scalar_phase in range(29):
            for e in range(1, 25):
                n = norms[e]
                # (1-N(epsilon))*bar(y) = kappa*phi^5
                #       +epsilon*phi^-8-epsilon-N(epsilon)*bar(kappa).
                ybar_terms = [(17, 5*phase), (e, scalar_phase-8*phase),
                              (F.s25(0, e), scalar_phase), (F.s25(0, F.m25(n, F.bar25(17))), 0)]
                if n == 1:
                    residual = poly(ybar_terms)
                    if residual == F.ZERO:
                        boundary.append([phase, scalar_phase, e])
                    continue
                inv = pow((1-n) % 5, -1, 5)
                y_terms = [(F.m25(inv, F.bar25(a)), -j) for a, j in ybar_terms]
                # Directly expanded x=(phi^8+epsilon*bar(kappa)*phi^-5
                #                          -epsilon*kappa-N(epsilon))/(1-N).
                x_terms = [(inv, 8*phase), (F.m25(inv, F.m25(e, F.bar25(17))), scalar_phase-5*phase),
                           (F.s25(0, F.m25(inv, F.m25(e, 17))), scalar_phase), (F.s25(0, F.m25(inv, n)), 0)]
                wx, wy = combine(x_terms, 2), combine(y_terms, 6)
                w0 = [(x+y) % 5 for x, y in zip(wx, wy)]
                masses = []
                for mr in range(5):
                    weights = [(v+4*mr) % 5 for v in w0]
                    mass = sum(weights)
                    assert mass % 5 == mr
                    masses.append(mass)
                    if mass <= minimum:
                        if mass < minimum:
                            minimum, minima = mass, []
                        minima.append({'phase': phase, 'scalar_phase': scalar_phase, 'epsilon_base': e,
                                       'mass_mod5': mr, 'weights': weights})
                cases.append([phase, scalar_phase, e, *masses])
    result = {'scope': 'Balanced endpoints, arbitrary relative phase, epsilon in F25*mu29; necessary moments only',
              'norm_one_boundaries': boundary, 'norm_one_cases_checked': 6*29*29,
              'non_norm_one_cases': cases, 'case_count': len(cases),
              'minimum_residue_mass_off_norm_one': minimum, 'attaining_cases': minima,
              'fourier_templates': {str(k):v for k,v in templates.items()},
              'node_modulus_F5': F.MOD, 'beta_embedding': F.BETA,
              'actual_curves_constructed': 0}
    assert len(cases) == 18*29*29
    path.write_text(json.dumps(result,separators=(',', ':'))+'\n')
    print('Complete scalar/phase cases:', 24*29*29, 'norm-one compatible:', len(boundary))
    print('Off norm-one minimum mass:', minimum, 'attaining cases:', len(minima))


if __name__ == '__main__':
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output', type=Path, required=True)
    main(ap.parse_args().output)
