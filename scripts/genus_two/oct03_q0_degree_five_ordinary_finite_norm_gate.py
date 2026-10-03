#!/usr/bin/env -S sage -python
"""Fresh finite-algebra norm gate after the exact second-jet reduction.

Two quotient algebras of degrees seven/four; no GB or root-point sweep.
Retain singular shared-root auxiliary models and all degree drops, reversing
the first degree-fourteen norm at its known nonzero constant square root.
Only actual pole/leading opens are removed. Exact gcd Bezout witness saved.
Ten mathematical CPU seconds after Sage import, with hard OS backup.
"""
import json
import math
import resource
import signal
import time
from pathlib import Path
from sage.all import GF, PolynomialRing

out = (Path(__file__).resolve().parents[2].parent / 'litt3-computation-data'
       / 'oct03_q0_degree_five_ordinary_finite_norm_gate')
out.mkdir(parents=True, exist_ok=True)
path = out/'gate.json'
started = time.process_time()
receipt = {'scope': 'second-jet residual degree-five ordinary linear model '
                    'only: genus two and singular elliptic shared-root retained',
           'field': 'F25=F5[nu]/(nu^2-nu-3)', 'cases': [],
           'budget_cpu_seconds': 10}


def save():
    receipt['cpu_seconds'] = time.process_time()-started
    path.write_text(json.dumps(receipt, indent=2)+'\n')


class BudgetExpired(Exception):
    pass


def alarm_handler(signum, frame):
    raise BudgetExpired()


signal.signal(signal.SIGPROF, alarm_handler)
signal.setitimer(signal.ITIMER_PROF, 10)
cpu_limit = math.floor(started)+10
resource.setrlimit(resource.RLIMIT_CPU, (cpu_limit, cpu_limit))
save()
try:
    base = PolynomialRing(GF(5), 'n'); n = base.gen()
    K25 = GF(25, name='nu', modulus=n**2-n-3); nu = K25.gen()
    R = PolynomialRing(K25, 'v'); v = R.gen()

    for eps in (1, -1):
        case = {'epsilon': eps, 'status': 'started'}
        receipt['cases'].append(case); save()
        if eps == 1:
            residual = (v**7+3*nu*v**6+v**5+(3*nu+3)*v**4
                        +(4*nu+4)*v**2+(4*nu+1)*v+nu+4)
            ln = (nu*v**6+(4*nu+1)*v**5+(2*nu+3)*v**4
                  +(2*nu+1)*v**3+(nu+4)*v**2+(4*nu+4)*v+1)
            ld = (v**6+(2*nu+3)*v**4+4*nu*v**3+(3*nu+4)*v**2
                  +(4*nu+4)*v+2*nu+3)
        else:
            residual = v**4+(3*nu+4)*v**3+2*nu*v**2+2*v+4
            ln = 4*nu*v**3+2*nu*v**2+4*v+4
            ld = v**3+(3*nu+1)*v**2+4*nu*v+3*nu+3
        initial = residual.monic()
        assert residual.gcd(v*(v-1)*(v**2-v+1)*(-eps*(v-1)**3-1)*ld).degree() == 0
        removed = []
        case.update({'initial_second_jet_residual': str(initial),
                     'lambda_numerator': str(ln), 'lambda_denominator': str(ld)})
        save()

        def model(modulus):
            AA = R.quotient(modulus, names=('vv',)); vv = AA.gen()
            ss = vv-1; dd = vv**2-vv+1; kk = -eps*ss**3-1
            lam = AA(ln)*AA(ld).inverse_of_unit()
            ZZ = PolynomialRing(AA, 'z'); z = ZZ.gen()
            jj = z**2+ss**2*z+ss**4
            bb = vv*z+ss**2; cc = z+vv*ss
            hh = ((2*vv-1)*z+ss**2*(vv-2))*dd.inverse_of_unit()
            ell = lam*jj+kk*hh
            psi = z*(nu*ell**2+(z**2+z+1)*jj)
            return AA, ZZ, z, jj, bb, cc, ell, psi

        # Do NOT impose a discriminant open: Psi=h^2 Phi is the retained
        # elliptic shared-root case. Only its actual infinity and zero
        # branch coefficients must be nonzero.
        while residual.degree() > 0:
            AA, ZZ, z, J, b, c, ell, Psi = model(residual)
            physical_factor = residual.gcd(R(Psi[5].lift())*R(Psi[1].lift()))
            if physical_factor.degree() == 0:
                break
            physical_factor = physical_factor.monic()
            removed.append(str(physical_factor))
            residual = (residual//physical_factor).monic()
        if residual.degree() == 0:
            case.update({'removed_leading_or_simple_zero_factors': removed,
                         'residual_after_physical_opens': str(residual),
                         'unit_after_norms': True, 'status': 'completed',
                         'reason': 'all second-jet roots violate actual leading/simple-zero opens'})
            save(); continue

        AA, ZZ, z, J, b, c, ell, Psi = model(residual)
        A = c*ell; B = b*ell
        U = A.derivative()*z*J-A*(J+z*J.derivative())
        V = (b.derivative()*Psi+b*Psi.derivative()/2)*z*J-b*Psi*(2*J+z*J.derivative())
        C = B.derivative()*J-B*J.derivative()
        W = (c.derivative()*Psi+c*Psi.derivative()/2)*J-c*Psi*J.derivative()
        numerator = V**2-nu*z**2*Psi*U**2
        N1, rem = numerator.quo_rem(z**2)
        assert rem == 0
        N2 = W**2-nu*Psi*C**2
        assert N1.degree() <= 14 and N2.degree() == 14
        reverse1 = sum(N1[i]*z**(14-i) for i in range(15))
        root1 = b[0]*Psi[1]*J[0]
        root2 = Psi[5]

        def square_constraints(poly, lead):
            inverse = (2*lead).inverse_of_unit()
            assert poly[14] == lead**2
            root = ZZ(lead)*z**7
            for j in range(1, 8):
                degree = 14-j
                root += (poly[degree]-(root**2)[degree])*inverse*z**(7-j)
            remainder = poly-root**2
            assert remainder.degree() <= 6
            return [R(remainder[i].lift()) for i in range(7)], root

        equations1, square1 = square_constraints(reverse1, root1)
        equations2, square2 = square_constraints(N2, root2)
        equations = equations1+equations2
        raw = residual
        weights = [R.one()]
        for value in equations:
            new, left, right = raw.xgcd(value)
            weights = [left*weight for weight in weights]+[right]
            raw = new
        normalization = raw.leading_coefficient()
        raw /= normalization
        weights = [weight/normalization for weight in weights]
        assert weights[0]*residual+sum(weight*value for weight, value in zip(weights[1:], equations)) == raw
        case.update({'removed_leading_or_simple_zero_factors': removed,
                     'residual_after_physical_opens': str(residual),
                     'coefficient_algebra_degree': int(residual.degree()),
                     'J': str(J), 'b': str(b), 'c': str(c),
                     'ell': str(ell), 'Psi': str(Psi),
                     'norm1_degree': int(N1.degree()), 'norm2_degree': int(N2.degree()),
                     'norm1': str(N1), 'norm2': str(N2),
                     'reverse_norm1_candidate': str(square1),
                     'norm2_candidate': str(square2),
                     'norm_residual_coefficients': [str(x) for x in equations],
                     'gcd_with_second_jet_residual': str(raw),
                     'gcd_degree': int(raw.degree()),
                     'bezout_weights_including_residual': [str(x) for x in weights],
                     'bezout_identity_verified': True,
                     'unit_after_norms': raw.degree() == 0,
                     'status': 'completed'})
        save()
except BudgetExpired:
    receipt['budget_expired'] = True
finally:
    signal.setitimer(signal.ITIMER_PROF, 0)
    save()
print(json.dumps({'cases': [(x['epsilon'], x['status'], x.get('gcd_degree'),
                              x.get('unit_after_norms')) for x in receipt['cases']],
                  'cpu_seconds': receipt['cpu_seconds'],
                  'budget_expired': receipt.get('budget_expired', False), 'receipt': str(path)}))
