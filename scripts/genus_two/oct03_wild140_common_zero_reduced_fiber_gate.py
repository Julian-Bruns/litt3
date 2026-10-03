#!/usr/bin/env -S sage -python
"""Exact small reduced-fiber test on the finite common-zero boundary."""
import json
import signal
from pathlib import Path
from sage.all import GF, PolynomialRing

signal.alarm(6)
out=Path('../litt3-computation-data/oct03_wild140_normalized_subresultants')
data=json.loads((out/'common_zero_receipt.json').read_text())
R=PolynomialRing(GF(5),names=('Q','B','S','T','Z'))
Q,B,S,T,Z=R.gens();gb=[R(p) for p in data['basis']]
Rw=PolynomialRing(R,'w');w=Rw.gen();l=3+2*Q+2*T
A=w**3+l*w**2+B*w-B*(l-T)+3*T*l**2+Q*T**3
Phi=w**5+Q*w**4+S
C=w**2+(l+T)*w+B+l*T+T**2
assert A-A(T)==(w-T)*C
M=C**2-Phi
raw_disc=R(M.resultant(M.derivative()))
disc=raw_disc.reduce(gb)
mt=R(M(T)).reduce(gb);pt=R(Phi(T)).reduce(gb)
product=(disc*mt*pt).reduce(gb)
signal.alarm(0)
receipt={'scope':'common-zero reduced F criterion ONLY',
         'residual_norm':str(M),'raw_residual_resultant':str(raw_disc),
         'resultant_normal_form':str(disc),'M_T_normal_form':str(mt),
         'Phi_T_normal_form':str(pt),'product_normal_form':str(product)}
(out/'common_zero_reduced_fiber_receipt.json').write_text(json.dumps(receipt,indent=2)+'\n')
print(json.dumps({'disc_nf':str(disc),'M_T_nf':str(mt),
                  'Phi_T_nf':str(pt),'product_nf':str(product)}))
