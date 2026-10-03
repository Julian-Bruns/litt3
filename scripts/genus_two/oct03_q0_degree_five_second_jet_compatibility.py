#!/usr/bin/env -S sage -python
"""One fresh two-pole second-jet compatibility in F25(v), both signs.

No norm replay, Groebner basis or candidate sweep. Every inverted term is
recorded as a physical pole open. Ten mathematical CPU seconds after Sage
import, with a hard OS guard. Preserve finite residual factors explicitly.
"""
import json
import math
import resource
import signal
import time
from pathlib import Path
from sage.all import GF, PolynomialRing

out = (Path(__file__).resolve().parents[2].parent / 'litt3-computation-data'
       / 'oct03_q0_degree_five_second_jet_compatibility')
out.mkdir(parents=True, exist_ok=True)
path = out/'compatibility.json'
started = time.process_time()
receipt = {'scope': 'ordinary degree-five linear-numerator model, second-jet '
                    'compatibility only; genus two or singular elliptic companion',
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
    om = 1+2*nu
    assert om**2+om+1 == 0 and om != 1
    R = PolynomialRing(K25, 'v'); v = R.gen()
    F = R.fraction_field(); vv = F(v)
    s = vv-1; Delta = vv**2-vv+1; rho = -s**3
    hprime = (2*vv-1)/Delta
    for eps in (1, -1):
        case = {'epsilon': eps, 'status': 'started'}
        receipt['cases'].append(case); save()
        kk = eps*rho-1
        physical_values = {'v': vv, 's': s, 'Delta': Delta, 'K': kk}
        lambdas = []
        rows = []
        for label, om_a in (('a', om), ('d', om**2)):
            a = om_a*s**2
            alpha = rho/a
            h = ((2*vv-1)*a+s**2*(vv-2))/Delta
            jp = 2*a+s**2
            C = (vv+(a+s)/alpha)/a
            D = (-vv+2*alpha+s/alpha)/a**2
            E = (a+s)*(a**2+a+1)*jp/(2*rho)
            rhs = -3*(1-rho**2)/(2*a*kk)
            lam = (rhs-C*kk*hprime-D*kk*h-E/(nu*kk*h))/(C*jp)
            assert alpha**2 == a
            assert h*(a+vv*s) == a**2*jp/rho
            assert C*(lam*jp+kk*hprime)+D*kk*h+E/(nu*kk*h) == rhs
            physical_values.update({label+'_h': h, label+'_C': C,
                                    label+'_Jprime': jp})
            rows.append({'point': label, 'a': str(a), 'alpha': str(alpha),
                         'H_value': str(h), 'C': str(C), 'D': str(D),
                         'E': str(E), 'rhs': str(rhs), 'lambda': str(lam)})
            lambdas.append(lam)
        difference = lambdas[0]-lambdas[1]
        physical = R.one()
        for value in physical_values.values():
            assert value != 0
            physical *= R(value.numerator())*R(value.denominator())
        physical = physical.monic()
        removed = []
        if difference:
            residual = R(difference.numerator()).monic()
            raw = residual
            while residual.degree() > 0:
                common = residual.gcd(physical)
                if common.degree() == 0:
                    break
                common = common.monic()
                removed.append(str(common))
                residual = (residual//common).monic()
            denominator = R(difference.denominator())
            den_rem = denominator.monic()
            while den_rem.degree() > 0:
                common = den_rem.gcd(physical)
                assert common.degree() > 0, 'nonphysical cleared denominator'
                den_rem = (den_rem//common).monic()
        else:
            raw = residual = R.zero()
        case.update({'pole_formulas': rows,
                     'lambda_difference': str(difference),
                     'raw_compatibility_numerator': str(raw),
                     'physical_opens': {name: str(x) for name, x in physical_values.items()},
                     'physical_polynomial': str(physical),
                     'removed_physical_factors': removed,
                     'residual_compatibility': str(residual),
                     'residual_degree': int(residual.degree()),
                     'compatibility_identically_zero': not bool(difference),
                     'unit_on_physical_open': bool(difference) and residual.degree() == 0,
                     'status': 'completed'})
        save()
except BudgetExpired:
    receipt['budget_expired'] = True
finally:
    signal.setitimer(signal.ITIMER_PROF, 0)
    save()
print(json.dumps({'cases': [(x['epsilon'], x['status'], x.get('residual_degree'),
                              x.get('compatibility_identically_zero')) for x in receipt['cases']],
                  'cpu_seconds': receipt['cpu_seconds'],
                  'budget_expired': receipt.get('budget_expired', False), 'receipt': str(path)}))
