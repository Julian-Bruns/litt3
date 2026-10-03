#!/usr/bin/env -S sage -python
"""New necessary univariate gates for the ordinary elliptic coprime case.

No candidate sweep or Groebner basis.  The four cases retain both independent
first-copy signs and both mu6 transversals.  Reversing the first degree-twelve
norm retains its leading degree drop.  All square recursions are exact over
F25(t); denominator factors are checked against the physical opens.

Execution needs the parent's single-core authorization.  Ten mathematical
CPU seconds after Sage import; a hard OS guard backs up Python's timer.
"""
import json
import math
import resource
import signal
import time
from pathlib import Path

from sage.all import GF, PolynomialRing

out = (Path(__file__).resolve().parents[2].parent / 'litt3-computation-data'
       / 'oct03_q0_degree_five_ordinary_elliptic_coprime_gate')
out.mkdir(parents=True, exist_ok=True)
path = out / 'gate.json'
receipt = {'scope': 'necessary derivative-norm squares, ordinary elliptic '
                    'coprime quadratic numerators, degree five only',
           'field': 'F25=F5[nu]/(nu^2-nu-3)',
           'budget_cpu_seconds': 10, 'cases': []}
started = time.process_time()


def save():
    receipt['cpu_seconds'] = time.process_time() - started
    path.write_text(json.dumps(receipt, indent=2) + '\n')


class BudgetExpired(Exception):
    pass


def alarm_handler(signum, frame):
    raise BudgetExpired()


def strip_physical(poly, physical):
    """Remove precisely factors supported on the explicitly recorded opens."""
    poly = poly.monic() if poly else poly
    removed = []
    while poly and poly.degree() > 0:
        common = poly.gcd(physical)
        if common.degree() == 0:
            break
        removed.append(str(common.monic()))
        poly = (poly // common).monic()
    return poly, removed


signal.signal(signal.SIGPROF, alarm_handler)
signal.setitimer(signal.ITIMER_PROF, 10)
# libSingular can defer Python interrupts. This job uses only univariate
# arithmetic, but retain a hard guard rather than relying on that fact.
cpu_limit = math.floor(started) + 10
resource.setrlimit(resource.RLIMIT_CPU, (cpu_limit, cpu_limit))
save()
try:
    base = PolynomialRing(GF(5), 'n'); n = base.gen()
    K = GF(25, name='nu', modulus=n**2-n-3); nu = K.gen()
    om = 1+2*nu
    assert om**2+om+1 == 0 and om != 1
    R = PolynomialRing(K, 't'); t = R.gen()
    F = R.fraction_field()
    Z = PolynomialRing(F, 'z'); z = Z.gen()

    def square_constraints(poly, root_lead):
        """Degree-six square root, with known nonzero leading coefficient."""
        assert poly.degree() <= 12 and root_lead != 0
        assert poly[12] == root_lead**2
        root = Z(root_lead)*z**6
        for j in range(1, 7):
            degree = 12-j
            root += ((poly[degree]-(root**2)[degree])/(2*root_lead))*z**(6-j)
        remainder = poly-root**2
        assert remainder.degree() <= 5
        return [remainder[i] for i in range(6)], root

    for kind in (0, 1):
        for eps in (1, -1):
            case = {'type': kind, 'epsilon': eps, 'status': 'started'}
            receipt['cases'].append(case); save()
            J = z**2+om**2*t**2*z+om*t**4
            rho = -F(t)**3; kk = eps*rho-1
            if kind == 0:
                c = z**2+om**2*t**2*z-om*t
                b = om*t*z**2-z-om**2*t**2
                H = (-z+om**2*t**2)/(t**3+1)
            else:
                c = z**2+(2*om+2*t+om**2*t**2)*z+om*t+2*t**2
                b = (2*om**2+om*t)*z**2+(1+2*om**2*t+2*om*t**2)*z+om**2*t**2
                cinv = c.inverse_mod(J)
                H = ((z**2*J.derivative()/rho)*cinv) % J
            assert (z*c**2-b**2) == (z**3-1)*J
            assert ((H*c-z**2*J.derivative()/rho) % J) == 0
            ell = kk*H
            Phi = z*(nu*ell**2+J)
            A = c*ell; B = b*ell
            U = A.derivative()*z*J-A*(J+z*J.derivative())
            V = (b.derivative()*Phi+b*Phi.derivative()/2)*z*J-b*Phi*(2*J+z*J.derivative())
            C = B.derivative()*J-B*J.derivative()
            W = (c.derivative()*Phi+c*Phi.derivative()/2)*J-c*Phi*J.derivative()
            numerator = V**2-nu*z**2*Phi*U**2
            N1, rem = numerator.quo_rem(z**2)
            assert rem == 0
            N2 = W**2-nu*Phi*C**2
            assert N1.degree() <= 12 and N2.degree() == 12
            reverse1 = sum(N1[i]*z**(12-i) for i in range(13))
            root1 = b[0]*Phi[1]*J[0]
            root2 = Phi[3]
            equations1, square1 = square_constraints(reverse1, root1)
            equations2, square2 = square_constraints(N2, root2)
            equations = equations1+equations2

            # phi/z must be squarefree with nonzero constant and leading
            # coefficient: the actual B is a smooth elliptic curve with P
            # at infinity and a simple branch point at zero.
            c_norm = c.resultant(J)
            disc = Phi[2]**2-4*Phi[3]*Phi[1]
            opens = {'t': F(t), 'K': kk, 'norm_c_mod_J': c_norm,
                     'Phi_lead': Phi[3], 'Phi_simple_zero': Phi[1],
                     'elliptic_discriminant': disc,
                     'known_root1': root1, 'known_root2': root2}
            physical = R.one()
            for value in opens.values():
                assert value != 0
                physical *= R(value.numerator())*R(value.denominator())
            physical = physical.monic()
            assert physical != 0
            for value in equations:
                den_residual, _ = strip_physical(R(value.denominator()), physical)
                assert den_residual.degree() == 0
            nums = [R(value.numerator()) for value in equations]
            raw = R.zero()
            weights = []
            for value in nums:
                new, left, right = raw.xgcd(value)
                weights = [left*weight for weight in weights]+[right]
                raw = new
            assert raw != 0, 'all constraints vanished: not a finite gate'
            normalization = raw.leading_coefficient()
            raw /= normalization
            weights = [weight/normalization for weight in weights]
            assert sum(weight*value for weight, value in zip(weights, nums)) == raw
            residual, removed = strip_physical(raw, physical)
            case.update({'J': str(J), 'b': str(b), 'c': str(c),
                         'H': str(H), 'ell': str(ell), 'Phi': str(Phi),
                         'norm1_degree': int(N1.degree()),
                         'norm2_degree': int(N2.degree()),
                         'norm1': str(N1), 'norm2': str(N2),
                         'reverse_norm1_square_candidate': str(square1),
                         'norm2_square_candidate': str(square2),
                         'square_equation_numerators': [str(x) for x in nums],
                         'physical_opens': {name: str(value) for name, value in opens.items()},
                         'physical_polynomial': str(physical),
                         'raw_gcd': str(raw), 'raw_gcd_degree': int(raw.degree()),
                         'raw_gcd_bezout_weights': [str(weight) for weight in weights],
                         'raw_gcd_bezout_identity_verified': True,
                         'removed_physical_factors': removed,
                         'residual_gcd': str(residual),
                         'residual_degree': int(residual.degree()),
                         'unit_on_physical_open': residual.degree() == 0,
                         'status': 'completed'})
            save()
except BudgetExpired:
    receipt['budget_expired'] = True
finally:
    signal.setitimer(signal.ITIMER_PROF, 0)
    save()
print(json.dumps({'cases': [(x['type'], x['epsilon'], x['status'],
                              x.get('residual_degree')) for x in receipt['cases']],
                  'budget_expired': receipt.get('budget_expired', False),
                  'cpu_seconds': receipt['cpu_seconds'], 'receipt': str(path)}))
