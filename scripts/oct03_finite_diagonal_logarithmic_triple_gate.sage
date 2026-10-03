"""PREPARED ONLY: one new exact logarithmic triple-root gate.

No run is authorized yet. Inspect source and necessity note first; any
approved run must have one thread and a hard external process-group
timeout, fresh evidence, no sampling or subsequent replay.

At a surviving actual finite uniform-wild ordinary diagonal, put
A=X1,B=X2,eps=z^3-1. The original q/theta comparisons with kappa^3=1
give eps'/eps=G(A)+O(eps), G=4*p'/p+A/q+1/A. The different tower gives
ord(eps'/eps)>=3 for EVERY e5(delta>=8) or e10(delta>=13), including
larger breaks and wild Q/z strata. Thus at the ordinary A-value the
numerator L=4*A*q*p'+(2*A^2+d0)*p has a root of multiplicity>=3.
This process checks gcd(L,L',HasseD2(L)) and emits an exact three-term
Bezout identity if it is one. A nonconstant factor is unresolved.
"""
from sage.all import *
import json,time
started=time.monotonic()
k=GF(25,name='beta',modulus=GF(5)['b'].gen()**2-GF(5)['b'].gen()-3)
beta=k.gen()
def elt(n): return k(n%5)+k(n//5)*beta
def code(a):
    v=a.polynomial().list()
    return int(v[0] if v else 0)+5*int(v[1] if len(v)>1 else 0)
def codes(poly): return [code(c) for c in poly.list()]
def emit(obj):
    obj['elapsed_seconds']=time.monotonic()-started
    print(json.dumps(obj),flush=True)
R=PolynomialRing(k,'A');A=R.gen()
P=sum(elt(n)*A**i for i,n in enumerate([11,22,18,5,19,20,15,16,9,22,1]))
p=P(A-1);d0=elt(23);q=A**2+d0
L=4*A*q*p.derivative()+(2*A**2+d0)*p
Lp=L.derivative()
H2=sum(k(binomial(i,2))*L[i]*A**(i-2) for i in range(2,L.degree()+1))
assert L.degree()==12 and Lp.degree()==11 and H2.degree()==10
emit({'event':'logarithmic_triple_gate_initialized',
      'field':'F25,beta^2=beta+3; a+5b encoding',
      'p_coefficients':codes(p),'q_coefficients':codes(q),
      'L_coefficients':codes(L),'L_derivative_coefficients':codes(Lp),
      'Hasse_D2_coefficients':codes(H2),
      'scope':'actual finite uniform wild e5/e10; ordinary p/q/A units, s1 and x-diagonal, original phase kappa^3=1',
      'retained_outside_scope':['nonuniform simple fold','points outside the audited finite classification','actual source existence']})
g01,a,b=L.xgcd(Lp)
assert a*L+b*Lp==g01
emit({'event':'first_exact_gcd_checkpoint','gcd_L_Lp_coefficients':codes(g01)})
g,c,d=g01.xgcd(H2)
assert c*g01+d*H2==g
if g.degree()==0:
    scale=g[0]**(-1)
    u=scale*c*a;v=scale*c*b;w=scale*d
    assert u*L+v*Lp+w*H2==1
    emit({'event':'all_geometric_triple_roots_absent','verdict':'PASS',
          'bezout_L_coefficients':codes(u),'bezout_Lp_coefficients':codes(v),
          'bezout_HasseD2_coefficients':codes(w),
          'identity':'u*L+v*L_derivative+w*HasseD2(L)=1',
          'conclusion':'L has no geometric root of multiplicity>=3; stated surviving finite uniform-wild diagonal is impossible',
          'retained_outside_scope':['nonuniform simple fold','points outside the audited finite classification','actual source existence']})
else:
    emit({'event':'triple_root_gate_unresolved','common_factor_coefficients':codes(g),
          'conclusion':'A nonconstant necessary candidate factor remains; no all-geometric diagonal decision'})
