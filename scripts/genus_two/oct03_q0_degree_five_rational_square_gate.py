#!/usr/bin/env python3
"""One fresh bounded necessary gate for rational degree-five q0 quotients.

Four complete mu6 partition types. This tests only ramification-square
conditions, not the fixed P cube or actual common-cover existence. Imports
are outside the ten CPU-second mathematical budget. All output is external.
"""
import json
import signal
import time
from pathlib import Path
import sympy as sp

v, a, b, h, om, inv = sp.symbols('v a b h om inv')
out = Path(__file__).resolve().parents[2].parent / 'litt3-computation-data' / 'oct03_q0_degree_five_rational_square_gate'
out.mkdir(parents=True, exist_ok=True)
receipt = {'characteristic': 5, 'omega_relation': 'omega^2+omega+1',
           'scope': 'necessary derivative-square equations only', 'cases': []}

class BudgetExpired(Exception):
    pass

def alarm_handler(signum, frame):
    raise BudgetExpired()

def red(expr):
    expr = sp.rem(sp.Poly(sp.expand(expr), om), sp.Poly(om**2+om+1, om)).as_expr()
    return sp.Poly(expr, a, b, h, om, modulus=5).as_expr()

def v_red(expr):
    pp = sp.Poly(sp.expand(expr), v)
    if pp.is_zero:
        return sp.Integer(0)
    return sum(red(pp.nth(i))*v**i for i in range(pp.degree()+1))

def square_equations(poly):
    pp = sp.Poly(poly, v)
    gg, ff, ee, dd, cc, bb, ll = [red(pp.nth(i)) for i in range(7)]
    cn = red(4*ll*cc-bb**2)
    dn = red(8*ll**2*dd-bb*cn)
    # Q/L=(v^3+B/(2L)*v^2+cn/(8L^2)*v+dn/(16L^3))^2.
    return [red(64*ll**3*ee-cn**2-4*bb*dn),
            red(64*ll**4*ff-cn*dn), red(256*ll**5*gg-dn**2)], ll

signal.signal(signal.SIGPROF, alarm_handler)
started = time.process_time()
signal.setitimer(signal.ITIMER_PROF, 10)
try:
    roots = [1, -om, om**2, -1, om, -om**2]
    types = [('opposite_alternating', [0, 2, 4]),
             ('opposite_consecutive', [0, 1, 2]),
             ('opposite_mixed', [0, 1, 3]), ('same_factor', None)]
    den = (v-a)*(v-b)
    for label, indices in types:
        case = {'type': label, 'status': 'started'}
        receipt['cases'].append(case)
        if indices is None:
            uu = v-1
            vv = sum(v**i for i in range(6))
            ff, gg = den**2*uu, vv
            opposite_open = vv.subs(v,a)*vv.subs(v,b)
        else:
            uu = v_red(sp.prod(v-roots[i] for i in indices))
            vv = v_red(sp.prod(v-roots[i] for i in range(6) if i not in indices))
            ff, gg = (v-a)**2*uu, (v-b)**2*vv
            opposite_open = vv.subs(v,a)*uu.subs(v,b)
        assert v_red(uu*vv-(v**6-1)) == 0
        n1, n2 = v_red(ff-h*gg), v_red(ff+h*gg)
        q1 = v_red(v*den*sp.diff(n1,v)-(3*den+v*sp.diff(den,v))*n1)
        q2 = v_red(den*sp.diff(n2,v)-sp.diff(den,v)*n2)
        assert sp.Poly(q1,v).degree() <= 6
        assert sp.Poly(q2,v).degree() <= 6
        # Reverse Q1: its leading coefficient Q1(0) is nonzero at
        # the actual triple pole. This retains its possible degree-four edge.
        reverse_q1 = sum(sp.Poly(q1,v).nth(i)*v**(6-i) for i in range(7))
        eq1, lead1 = square_equations(reverse_q1)
        eq2, lead2 = square_equations(q2)
        open_poly = red(a*b*(a-b)*h*lead1*lead2*opposite_open)
        assert open_poly != 0
        case.update({'U': str(uu), 'V': str(vv), 'Q1': str(q1), 'Q2': str(q2),
                     'square_equations': [str(x) for x in eq1+eq2],
                     'open_polynomial': str(open_poly), 'status': 'equations_derived'})
        basis = sp.groebner(eq1+eq2+[om**2+om+1, inv*open_poly-1],
                            inv, a, b, h, om, modulus=5, order='grevlex')
        case.update({'basis': [str(x.as_expr()) for x in basis.polys],
                     'unit_ideal': list(basis) == [1], 'status': 'completed'})
except BudgetExpired:
    receipt['budget_expired'] = True
finally:
    signal.setitimer(signal.ITIMER_PROF, 0)
    receipt['cpu_seconds'] = time.process_time()-started
    (out/'square_gate.json').write_text(json.dumps(receipt, indent=2)+'\n')
print(json.dumps({'cases': [(x['type'], x['status'], x.get('unit_ideal')) for x in receipt['cases']],
                  'budget_expired': receipt.get('budget_expired', False),
                  'cpu_seconds': receipt['cpu_seconds'], 'receipt': str(out/'square_gate.json')}))
