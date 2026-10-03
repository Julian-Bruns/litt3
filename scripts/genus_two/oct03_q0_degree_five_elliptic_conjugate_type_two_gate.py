#!/usr/bin/env -S sage -python
"""One new exact remaining degree-five elliptic conjugate Type II gate.

Three parameters; physical opens and the v=0 degree-drop edge retained.
Mathematical budget ten CPU seconds, one worker; no earlier gate replayed.
"""
import json
import resource
import signal
import time
from pathlib import Path
from sage.all import GF,PolynomialRing

out=Path(__file__).resolve().parents[2].parent/'litt3-computation-data'/'oct03_q0_degree_five_elliptic_conjugate_type_two_gate'
out.mkdir(parents=True,exist_ok=True);path=out/'gate.json'
receipt={'characteristic':5,'scope':'remaining elliptic conjugate Type II necessary norms only',
         'backend':'Sage/libSingular','status':'started',
         'budget_method':'hard OS CPU limit plus Python ten-second alarm; receipt flushed before backend'}
class BudgetExpired(Exception):pass
def alarm_handler(signum,frame):raise BudgetExpired()
started=time.process_time()
# libSingular deferred the original Python SIGPROF exception until16.337285
# CPU seconds. The executed original is archived with that timeout receipt.
# A future explicitly authorized run must have a hard OS limit as well.
# Flooring the absolute CPU threshold leaves at most ten more CPU seconds.
hard_cpu=int(started)+10
resource.setrlimit(resource.RLIMIT_CPU,(hard_cpu,hard_cpu))
def save():
    receipt['cpu_seconds']=time.process_time()-started
    path.write_text(json.dumps(receipt,indent=2)+'\n')
signal.signal(signal.SIGPROF,alarm_handler);signal.setitimer(signal.ITIMER_PROF,10)
try:
    R=PolynomialRing(GF(5),names=('inv','v','ell','m'),order='degrevlex');inv,v,ell,m=R.gens()
    Z=PolynomialRing(R,'z');z=Z.gen();half=GF(5)(3)
    a=4*(v-1)**2;u=4*v**2+3*v+3;b=v*z+a;c=z+u;L=ell*z+m;J=z-a
    Phi=z*(L**2+z**2+z+1);p=ell**2+1;p0=m**2+1
    assert z*c**2-b**2==(z-a)**2*(z-1)
    A=c*L;B=b*L
    U=A.derivative()*z*J-A*(2*z-a)
    VV=(b.derivative()*Phi+b*Phi.derivative()*half)*z*J-b*Phi*(3*z-2*a)
    C=B.derivative()*J-B
    WW=(c.derivative()*Phi+c*Phi.derivative()*half)*J-c*Phi
    numerator=VV**2-z**2*Phi*U**2
    N1,remainder=numerator.quo_rem(z**2);assert remainder==0
    N2=WW**2-Phi*C**2
    assert N1.degree()<=8 and N1[0]==(a**2*p0)**2
    assert N2.degree()==8 and N2[8]==p**2
    reverse=sum(N1[i]*z**(8-i) for i in range(9))
    RF=R.fraction_field();ZF=PolynomialRing(RF,'z');zf=ZF.gen()
    def square_equations(Q,lead):
        q=ZF(Q);root=ZF(lead)*zf**4
        for j in range(1,5):
            coefficient=(q[8-j]-(root**2)[8-j])/(2*RF(lead))
            root+=coefficient*zf**(4-j)
        rem=q-root**2;assert rem.degree()<=3
        equations=[R(rem[i].numerator()) for i in range(4)]
        for i in range(4):
            for factor,multiplicity in R(rem[i].denominator()).factor():
                assert (R(lead)**20)%factor==0
        return equations,[str(root[i]) for i in range(5)]
    e1,r1=square_equations(reverse,a**2*p0);e2,r2=square_equations(N2,p)
    Ta=a**2+a+1;discriminant=(2*ell*m+1)**2-4*p*p0
    open_poly=(v**2-1)*p*p0*Ta*((ell*a+m)**2+Ta)*discriminant
    assert open_poly!=0
    receipt.update({'a':str(a),'b':str(b),'c':str(c),'Phi':str(Phi),
                    'N1':str(N1),'N2':str(N2),'reverse_N1':str(reverse),
                    'root1':r1,'root2':r2,'equations':[str(e) for e in e1+e2],
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
