"""Global, exact certificate that the critical discriminant is never square.

This is NOT a search and is NOT a certificate for the degree-140 square locus.
It uses all H and q with q*(q-<118020>) nonzero, over the algebraic closure.
Fixed-degree Sylvester determinants retain all leading-coefficient drops.
"""
from __future__ import annotations
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'src'))
import field as F
import poly as U
import cube_free as CF
import evaluate as E
from laurent import LP


def reduce_curve(a: LP) -> LP:
    """Reduce products of already reduced elements using Y^3=P/q."""
    out: dict[tuple[int, ...], int] = {}
    for (h, q, x, y), c in a.d.items():
        if y < 3:
            CF.addterm(out, (h, q, x, y), c)
        else:
            if y >= 6:
                raise ValueError('Only products of two reduced elements are used.')
            for i, v in enumerate(E.P):
                if v:
                    CF.addterm(out, (h, q - 1, x + i, y - 3), F.mul(c, v))
    return LP(out)


def h_coefficients(a: LP, x_degree: int) -> list[list[int]]:
    """Ascending H rows, each an ascending q polynomial."""
    rows: list[list[int]] = []
    for (h, q, x, y), c in a.d.items():
        if x != x_degree:
            continue
        assert y == 0 and q >= 0
        while len(rows) <= h:
            rows.append([])
        while len(rows[h]) <= q:
            rows[h].append(0)
        rows[h][q] = c
    return [U.trim(p) for p in rows]


def determinant(matrix: list[list[list[int]]]) -> list[int]:
    """Fraction-free determinant in K[q], including singular matrices."""
    m = [[p[:] for p in row] for row in matrix]
    n = len(m)
    if any(len(row) != n for row in m):
        raise ValueError('A square matrix is required.')
    if not n:
        return [1]
    previous, sign = [1], 1
    for k in range(n - 1):
        pivot_row = next((i for i in range(k, n) if m[i][k]), None)
        if pivot_row is None:
            return []
        if pivot_row != k:
            m[k], m[pivot_row] = m[pivot_row], m[k]
            sign = -sign
        pivot = m[k][k]
        for i in range(k + 1, n):
            for j in range(k + 1, n):
                numerator = U.sub(U.mul(pivot, m[i][j]),
                                  U.mul(m[i][k], m[k][j]))
                m[i][j] = U.exactdiv(numerator, previous)
            m[i][k] = []
        previous = pivot
    return U.scale(m[-1][-1], sign % 5)


def sylvester(a: list[list[int]], b: list[list[int]]) -> list[list[list[int]]]:
    """Rows are shifted ascending polynomials; their lengths stay fixed."""
    n, m = len(a) - 1, len(b) - 1
    return ([[[] for _ in range(i)] + a + [[] for _ in range(m - 1 - i)]
             for i in range(m)] +
            [[[] for _ in range(i)] + b + [[] for _ in range(n - 1 - i)]
             for i in range(n)])


def xgcd(a: list[int], b: list[int]) -> tuple[list[int], list[int], list[int]]:
    aa, bb = a[:], b[:]
    s0, s1, t0, t1 = [1], [], [], [1]
    while bb:
        q, r = U.divmodp(aa, bb)
        aa, bb = bb, r
        s0, s1 = s1, U.sub(s0, U.mul(q, s1))
        t0, t1 = t1, U.sub(t0, U.mul(q, t1))
    if not aa:
        return [], [], []
    c = F.inv(aa[-1])
    return U.scale(aa, c), U.scale(s0, c), U.scale(t0, c)


def main() -> None:
    if sys.flags.optimize:
        raise RuntimeError('Assertions must be enabled.')
    data = json.loads((ROOT / 'data/cube_free.json').read_text())
    g = {i: LP.load(data['barred_numerators']['g' + str(i)]) for i in (2, 3, 4)}
    delta = reduce_curve(4 * g[3] ** 2 + 3 * g[2] * g[4])
    ch = [LP({(h, q, x, 0): c for (h, q, x, y), c in delta.d.items() if y == j})
          for j in range(3)]
    assert [max(e[2] for e in a.d) for a in ch] == [10, 7, 4]
    dq = LP({(0, 0, 0, 0): 47171, (0, 1, 0, 0): 357608})
    top = LP({(h, q, 0, 0): c for (h, q, x, y), c in ch[2].d.items() if x == 4})
    expected_top = (dq ** 2).shift((0, 4, 0, 0)) * LP({(0, 0, 0, 0): F.scale(F.powk(E.EPS, 2), 4)})
    assert top == expected_top
    invariant = ch[1] ** 2 - 4 * ch[0] * ch[2]
    pivot = [F.neg(118020), 1]
    assert U.scale(pivot, 357608) == [47171, 357608]
    patterns = {14: (6, 4), 13: (5, 3), 12: (2, 2)}
    primitive, records = {}, {}
    for x, (q_power, pivot_power) in patterns.items():
        rows = h_coefficients(invariant, x)
        content = U.shift(U.powp(pivot, pivot_power), q_power)
        gcd = []
        for row in rows:
            gcd = U.gcd(gcd, row)
        assert gcd == content
        primitive[x] = [U.exactdiv(row, content) for row in rows]
        assert all(U.mul(content, row) == original
                   for row, original in zip(primitive[x], rows))
        records[str(x)] = {
            'removed_content': {'q_power': q_power, 'pivot_power': pivot_power,
                                'pivot_K_code': 118020},
            'primitive_H_rows_ascending_q': primitive[x],
            'H_degree': len(primitive[x]) - 1,
            'q_degree': max(map(len, primitive[x])) - 1,
        }
    assert [(records[str(x)]['H_degree'], records[str(x)]['q_degree'])
            for x in (14, 13, 12)] == [(2, 4), (5, 8), (8, 18)]
    r13 = determinant(sylvester(primitive[14], primitive[13]))
    r12 = determinant(sylvester(primitive[14], primitive[12]))
    assert (len(r13) - 1, len(r12) - 1) == (30, 52)
    gcd, a, b = xgcd(r13, r12)
    assert gcd == [0] * 10 + [1]
    assert U.add(U.mul(a, r13), U.mul(b, r12)) == gcd
    certificate = {
        'scope': 'Critical discriminant only; NOT the residual-square decision.',
        'coefficient_field': 'K and K codes exactly as data/input.json',
        'open_set': 'q*(q-<118020>) != 0; H arbitrary in the algebraic closure',
        'definition': 'Delta_star=4*n_g3^2+3*n_g2*n_g4 in Y^3=P/q',
        'scaling': 'Delta_star(x,Y)=d(q)^2*w^10*Delta(x,wY), q=w^3',
        'necessary_square_identity': 'If Delta_star=(a(x)+Y*b(x))^2, B^2-4*A*C=0 for its three characters A,B,C.',
        'coefficients_of_B2_minus_4AC': records,
        'resultants': {
            'Res_H_fixed_2_5': r13,
            'Res_H_fixed_2_8': r12,
        },
        'bezout': {'a': a, 'b': b, 'rhs_q10': gcd,
                   'identity': 'a*Res_H_fixed_2_5+b*Res_H_fixed_2_8=q^10'},
        'all_removed_factors_already_units': True,
        'all_fixed_degree_drops_retained': True,
    }
    path = ROOT / 'intersection/data/critical_nonsquare.json'
    path.write_text(json.dumps(certificate, indent=2) + '\n')
    summary = {
        'status': 'PASS', 'global_not_a_parameter_search': True,
        'delta_expanded_terms_regenerated_not_stored': len(delta.d),
        'necessary_invariant_terms_regenerated_not_stored': len(invariant.d),
        'primitive_bidegrees_H_q': [[2, 4], [5, 8], [8, 18]],
        'fixed_resultant_degrees_q': [30, 52], 'gcd': 'q^10',
        'bezout_identity_checked_exactly': True,
        'critical_discriminant_uniformly_nonsquare': True,
        'source_square_locus': 'UNRESOLVED',
    }
    (ROOT / 'intersection/evidence/critical_checks.json').write_text(json.dumps(summary, indent=2) + '\n')
    print(json.dumps(summary, indent=2))


if __name__ == '__main__':
    main()
