#!/usr/bin/env sage
"""Exact W1[9], J[6] repeated-support and finite-prime-support inputs."""
import itertools
import json
import time
from pathlib import Path
started=time.monotonic()
root=Path(__file__).resolve().parents[1]
k=GF(125,name='a',modulus=PolynomialRing(GF(5),'z')([1,1,0,1]));a=k.gen()
R=PolynomialRing(k,'t');t=R.gen();K=R.fraction_field()
F=lambda x:x*(x-1)*(x-2)*(x-3)*(x-a)
ft=F(t);S=PolynomialRing(K,'h');h=S.gen();fh=F(t+h)
cs=[K.one()]
for n in range(1,9):cs.append((fh[n]/ft-sum(cs[i]*cs[n-i] for i in range(1,n)))/2)
assert (sum(cs[i]*h**i for i in range(9))**2-fh/ft)%h**9==0
mat=matrix(K,[[cs[n-j] for j in range(3)] for n in range(5,9)])
minors=[mat.matrix_from_rows(rows).det().numerator() for rows in itertools.combinations(range(4),int(3))]
g=R.zero();lifts=[]
for minor in minors:
    g,s0,t0=g.xgcd(minor)
    lifts=[s0*v for v in lifts]+[t0]
assert g==1 and sum(v*f for v,f in zip(lifts,minors))==1
enc=lambda c:[int(v) for v in c.polynomial().list()]
encpoly=lambda f:[enc(c) for c in f.list()]

# Translate every nonzero3-class by every rational2-class. Its reduced
# quadratic U is unchanged by sign, so the complete40-point norm algebra
# suffices. Repeated U detects 2[P-O] in J[6], hence W1[12].
data=json.loads((root/'Research/computations/backup_genus_two_torsion.json').read_text())
decode=lambda cs:sum(k(v)*a**i for i,v in enumerate(cs))
aspoly=lambda coeffs:R([decode(cs) for cs in coeffs])
q=aspoly(data['separator_coefficients']);A=R.quotient(q,names='l');lam=A.gen()
inv=lambda value:A(A(value).lift().inverse_mod(q))
Ar=PolynomialRing(A,'u');u=Ar.gen()
r=A(aspoly(data['r_coefficients']));s=A(aspoly(data['s_coefficients']))
U=u**2+r*u+s
B=Ar([A(aspoly(c)) for c in data['B_coefficients_as_polynomials_in_lambda']])
assert B**2-lam*F(u)==U**3
V=B%U
branches=[k(0),k(1),k(2),k(3),a]
rows=[]
for size in [1,2]:
  for subset in itertools.combinations(branches,int(size)):
    E=prod(u-c for c in subset)
    H=E%U;h0,h1=H[0],H[1]
    determinant=h0*(h0-r*h1)+s*h1**2
    detinv=inv(determinant)
    w0=((h0-r*h1)*V[0]+s*h1*V[1])*detinv
    w1=(-h1*V[0]+h0*V[1])*detinv
    W=E*(w0+w1*u)
    assert (W-B)%U==0 and W%E==0
    red,rem=(F(u)-inv(lam)*W**2).quo_rem(U*E)
    assert not rem and red.degree()==2
    leadinv=inv(red[2]);red*=leadinv
    discriminant=red[1]**2-4*red[0]
    bad=q.gcd(discriminant.lift()).monic()
    gcd_check,bezout_q,bezout_disc=q.xgcd(discriminant.lift())
    assert gcd_check==1 and bezout_q*q+bezout_disc*discriminant.lift()==1
    rows.append({'two_torsion_branch_subset':[enc(c) for c in subset],
                 'repeated_support_norm_degree':int(bad.degree()),
                 'repeated_support_separator':encpoly(bad),
                 'reduced_U_coefficients_in_lambda':[encpoly(c.lift()) for c in red.list()],
                 'discriminant_coefficients':encpoly(discriminant.lift()),
                 'bezout_q_multiplier':encpoly(bezout_q),
                 'bezout_discriminant_multiplier':encpoly(bezout_disc)})

Q=PolynomialRing(QQ,'T');T=Q.gen()
P=T**4-8*T**3+182*T**2-1000*T+15625
inverse=(T**24-1).inverse_mod(P)
assert ((T**24-1)*inverse-1)%P==0
inverse_quotient=((T**24-1)*inverse-1)//P
assert max(ZZ(c.denominator()).valuation(3) for c in inverse.list())==2
assert ZZ(P.resultant(T**24-1)).valuation(3)==8
assert P(1)==14800 and P(-1)==16816
assert ZZ(P(1)).valuation(2)==ZZ(P(-1)).valuation(2)==4
assert ZZ(P.resultant(T**24-1)).valuation(2)==16

out={'status':'exact small-torsion certificates; no common-cover claim',
     'field_modulus':[1,1,0,1],
     'W1_9':{'nonzero_classes':0,'matrix_rows':'n=5,6,7,8; columns c_n,c_(n-1),c_(n-2)',
       'minor_numerator_degrees':[int(f.degree()) for f in minors],
       'minor_numerators':[encpoly(f) for f in minors],
       'bezout_multipliers':[encpoly(v) for v in lifts],
       'exact_bezout_sum_one_verified':True,
       'scope':'Nonbranch points excluded by jets; Weierstrass points have order2 and O is the zero class.'},
     'W1_12':{'J3_translated_by_all15_nonzero_J2_classes':rows,
       'total_repeated_support_norm_degree':sum(row['repeated_support_norm_degree'] for row in rows),
       'scope':'Together with the zero-translate discriminant and L(4O), detects every non-Weierstrass12-torsion point.'},
     'Frobenius24_inverse':{'polynomial_coefficients':[str(c) for c in inverse.list()],
       'bezout_quotient_coefficients':[str(c) for c in inverse_quotient.list()],
       'identity':'(T^24-1)*inverse-1=P*quotient','max_denominator_3adic_valuation':2,
       'determinant_3adic_valuation':8,'determinant_2adic_valuation':16},
     'rigidity_applications':{'dependency':'low_pencil_torsion_rigidity, author proof not independently audited',
       'W1_pure3_primary':'zero, using inverse bound9 and exact W1[9] certificate',
       'W1_pure2_primary':'six Weierstrass classes, using pi^2-I=4*unit and L(4O)',
       'W1_mixed2_3_field':'F125^24','W1_mixed2_3_exponent_bound':144,
       'warning':'Do not project a mixed torsion class to a primary W1 class.'},
     'elapsed_seconds':time.monotonic()-started}
target=root/'Research/computations/backup_genus_two_small_torsion.json'
target.write_text(json.dumps(out,indent=1,default=int)+'\n')
print(json.dumps({'output':str(target),'W1_9_nonzero':0,
                  'W1_12_repeated_norm_degrees':[row['repeated_support_norm_degree'] for row in rows],
                  'elapsed_seconds':out['elapsed_seconds']},indent=2,default=int),flush=True)
