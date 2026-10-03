#!/usr/bin/env -S sage -python
"""Exact low-even-part ODE coefficients; no enumeration or solving."""
import json
from pathlib import Path
from sage.all import GF, PolynomialRing

R=PolynomialRing(GF(5),names=('q','lam','s','u','v','b'))
q,lam,s,u,v,b=R.gens();Rw=PolynomialRing(R,'w');w=Rw.gen()
Phi=w**5+q*w**4+lam*w+s;A=u*w+v;B=w-b
V=Phi+Phi.derivative()*B/2
C=q*(2*w**2+b*w+b**2)
odd=B*C-V.derivative()
even=A*C-Phi.derivative()*u/2
assert odd==-q*b**3-4*lam
assert even[2]==q*(u*b+2*v)
assert even[1]==q*(u*b**2+v*b)
assert even[0]==q*v*b**2-3*lam*u
assert even[3]==0
assert R(even[1]).subs({v:2*u*b})==3*q*u*b**2
out=Path('../litt3-computation-data/oct03_wild140_fixed_origin_cubic_cartier')
out.mkdir(parents=True,exist_ok=True)
receipt={'scope':'necessary low-even-part ODE coefficient identities',
         'odd_residual':str(odd),'even_residual':str(even),
         'checks':{'exact_odd_and_even_coefficients':True},
         'implications':'q!=0: q*b^3=lam, v=2*u*b, 3*q*u*b^2=0'}
(out/'low_even_part_ode_receipt.json').write_text(json.dumps(receipt,indent=2)+'\n')
print('Exact low-even-part ODE coefficients PASS.')
