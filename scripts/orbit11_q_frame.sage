#!/usr/bin/env sage
"""Bounded exact test of a Q-frame minor over a normalized oper's relative field.

The cubic deck grading removes any need to choose a cube root. This is
matrix arithmetic only; it never builds atlas tensors or runs their solver.
"""
import argparse
import hashlib
import json
import signal
import time
from copy import copy
from pathlib import Path


def inspect(relative, output, max_seconds, row_order, symbolic):
    started = time.monotonic()
    root = Path(__file__).resolve().parents[1]
    report = {'scope': 'Q-frame minor only; no atlas solving or exclusion.',
              'status': 'started'}
    output = Path(output)
    output.parent.mkdir(parents=True, exist_ok=True)
    def elapsed(): return time.monotonic()-started
    def announce(stage):
        report['stage'] = stage
        print(stage, 'seconds', round(elapsed(), 3), flush=True)
    def stop(signum, frame):
        raise TimeoutError('The bounded matrix check reached its time limit.')
    signal.signal(signal.SIGALRM, stop)
    signal.alarm(int(max_seconds))
    try:
        prime = GF(5)
        k = GF(25, name='a', modulus=PolynomialRing(prime, 'z')([2, 4, 1]))
        a = k.gen()
        Z = PolynomialRing(k, 'z')
        decode = lambda c: k(int(c)%5)+k(int(c)//5)*a
        encode = lambda c: int(c.polynomial()[0])+5*int(c.polynomial()[1])
        data = json.loads(Path(relative).read_text())
        assert data['factor_and_embedding_verified']
        modulus = Z([decode(c) for c in data['relative_modulus']])
        assert modulus.degree() == data['degree_F25']
        report['relative_source_sha256'] = hashlib.sha256(Path(relative).read_bytes()).hexdigest()
        report['rep'] = data['rep']
        report['degree_F25'] = data['degree_F25']
        report['lambda_is_cube'] = data['lambda_is_cube']
        old_source = root / 'Research/computations/wronskian_differential_projection.json'
        old = json.loads(old_source.read_text())
        parse = lambda c: k(sage_eval(c, locals={'a': a}))
        original = matrix(k, [[parse(c) for c in row] for row in old['Q_matrix_rows']])
        cols = list(original.pivots())
        scan_rows = list(range(original.nrows()))
        if row_order == 'high':
            scan_rows.reverse()
        row_pivots = original.matrix_from_rows_and_columns(scan_rows, cols).transpose().pivots()
        rows = [scan_rows[i] for i in row_pivots]
        assert len(cols) == len(rows) == 32
        mons64 = [tuple(m) for m in old['Q_domain_monomials_L64']]
        mons112 = [tuple(m) for m in old['Q_target_monomials_L112']]
        report.update({'column_indices': cols, 'row_indices': rows, 'row_order': row_order,
                       'source_minor_sha256': hashlib.sha256(old_source.read_bytes()).hexdigest(),
                       'input_monomials': [mons64[i] for i in cols],
                       'output_monomials': [mons112[j] for j in rows]})
        announce('first-oper minor selected')

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

        # Verify the grading formula on the original first-oper matrix.
        namespace = {'__file__': str(root/'scripts/oper_representatives.sage')}
        exec(compile((root/'scripts/oper_representatives.sage').read_text(),
                     'oper_representatives.sage', 'exec'), namespace)
        first = namespace['load_oper']('orbit_0000')
        t = first['c4']
        first_minor = make_minor(k, [c/t**2 for c in first['A'].list()],
                                 first['B'].list(), [c/t for c in first['C'].list()], t**3)
        expected = matrix(k, [[original[r, c]*t**(mons64[c][1]-mons112[r][1])
                               for c in cols] for r in rows])
        assert first_minor == expected and first_minor.is_invertible()
        report['first_oper_grading_formula_verified'] = True
        announce('cubic grading formula verified')
        if symbolic:
            names = (['a%d'%i for i in range(10)]+['b%d'%i for i in range(8)]
                     +['c%d'%i for i in range(4)]+['lam'])
            field = PolynomialRing(k, names=names, order='degrevlex')
            coordinates = dict(zip(names, field.gens()))
            coordinates['lambda'] = coordinates.pop('lam')
            report['scope'] = 'Universal polynomial Q minor; no atlas solving or exclusion.'
            report['symbolic_variables'] = names
        else:
            # The factor and its F25 embedding are already exactly certified.
            # Calling Z.quotient would repeat the certified irreducibility test.
            from sage.rings.polynomial.polynomial_quotient_ring import PolynomialQuotientRing_field
            field = PolynomialQuotientRing_field(Z, modulus, ('alpha',))
            report['relative_quotient_type'] = type(field).__name__
            coordinates = {name: field(Z([decode(c) for c in values]))
                           for name, values in data['normalized_coordinates'].items()}
        lam = coordinates['lambda']
        assert lam != 0
        if not symbolic:
            assert coordinates['a9'] == field.gen()
        announce('symbolic coordinates loaded' if symbolic else 'relative coordinate field loaded')
        matrix_g = make_minor(field,
            [coordinates['a%d'%i] for i in range(10)]+[field.one()],
            [coordinates['b%d'%i] for i in range(8)],
            [coordinates['c%d'%i] for i in range(4)]+[field.one()], lam)
        announce('normalized minor constructed')
        g = copy(matrix_g)
        determinant = field.one()
        pivot_degrees = []
        for step in range(32):
            candidates = [(int(g[i,j].total_degree() if symbolic else g[i,j].lift().degree()), i, j)
                          for i in range(step, 32) for j in range(step, 32) if g[i,j]]
            if not candidates:
                determinant = field.zero()
                break
            degree, row, column = min(candidates)
            if symbolic and degree > 0:
                remaining = g.matrix_from_rows_and_columns(list(range(step, 32)), list(range(step, 32)))
                report['constant_pivots'] = step
                report['remaining_matrix_size'] = 32-step
                report['remaining_matrix'] = [[str(c) for c in row] for row in remaining.rows()]
                report['remaining_degrees'] = [[int(c.total_degree()) if c else -1 for c in row]
                                                for row in remaining.rows()]
                report['remaining_term_counts'] = [[len(c.dict()) for c in row] for row in remaining.rows()]
                report['constant_determinant_factor'] = str(determinant)
                report['universal_constant_elimination_verified'] = True
                report['status'] = 'complete'
                announce('constant elimination leaves %d by %d polynomial matrix'%(32-step, 32-step))
                return
            if row != step:
                g.swap_rows(row, step)
                determinant = -determinant
            if column != step:
                g.swap_columns(column, step)
                determinant = -determinant
            pivot = g[step, step]
            determinant *= pivot
            pivot_degrees.append(degree)
            report['completed_pivots'] = step+1
            report['pivot_degrees'] = pivot_degrees[:]
            inv = field(~k(pivot.constant_coefficient())) if symbolic else ~pivot
            for j in range(step+1, 32):
                g[step, j] *= inv
            for i in range(step+1, 32):
                entry = g[i, step]
                if entry:
                    for j in range(step+1, 32):
                        g[i, j] -= entry*g[step, j]
                g[i, step] = 0
            if (step+1)%4 == 0:
                announce('exact elimination through pivot %d'%(step+1))
        report['pivot_degrees'] = pivot_degrees
        report['minor_nonzero'] = bool(determinant)
        if determinant:
            det_poly = Z(determinant.lift())
            det_norm = modulus.resultant(det_poly)
            assert det_norm != 0
            report['determinant'] = [encode(c) for c in det_poly.list()]
            report['determinant_norm_F25'] = encode(det_norm)
            report['deck_weight'] = (sum(mons112[r][1] for r in rows)
                                     -sum(mons64[c][1] for c in cols))
        report['status'] = 'complete'
    except TimeoutError as error:
        report['status'] = 'bounded_check_incomplete'
        report['reason'] = str(error)
    finally:
        signal.alarm(0)
        report['elapsed_seconds'] = elapsed()
        output.write_text(json.dumps(report, indent=2, default=int)+'\n')
    print(json.dumps({key: val for key, val in report.items()
                      if key not in ['determinant', 'input_monomials', 'output_monomials']},
                     indent=2, default=int), flush=True)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--relative', required=True)
    parser.add_argument('--output', required=True)
    parser.add_argument('--max-seconds', type=int, default=180)
    parser.add_argument('--row-order', choices=['high', 'low'], default='high',
                        help='High pole rows expose the constant indicial pivots first.')
    parser.add_argument('--symbolic', action='store_true',
                        help='Stop after all constant pivots over the normalized coordinate polynomial ring.')
    args = parser.parse_args()
    inspect(args.relative, args.output, args.max_seconds, args.row_order, args.symbolic)
