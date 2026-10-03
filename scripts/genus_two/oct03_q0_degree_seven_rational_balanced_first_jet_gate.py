#!/usr/bin/env -S sage -python
"""Fresh d7 rational balanced first-jet gcd gate, two orientations/twenty cubic factors/two signs.

Univariate exact xgcd only; no norm, GB or root-point search. Keep permitted
mu6/pole collisions via opposite-factor units and both own triple poles.
The unbalanced allocation is excluded conceptually and is not computed here.
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
       / 'oct03_q0_degree_seven_rational_balanced_first_jet_gate')
out.mkdir(parents=True, exist_ok=True)
path = out/'gate.json'
started = time.process_time()
receipt = {'scope': 'rational cubic-index3 degree7, one triple infinity pole, '
                    'one conjugate ordinary shared pole pair and two other poles, balanced allocation only',
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
    for zeta in (om, om**2):
        zeta_other = zeta**2
        Splus = (t-lam)*(t-zeta*lam)
        Sminus = (t+lam)*(t+zeta_other*lam)
        positive_points = [lam, zeta*lam]
        negative_points = [-lam, -zeta_other*lam]
        assert Splus == (t-positive_points[0])*(t-positive_points[1])
        assert Sminus == (t-negative_points[0])*(t-negative_points[1])
        for indices in itertools.combinations(range(6), 3):
            U = T.one(); V = T.one()
            for j, root in enumerate(roots):
                if j in indices:
                    U *= t-root
                else:
                    V *= t-root
            assert U*V == t**6-1 and U.degree() == 3 and V.degree() == 3
            Ul = R(U(lam)); U0 = R(U(0))
            for eps in (1, -1):
                case = {'zeta': str(zeta), 'U_root_indices': list(indices),
                        'U_roots': [str(roots[j]) for j in indices],
                        'epsilon': eps, 'status': 'started'}
                receipt['cases'].append(case); save()
                K = eps*lam**3-1
                A = lam
                SpA = R(Splus.derivative()(A))
                C = R(Sminus(A)*U(A))
                other_plus = positive_points[1]
                equations = [R(A*SpA*Sminus(other_plus)*U(other_plus)
                               -other_plus*Splus.derivative()(other_plus)*C)]
                equations.extend(R(C*Splus(s)*V(s)
                                   -4*A*s*nu*K**2*SpA*Sminus.derivative()(s))
                                 for s in negative_points)
                N = 4*nu*A**2*K**2*SpA**2
                opens = {'lambda': lam, 'K': K,
                         'U_positive_point1': Ul,
                         'U_positive_point2': R(U(other_plus)),
                         'V_negative_point1': R(V(negative_points[0])),
                         'V_negative_point2': R(V(negative_points[1])),
                         'own_triple_x2_infinity': N+C**2,
                         'own_triple_x1_zero': R(N*(Sminus(0)*U0)**2
                                                +C**2*Splus(0)**2)}
                physical = R.one()
                for value in opens.values():
                    assert value != 0
                    physical *= value
                raw = equations[0]
                weights = [R.one()]
                for equation in equations[1:]:
                    new_raw, left, right = raw.xgcd(equation)
                    weights = [left*w for w in weights]+[right]
                    raw = new_raw
                if raw:
                    leading = raw.leading_coefficient()
                    raw /= leading; weights = [w/leading for w in weights]
                assert sum(w*e for w,e in zip(weights,equations)) == raw
                residual, removed = strip_physical(raw, physical)
                case.update({'U': str(U), 'V': str(V),
                             'first_jet_equations': [str(x) for x in equations],
                             'physical_opens': {name: str(value) for name,value in opens.items()},
                             'physical_polynomial': str(physical),
                             'raw_gcd': str(raw), 'raw_gcd_degree': int(raw.degree()),
                             'raw_gcd_bezout_weights': [str(w) for w in weights],
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
