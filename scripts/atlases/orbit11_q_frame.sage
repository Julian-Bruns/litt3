#!/usr/bin/env sage
"""Bounded exact test of a Q-frame minor over a normalized oper's relative field.

The cubic deck grading removes any need to choose a cube root. This is
matrix arithmetic only; it never builds atlas tensors or runs their solver.
"""
import argparse
import hashlib
import itertools
import json
import signal
import time
from copy import copy
from pathlib import Path


def inspect(relative, output, max_seconds, row_order, symbolic, census_algebra=False):
    started = time.monotonic()
    root = Path(__file__).resolve().parents[2]
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
        namespace = {'__file__': str(root/'scripts/atlases/opers/oper_representatives.sage')}
        exec(compile((root/'scripts/atlases/opers/oper_representatives.sage').read_text(),
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
        special=None
        if census_algebra:
            assert symbolic, '--census-algebra requires --symbolic'
            certificate_path=root/'Research/computations/normalized_oper_algebra_certificate.json'
            certificate=json.loads(certificate_path.read_text())
            PR=PolynomialRing(GF(5),'z',implementation='FLINT')
            modulus_all=PR(certificate['P'])
            assert modulus_all.degree()==19290
            from sage.rings.polynomial.polynomial_quotient_ring import PolynomialQuotientRing_generic
            algebra=PolynomialQuotientRing_generic(PR,modulus_all,('alpha',))
            za=algebra(PR(certificate['coordinates']['zeta']))
            assert za**2+4*za+2==0
            embed=lambda c:algebra(int(k(c)[0]))+int(k(c)[1])*za
            values=[algebra(PR(certificate['coordinates']['a%d'%i])) for i in range(10)]
            values += [algebra(PR(c)) for c in certificate['B']]
            values += [algebra(PR(certificate['coordinates']['c%d'%i])) for i in range(4)]
            values += [algebra(PR(certificate['lambda']))]
            assert len(values)==len(field.gens())
            # Evaluate only the small original Q minor, never the expanded
            # degree-nine Schur expressions. Subsequent elimination is a
            # straight-line computation in the whole finite census algebra.
            monomial_cache={}
            def specialize(f):
                result=algebra.zero()
                for ex,c in f.dict().items():
                    ex=tuple(ex)
                    if ex not in monomial_cache:
                        value=algebra.one()
                        for i,power in enumerate(ex):
                            if power:value*=values[i]**power
                        monomial_cache[ex]=value
                    result+=embed(c)*monomial_cache[ex]
                return result
            special=matrix(algebra,[[specialize(c) for c in row] for row in matrix_g.rows()])
            report['census_source_sha256']=hashlib.sha256(certificate_path.read_bytes()).hexdigest()
            announce('whole19290-dimensional census algebra specialized')
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
                report['status'] = 'census_determinant_pending' if special is not None else 'complete'
                announce('constant elimination leaves %d by %d polynomial matrix'%(32-step, 32-step))
                if special is not None:
                    h=special[step:,step:];n=h.nrows()
                    # Division-free subset determinant; the census algebra
                    # is a PRODUCT of fields, not a field. No inverse of an
                    # unproved unit is allowed in this final6x6 determinant.
                    minors={0:algebra.one()}
                    for mask in range(1,1<<n):
                        row=int(mask).bit_count()-1;ans=algebra.zero()
                        for column in range(n):
                            if mask&(1<<column):
                                sign=-1 if (row+int(mask&((1<<column)-1)).bit_count())%2 else 1
                                ans+=sign*minors[mask-(1<<column)]*h[row,column]
                        minors[mask]=ans
                    det_all=embed(determinant.constant_coefficient())*minors[(1<<n)-1]
                    # Independent determinant algorithm: all permutations,
                    # with signs counted directly, not the subset recurrence.
                    direct=algebra.zero()
                    for permutation in itertools.permutations(range(n)):
                        inversions=sum(permutation[i]>permutation[j]
                                       for i in range(n) for j in range(i+1,n))
                        term=algebra.one()
                        for i in range(n):term*=h[i,permutation[i]]
                        direct+=(-1 if inversions%2 else 1)*term
                    assert direct==minors[(1<<n)-1]
                    det_poly=PR(det_all.lift())
                    common,bez_det,bez_mod=det_poly.xgcd(modulus_all)
                    assert bez_det*det_poly+bez_mod*modulus_all==common
                    closed=json.loads((root/'Research/computations/normalized_oper_closed_points.json').read_text())['factors']
                    assert prod(PR(row['polynomial']) for row in closed)==modulus_all
                    if common!=1:
                        report.update(status='census_frame_minor_has_zeros',
                            failing_representatives=[row['id'] for row in closed
                                if PR(row['polynomial']).gcd(det_poly).degree()>0],
                            determinant_gcd=[int(c) for c in common.list()])
                        announce('chosen frame does not cover all12 representatives')
                        return
                    report.update(status='complete',all12_noninvariant_frames_nonzero=True,
                        representative_ids=[row['id'] for row in closed],
                        determinant_mod_census=[int(c) for c in det_poly.list()],
                        determinant_inverse_mod_census=[int(c) for c in bez_det.list()],
                        determinant_modulus_multiplier=[int(c) for c in bez_mod.list()],
                        exact_global_bezout_identity_verified=True,
                        independent_permutation_determinant_verified=True,
                        scope='Uniform Q frame for all12 noninvariant representatives; no atlas exclusion.')
                    compact={key:report[key] for key in [
                        'status','scope','row_indices','column_indices',
                        'source_minor_sha256','census_source_sha256','constant_pivots',
                        'constant_determinant_factor','representative_ids',
                        'determinant_mod_census','determinant_inverse_mod_census',
                        'determinant_modulus_multiplier','exact_global_bezout_identity_verified',
                        'independent_permutation_determinant_verified']}
                    compact['generator_source_sha256']=hashlib.sha256(Path(__file__).with_suffix('').with_suffix('.sage').read_bytes()).hexdigest() if str(__file__).endswith('.sage.py') else hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
                    compact['seconds']=elapsed()
                    output.with_suffix('.certificate.json').write_text(json.dumps(compact,indent=2,default=int)+'\n')
                    announce('all12 frames NONZERO: exact global Bezout certificate')
                return
            if row != step:
                g.swap_rows(row, step)
                if special is not None:special.swap_rows(row,step)
                determinant = -determinant
            if column != step:
                g.swap_columns(column, step)
                if special is not None:special.swap_columns(column,step)
                determinant = -determinant
            pivot = g[step, step]
            determinant *= pivot
            pivot_degrees.append(degree)
            report['completed_pivots'] = step+1
            report['pivot_degrees'] = pivot_degrees[:]
            inv = field(~k(pivot.constant_coefficient())) if symbolic else ~pivot
            special_inv=embed(inv.constant_coefficient()) if special is not None else None
            if special is not None:assert special[step,step]*special_inv==1
            for j in range(step+1, 32):
                g[step, j] *= inv
                if special is not None:special[step,j]*=special_inv
            for i in range(step+1, 32):
                entry = g[i, step]
                if entry:
                    for j in range(step+1, 32):
                        g[i, j] -= entry*g[step, j]
                        if special is not None:special[i,j]-=special[i,step]*special[step,j]
                g[i, step] = 0
                if special is not None:special[i,step]=0
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
    parser.add_argument('--census-algebra',action='store_true',
                        help='Replay constant elimination simultaneously on all12 normalized oper factors, with an exact determinant Bezout certificate')
    args = parser.parse_args()
    inspect(args.relative, args.output, args.max_seconds, args.row_order, args.symbolic,args.census_algebra)
