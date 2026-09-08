#!/usr/bin/env sage
"""Bounded native row-module certificate for backup chart zero.

For N(b) the eight projected rooted rows, seek quadratic coefficients
lambda(b) with sum lambda_h N_h = S_0. This is an 80-by-80 linear
problem, not a generic-rank assertion. A successful identity gives
1=sum_h (L_0h+sum_a lambda_a^5 Q_ah) F_h in the ORIGINAL twelve
incidence rows; the thirteenth inverse-norm multiplier is exactly zero.
Failure of this bounded ansatz says nothing about atlas existence.
"""
import argparse
import hashlib
import itertools
import json
import time
from pathlib import Path


def run(tensor_path, output, summary, degree, vector_solver):
    from atlas_native_rref import NativeRref
    started = time.monotonic()
    raw = Path(tensor_path).read_bytes(); data = json.loads(raw)
    prime = PolynomialRing(GF(5), 'x')
    k = GF(5**data['field_degree'], name='c', modulus=prime(data['field_modulus']))
    decode = lambda cs: k(prime(cs))
    I = matrix(k, [[decode(co) for co in row] for row in data['I']], implementation='generic')
    pivots = list(I.transpose().pivots()); assert len(pivots) == 4
    selector = matrix(k, 4, 12, implementation='generic')
    for j, h in enumerate(pivots): selector[j, h] = 1
    left = I.matrix_from_rows(pivots).inverse()*selector
    assert left*I == identity_matrix(k, 4)
    projection = matrix(k, [[k(h == j)-sum(I[h, a]*left[a, j] for a in range(4))
                           for j in range(12)] for h in range(12) if h not in pivots], implementation='generic')
    assert projection*I == 0 and projection.nrows() == 8
    tensor = matrix(k, [[decode(data['tensor'][i][j][h]) for i in range(4) for j in range(4)]
                       for h in range(12)], implementation='generic')
    N = projection*tensor; S = -left*tensor
    root_power = 5**(data['field_degree']-1)
    Nroot = N.apply_map(lambda c: c**root_power)
    Sroot = S.apply_map(lambda c: c**root_power)
    assert Nroot.apply_map(lambda c: c**5) == N
    assert Sroot.apply_map(lambda c: c**5) == S
    B = PolynomialRing(k, names=['b1', 'b2', 'b3'], order='degrevlex')
    b = [B.one()]+list(B.gens())
    rows = [[sum((Nroot[a, 4*i+j]*b[j] for j in range(4)), B.zero()) for i in range(4)] for a in range(8)]
    target = [sum((Sroot[0, 4*i+j]*b[j] for j in range(4)), B.zero()) for i in range(4)]
    def exponents(bound):
        return sorted((ex for ex in itertools.product(range(bound+1), repeat=3) if sum(ex) <= bound), key=lambda ex: (sum(ex), ex))
    source_exponents = exponents(degree); target_exponents = exponents(degree+1)
    monomials = [B({ex: k.one()}) for ex in source_exponents]
    sources = [[monomial*f for f in row] for row in rows for monomial in monomials]
    def flatten(row):
        dictionaries = [{tuple(ex): co for ex, co in f.dict().items()} for f in row]
        return [dictionaries[i].get(ex, k.zero()) for i in range(4) for ex in target_exponents]
    M = matrix(k, [flatten(row) for row in sources], implementation='generic')
    wanted = vector(k, flatten(target))
    print(json.dumps({'stage': 'native row-module RREF', 'matrix_shape': list(M.dimensions()),
                     'coefficient_field_degree': data['field_degree'],
                     'preparation_seconds': time.monotonic()-started}, default=int), flush=True)
    if vector_solver:
        from backup_native_linear import NativeLinear
        engine=NativeLinear(k);assert engine.self_test()
        answer=engine.solve_or_dual(M,wanted);reported_rank=answer['rank']
        coefficients=list(answer['vector']) if not answer['dual'] else [k.zero()]*M.nrows()
    else:
        engine = NativeRref(k)
        reduced, transform = engine.rref(M, audit_sage=False)
        leading = [next(j for j, c in enumerate(row) if c) for row in reduced.rows()]
        assert leading == sorted(set(leading))
        assert all(reduced[i, j] == k(i == h) for h, j in enumerate(leading) for i in range(reduced.nrows()))
        coordinates = vector(k, [wanted[j] for j in leading])
        active = [i for i, co in enumerate(coordinates) if co]
        candidate = engine.multiply(matrix(k, 1, len(active), [coordinates[i] for i in active], implementation='generic'), transform.matrix_from_rows(active))
        coefficients = list(candidate.row(0));reported_rank=int(reduced.nrows())
    multipliers = [sum((coefficients[a*len(monomials)+j]*monomial for j, monomial in enumerate(monomials)), B.zero()) for a in range(8)]
    residual = [sum((multipliers[a]*rows[a][i] for a in range(8)), B.zero())-target[i] for i in range(4)]
    result = {'status': 'bounded_row_module_ansatz_no_certificate',
              'tensor_sha256': hashlib.sha256(raw).hexdigest(),
              'tensor_path': str(Path(tensor_path).resolve()),
              'twist_index': data['twist_index'], 'chart_first_nonzero_b': 0,
              'degree_bound_in_b': degree, 'matrix_shape': list(M.dimensions()),
              'source_monomial_exponents': source_exponents,
              'target_monomial_exponents': target_exponents,
              'target_component_order': [0, 1, 2, 3],
              'native_reported_rank': reported_rank,
              'single_rhs_memory_bounded_backend': bool(vector_solver),
              'native_records': engine.records,
              'scope': 'Only an exact unit identity is an atlas exclusion; failure of this degree-bounded row-module ansatz is not an atlas solution.'}
    if not any(residual):
        # Independent polynomial equality, not trust in native RREF rank.
        result['exact_projected_polynomial_identity_verified'] = True
        names = ['p0', 'p1', 'p2', 'p3', 'b1', 'b2', 'b3', 'z']
        R = PolynomialRing(k, names=names, order='degrevlex')
        pp = list(R.gens()[:4]); bb = [R.one()]+list(R.gens()[4:-1]); z = R.gens()[-1]
        original = [sum((decode(data['I'][h][j])*bb[j] for j in range(4)), R.zero())+
                    sum((decode(data['tensor'][i][j][h])*pp[i]*bb[j]**5 for i in range(4) for j in range(4)), R.zero()) for h in range(12)]
        norm = sum((decode(data['ell'][i][j])*pp[i]*bb[j] for i in range(4) for j in range(4)), R.zero())
        original.append(z*norm-1)
        fifth = [R({(0, 0, 0, 0)+tuple(5*n for n in ex)+(0,): co**5 for ex, co in h.dict().items()}) for h in multipliers]
        lifted = [R(left[0, h])+sum((fifth[a]*projection[a, h] for a in range(8)), R.zero()) for h in range(12)]+[R.zero()]
        assert sum((weight*f for weight, f in zip(lifted, original)), R.zero()) == 1
        result.update(status='empty_chart_exact_original_equation_certificate',
                      field_degree=data['field_degree'], field_modulus=data['field_modulus'], variables=names,
                      original_equations=[str(f) for f in original],
                      unit_certificate_multipliers=[str(h) for h in lifted],
                      exact_unit_identity_verified_against_all13_original_rows=True,
                      engine='native FLINT bounded row-module solve, direct original polynomial replay')
        target_path = Path(output); temporary = Path(str(target_path)+'.tmp')
        result['elapsed_seconds'] = time.monotonic()-started
        temporary.write_text(json.dumps(result, indent=1, default=int)+'\n'); temporary.replace(target_path)
    else:
        # A small exact dual certificate distinguishes actual ansatz
        # inconsistency from a merely unverified native rank report.
        if vector_solver:
            assert answer['dual'];dual=answer['vector']
        else:
            flat_residual = flatten(residual)
            column = next(j for j, c in enumerate(flat_residual) if c)
            dual = vector(k, M.ncols()); dual[column] = 1
            for i, pivot in enumerate(leading): dual[pivot] -= reduced[i, column]
        assert M*dual == 0 and wanted*dual != 0
        encode = lambda c: [int(v) for v in k(c).polynomial().list()]
        result.update(status='bounded_row_module_ansatz_inconsistent_exact_dual_certificate',
                      exact_dual_annihilator=[encode(c) for c in dual],
                      exact_nonzero_target_pairing=encode(wanted*dual),
                      dual_certificate_verified_on_original_coefficient_matrix=True)
    result['elapsed_seconds'] = time.monotonic()-started
    if summary:
        target_path = Path(summary); temporary = Path(str(target_path)+'.tmp')
        temporary.write_text(json.dumps(result, indent=1, default=int)+'\n'); temporary.replace(target_path)
    print(json.dumps({key: result[key] for key in ['status', 'twist_index', 'degree_bound_in_b', 'matrix_shape', 'native_reported_rank', 'elapsed_seconds']}, indent=1, default=int), flush=True)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--tensor', required=True)
    parser.add_argument('--output', required=True)
    parser.add_argument('--summary')
    parser.add_argument('--degree', type=int, choices=[0, 1, 2, 3], default=2)
    parser.add_argument('--vector-solver',action='store_true',help='Use a low-memory single-RHS native solve or dual witness, with direct original-vector checks.')
    args = parser.parse_args(); run(args.tensor, args.output, args.summary, args.degree, args.vector_solver)
