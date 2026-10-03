#!/usr/bin/env -S sage -python
"""Fresh unresolved-only GF25 backend gate; alternating type is not replayed.

Mathematical budget ten CPU seconds, one worker. Source derives exactly the
same necessary equations using a coefficient field instead of omega as a
fifth polynomial variable. Receipts are flushed before each backend call.
"""
import json
import signal
import time
from pathlib import Path
from sage.all import GF, PolynomialRing

out = Path(__file__).resolve().parents[2].parent / 'litt3-computation-data' / 'oct03_q0_degree_five_rational_square_gate'
out.mkdir(parents=True, exist_ok=True)
path = out/'unresolved_gf25_gate.json'
receipt = {'characteristic': 5, 'omega_relation': 'omega^2+omega+1',
           'scope': 'three previously unresolved necessary partition ideals only',
           'backend': 'Sage/libSingular', 'cases': []}

class BudgetExpired(Exception):
    pass

def alarm_handler(signum, frame):
    raise BudgetExpired()

started = time.process_time()
def save():
    receipt['cpu_seconds'] = time.process_time()-started
    path.write_text(json.dumps(receipt, indent=2)+'\n')

signal.signal(signal.SIGPROF, alarm_handler)
signal.setitimer(signal.ITIMER_PROF, 10)
try:
    base = PolynomialRing(GF(5), 'o'); o = base.gen()
    K = GF(25, name='omega', modulus=o**2+o+1); om = K.gen()
    R = PolynomialRing(K, names=('inv','a','b','h'), order='degrevlex')
    inv,a,b,h = R.gens()
    V = PolynomialRing(R,'v'); v = V.gen()
    roots = [1,-om,om**2,-1,om,-om**2]
    den = (v-a)*(v-b)
    def square_equations(poly):
        gg,ff,ee,dd,cc,bb,ll = [R(poly[i]) for i in range(7)]
        cn=4*ll*cc-bb**2; dn=8*ll**2*dd-bb*cn
        return [64*ll**3*ee-cn**2-4*bb*dn,
                64*ll**4*ff-cn*dn,256*ll**5*gg-dn**2],ll
    for label, indices in [('opposite_consecutive',[0,1,2]),
                           ('opposite_mixed',[0,1,3]),('same_factor',None)]:
        case={'type':label,'status':'started'}; receipt['cases'].append(case); save()
        if indices is None:
            uu=v-1; vv=sum(v**i for i in range(6))
            ff=den**2*uu; gg=vv
            opposite_open=vv(a)*vv(b)
        else:
            uu=V.one();vv=V.one()
            for i in range(6):
                if i in indices: uu*=v-roots[i]
                else: vv*=v-roots[i]
            ff=(v-a)**2*uu;gg=(v-b)**2*vv
            opposite_open=vv(a)*uu(b)
        assert uu*vv==v**6-1
        n1=ff-h*gg;n2=ff+h*gg
        q1=v*den*n1.derivative()-(3*den+v*den.derivative())*n1
        q2=den*n2.derivative()-den.derivative()*n2
        assert q1.degree()<=6 and q2.degree()<=6
        reverse_q1=sum(q1[i]*v**(6-i) for i in range(7))
        eq1,lead1=square_equations(reverse_q1);eq2,lead2=square_equations(q2)
        open_poly=a*b*(a-b)*h*lead1*lead2*opposite_open
        assert open_poly!=0
        equations=eq1+eq2
        case.update({'U':str(uu),'V':str(vv),'Q1':str(q1),'Q2':str(q2),
                     'square_equations':[str(e) for e in equations],
                     'open_polynomial':str(open_poly),'status':'equations_derived'})
        save()
        basis=R.ideal(equations+[inv*open_poly-1]).groebner_basis()
        case.update({'basis':[str(p) for p in basis],
                     'unit_ideal':list(basis)==[R.one()],'status':'completed'})
        save()
except BudgetExpired:
    receipt['budget_expired']=True
finally:
    signal.setitimer(signal.ITIMER_PROF,0);save()
print(json.dumps({'cases':[(c['type'],c['status'],c.get('unit_ideal')) for c in receipt['cases']],
                  'budget_expired':receipt.get('budget_expired',False),
                  'cpu_seconds':receipt['cpu_seconds'],'receipt':str(path)}))
