#!/usr/bin/env -S sage -python
"""Exact low-degree ODE reduction and fixed-origin primitive identities."""
import json
import signal
from pathlib import Path
from sage.all import GF, PolynomialRing

signal.alarm(6)
R=PolynomialRing(GF(5),names=('Q','B','L','T'))
Q,B,L,T=R.gens();Rw=PolynomialRing(R,'w');w=Rw.gen()
l=3+2*Q+2*T
A=w**3+l*w**2+B*w-B*(l-T)+3*T*l**2+Q*T**3-L
Phi=w**5+Q*w**4+L*w+Q*L;bb=w-T
V=Phi+Phi.derivative()*bb/2
c2=2*Q-1;c1=(Q-1)*T-l;c0=T*c1-B
C=c2*w**2+c1*w+c0
odd=bb*C+A-V.derivative()
assert odd.degree()<=0
even=A*C+Phi*bb-Phi*A.derivative(2)-Phi.derivative()*A.derivative()/2
assert even[5]==2*(Q-1)
assert R(even[4]).subs({Q:R(1)})==2*T
assert R(even[3]).subs({Q:R(1),T:R(0)})==3*B
subs={Q:R(1),T:R(0),B:R(0)}
assert all(R(p).subs(subs)==0 for p in odd.list()+even.list())
H=(A**3+3*A*Phi*bb**2)*Phi**2
assert all(R(H[j]).subs(subs)==0 for j in (19,14,9,4))

P=w**5+w**4+L*w+L;A0=w**3-L
U=4*w**9+3*w**8+4*L*w**4+4*L**2*w**2
J=3*w**6+4*L*w**3+3*L**2
assert U.derivative()==3*A0**2*w+P*w**3
assert P*J.derivative()+P.derivative()*J/2==A0**3+3*A0*P*w**2
N=A0**2-P*w**2
D=w**5+2*L*w+L
packet=2*D**2+3*(w**10+L*w**5+L**2)
assert (w*U+(L-w**3)*J-w*packet).quo_rem(N)[1]==0
disc=R(N.resultant(N.derivative()))
assert disc!=0
signal.alarm(0)
receipt={'scope':'necessary reduced-F fixed-origin ODE identities, no exclusion',
         'odd_residual':str(odd),'even_residual':str(even),
         'forced_coefficients':['2*(Q-1)','2*T after Q=1','3*B after Q=1,T=0'],
         'primitive_even':str(U),'primitive_odd':str(J),
         'norm':str(N),'norm_resultant':str(disc),
         'D_on_norm':str(D),'G0_on_norm_packet':str(packet),
         'checks':{'ODE_high_coefficients':True,'all_ODE_residuals':True,
                   'all_Cartier_rows':True,'primitive_identity':True,
                   'norm_packet_identity':True,'generic_norm_squarefree':True}}
out=Path('../litt3-computation-data/oct03_wild140_fixed_origin_cubic_cartier')
out.mkdir(parents=True,exist_ok=True)
(out/'ode_identity_receipt.json').write_text(json.dumps(receipt,indent=2)+'\n')
print(json.dumps({'checks':receipt['checks'],'norm_resultant':str(disc)}))
