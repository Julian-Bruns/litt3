#!/usr/bin/env sage
"""Exact finite-precision replay of a FORMAL local model, not a cover.

The proof is the z-adic contraction argument in
Research/notes/deformations/fl_contact_two_boundary.md. This checks the full original FL
connection, its Frobenius oper line, and the contact coefficient.
No search over covers or claim about global algebraization is made.
"""
import json
import time


def run_case(n, constant):
    started = time.monotonic()
    Q = 5**n
    P = 5*Q
    precision = 2*P+20
    series = PowerSeriesRing(GF(5), 'z', default_prec=precision)
    z = series.gen()
    one = series(1).add_bigoh(precision)
    c = series(constant).add_bigoh(precision)

    def coordinates(a):
        aq = (a**Q).add_bigoh(precision)
        A = one
        for iteration in range(20):
            ap = (A**P).add_bigoh(precision)
            H = (ap-z*aq).add_bigoh(precision)
            next_A = (ap/H**2).add_bigoh(precision)
            if next_A == A:
                phi = (z/H).add_bigoh(precision)
                assert A**(P-1) == H**2
                return A, H, phi
            A = next_A
        raise AssertionError('inner contraction did not converge')

    def primitive(R):
        coefficients = [GF(5)(0)]*precision
        for j in range(precision-1):
            if (j+1) % 5 == 0:
                assert R[j] == 0, ('Cartier obstruction', n, j)
            else:
                coefficients[j+1] = R[j]/GF(5)(j+1)
        return series(coefficients).add_bigoh(precision)

    a = c
    valuations = []
    for iteration in range(20):
        A, H, phi = coordinates(a)
        R = (z**4*A**5-phi**4*A).add_bigoh(precision)
        next_a = (c+primitive(R)).add_bigoh(precision)
        difference = next_a-a
        if difference == 0:
            break
        valuations.append(int(difference.valuation()))
        a = next_a
    else:
        raise AssertionError('outer contraction did not converge')

    check_precision = precision-1

    def check_zero(expression, label):
        assert expression.add_bigoh(check_precision) == 0, (n, constant, label)

    check_zero(phi.derivative()-A, 'actual derivative')
    check_zero(a.derivative()-z**4*A**5+phi**4*A, 'original FL connection')
    check_zero(phi*A**P-z*(1+phi*a**Q), 'Frobenius oper line')
    check_zero(phi**2*A**(P-1)-z**2, 'common tensor')
    assert a[0] == GF(5)(constant)
    assert phi[1] == 1
    assert phi[2] == GF(5)(constant)**Q != 0
    # The connection d + [[0,-z^4],[0,0]] dz has p-curvature
    # sending v to e, since -D^4(z^4)=1 in characteristic five.
    assert -(z**4).derivative(4)[0] == 1
    return {
        'n': int(n), 'Q': int(Q), 'P': int(P),
        'constant': int(constant), 'verified_mod_z': int(check_precision),
        'successive_correction_orders': valuations,
        'contact': int((phi-z).valuation()),
        'seconds': float(round(time.monotonic()-started, 6)),
        'status': 'PASS_FORMAL_LOCAL_ONLY',
    }


started = time.monotonic()
results = [run_case(n, c) for n in (1, 2, 3) for c in (1, 2, 3, 4)]
for result in results:
    print(json.dumps(result, sort_keys=True), flush=True)
print(json.dumps({'cases': len(results), 'seconds': float(round(time.monotonic()-started, 6)),
                  'status': 'ALL_LOCAL_IDENTITIES_PASS',
                  'limitation': 'No actual global span or lift is constructed'},
                 sort_keys=True), flush=True)
