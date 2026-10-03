#!/usr/bin/env -S sage -python
"""One new d6 necessary second-jet gate in four univariate models.

Only quotient reduction in F25(rho)[z]/(z^3-rho^2) and univariate gcds.
No norm gate, GB, root-point sweep or completed-input replay. All inverted
terms are checked against genuine ordinary-pole opens. Ten mathematical
CPU seconds after Sage import, with hard OS guard.
"""
import json
import math
import resource
import signal
import time
from pathlib import Path
from sage.all import GF, PolynomialRing

out = (Path(__file__).resolve().parents[2].parent / 'litt3-computation-data'
       / 'oct03_q0_degree_six_quintic_second_jet_gate')
out.mkdir(parents=True, exist_ok=True)
path = out/'gate.json'
started = time.process_time()
receipt = {'scope': 'degree-six one-triple-infinity, three distinct ordinary '
                    'poles, quintic/auxiliary quintic model; second jet only',
           'field': 'F25=F5[nu]/(nu^2-nu-3)', 'cases': [],
           'budget_cpu_seconds': 10}


def save():
    receipt['cpu_seconds'] = time.process_time()-started
    path.write_text(json.dumps(receipt, indent=2)+'\n')


class BudgetExpired(Exception):
    pass


def alarm_handler(signum, frame):
    raise BudgetExpired()


def strip_physical(poly, physical):
    poly = poly.monic() if poly else poly
    removed = []
    while poly and poly.degree() > 0:
        common = poly.gcd(physical)
        if common.degree() == 0:
            break
        common = common.monic()
        removed.append(str(common))
        poly = (poly//common).monic()
    return poly, removed


signal.signal(signal.SIGPROF, alarm_handler)
signal.setitimer(signal.ITIMER_PROF, 10)
cpu_limit = math.floor(started)+10
resource.setrlimit(resource.RLIMIT_CPU, (cpu_limit, cpu_limit))
save()
try:
    base = PolynomialRing(GF(5), 'n'); n = base.gen()
    K25 = GF(25, name='nu', modulus=n**2-n-3); nu = K25.gen()
    R = PolynomialRing(K25, 'rho'); rho_poly = R.gen()
    F = R.fraction_field(); rho = F(rho_poly)
    Z = PolynomialRing(F, 'z'); z = Z.gen()
    for sigma in (1, -1):
        kk = K25(1) if sigma == 1 else 4*nu+3
        assert kk**2 == 2*sigma-1
        for eps in (1, -1):
            case = {'sigma': sigma, 'k': str(kk), 'epsilon': eps, 'status': 'started'}
            receipt['cases'].append(case); save()
            K = eps*rho-1
            J = z**3-rho**2
            c = z**2+sigma*z+rho*kk
            b = kk*z**2+rho*z+rho*sigma
            ell = (3*rho*K*z*c.inverse_mod(J)) % J
            zi = z.inverse_mod(J)
            li = ell.inverse_mod(J)
            assert z*b-rho*c == kk*J
            assert z**2*c-rho*b == (z+sigma)*J
            assert z*c**2-b**2 == J*(z**2+z+1)
            assert ((ell*c-3*rho*K*z) % J) == 0
            assert ((ell*b-3*K*rho**2) % J) == 0
            C = c*zi/rho
            D = -kk*zi**2-1/(2*rho)+sigma*zi/rho
            E = (z+sigma)*(z-1)*J.derivative()/(2*rho)
            expression = (C*ell.derivative()+D*ell+E*li/nu
                          +3*(1-rho**2)*zi/(2*K)) % J
            equations = [expression[i] for i in range(3)]
            opens = {'rho': rho, 'K': K, 'norm_c_mod_J': c.resultant(J),
                     'norm_ell_mod_J': ell.resultant(J)}
            physical = R.one()
            for value in opens.values():
                assert value != 0
                physical *= R(value.numerator())*R(value.denominator())
            physical = physical.monic()
            for value in equations:
                remainder, _ = strip_physical(R(value.denominator()), physical)
                assert remainder.degree() == 0
            nums = [R(value.numerator()) for value in equations]
            raw = R.zero(); weights = []
            for value in nums:
                new, left, right = raw.xgcd(value)
                weights = [left*weight for weight in weights]+[right]
                raw = new
            if raw:
                leading = raw.leading_coefficient()
                raw /= leading; weights = [weight/leading for weight in weights]
            assert sum(weight*value for weight, value in zip(weights, nums)) == raw
            residual, removed = strip_physical(raw, physical)
            case.update({'J': str(J), 'b': str(b), 'c': str(c), 'ell': str(ell),
                         'second_jet_remainder': str(expression),
                         'second_jet_numerators': [str(x) for x in nums],
                         'physical_opens': {name: str(value) for name, value in opens.items()},
                         'physical_polynomial': str(physical),
                         'raw_gcd': str(raw), 'raw_gcd_degree': int(raw.degree()),
                         'raw_gcd_bezout_weights': [str(x) for x in weights],
                         'bezout_identity_verified': True,
                         'removed_physical_factors': removed,
                         'residual_gcd': str(residual),
                         'residual_degree': int(residual.degree()),
                         'unit_on_physical_open': bool(raw) and residual.degree() == 0,
                         'status': 'completed'})
            save()
except BudgetExpired:
    receipt['budget_expired'] = True
finally:
    signal.setitimer(signal.ITIMER_PROF, 0)
    save()
print(json.dumps({'cases': [(x['sigma'], x['epsilon'], x['status'],
                              x.get('residual_degree')) for x in receipt['cases']],
                  'cpu_seconds': receipt['cpu_seconds'],
                  'budget_expired': receipt.get('budget_expired', False), 'receipt': str(path)}))
