#!/usr/bin/env -S sage -python
"""One new two-parameter calibrated degree-five necessary gate, CPU cap10s.

Both distinct shared simple infinity poles are Weierstrass. Exact actual
calibration was used before this test. No fixed arithmetic is replayed.
"""
import json
import signal
import time
from pathlib import Path
from sage.all import GF, PolynomialRing

out=Path(__file__).resolve().parents[2].parent/'litt3-computation-data'/'oct03_q0_degree_five_two_weierstrass_gate'
out.mkdir(parents=True,exist_ok=True); path=out/'gate.json'
receipt={'characteristic':5,'scope':'both distinct shared simple poles Weierstrass; necessary norms only',
         'backend':'Sage/libSingular','status':'started'}
class BudgetExpired(Exception): pass
def alarm_handler(signum,frame): raise BudgetExpired()
started=time.process_time()
def save():
    receipt['cpu_seconds']=time.process_time()-started
    path.write_text(json.dumps(receipt,indent=2)+'\n')
signal.signal(signal.SIGPROF,alarm_handler);signal.setitimer(signal.ITIMER_PROF,10)
try:
    R=PolynomialRing(GF(5),names=('inv','v','t'),order='degrevlex');inv,v,t=R.gens()
    Z=PolynomialRing(R,'z');z=Z.gen()
    s=v-1;u=v*s;b=v*z+s**2;c=z+u
    J=z**2+s**2*z+s**4;T=z**2+z+1;H=t*J+T;Psi=z*J*H;p=t+1
    assert z*c**2-b**2==(z-1)*J
    VV=2*b.derivative()*z*J*H+b*((-3*J-z*J.derivative())*H+z*J*H.derivative())
    WW=2*c.derivative()*z*J*H+c*((J-z*J.derivative())*H+z*J*H.derivative())
    N1=VV**2-4*t*u**2*Psi*J**2;N2=WW**2-4*t*v**2*Psi*J**2
    assert N1.degree()==10 and N1[10]==(v*p)**2
    assert N2.degree()==10 and N2[10]==(2*p)**2
    RF=R.fraction_field();ZF=PolynomialRing(RF,'z');zf=ZF.gen()
    def square_equations(Q,lead):
        q=ZF(Q);root=ZF(lead)*zf**5
        for j in range(1,6):
            coefficient=(q[10-j]-(root**2)[10-j])/(2*RF(lead))
            root+=coefficient*zf**(5-j)
        rem=q-root**2;assert rem.degree()<=4
        equations=[R(rem[i].numerator()) for i in range(5)]
        # Denominators are supported only at the prescribed known root.
        for i in range(5):
            for factor,multiplicity in R(rem[i].denominator()).factor():
                assert (R(lead)**20)%factor==0
        return equations,[str(root[i]) for i in range(6)]
    e1,r1=square_equations(N1,v*p);e2,r2=square_equations(N2,2*p)
    open_poly=v*s*(s**6-1)*t*p*(t*s**4+1)
    assert open_poly!=0
    receipt.update({'J':str(J),'b':str(b),'c':str(c),'Psi':str(Psi),
                    'N1':str(N1),'N2':str(N2),'root1':r1,'root2':r2,
                    'equations':[str(e) for e in e1+e2],
                    'open_polynomial':str(open_poly),'status':'equations_derived'})
    save()
    basis=R.ideal(e1+e2+[inv*open_poly-1]).groebner_basis()
    receipt.update({'basis':[str(f) for f in basis],
                    'unit_ideal':list(basis)==[R.one()],'status':'completed'})
except BudgetExpired:
    receipt['budget_expired']=True
finally:
    signal.setitimer(signal.ITIMER_PROF,0);save()
print(json.dumps({'status':receipt['status'],'unit_ideal':receipt.get('unit_ideal'),
                  'budget_expired':receipt.get('budget_expired',False),
                  'cpu_seconds':receipt['cpu_seconds'],'receipt':str(path)}))
