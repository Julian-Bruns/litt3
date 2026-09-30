#!/usr/bin/env python3
"""Nondestructive exact verification of this archive's PARTIAL results.

Default: also regenerate all 13 bounded discriminant examples.
--quick: skip those examples, but check the universal row certificate and ranks.
Neither mode decides the remaining geometric existence/torsion problem.
"""
from __future__ import annotations

import argparse
import json
import pathlib
import platform
import random
import subprocess
import sys
import time

import numpy as np
import sympy as sp

import field as F
import linear_system as L
from make_certificate import trace_matrix
from profile_probe import restrict, subspace
import discriminant_probe as D

ROOT = pathlib.Path(__file__).resolve().parents[1]
P_ROOTS = [9, 14, 2514, 7367, 20130, 104315, 139659, 154113, 281660, 364472]
A_ROOTS = [25, 145049, 211895, 211959]


def check(condition: bool, message: str) -> None:
    if not condition:
        raise AssertionError(message)


def say(message: str) -> None:
    print(message, flush=True)


def verify_field() -> None:
    exp, log, _, _, generator = F.tables()
    check(exp.shape == (390624,), 'Wrong multiplicative-table length')
    check(np.array_equal(np.sort(exp), np.arange(1, F.Q)), 'Nonzero elements not enumerated exactly')
    check(np.array_equal(log[exp], np.arange(F.ORDER)), 'Log-table inverse fails')
    check(F.raw_pow(generator, F.ORDER) == 1, 'Generator does not have exponent dividing q-1')
    for prime in sp.factorint(F.ORDER):
        check(F.raw_pow(generator, F.ORDER // prime) != 1, 'Generator order is too small')
    check(int(F.mul(5, 5)) == int(F.add(5, 3)), 'beta relation fails')
    check(L.peval([5, 2, 6, 7, 1], 25) == 0, 'alpha relation fails')
    rng = random.Random(20260925)
    for _ in range(256):
        a, b = rng.randrange(F.Q), rng.randrange(F.Q)
        check(int(F.mul(a, b)) == F.raw_mul(a, b), 'Raw/table multiplication mismatch')
        check(int(F.sub(F.add(a, b), b)) == a, 'Addition inverse failed')
        if a:
            check(int(F.mul(a, F.inv(a))) == 1, 'Multiplicative inverse failed')
    # A full-table recurrence, independently of the C++ multiplication routine.
    check(exp[0] == 1, 'Multiplicative table has wrong first element')
    for i in [1, 2, 3, 17, 333, 50000, F.ORDER-1]:
        check(int(exp[i]) == F.raw_pow(generator, i), 'Independent power check failed')
    say(f'PASS field: F_{F.Q}; primitive element code {generator}; all nonzero codes distinct; 256 cross-checks')


def verify_input_data() -> None:
    check(np.array_equal(L.pder(L.Q), L.pmul(L.P, L.ppow(L.A, 2))), 'Qprime != P A^2')
    for poly, name in [(L.P, 'P'), (L.A, 'A')]:
        check(len(D.pgcd(poly, L.pder(poly))) == 1, f'{name} not squarefree')
    check(len(D.pgcd(L.P, L.A)) == 1, 'P and A not coprime')
    for subtract, modulus, name in [(L.B0, L.ppow(L.P, 2), 'P^2|(Q-B0^5)'),
                                     (L.L0, L.ppow(L.A, 3), 'A^3|(Q-L0^5)')]:
        diff = L.padd(L.Q, F.neg(L.ppow(subtract, 5)))
        check(not np.any(L.pdiv(diff, modulus)[1]), name + ' failed')
    for poly, roots in [(L.P, P_ROOTS), (L.A, A_ROOTS)]:
        check(len(set(roots)) == len(poly)-1, 'Root list cardinality incorrect')
        check(all(L.peval(poly, r) == 0 for r in roots), 'Not all listed elements are roots')
    orbit = [int(F.pow(25, 25**j)) for j in range(4)]
    check(set(orbit) == set(A_ROOTS), 'Support conjugacy orbit incorrect')
    check(all(int(F.pow(c, 25)) == c for c in L.P+L.A+L.Q+L.B0+L.L0), 'Base coefficients not in F25')
    say('PASS input identities: derivatives, squarefreeness, coprimality, branch/support divisibilities, all P/A roots and support orbit')


def verify_linear_system() -> tuple[np.ndarray, np.ndarray]:
    data = json.loads((ROOT / 'data/linear_system.json').read_text())
    M, t, blocks = L.build()
    check(M.shape == (288, 196), 'Unexpected reconstructed matrix shape')
    check(blocks == {'branch_rows': 150, 'support_rows': 135, 'infinity_rows': 3}, 'Wrong row blocks')
    check(np.array_equal(M, np.asarray(data['matrix'])), 'Stored/reconstructed matrix mismatch')
    check(np.array_equal(t, np.asarray(data['tB'])), 'Stored/reconstructed tB mismatch')
    check(data['variables'] == [list(x) for x in L.VARS]+[['kappa']], 'Wrong variable ordering')
    for name in ['P', 'A', 'Q', 'B0', 'L0']:
        check(data[name] == getattr(L, name), f'Stored {name} differs from source')
    check(len(F.rref(M[:150])[1]) == 148, 'Wrong branch rank')
    matrices = [(M, 'kernel', 18), (trace_matrix(M), 'trace_kernel', 13),
                (L.restricted_matrix(M), 'polynomial_v_kernel', 12)]
    for matrix, key, dim in matrices:
        K, piv = F.kernel(matrix)
        saved = np.asarray(data[key], dtype=np.int32)
        check(K.shape[1] == dim, f'Wrong {key} dimension')
        check(np.array_equal(K, saved), f'Wrong stored {key}')
        check(L.check_kernel(matrix, saved), f'{key} does not satisfy equations')
        say(f'PASS {key}: rank {len(piv)}, dimension {dim}; stored basis regenerated exactly')
    return M, np.asarray(data['polynomial_v_kernel'], dtype=np.int32)


def verify_certificate(M: np.ndarray) -> None:
    cert = json.loads((ROOT / 'certificates/third_pole_row.json').read_text())
    Mt = trace_matrix(M)
    c = sum(a*25**i for i, a in enumerate([24, 4, 0, 23]))
    check(c == 359499 and c != 0, 'c_alpha code failed')
    target = np.zeros(L.NV, dtype=np.int32)
    target[L.VARS.index((3, 12, 1))] = 1
    target[-1] = int(F.neg(c))
    check(np.array_equal(target, cert['target']), 'Certificate has wrong target')
    check(Mt.shape[0] == cert['number_of_rows'] == 302, 'Certificate row count wrong')
    check(len(cert['row_combination']) == 65, 'Expected 65 nonzero weights')
    result = np.zeros(L.NV, dtype=np.int32)
    indices = []
    for index, weight in cert['row_combination']:
        check(0 <= index < len(Mt) and 0 < weight < F.Q, 'Invalid row weight')
        indices.append(index)
        result = F.add(result, F.mul(weight, Mt[index]))
    check(len(set(indices)) == len(indices), 'Duplicate row indices')
    check(np.array_equal(result, target), 'Row certificate does not prove target')
    say('PASS universal certificate: 65-row combination equals N3[x^12*y] - c_alpha*kappa entry by entry')


def verify_profiles(K: np.ndarray) -> None:
    profiles = [(0, (4,4,2)), (0, (4,4,1,1)), (0, (3,3,3,1)),
                (0, (3,3,2,2)), (0, (3,3,2,1,1)), (0, (2,2,2,2,2)),
                (1, (3,3,1)), (1, (2,2,2,1)), (2, (1,1,1,1))]
    remaining = []
    for d, part in profiles:
        check(sum(part) == 10-3*d, 'Bad supplied partition')
        poles = sorted([2+m for m in part]+[2]*(5-len(part))+[1]*5, reverse=True)
        excluded = len(part) == 4 or sum(poles[:3]) < 16-3*d
        if not excluded:
            remaining.append((d, part))
    check(remaining == [(0, (4,4,2)), (1, (3,3,1))], 'Profile arithmetic did not give the claimed two survivors')
    for d, p2, p3, p4, dim in [(0, 10, 14, 17, 5), (0, 6, 12, 16, 3)]:
        kk = subspace(K, d, p2, p3, p4)
        check(kk.shape[1] == dim and not np.any(kk[-1]), 'Auxiliary kappa=0 profile check failed')
    constant = subspace(K, 0, 12, 16, 17)
    check(constant.shape[1] == 8, 'Constant survivor space dimension wrong')
    check(np.any(constant[L.VARS.index((0,0,0))]), 'Constant v cannot be normalized')
    base = subspace(K, 1, 10, 13, 14)
    for r in P_ROOTS:
        row1 = L.equation({(0,0,0):1, (0,1,0):r})
        row2 = L.equation({(2,i,2):int(F.pow(r,i)) for i in range(5)})
        kk = restrict(base, [row1, row2])
        check(kk.shape[1] == 8, 'Linear survivor space dimension wrong')
        check(np.any(kk[L.VARS.index((0,1,0))]), 'Linear v cannot be normalized')
    say('PASS profile arithmetic: seven excluded, only constant (4,4,2) and linear (3,3,1) remain; all 11 fixed-v spaces have affine dimension 7')


def verify_symbolic_resultant() -> None:
    w, a, b, c, d, f, k, v = sp.symbols('w a b c d f k v')
    variables = (a,b,c,d,f,k)
    stored = sp.sympify((ROOT/'data/generic_resultant.txt').read_text(),
                        locals={str(x):x for x in variables})
    poly = sp.Poly(stored, *variables, modulus=5)
    check(len(poly.terms()) == 43, 'Wrong number of resultant terms')
    monic = (w**5+f)*(w**5+a*w**3+b*w**2+c*w+d)+k
    quadratic = 3*a*w**2+2*b*w+c
    direct = sp.Poly(sp.resultant(monic, quadratic, w), *variables, modulus=5)
    check(poly == direct, 'Generic monic resultant mismatch')
    homogeneous = 0
    for exponents, coefficient in poly.terms():
        ve = 12-sum(exponents[i] for i in [0,1,2,3,5])
        check(ve >= 0, 'Invalid scaling exponent')
        term = int(coefficient)*v**ve
        for symbol, exponent in zip(variables, exponents):
            term *= symbol**exponent
        homogeneous += term
    nonmonic = (w**5+f)*(v*w**5+a*w**3+b*w**2+c*w+d)+k
    direct2 = sp.Poly(sp.resultant(nonmonic, quadratic, w), *variables, v, modulus=5)
    check(sp.Poly(homogeneous, *variables, v, modulus=5) == direct2, 'Nonmonic homogenization mismatch')
    yp, ap, bp, cp, pp = sp.symbols('Y A B C P')
    norm_direct = sp.resultant(yp**3-pp, ap+bp*yp+cp*yp**2, yp)
    norm_formula = ap**3+bp**3*pp+cp**3*pp**2-3*ap*bp*cp*pp
    check(sp.expand(norm_direct-norm_formula) == 0, 'Cubic norm identity failed')
    say('PASS symbolic checks: 43-term resultant, degree-12 nonmonic homogenization, cubic norm formula')


def verify_samples(M: np.ndarray) -> None:
    count = 0
    cases = [(seed, None) for seed in [1,2,3]] + [(1,r) for r in P_ROOTS]
    for seed, r in cases:
        name = f'discriminant_sample_{seed}.json' if r is None else f'discriminant_linear_{r}.json'
        saved = json.loads((ROOT/'data'/name).read_text())
        recomputed = D.sample(seed=seed, root_value=r, write=False, return_record=True)
        check(recomputed == saved, f'Saved/recomputed sample mismatch: {name}')
        z = np.asarray(saved['variables'], dtype=np.int32)
        check(L.check_kernel(L.restricted_matrix(M), z[:,None]), f'Sample not in polynomial-v kernel: {name}')
        check(z[-1] != 0, f'Sample kappa zero: {name}')
        residual = saved['residual_discriminant_norm']
        check(len(residual) == 145 and residual[-1] == 1, 'Residual not monic degree 144')
        check(saved['repeated_part_gcd'] == [1], 'Residual not squarefree')
        count += 1
    check(count == 13, 'Did not check exactly 13 saved samples')
    say('PASS 13 BOUNDED examples: exact coefficient vectors and degree-144 squarefree residuals regenerated; none is a cover witness')


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--quick', action='store_true', help='skip the 13 bounded discriminant examples')
    args = parser.parse_args()
    start = time.monotonic()
    say('DEGREE-TEN ETALE SECTOR — PARTIAL-RESULT VERIFICATION')
    say(f'Python {platform.python_version()}; NumPy {np.__version__}; SymPy {sp.__version__}')
    say(subprocess.check_output(['g++','--version'], text=True).splitlines()[0])
    verify_field()
    verify_input_data()
    M, K = verify_linear_system()
    verify_certificate(M)
    verify_profiles(K)
    verify_symbolic_resultant()
    if args.quick:
        say('SKIPPED by --quick: regeneration of all 13 bounded discriminant examples')
    else:
        verify_samples(M)
    say(f'ALL REQUESTED ARCHIVE CHECKS PASSED ({time.monotonic()-start:.3f} seconds).')
    say('STATUS STILL PARTIAL: remaining exceptional etale/torsion loci are NOT decided by this verifier.')


if __name__ == '__main__':
    try:
        main()
    except (AssertionError, ValueError, ZeroDivisionError, subprocess.CalledProcessError) as error:
        print(f'VERIFICATION FAILED: {error}', file=sys.stderr, flush=True)
        raise
