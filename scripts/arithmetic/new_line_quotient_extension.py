#!/usr/bin/env python3
"""Exact primitive and residue data for lambda-perp/lambda on fixed X.

Run with Sage Python. The identification with the integral extension is
proved separately; this script checks its polynomial and residue inputs.
All displayed rows use F25 codes n0+5*n1, a^2=a+3.
"""
import json
from pathlib import Path
from sage.all import GF, PolynomialRing, PowerSeriesRing

F5=GF(5)
T=PolynomialRing(F5,'t'); t=T.gen()
k=GF(25,'a',modulus=t*t-t-3); a=k.gen()
R=PolynomialRing(k,'x'); x=R.gen()
def decode(n): return k(n%5)+k(n//5)*a
def code(c):
    row=list(k(c).polynomial())+[F5(0)]*2
    return int(row[0])+5*int(row[1])
def row(f): return [code(c) for c in f.list()]
P=R([decode(c) for c in (11,22,18,5,19,20,15,16,9,22,1)])
A=R([decode(c) for c in (1,21,14,22,13)])
dQ=P*A*A
Q=R.zero()
for i,c in enumerate(dQ.list()):
    if (i+1)%5==0:
        assert c==0
    else:
        Q+=c/k((i+1)%5)*x**(i+1)
assert Q.derivative()==dQ
K=R.quotient(P,'xx'); xx=K.gen()
assert all(z**(5**8)==z for z in (xx,K(a)))
N=R((K(Q)**(5**7)).lift())
assert (N**5-Q)%P==0
Tpoly,rem=(Q-N**5).quo_rem(P**2)
assert rem==0
assert P*Tpoly.derivative()+k(2)*P.derivative()*Tpoly==A*A

# Relative Frobenius coefficients on C=X^(1).
P1=R([c**5 for c in P.list()]); N1=R([c**5 for c in N.list()])
PS=PowerSeriesRing(k,'z',default_prec=8); z=PS.gen()
ratio=PS(list(reversed(N1.list())))/PS(list(reversed(P1.list())))
# N1 degree9 and P1 degree10, so N1(x)/P1(x)=z*ratio(z).
assert N1.degree()==9 and P1.degree()==10
# For epsilon=3*N1/y1 and eta_C=dx1/y1^2, the residue at O_C is
# 3 (extension scalar) * 3 (cubic index) * minus coeff x1^-1.
pairings=[-k(9)*ratio[i] for i in range(5)]+[k(0),k(0)]
assert any(pairings)

out={
 'Q':row(Q),'N':row(N),'polynomial_primitive_T':row(Tpoly),
 'relative_N1':row(N1),
 'epsilon_residues_basis_1_x_x2_x3_x4_y_xy':list(map(code,pairings)),
 'primitive_identity':'d(Q/y^5)=d(y*T)=A^2 dx/y^2',
 'difference':'Q/y^5-y*T=(N/y)^5',
 'extension_convention':'l=[f^2]/A^5; r=[f^3]/A^5; r_aff=r-3*(N/y)^5*l',
 'relative_frobenius_splitting':'r_split=r-3*f*l=r_aff-3*g*l; f=Q/y^5, g=y*T',
 'canonical_connection':'nabla(l)=0; nabla(r_split)=-3*A^2*(dx/y^2)*l',
 'frobenius_zero_reason':'epsilon has cubic character zeta^2; F*epsilon has character zeta. H0(omega(-10O)) has character zeta, hence its invariant Serre pairing vanishes.',
 'scope':'Polynomial/residue certificate; full extension identification and local saturation are prose.'
}
dest=Path(__file__).resolve().parents[3]/'litt3-computation-data/finite_coefficients_contacts_20260923/new_line_quotient_extension.json'
dest.write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out,indent=2))
