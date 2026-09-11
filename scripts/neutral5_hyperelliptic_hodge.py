#!/usr/bin/env sage-python
"""Independent small Hodge model and primary-repair transport on genus six.

All calculations are in characteristic five.  This prepares the genuine
next-Witt obstruction problem but does not compute that obstruction.
"""
import argparse
import json
from pathlib import Path
import time

from sage.all import GF, PolynomialRing, PowerSeriesRing, matrix, vector


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--model', required=True)
    ap.add_argument('--output', required=True)
    args = ap.parse_args()
    start = time.monotonic()
    data = json.loads(Path(args.model).read_text())
    P = PolynomialRing(GF(5), 't')
    k = GF(625, 't', modulus=P(data['field_modulus']))
    t = k.gen()
    ring = PolynomialRing(k, 's'); s = ring.gen()
    decode = lambda cs: k(cs)
    encode = lambda a: [int(k(a).polynomial()[i]) for i in range(4)]
    poly = lambda key: ring([decode(c) for c in data[key]])
    N, D = poly('numerator'), poly('denominator')
    d, J = poly('denominator_square_root'), poly('elliptic_y_numerator')
    G = poly('hyperelliptic_polynomial')
    S5 = poly('elliptic_source_polynomial')
    q = N/D
    H = t**2 + 2; mu = 4+4*t; h0 = 4*t+3
    c = -H
    assert D == d**2
    assert q.derivative()*d**5/J == c*D
    A = c**4*D*(N-t*D)*(N-h0*D)**2/mu
    A = ring(A)
    assert A.degree() == 19
    # eta_C=c*D*eta_T.  Therefore A_T=(c*D)^4*A_C(q).
    assert A == (c*D)**4*(q-t)*(q-h0)**2/mu

    def coeff(poly, power):
        return poly[power] if power >= 0 else k(0)
    plus = matrix(k, 11, 11,
                  lambda i,j: coeff(A*G**2, 5*(j+1)-(i+1)))
    minus = matrix(k, 4, 4,
                   lambda i,j: coeff(A, 5*(j+1)-(i+1)))
    full = matrix.block_diagonal([plus, minus])
    assert plus.rank() == 10 and minus.rank() == 4
    fitting = [15]
    iterate = matrix.identity(k, 15)
    for step in range(1,9):
        iterate = iterate*full.apply_map(lambda a: a**(5**(step-1)))
        fitting.append(int(iterate.rank()))
    assert fitting == [15,14,13,12,11,10,9,9,9]

    # Explicit AS/Verschiebung identification, independently audited.
    B0 = ((2+3*t+3*t**2+2*t**3)*s + (3+t+2*t**2))
    s0 = B0*D/J  # w/(lambda*ell), which has coefficients in F625.
    assert (q*q+1)**2*(q-t)**2*s0**5-H*s0 == q-2*t
    prefactor = J/(c*d**7)
    k3 = 4+t+3*t**2
    kernel = prefactor*(1/q+4/q**2+k3/q**3)
    rho_z = [1+4*t+2*t**2, 1+t+t**3, t+2*t**2+2*t**3]
    rho_u = [rho_z[0], rho_z[1]-(t+1)*rho_z[0],
             rho_z[2]+(t+1)*rho_z[0]]
    rho = prefactor*sum(rho_u[i]/q**(i+1) for i in range(3))
    a0 = 2+2*t+4*t**3
    particular = prefactor*((4+4*t+t**3)/q+(1+3*t**3)/q**2
                  +(t+2)/H*s0/q
                  +a0*(q*q+1)*(q-t)/H*s0**2
                      *(1/q+4/q**2+k3/q**3))

    # On the original pulled-back Cech cover, poles of these coefficients
    # are over u=0 and u=infinity.  The latter consists of infinity and
    # the roots of d.  Residue reciprocity moves them to the N-poles.
    # Standard Y/s^i represents minus twice the dual coefficient. Thus
    # the desired coordinates are the N-supported principal part's
    # Laurent coefficients s^-1,...,s^-11 at infinity.
    series = PowerSeriesRing(k, 'z', default_prec=20); z = series.gen()
    def coordinates(rational):
        num, den = map(ring, [rational.numerator(), rational.denominator()])
        nden = den.gcd(N**10)
        other = den // nden
        assert nden.gcd(other) == 1
        assert not other or (d**30).mod(other) == 0
        if nden.degree() == 0:
            return vector(k, 11)
        remainder = (num*other.inverse_mod(nden)).mod(nden)
        if not remainder:
            return vector(k, 11)
        shift = nden.degree()-remainder.degree()
        assert shift > 0
        rev_num = series(list(reversed(remainder.list())))
        rev_den = series(list(reversed(nden.list())))
        expansion = z**shift*rev_num/rev_den
        return vector(k, [expansion[i] for i in range(1,12)])

    kv, rv, xv = [coordinates(r) for r in [kernel,rho,particular]]
    assert kv and rv and xv
    assert plus*vector(k, [a**5 for a in kv]) == 0
    assert plus*vector(k, [a**5 for a in xv]) == rv
    assert plus.right_kernel().dimension() == 1
    # The dual obstruction coordinate is normalized by the first
    # nonzero coordinate, without suppressing its Serre-frame choice.
    dual = plus.left_kernel().basis()[0]
    assert dual.dot_product(rv) == 0

    def rat_encode(f):
        return {name:[[int(a.polynomial()[i]) for i in range(4)]
                      for a in ring(poly)]
                for name,poly in [('numerator',f.numerator()),
                                  ('denominator',f.denominator())]}
    output = dict(status='PASS',field_modulus=data['field_modulus'],
                  basis=['Y/s^%s'%i for i in range(1,12)]
                        +['1/s^%s'%i for i in range(1,5)],
                  hodge_multiplier=[encode(a) for a in A],
                  hodge_matrix=[[encode(a) for a in row] for row in full],
                  semilinear_rank_sequence=fitting,
                  kernel=[encode(a) for a in kv],
                  particular_primary_repair=[encode(a) for a in xv],
                  reference_primary_obstruction=[encode(a) for a in rv],
                  obstruction_dual=[encode(a) for a in dual],
                  rational_cochains={'kernel':rat_encode(kernel),
                      'particular':rat_encode(particular),'rho':rat_encode(rho)},
                  seconds=time.monotonic()-start,
                  scope='Actual hyperelliptic Hodge matrix and Cech transport of the primary repair only. No W4 result.')
    Path(args.output).write_text(json.dumps(output,indent=2)+'\n')
    print('Hyperelliptic + block rank:',plus.rank(),'minus block rank:',minus.rank())
    print('Semilinear ranks:',fitting)
    print('Particular primary repair:',xv)
    print('Kernel:',kv)
    print('PASS exact small Hodge matrix and primary cochain transport')


if __name__ == '__main__':
    main()
