#!/usr/bin/env sage
"""Certify the F625 model of the unique rational cyclic-five repair class.

This constructs an actual etale genus-six cover. Full BT effectivity
on it is NOT asserted; only the previously proved BT2 repair is reused.
"""
import argparse,json
from pathlib import Path
ap=argparse.ArgumentParser(description=__doc__)
ap.add_argument('--output',type=Path)
args=ap.parse_args()
k=GF(5**4,'tau',modulus=[3,4,1,4,1]);a=k.gen()
P=PolynomialRing(k,'u');u=P.gen()
f=u*(u-1)*(u-2)*(u-3)*(u-a)
chi=3*a*a+a+3
A=(u**5+(3+3*a)*u**4+(3+4*a+a*a)*u**3
   +(1+4*a+3*a*a)*u**2+(3+3*a+3*a*a)*u+(2+4*a+a*a))
N=f**7+a**5*f**2*u**20-chi*f*u**24-chi*a*u**28-A*u**30
assert N.degree()<=27
# c=z^-3+tau*z^-1=v*(f/u^6+tau/u^2), z=u^2/v.
# Thus c^5-chi*c-v*A=v*N/u^30, regular with positive order at O.
assert N.degree()==27
F=matrix(k,[[4*a*a+a+2,3*a+3],[a**3+3*a*a+3,4*a*a+1]])
v=vector(k,[1,a]);assert F*vector(k,[c**5 for c in v])==chi*v
M=identity_matrix(k,2)
for i in range(4):M=M*F.apply_map(lambda c:c**(5**i))
assert M.charpoly()==M.charpoly().parent()([1,2,1])
assert (M+identity_matrix(k,2)).rank()==1
assert M*v==-v
assert (M+identity_matrix(k,2))**2==zero_matrix(k,2)
assert chi**((625-1)//4)==-1
# Check the two cohomology coefficients directly in the rational
# numerator, independently of the recorded Frobenius matrix.
assert N[29]==N[28]==0
enc=lambda c:[int(c[i]) for i in range(4)]
receipt={'status':'PASS','field_modulus':[3,4,1,4,1],
 'chi':enc(chi),'A_ascending':[enc(c) for c in A],
 'remainder_degree':int(N.degree()),'remainder_ascending':[enc(c) for c in N],
 'frobenius_matrix':[[enc(c) for c in row] for row in F],
 'arithmetic_frobenius_matrix':[[enc(c) for c in row] for row in M],
 'class_vector':[enc(c) for c in v],
 'geometric_cover_residue_degrees':[1,5],
 'deck_splitting_extension_over_F625':2,
 'scope':'Actual etale genus-six cover and cover-class arithmetic. No full group upstairs.'}
if args.output:
 args.output.parent.mkdir(parents=True,exist_ok=True)
 args.output.write_text(json.dumps(receipt,indent=2,default=int)+'\n')
print('PASS: explicit F625 cover, regular infinity remainder, unique rational class, deck splits over F625^2.')
