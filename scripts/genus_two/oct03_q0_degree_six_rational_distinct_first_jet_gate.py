#!/usr/bin/env -S sage -python
"""Fresh d6 rational DISTINCT-Q first-jet gcd gate, fifteen factors/two signs.

Univariate exact xgcd only; no norm, GB or root-point search. Keep permitted
mu6/pole collisions via opposite-factor units and both own triple poles.
The conjugate-pair rational configuration is NOT covered by this source.
Ten mathematical CPU seconds after Sage import, with hard OS guard.
"""
import itertools
import json
import math
import resource
import signal
import time
from pathlib import Path
from sage.all import GF, PolynomialRing

out = (Path(__file__).resolve().parents[2].parent / 'litt3-computation-data'
       / 'oct03_q0_degree_six_rational_distinct_first_jet_gate')
out.mkdir(parents=True, exist_ok=True)
path = out/'gate.json'
started = time.process_time()
receipt = {'scope': 'rational cubic-index3 degree6, one triple infinity pole, '
                    'three DISTINCT ordinary shared simple z-coordinates only',
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
    om = 1+2*nu
    assert om**2+om+1 == 0 and om != 1
    R = PolynomialRing(K25, 'lam'); lam = R.gen()
    T = PolynomialRing(R, 't'); t = T.gen()
    roots = [K25(1), -K25(1), om, -om, om**2, -om**2]
    Splus = t-lam; Sminus = t**2-lam*t+lam**2
    negative_points = [-om*lam, -om**2*lam]
    assert Sminus == (t-negative_points[0])*(t-negative_points[1])
    for indices in itertools.combinations(range(6), 2):
        U = T.one(); V = T.one()
        for j, root in enumerate(roots):
            if j in indices:
                U *= t-root
            else:
                V *= t-root
        assert U*V == t**6-1 and U.degree() == 2 and V.degree() == 4
        Ul = R(U(lam)); U0 = R(U(0))
        for eps in (1, -1):
            case = {'U_root_indices': list(indices), 'U_roots': [str(roots[j]) for j in indices],
                    'epsilon': eps, 'status': 'started'}
            receipt['cases'].append(case); save()
            K = eps*lam**3-1
            equations = [R(lam*Ul*(s-lam)*V(s)-4*nu*K**2*s*Sminus.derivative()(s))
                         for s in negative_points]
            opens = {'lambda': lam, 'K': K, 'U_lambda': Ul,
                     'V_negative_point1': R(V(negative_points[0])),
                     'V_negative_point2': R(V(negative_points[1])),
                     'own_triple_x2_infinity': 4*nu*K**2+lam**2*Ul**2,
                     'own_triple_x1_zero': 4*nu*K**2*U0**2+Ul**2}
            physical = R.one()
            for value in opens.values():
                assert value != 0
                physical *= value
            raw, left, right = equations[0].xgcd(equations[1])
            if raw:
                leading = raw.leading_coefficient()
                raw /= leading; left /= leading; right /= leading
            assert left*equations[0]+right*equations[1] == raw
            residual, removed = strip_physical(raw, physical)
            case.update({'U': str(U), 'V': str(V),
                         'first_jet_equations': [str(x) for x in equations],
                         'physical_opens': {name: str(value) for name, value in opens.items()},
                         'physical_polynomial': str(physical),
                         'raw_gcd': str(raw), 'raw_gcd_degree': int(raw.degree()),
                         'raw_gcd_bezout_weights': [str(left), str(right)],
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
print(json.dumps({'case_count': len(receipt['cases']),
                  'completed_case_count': sum(x['status'] == 'completed' for x in receipt['cases']),
                  'residual_degrees': [x.get('residual_degree') for x in receipt['cases']],
                  'cpu_seconds': receipt['cpu_seconds'],
                  'budget_expired': receipt.get('budget_expired', False), 'receipt': str(path)}))
