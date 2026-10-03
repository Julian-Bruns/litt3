#!/usr/bin/env -S sage -python
"""Small common-zero boundary probe after the universal norm resultant gate."""
import json
import signal
from pathlib import Path
from sage.all import GF, PolynomialRing

signal.alarm(6)
R=PolynomialRing(GF(5),names=('Q','B','S','T','Z'))
Q,B,S,T,Z=R.gens();Rw=PolynomialRing(R,'w');w=Rw.gen()
l=3+2*Q+2*T
A=w**3+l*w**2+B*w-B*(l-T)+3*T*l**2+Q*T**3
Phi=w**5+Q*w**4+S
H=(A**3+3*A*Phi*(w-T)**2)*Phi**2
I=R.ideal([R(H[j]) for j in (14,9,4)]+[Z*Q*S*T-1,R(A(T))])
gb=I.groebner_basis()
N=A**2-Phi*(w-T)**2
quot,rem=N.quo_rem((w-T)**2)
# The remainder vanishes only modulo A(T); do not divide before reduction.
coeffs=[R(p).reduce(gb) for p in N.list()]
reducedN=Rw(coeffs)
quot,rem=reducedN.quo_rem((w-T)**2)
rem=[R(p).reduce(gb) for p in rem.list()]
signal.alarm(0)
receipt={'scope':'common-zero boundary exploratory GB only',
         'dimension':int(I.dimension()),
         'basis':[str(p) for p in gb],
         'max_degree':max(int(p.total_degree()) for p in gb),
         'reduced_norm_quotient':[str(p) for p in quot.list()],
         'division_remainder_nf':[str(p) for p in rem]}
out=Path('../litt3-computation-data/oct03_wild140_normalized_subresultants')
(out/'common_zero_receipt.json').write_text(json.dumps(receipt,indent=2)+'\n')
print(json.dumps({'dimension':receipt['dimension'],'basis_size':len(gb),
                  'max_degree':receipt['max_degree']}))
