#!/usr/bin/env sage
"""The ten dormant secants and their exact genus-three Cartier packets.

Only the already-certified five-oper algebra is used. There is no new
oper enumeration, finite-field point count, or atlas solve. The genus-five
spectral curve has an actual etale double leg to the genus-three curve;
its double leg to the original genus-two C is RAMIFIED, not etale.
"""
import argparse
import hashlib
import itertools
import json
import time
from pathlib import Path


def run(preparation, output):
    started = time.monotonic()
    raw = Path(preparation).read_bytes()
    data = json.loads(raw)
    prime = PolynomialRing(GF(5), 'x')
    k = GF(125, name='alpha', modulus=prime(data['field']['modulus']))
    alpha = k.gen()
    decode = lambda cs: k(prime(cs))
    Z = PolynomialRing(k, 'z'); z = Z.gen()
    decode_poly = lambda cs: Z([decode(c) for c in cs])
    q = decode_poly(data['opers']['separator_coefficients'])
    p0 = decode_poly(data['opers']['b0_coefficients'])
    p1 = decode_poly(data['opers']['b1_coefficients'])
    assert q.degree() == 5 and q.is_monic() and q.is_irreducible()
    assert q.gcd(q.derivative()) == 1
    L = Z.quotient(q, names='zeta'); zeta = L.gen()
    assert L.is_field()
    roots = [zeta**(125**i) for i in range(5)]
    assert len(set(roots)) == 5 and roots[-1]**125 == roots[0]
    assert all(q(root) == 0 for root in roots)
    opers = [(p0(root), p1(root), root) for root in roots]
    S = PolynomialRing(L, 'u'); u = S.gen()
    h = u*(u-1)*(u-2)*(u-3)*(u-alpha)
    assert h.is_squarefree() and h.degree() == 5

    # Verify original dormancy directly, independently of the printed GB.
    for b0, b1, b2 in opers:
        num = 4*h*h.derivative(2)+2*h.derivative()**2+(2*u**3+b0+b1*u+b2*u**2)*h
        curv = (h**2*num.derivative(2)-4*h*h.derivative()*num.derivative()
                +(6*h.derivative()**2-2*h*h.derivative(2))*num-3*num**2)
        assert curv == 0
    encode_base = lambda value: [int(c) for c in k(value).polynomial().list()]
    encode = lambda value: [encode_base(c) for c in L(value).lift().list()]
    encode_poly = lambda value: [encode(c) for c in S(value).list()]
    encode_matrix = lambda value: [[encode(c) for c in row] for row in value.rows()]
    sigma = lambda value: value**(5**14)
    pair_index = {pair: index for index, pair in enumerate(itertools.combinations(range(5), 2))}
    rows = []
    secants = {}
    for i, j in pair_index:
        A = S([opers[i][c]-opers[j][c] for c in range(3)])
        assert A and A.degree() == 2
        secants[(i, j)] = A
        discriminant = A.discriminant()
        branch_gcd = A.gcd(h)
        simple = bool(discriminant)
        disjoint = branch_gcd.degree() == 0
        row = {'pair': [i, j], 'A_coefficients': encode_poly(A),
               'degree_A': int(A.degree()), 'A_discriminant': encode(discriminant),
               'gcd_A_h_coefficients': encode_poly(branch_gcd),
               'two_simple_roots': simple, 'disjoint_from_h': disjoint}
        if simple and disjoint:
            P = 2*A*h
            assert P.degree() == 7 and P.is_squarefree()
            H = matrix(L, 3, 3, [(P**2)[5*r-c]
                                 for r in range(1, 4) for c in range(1, 4)])
            M = H.apply_map(sigma)
            assert M.apply_map(lambda c: c**5) == H
            coeff = vector(L, [2*A[c] for c in range(3)])
            # Cartier is inverse-Frobenius-semilinear; retain that convention.
            image = M*vector(L, [sigma(c) for c in coeff])
            assert H*coeff == vector(L, [c**5 for c in coeff])
            assert image == coeff
            direct = (2*A)*P**2
            assert vector(L, [direct[5*r+4] for r in range(3)]) == H*coeff
            product = identity_matrix(L, 3)
            rank_sequence = []
            for iteration in range(3):
                product = product*M.apply_map(lambda c: c**(5**(14*iteration)))
                rank_sequence.append(int(product.rank()))
            determinant = H.det()
            row.update({'E_equation': 'w^2=2*A(u)*h(u)',
                        'E_polynomial_coefficients': encode_poly(P),
                        'E_genus': 3, 'spectral_genus': 5,
                        'spectral_to_E_etale_degree': 2,
                        'spectral_to_C_branch_degree': 4,
                        'H_coefficients': encode_matrix(H),
                        'Cartier_matrix_coefficients': encode_matrix(M),
                        'H_determinant': encode(determinant),
                        'H_determinant_inverse': encode(1/determinant) if determinant else None,
                        'Cartier_iterate_rank_sequence': rank_sequence,
                        'p_rank': rank_sequence[-1],
                        'eta_coefficients': [encode(c) for c in coeff],
                        'eta_Cartier_fixed': True, 'eta_zero_orders': [2, 2]})
        rows.append(row)

    # Only the stated symmetries are identified: F125-Frobenius and swap.
    # There is no claim these are the full unmarked genus-three moduli orbits.
    for pair, A in secants.items():
        shifted = ((pair[0]+1)%5, (pair[1]+1)%5)
        ordered = tuple(sorted(shifted))
        sign = 1 if shifted == ordered else -1
        assert S([c**125 for c in A.list()]) == sign*secants[ordered]
        row = rows[pair_index[pair]]
        row['F125_Frobenius_pair'] = list(ordered)
        row['F125_Frobenius_sign'] = sign
        row['cyclic_distance_orbit'] = min(pair[1]-pair[0], 5-(pair[1]-pair[0]))
    assert len({tuple((A/A.leading_coefficient()).list()) for A in secants.values()}) == 10
    orbit_counts = {str(d): sum(row['cyclic_distance_orbit'] == d for row in rows) for d in [1, 2]}
    assert orbit_counts == {'1': 5, '2': 5}
    good = [row for row in rows if row['two_simple_roots'] and row['disjoint_from_h']]
    result = {
        'status': 'exact ten dormant-secant genus-three differential-marked packet',
        'preparation_sha256': hashlib.sha256(raw).hexdigest(),
        'field': {'base_order': 125, 'base_generator': 'alpha',
                  'base_modulus': data['field']['modulus'],
                  'relative_generator': 'zeta',
                  'relative_modulus': data['opers']['separator_coefficients'],
                  'absolute_degree_over_F5': 15,
                  'encoding': 'outer ascending powers of zeta, inner ascending powers of alpha'},
        'oper_ordering': 'zeta_i=zeta^(125^i), i=0,...,4; b2=zeta_i',
        'oper_coefficients': [[encode(c) for c in b] for b in opers],
        'h_coefficients': encode_poly(h),
        'Cartier_convention': 'basis u^(j-1)du/w, H_ij=[u^(5i-j)](2Ah)^2; C(c)=H^(1/5)c^(1/5)',
        'pair_count': 10, 'simple_disjoint_pairs': len(good),
        'F125_Frobenius_unordered_orbit_sizes': orbit_counts,
        'swap_isomorphism': 'A -> -A, w -> 2w, eta -> 2eta; 2 is in F5',
        'genus_three_p_rank_counts': {str(f): sum(row.get('p_rank') == f for row in good) for f in range(4)},
        'pairs': rows,
        'elapsed_seconds': time.monotonic()-started,
        'scope': 'Exact endpoint algebra and author spectral-cover geometry. The actual spectral-to-E double leg is etale, but spectral-to-C is ramified; no common etale cover of X and C is constructed or excluded.'}
    target = Path(output); temporary = Path(str(target)+'.tmp')
    temporary.write_text(json.dumps(result, indent=1, default=int)+'\n'); temporary.replace(target)
    print(json.dumps({key: result[key] for key in ['status', 'pair_count', 'simple_disjoint_pairs',
                     'F125_Frobenius_unordered_orbit_sizes', 'genus_three_p_rank_counts',
                     'elapsed_seconds']}, indent=1, default=int), flush=True)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--preparation', default='Research/computations/backup_genus_two_preparation.json')
    parser.add_argument('--output', default='Research/computations/backup_genus_two_secant_curves.json')
    args = parser.parse_args(); run(args.preparation, args.output)
