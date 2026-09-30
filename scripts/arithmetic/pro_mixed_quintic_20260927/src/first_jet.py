"""Exact first-jet reconstruction for the two integral comparison equations.

This is a reconstruction kernel, NOT a complete incidence enumerator or an
existence solver. Coefficients and polynomial rows use the archive conventions.
A bivariate polynomial is a list indexed by the U exponent, whose entries are
ascending polynomials in z. All multiplicities remain integers in products.
"""
from exact import (F, Extension, trim, add, sub, scale, mul, power, derivative,
                   evaluate, divmod_poly, mod)


class FastExtension(Extension):
    """The same exact field representation, with Euclidean inverses."""
    def inv(self, a):
        if a == self.zero:
            raise ZeroDivisionError('inverse of zero')
        old, rr = self.h, trim(a, self.base)
        old_s, ss = [], [self.base.one]
        while rr:
            qq, rest = divmod_poly(old, rr, self.base)
            old, rr = rr, rest
            old_s, ss = ss, sub(old_s, mul(qq, ss, self.base), self.base)
        if len(old) != 1:
            raise ZeroDivisionError('nonunit in extension algebra')
        return self.element(scale(old_s, self.base.inv(old[0]), self.base))


def btrim(poly):
    poly = list(poly)
    while poly and not poly[-1]:
        poly.pop()
    return poly


def badd(left, right, K):
    return btrim([add(left[i] if i < len(left) else [],
                      right[i] if i < len(right) else [], K)
                  for i in range(max(len(left), len(right)))])


def bscale(poly, scalar, K):
    return btrim([scale(row, scalar, K) for row in poly])


def evaluate_u(poly, alpha, K):
    result = []
    for row in reversed(poly):
        result = add(scale(result, alpha, K), row, K)
    return result


def derivative_u(poly, K):
    return btrim([scale(poly[i], K.integer(i), K)
                  for i in range(1, len(poly))])


def hermite(roots, values, jets, K):
    """Unique polynomial of U-degree < 2*len(roots) with given first jets.

    Values and jets are polynomials in z. No division by a multiplicity,
    by 5, or by an unknown parameter occurs.
    """
    if not (len(roots) == len(values) == len(jets)):
        raise ValueError('root/value/jet lengths differ')
    if len(set(roots)) != len(roots):
        raise ValueError('Hermite roots must be distinct')
    output = []
    for i, alpha in enumerate(roots):
        basis = [K.one]
        denom = K.one
        for j, beta in enumerate(roots):
            if i == j:
                continue
            basis = mul(basis, [K.neg(beta), K.one], K)
            denom = K.mul(denom, K.sub(alpha, beta))
        basis = scale(basis, K.inv(denom), K)
        db = evaluate(derivative(basis, K), alpha, K)
        sq = mul(basis, basis, K)
        kb = mul([K.neg(alpha), K.one], sq, K)
        hb = sub(sq, scale(kb, K.mul(K.integer(2), db), K), K)
        contribution = [add(scale(values[i], hb[j] if j < len(hb) else K.zero, K),
                            scale(jets[i], kb[j] if j < len(kb) else K.zero, K), K)
                        for j in range(max(len(hb), len(kb)))]
        output = badd(output, contribution, K)
    return output


def divide_linear(poly, root, K):
    quotient, remainder = divmod_poly(poly, [K.neg(root), K.one], K)
    if remainder:
        raise ValueError('requested linear divisor is absent')
    return quotient


def make_field_data(data):
    """F_(5^56) = F25[alpha][zeta], degrees 4 and 7.

    The archived verifiers prove both original irreducibilities. Degree 7
    remains irreducible after a degree-4 constant extension since gcd(4,7)=1.
    """
    E = FastExtension(data['A_monic'])
    K = FastExtension([E.embed(c) for c in data['zeta_minimal_over_F25']], E)
    alpha0 = E.element([0, 1])
    aa = [E.pow(alpha0, 25**i) for i in range(4)]
    ev = lambda row, x: evaluate([E.embed(c) for c in row], x, E)
    A, P = data['A'], data['P']
    Ap, App, Pp = derivative(A), derivative(derivative(A)), derivative(P)
    cap = E.div(E.mul(E.integer(3), E.mul(E.pow(ev(Ap, alpha0), 3),
                                         E.pow(ev(P, alpha0), 2))),
                E.pow(E.embed(A[-1]), 3))
    b0 = E.pow(cap, pow(29, -1, E.order - 1))
    bb = [E.pow(b0, 25**i) for i in range(4)]
    beta = [E.pow(b0, (25**i - 1)//3) for i in range(4)]
    zeta = K.element([E.zero, E.one])
    xi_code = next(c for c in range(2, 25) if F.pow(c, 3) == 1)
    xi = K.embed(E.embed(xi_code))
    chi = K.mul(xi, K.pow(zeta, 10))  # chi^3=zeta; ord(chi)=87.
    return {
        'E': E, 'K': K, 'alpha8': aa, 'b08': bb, 'beta8': beta,
        'roots': [K.embed(a) for a in aa],
        'Ap': [K.embed(ev(Ap, a)) for a in aa],
        'Kappa': [K.embed(E.sub(E.div(ev(Pp, a), ev(P, a)),
                                  E.div(ev(App, a), ev(Ap, a)))) for a in aa],
        'b0': [K.embed(b) for b in bb], 'beta': [K.embed(b) for b in beta],
        'A4': K.embed(E.embed(A[-1])), 'zeta': zeta, 'chi': chi,
        'xi_F25_code': xi_code,
    }


def endpoint_slopes(labels, field):
    K = field['K']
    return [K.div(K.mul(field['A4'], K.mul(K.pow(field['b0'][i], 4),
                                          K.pow(field['zeta'], 4*j))),
                  field['Ap'][i]) for i, j in labels]


def build_leg(n, labels, incidence, field):
    """Return H0,H1 with G(U,z)=H0(U,z)+lambda*H1(U,z).

    labels contains five (root, phase) occurrences. incidence is a dictionary
    (i,j,r)->positive integer q, 0<=r<87. This constructs only necessary
    integral equations. It does not test norm alignment, connectedness,
    global etaleness, or source existence.
    """
    if not isinstance(n, int) or not 15 <= n <= 218:
        raise ValueError('n outside the stated problem')
    if len(labels) != 5 or any(not (0 <= i < 4 and 0 <= j < 29)
                               for i, j in labels):
        raise ValueError('invalid endpoint multiset')
    K = field['K']
    roots, ap, kappas = field['roots'], field['Ap'], field['Kappa']
    counts = [sum(i == a for a, _ in labels) for i in range(4)]
    slopes = endpoint_slopes(labels, field)
    values, jets0, jets1 = [], [], []
    rows = [[] for _ in range(4)]
    capacity = {}
    for (i, j, r), q in sorted(incidence.items()):
        if not (0 <= i < 4 and 0 <= j < 4 and 0 <= r < 87
                and isinstance(q, int) and 1 <= q <= 5):
            raise ValueError('invalid integral incidence entry')
        c = K.mul(K.div(field['beta'][i], field['beta'][j]),
                  K.pow(field['chi'], r))
        rows[i].append((j, c, q))
        capacity[c] = capacity.get(c, 0) + q
    if any(q > 5 for q in capacity.values()):
        raise ValueError('point-count capacity exceeds quintic fiber degree')
    for i in range(4):
        if counts[i] + sum(q for _, _, q in rows[i]) != n:
            raise ValueError('row degree does not equal n')
        value = [K.zero]*counts[i] + [K.one]
        for _, c, q in rows[i]:
            value = mul(value, power([K.neg(c), K.one], q, K), K)
        d0, d1 = [], []
        for j, c, q in rows[i]:
            quotient = divide_linear(value, c, K)
            k0 = K.mul(K.integer(2), K.mul(c, kappas[i]))
            k1 = K.neg(K.mul(K.integer(2), K.mul(K.pow(c, -12),
                         K.div(K.mul(ap[i], kappas[j]), ap[j]))))
            d0 = sub(d0, scale(quotient, K.mul(K.integer(q), k0), K), K)
            d1 = sub(d1, scale(quotient, K.mul(K.integer(q), k1), K), K)
        if counts[i]:
            slope_sum = K.zero
            for (root, _), a in zip(labels, slopes):
                if root == i:
                    slope_sum = K.add(slope_sum, K.inv(a))
            d1 = sub(d1, scale(divide_linear(value, K.zero, K), slope_sum, K), K)
        # Independent compact expression; integer n is reduced only here.
        compact = scale(sub([K.zero] + derivative(value, K),
                            scale(value, K.integer(n), K), K),
                        K.neg(K.mul(K.integer(2), kappas[i])), K)
        assert d0 == compact
        values.append(value); jets0.append(d0); jets1.append(d1)
    h0 = hermite(roots, values, jets0, K)
    h1 = hermite(roots, [[] for _ in roots], jets1, K)
    # An actual specialization must have U-degree five, not merely <=7.
    for i, alpha in enumerate(roots):
        assert evaluate_u(h0, alpha, K) == values[i]
        assert evaluate_u(h1, alpha, K) == []
        assert evaluate_u(derivative_u(h0, K), alpha, K) == jets0[i]
        assert evaluate_u(derivative_u(h1, K), alpha, K) == jets1[i]
    return {'H0': h0, 'H1': h1, 'values': values, 'jets0': jets0,
            'jets1': jets1, 'root_counts': counts, 'slopes': slopes}


def scalar_polynomial(labels, leg, field):
    """One necessary NONZERO polynomial of degree 2..5 for lambda.

    Its roots are candidates only. No division by scalar coefficients is used.
    U-degree, other endpoint jets, and the opposite leg are still to be checked.
    """
    K = field['K']
    counts = leg['root_counts']
    i = next(i for i, m in enumerate(counts) if m >= 2)
    m = counts[i]
    root = field['roots'][i]
    B = K.integer((-1)**m)
    for (a, _), slope in zip(labels, leg['slopes']):
        B = K.mul(B, slope if a == i else K.sub(root, field['roots'][a]))
    constant = lambda H: H[5][0] if len(H) > 5 and H[5] else K.zero
    c0, c1 = constant(leg['H0']), constant(leg['H1'])
    rho = leg['values'][i][m]
    assert rho != K.zero and B != K.zero
    out = [K.neg(K.mul(B, c0)), K.neg(K.mul(B, c1))]
    out += [K.zero]*(m+1-len(out))
    out[m] = K.add(out[m], rho)
    assert len(trim(out, K)) == m+1
    return {'root_index': i, 'degree': m, 'polynomial': out}


def opposite_incidence(incidence):
    return {(j, i, (-r) % 87): q for (i, j, r), q in incidence.items()}


def _bezout(values):
    """Return coefficients whose integer pairing with positive values is gcd."""
    coefficients, current = [], 0
    for value in values:
        old_r, rr = current, value
        old_s, ss, old_t, tt = 1, 0, 0, 1
        while rr:
            q = old_r // rr
            old_r, rr = rr, old_r-q*rr
            old_s, ss = ss, old_s-q*ss
            old_t, tt = tt, old_t-q*tt
        coefficients = [old_s*c for c in coefficients] + [old_t]
        current = old_r
    return current, coefficients


def recover_scalar(labels, leg, field):
    """Recover the ONLY possible nonzero scalar from fiber values and labels.

    The returned value is necessary, not a positive existence witness. The
    function does not assume the pencil's high coefficients vanish. All power
    equalities and the opposite leg still need validation. No scalar search.
    """
    K, roots = field['K'], field['roots']
    counts = leg['root_counts']
    B, rho = {}, {}
    for i, m in enumerate(counts):
        if not m:
            continue
        bi = K.integer((-1)**m)
        for (j, _), slope in zip(labels, leg['slopes']):
            bi = K.mul(bi, slope if i == j else K.sub(roots[i], roots[j]))
        B[i], rho[i] = bi, leg['values'][i][m]
        assert bi != K.zero and rho[i] != K.zero
    present = [i for i, m in enumerate(counts) if m]
    absent = [i for i, m in enumerate(counts) if not m]
    if absent:
        h = absent[0]
        wh = K.one
        for j, _ in labels:
            wh = K.mul(wh, K.sub(roots[h], roots[j]))
        constant = K.div(leg['values'][h][0], wh)
        powers = [K.div(K.mul(B[i], constant), rho[i]) for i in present]
        if len(present) == 1:
            # inverse of 5-Frobenius on F_(5^56); unique even over k.
            scalar = K.pow(powers[0], 5**55)
            method = 'unique_fifth_root'
        else:
            gg, coeffs = _bezout([counts[i] for i in present])
            assert gg == 1
            scalar = K.one
            for value, exponent in zip(powers, coeffs):
                scalar = K.mul(scalar, K.pow(value, exponent))
            method = 'integer_Bezout'
        return {'lambda': scalar, 'method': method, 'endpoint_constant': constant}
    # Necessarily counts are a permutation of (2,1,1,1).
    i = next(i for i, m in enumerate(counts) if m == 2)
    j = next(i for i, m in enumerate(counts) if m == 1)
    scalar = K.div(K.mul(rho[j], B[i]), K.mul(rho[i], B[j]))
    return {'lambda': scalar, 'method': 'multiplicity_two_over_one'}
