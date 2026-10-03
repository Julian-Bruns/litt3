#!/usr/bin/env python3
"""Fresh bounded necessary gate: rational degree-four q0-tensor quotients.

No fixed Cartier or old certificate is recalculated. Three mu6 partition
types, two parameters, exact square-coefficient substitution in char5.
The mathematical phase has a three-second alarm; raw results go outside
the research workspace. An unfinished Groebner computation proves nothing.
"""
import json
import signal
import time
from pathlib import Path
import sympy as sp

v, a, h, om, inv = sp.symbols('v a h om inv')
out = Path(__file__).resolve().parents[2].parent / 'litt3-computation-data' / 'oct03_q0_degree_four_rational_square_gate'
out.mkdir(parents=True, exist_ok=True)
receipt = {'characteristic': 5, 'omega_relation': 'omega^2+omega+1',
           'scope': 'necessary derivative-square equations only', 'cases': []}

class BudgetExpired(Exception):
    pass

def alarm_handler(signum, frame):
    raise BudgetExpired()

def red(expr):
    expr = sp.rem(sp.Poly(sp.expand(expr), om), sp.Poly(om**2+om+1, om)).as_expr()
    return sp.Poly(expr, a, h, om, modulus=5).as_expr()

def square_equations(poly):
    pp = sp.Poly(poly, v)
    ee, dd, cc, bb, ll = [red(pp.nth(i)) for i in range(5)]
    middle = red(4*ll*cc-bb**2)
    # For L!=0: Q/L=(v^2+B/(2L)*v+(4LC-B^2)/(8L^2))^2.
    return [red(8*ll**2*dd-bb*middle), red(64*ll**3*ee-middle**2)], ll

signal.signal(signal.SIGALRM, alarm_handler)
started = time.process_time()
signal.setitimer(signal.ITIMER_REAL, 3)
try:
    for label, rho in [('opposite', -1), ('order_three', om), ('order_six', -om)]:
        case = {'type': label, 'rho': str(rho)}
        receipt['cases'].append(case)
        uu = (v-1)*(v-rho)
        gg, remainder = sp.div(v**6-1, uu, v)
        remainder = red(remainder)
        assert remainder == 0
        ff = (v-a)**2*uu
        n1, n2 = sp.expand(ff-h*gg), sp.expand(ff+h*gg)
        q1 = sp.expand(v*(v-a)*sp.diff(n1,v)-(4*v-3*a)*n1)
        q2 = sp.expand((v-a)*sp.diff(n2,v)-n2)
        q1 = sum(red(sp.Poly(q1,v).nth(i))*v**i for i in range(6))
        q2 = sum(red(sp.Poly(q2,v).nth(i))*v**i for i in range(6))
        assert sp.Poly(q1,v).degree() <= 4
        assert sp.Poly(q2,v).degree() <= 4
        # Reverse Q1: its leading coefficient is Q1(0), nonzero under
        # the actual triple-pole hypotheses. This retains degree-two Q1.
        reverse_q1 = sum(sp.Poly(q1,v).nth(i)*v**(4-i) for i in range(5))
        eq1, lead1 = square_equations(reverse_q1)
        eq2, lead2 = square_equations(q2)
        open_poly = red(a*h*lead1*lead2*gg.subs(v,a))
        assert open_poly != 0
        case.update({'U': str(uu), 'G': str(gg), 'Q1': str(q1), 'Q2': str(q2),
                     'square_equations': [str(x) for x in eq1+eq2],
                     'open_polynomial': str(open_poly), 'status': 'equations_derived'})
        basis = sp.groebner(eq1+eq2+[om**2+om+1, inv*open_poly-1],
                            inv, a, h, om, modulus=5, order='grevlex')
        case.update({'basis': [str(x.as_expr()) for x in basis.polys],
                     'unit_ideal': list(basis) == [1], 'status': 'completed'})
except BudgetExpired:
    receipt['budget_expired'] = True
finally:
    signal.setitimer(signal.ITIMER_REAL, 0)
    receipt['cpu_seconds'] = time.process_time()-started
    (out/'square_gate.json').write_text(json.dumps(receipt, indent=2)+'\n')
print(json.dumps({'cases': [(x['type'], x['status'], x.get('unit_ideal')) for x in receipt['cases']],
                  'budget_expired': receipt.get('budget_expired', False),
                  'cpu_seconds': receipt['cpu_seconds'], 'receipt': str(out/'square_gate.json')}))
