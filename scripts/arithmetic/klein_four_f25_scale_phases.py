#!/usr/bin/env python3
"""All relative balanced phases with normalized epsilon in F25*.

Uses the exact scalar parametrization, including every norm-one boundary.
Fourier reconstruction is a precomputed F5-linear map, not a point search
for a curve. See the accompanying independent coefficient-field replay.
"""
import argparse
import json
from pathlib import Path
import klein_four_reciprocal_f25 as F


def main(path):
    zp = [F.power(F.ZETA, i) for i in range(29)]
    emb = [F.add(F.scale(F.ONE, i % 5), F.scale(F.BETA, i // 5)) for i in range(25)]

    def decode(x, y):
        mom = [None] * 29
        mom[0] = F.ZERO
        for j0, z0 in [(2, x), (6, y)]:
            j, z = j0, z0
            for _ in range(14):
                assert mom[j] is None
                mom[j] = z
                j, z = 5*j % 29, F.power(z, 5)
            assert j == j0 and z == z0
        out = []
        for i in range(29):
            w = F.ZERO
            for j, z in enumerate(mom):
                w = F.add(w, F.mul(z, zp[-i*j % 29]))
            w = F.scale(w, 4)
            assert w[1:] == (0,)*13
            out.append(w[0])
        return out

    columns = []
    for i in range(28):
        z = tuple(int(j == i % 14) for j in range(14))
        columns.append(decode(z if i < 14 else F.ZERO, F.ZERO if i < 14 else z))

    rows, norm_one = [], []
    for phase in range(29):
        p5, p8, pm8 = [zp[j*phase % 29] for j in (5, 8, -8)]
        for e in range(1, 25):
            norm = F.m25(e, F.bar25(e))
            rhs = F.add(F.mul(emb[17], p5), F.scale(emb[F.bar25(17)], -norm))
            rhs = F.add(rhs, F.scale(F.mul(emb[e], F.add(F.ONE, F.scale(pm8, 4))), 4))
            if norm == 1:
                assert rhs != F.ZERO
                norm_one.append({'phase': phase, 'epsilon': e, 'nonzero_residual': rhs})
                continue
            ybar = F.scale(rhs, pow((1-norm) % 5, -1, 5))
            y = F.power(ybar, 5**7)
            x = F.add(p8, F.mul(emb[e], F.add(y, F.scale(emb[17], 4))))
            xb = F.power(x, 5**7)
            assert F.mul(emb[e], F.add(F.ONE, F.scale(xb, 4))) == F.add(F.mul(emb[17], p5), F.scale(ybar, 4))
            assert F.mul(emb[e], F.add(emb[17], F.scale(y, 4))) == F.add(p8, F.scale(x, 4))
            coeff = x+y
            w0 = [sum(a*c[i] for a, c in zip(coeff, columns)) % 5 for i in range(29)]
            for mass_mod5 in range(5):
                weights = [(w+4*mass_mod5) % 5 for w in w0]
                mass, ones = sum(weights), weights.count(1)
                assert mass % 5 == mass_mod5
                rows.append({'phase': phase, 'epsilon': e, 'M2': x, 'M6': y,
                             'mass_mod5': mass_mod5, 'weights': weights,
                             'residue_mass': mass, 'residue_one_nodes': ones})
    assert len(norm_one) == 174 and len(rows) == 2610
    minimum = min(r['residue_mass'] for r in rows)
    result = {'scope': 'All balanced relative phases; normalized epsilon in F25*, necessary moments only',
              'field_modulus': F.MOD, 'beta_embedding': F.BETA,
              'norm_one_exclusions': norm_one, 'fourier_columns': columns,
              'rows': rows, 'minimum_residue_mass': minimum,
              'attaining_rows': [r for r in rows if r['residue_mass'] == minimum],
              'actual_curves_constructed': 0}
    path.write_text(json.dumps(result, separators=(',', ':'))+'\n')
    print('PASS: all174 norm-one boundaries,522 unique moment pairs and2610 residue vectors.')
    print('Minimum mass:', minimum, 'minimizers:', len(result['attaining_rows']))


if __name__ == '__main__':
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output', type=Path, required=True)
    main(ap.parse_args().output)
