#!/usr/bin/env sage
"""Bounded exact verification of the canonical-pencil atlas representation.

This reads the saved first-oper tensor and writes only the requested external
report. It does not run an atlas solver or mutate a production computation.
"""
import argparse
import hashlib
import json
import time
from pathlib import Path


def inspect_first(output):
    started = time.monotonic()
    root = Path(__file__).resolve().parents[1]
    source = root / 'Research/computations/canonical_atlas_system.json'
    saved = json.loads(source.read_text())
    dual_source = root / 'Research/computations/wronskian_serre_dual.json'
    dual = json.loads(dual_source.read_text())
    prime = GF(5)
    k = GF(25, name='a', modulus=PolynomialRing(prime, 'z')([2, 4, 1]))
    a = k.gen()
    R = PolynomialRing(k, 'x')
    x = R.gen()
    F = (x**10+(4*a+2)*x**9+(a+4)*x**8+(3*a+1)*x**7+3*a*x**6
         +4*a*x**5+(3*a+4)*x**4+a*x**3+(3*a+3)*x**2
         +(4*a+2)*x+2*a+1)
    parse = lambda s: k(sage_eval(s, locals={'a': a}))
    mat = lambda rows: matrix(k, [[parse(s) for s in row] for row in rows])
    basis = lambda n: sorted([(i, j) for j in range(3)
                            for i in range(n//3+1) if 3*i+10*j <= n],
                            key=lambda ij: 3*ij[0]+10*ij[1])
    mons_u, mons_t = basis(112), basis(192)
    assert mons_u == [tuple(m) for m in saved['SU_monomials']]
    ku, kt = mat(saved['SU_basis']), mat(dual['S40_basis'])
    assert mons_t == [tuple(m) for m in dual['monomials_L192']]
    assert ku.nrows() == 32 and kt.nrows() == 64
    old_n = [mat(tensor) for tensor in saved['N_tensor']]
    def polynomial(row):
        ans = [R.zero(), R.zero(), R.zero()]
        for c, (i, j) in zip(row, mons_u):
            ans[j] += c*x**i
        return ans
    def coefficients(parts):
        return [parts[j][i] for i, j in mons_t]
    ordinary, multiplied = [], []
    for row in ku.rows():
        parts = polynomial(row)
        ordinary.append(coefficients(parts))
        # (x^2*y)^5 = x^10*F*y^2 in y^3=F.
        product = [R.zero(), R.zero(), R.zero()]
        for j, p in enumerate(parts):
            product[(j+2)%3] += p*x**10*F**(1+(j+2)//3)
        multiplied.append(coefficients(product))
    new_basis = matrix(k, ordinary+multiplied)
    assert new_basis.rank() == 64
    pivots = list(kt.pivots())
    change = (new_basis.matrix_from_columns(pivots)
              * kt.matrix_from_columns(pivots).inverse())
    assert change*kt == new_basis and change.is_invertible()
    new_n = [change*entry for entry in old_n]
    for block in range(2):
        for i in range(32):
            assert new_n[i].row(32*block+i).is_zero()
            for j in range(i):
                assert (new_n[i].row(32*block+j)
                        +new_n[j].row(32*block+i)).is_zero()
    ranks = []
    set_random_seed(20260907)
    for _ in range(8):
        b = vector(k, [k.random_element() for _ in range(32)])
        bf = vector(k, [c**5 for c in b])
        outputs = [entry*bf for entry in new_n]
        pencil = [matrix(k, [[outputs[i][32*block+j]
                              for i in range(32)] for j in range(32)])
                  for block in range(2)]
        assert all(m.transpose() == -m for m in pencil)
        ranks.append({'beta': [str(c) for c in b],
                      'block_ranks': [int(m.rank()) for m in pencil],
                      'stack_rank': int(pencil[0].stack(pencil[1]).rank())})
    report = {
        'scope': 'Exact first-oper basis and tensor identities; no atlas exclusion.',
        'source_sha256': hashlib.sha256(source.read_bytes()).hexdigest(),
        'dual_source_sha256': hashlib.sha256(dual_source.read_bytes()).hexdigest(),
        'canonical_pencil': ['1', 'x^2*y'],
        'scalar_multiplier': 'x^10*F*y^2 = (x^2*y)^5',
        'dimensions': [32, 64],
        'direct_sum_basis_verified': True,
        'basis_change_invertible': True,
        'all_alternating_tensor_coefficients_verified': True,
        'sample_ranks': ranks,
        'basis_change': [[str(c) for c in row] for row in change.rows()],
        'elapsed_seconds': time.monotonic()-started,
    }
    output = Path(output)
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text(json.dumps(report, indent=2, default=int)+'\n')
    print(json.dumps({key: val for key, val in report.items()
                      if key not in ['basis_change', 'sample_ranks']}, indent=2, default=int))
    print('sample ranks:', [r['block_ranks']+[r['stack_rank']] for r in ranks])


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', required=True)
    args = parser.parse_args()
    inspect_first(args.output)
