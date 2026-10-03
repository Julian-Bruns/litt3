# A uniform rank125 fourth escape and its affine fifth obstruction

Version8,3 October2026. This theorem gives the fourth escape, complete
relative fifth image and affine support.
The
[actual fifth](rank125_fixed_line_fifth.md),
[actual sixth](rank125_fixed_line_sixth.md) and
[formal tower](rank125_all_heights.md) have separate canonical statements.

Use the original maximal C5³ cover of the genus-three curve, scalar
Schur coordinates and canonical ordinary-Y reference in the
[quadratic-channel proof](../../../Proofs/deformations/elementary_covers/fourth_hodge_quadratic_channel.md).
Put k0=F5[t]/(t³+t+1), k=bar(k0),
R=k[s1,s2,s3]/(s_i^5), J=(s1,s2,s3), K=Ann(f), dim K=43.
The scalar H is after coefficient Frobenius in the original scaled
logarithmic generators. Retain the actual flat line, preceding
filtered object, grading and source marking. Let K_d=K intersect J^d,
and let Z4 consist of the H whose given third curve
X3(H)=X3^0+n(H) admits a compatible fourth tuple.

Field codes[m] mean m0+m1*t+m2*t², for m=m0+5m1+25m2.

## Fourth escape and its whole affine fiber

There is an actual completed odd H* in Z4 with degree-five pivots

    ((H*)5_014,(H*)5_104,(H*)5_113,(H*)5_203)=(0,[101],[14],0).

Thus the [known15-dimensional locus](rank125_fourth_low_slice.md)
Z4 intersect K6 is a proper subset of Z4. The construction works
uniformly in the actual fixed reference coefficients alpha,beta:
an odd seed solves lower degrees, and a four-by-four terminal
matrix has constant nonzero determinant for every alpha,beta.
Its inverse cancels the actual terminal residual. These coefficients
are not free parameters chosen to obtain vanishing.

Let Q be the symmetric quadratic polarization, with Q(H,H)=Q(H),
and C the first WHOLE integral product carry in the original odd
logarithms, s_i^5/5=-c_i*s_i, c=(3,1,2). On K9,

    L_H*(V)=2Q(H*,V)-[C(q2*V9)]

is the complete relative fourth obstruction. It is k-linear, has
rank8 for every actual reference value, and is unchanged when H*
is translated by K9. Since dim K9=16,

    Z4 intersect(H*+K9)=H*+ker L_H*

is an eight-dimensional affine scalar family, with genuine terminal
primary and whole regular repairs. This is a geometric-point statement;
it makes no reducedness assertion for an unperfected parameter scheme.

The [actual fourth reference](rank125_actual_fourth_reference.md)
gives alpha1,beta0,omega1[57],omega2[17] and the symmetry-fixed origin

    Hstar=[101]nu1+[14]nu2+[122]nu11+[93]nu12
         +[117]nu15+[115]nu16+[83]nu27+[74]nu30+[58]nu31,

with complete E4(Hstar)=0. The uniform construction is retained
independently of this numerical specialization.

## Complete relative fifth image

Put A4(V)=E4(V)-Q(V). For any H in Z4 and compatible fourth
origin, translating its fourth source digit by actual n(V), V in K,
changes the fifth obstruction by

    R_H(V)=A4(V)+2Q(H,V).

This is an additive map in the original transported scalar coordinates,
with no additional Frobenius. It need not be k-linear on all K.
Its restriction to K9 is the preceding exact linear L_H.

The odd part of the fourth escape fiber is

    F_odd=Hstar+span(delta,nu39,nu40,nu41),
    delta=[117]nu32+nu33
         =[117]s1^4*s2*s3^4+s1^4*s2^2*s3^3
             +[41]s1^4*s2^3*s3^2+[35]s1^4*s2^4*s3,
    nu39=s1^3*s2^4*s3^4, nu40=s1^4*s2^3*s3^4,
    nu41=s1^4*s2^4*s3^3.

For every H in this four-dimensional affine family, the complete
geometric image on the22-dimensional odd source is exactly

    R_H(K_odd)=ker P5 in (R/(f))_odd,
    P5(E)=(E001,E010,E100,E030+[45]E021).

This image is an18-dimensional k-linear subspace, although R_H
itself can have mixed-additive tails. Constant invertible minors
and successive correction of the ACTUAL higher tails give the
complete image, not just an associated-graded rank.

An invariant fourth origin has odd absolute class C5(H).
The four values theta5(H)=P5(C5(H)) are independent of all43
fourth choices, including even ones. A compatible fifth tuple
exists above H if and only if theta5(H)=0. The scalar augmentation
already vanishes for every fourth choice over this family.

## Symmetry, uniform families and affine support

The actual involution over Y is

    jmath(u,kappa,y,W1,W2,W3)=(u,-kappa,-y,-W1,W2,W3).

It preserves the oper, twist and canonical reference and acts on
the original marked deformation functor. It inverts the original
sigma1 label and fixes sigma2,sigma3; it is not an identity-marking
automorphism. Its source and target scalar action is H(s)->-H(-s1,s2,s3).
It forces omega0=omega3=0 and permits the fixed Hstar construction
using only the fixed gamma1,gamma2 terminal repairs.

On F_odd its coordinate signs are(-1,1,-1,-1), and on theta5 they
are(-1,-1,1,-1). Its fixed line and residual are therefore

    H_lambda=Hstar+lambda*nu39,
    theta5(H_lambda)=(0,0,vartheta(lambda),0).

A compatible W5 tuple exists over this given third point exactly
when vartheta(lambda)=0, with all fourth and terminal choices allowed.

The uniform-family argument gives
vartheta in k[lambda^(1/5^infinity)], globally on the whole line.
Its reusable coefficient lemma works for any prime p, perfect field
k and finite parameter list T: the monomial map

    W_m(k)[T^(1/p^infinity)] -> W_m(k[T^(1/p^infinity)])

is injective and p-saturated. Its image is stable under actual
Frobenius and inverse Frobenius. Whole division preserves polynomial
monomial support. Smooth curve charts, fixed full-primary sections
and whole regular primitives give the actual compatible family;
pointwise choices of origins or Teichmuller lifts of intermediate
sums are not substituted for it.

The complete filtered fifth comparison proves the stronger identity

    vartheta(lambda)=b+a*lambda.

It uses the all-precision AS chart bound, full filtered primary solves,
whole regular primitives and this coefficientwise division. It
retains the mixed second repairs and divided carries. Its coefficients
are evaluated in the separate actual fifth theorem.

## Exact projection and first repair input

For an already divided special-fiber normal cochain Z in the original
AS chart, let Tr be the actual trace to the genus-three base and N_i
the base normal projections in order
(kappa/u,v/u,v/u²,v/u³,y/u,y/u²). Then

    E100([Z])=N0(Tr(W_U,1*Z))+[85]N1(-Tr Z)
               +[85]N2(-Tr Z)+[48]N3(-Tr Z).

The complete functional includes the infinity-boundary correction
and descends to the primary cokernel. For a fifth comparison Z is
formed only after the WHOLE repaired numerator is divided by125.

The actual source direction is

    n(nu39)=2*(kappa/u)*W1+[45]*v/u+[59]*v/u²+[94]*v/u³.

Its whole first affine/infinity repair is given in the proof.
For lambda*nu39 the source scales by lambda^(1/5), and that graph
pair scales by lambda. These primary data do not replace a whole
second repair or an actual fifth comparison.

[Human-readable proof and original evidence](../../../Proofs/deformations/elementary_covers/rank125_fourth_escape.md).
