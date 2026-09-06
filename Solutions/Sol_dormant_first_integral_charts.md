# Proof: first-integral charts and the fixed-X nonvanishing certificate

Canonical [statement](../Theorems/Thm_dormant_first_integral_charts.md).
The differential calculation was derived independently in the bounded
/root/dormant_elliptic_first_integral task, 2026-09-06; this is not a separate
audit of the fixed-X computational consequence.

## Solve the differential equation over its constant field

Write v=Dr. Differentiating D^2r=3r^2 gives D^3r=rv and
D^4r=v^2+3r^3=v^2-2r^3. Its derivative is zero. Since D^5=0 and
ker D=K^5, this gives c in C0.

If c=0 and r!=0, then v^2=2r^3 and v!=0. For s=3r/v,

    Ds=3*(v^2-r*D^2r)/v^2=1,        s^2=2/r.

Thus b=x-s belongs to C0 and r=2/(x-b)^2. Conversely every such expression
solves the equation and has c=0. The displayed recovery of s proves uniqueness.

Suppose c!=0. Set h=r^5 and s=rv/c. Then h is a nonzero constant and

    Ds=(v^2+r*D^2r)/c=1,
    c^2*s^2=r^2*v^2=2h+c*r^2.

Therefore b=x-s belongs to C0 and r^2=c*s^2+3h/c=q. Taking fifth powers
gives q^5=h^2, which after multiplying by c^5 is exactly the asserted
equation on c,h,b. Also r=q^3/h because r^6/r^5=r.

Conversely a triple satisfying that equation gives q^5=h^2. For r=q^3/h,
one gets r^2=q and r^5=h, so r!=0. Differentiation gives r*Dr=c*s and

    (Dr)^2=c^2*s^2/r^2=c+2r^3.

Differentiating r*Dr=c*s now yields r*D^2r=3r^3, hence D^2r=3r^2.
The reconstruction has precisely the prescribed c,h,b.

Geometrically (r,Dr) lies on v^2=2u^3+c. For c!=0 this is a smooth cubic;
the derivation du=v, dv=3u^2 has fifth power zero. The useful rational
function uv/c has derivative1. This does not rationally parametrize the
elliptic curve over its ground field: the reconstruction also constrains
Frobenius powers and works in the purely inseparable extension K/C0.

## Preserve the equation, not just its geometric solutions

Direct differentiation, using D^5=0, gives

    (Dr)^2-2r^3-D^4r = -D^2(D^2r-3r^2)-r(D^2r-3r^2),
    D((Dr)^2-2r^3-D^4r)=2(Dr)(D^2r-3r^2).

Thus E=0 implies J=0, and J=0 implies E=0 if Dr is invertible. The
necessity of a family qualification is visible at r=0: the linearizations
are D^2 for E and -D^4 for J. Replacing one scheme by the other without
checking the unit condition would change infinitesimal multiplicities.

## Uniform nonvanishing by partial fractions

The components1,y,y^2 over k(x) are preserved by D, hence by D^4. It suffices
to show that D^4 of the invariant component r0 does not vanish. Set

    H=2x^8+B-F'',
    r0=-2D(F'/F)+H/F.

Because deg F=10 in characteristic5, deg F''<=7. Consequently H has
degree8 and leading coefficient2, so H is nonzero and deg H<deg F.
The derivative term is killed by D^4 since D^5=0. Over an algebraic closure,
write H/F=sum_alpha R_alpha/(x-alpha). The roots alpha are distinct and
at least one R_alpha is nonzero, because H is not divisible by F. Then

    D^4(H/F)=4*sum_alpha R_alpha/(x-alpha)^5 != 0.

Distinct pole locations prohibit cancellation. This proves D^4r!=0 for
the ENTIRE family without computing a matrix or assuming dormancy.

More generally a proper rational function with poles of order at most2
has D^4 equal to zero exactly when all simple-pole coefficients vanish.
The double-pole terms are killed, whereas the simple-pole terms survive
with distinct fifth-order poles.

## A bounded global first-integral numerator

Use r=(n0+n1*y+n2*y^2)/F^2 from the fixed-X chart. Four differentiations
take the following exact form: start N_j=n_j and, for s=0,1,2,3, replace

    N_j <- F*N_j' + (2j-2-s)*F'*N_j.

Then D^4r=sum_j N_j*y^j/F^6. Since D(D^4r)=0, it is a fifth power.
At a finite branch point r has pole at most6, and D increases pole order
by at most3. Thus D^4r has pole at most18, hence at most15 because its
orders are multiples of5. At O, r has order at least6 and D increases
order by at least3, so D^4r has order at least18, hence at least20.
There are no other possible poles.

Its unique fifth root gamma consequently has poles of order at most3 at
the ten branch points and order at least4 at O. Multiplication by F gives
an affine function with pole at O at most26. The semigroup basis <3,10>
of L(26O) is precisely G0+G1*y+G2*y^2 with the stated degree bounds.

In polynomial terms the identities are

    N0=F*G0^5,       N1=F^4*G2^5,       N2=F^2*G1^5.

The retained script verifies the divisions exactly and checks that all
remaining x exponents are multiples of5. It records the affine map
w=M*v+d, where v is the ordered24-vector (b0,...,b7,c0,...,c4,a0,...,a10),
and w consists of the coefficients of G0^5,G1^5,G2^5 in that order.

## Exact nonvanishing, not a sample inference

For our fixed F the matrix M has rank17. The script saves a nonzero17-by17 minor and a
left-kernel row lambda with lambda*d=1. In the first nine coordinates,
the only nonzero entries of lambda are

    lambda_1=2a+3, lambda_2=2a+3, lambda_3=1, lambda_4=4a,
    lambda_5=3a, lambda_6=4a+3, lambda_7=4a+2, lambda_8=4a;

all other entries, including lambda_0, vanish. Exact multiplication checks
lambda*M=0 and lambda*d=1. Hence lambda*w=1 for EVERY potential in the
chart, agreeing with the uniform partial-fraction proof. The same witness
gives rank M<=17, and the saved nonzero minor gives the reverse inequality.

Reproduce with `sage scripts/dormant_first_integral.sage`. The compact
certificate is [dormant_first_integral.json](../Research/computations/dormant_first_integral.json),
with the explicit matrix, offset, minor and nonvanishing row. The script
also checks the rational reconstruction identities on125 exact examples
over F5(z), and directly tests the two known F25-rational invariant opers.
These tests support the formulas; they are not the proof of exhaustion.
They use numerator-based rational-function zero tests: a reproduced Sage10.9
normalization bug gives D(1/(z^15+4)) as0/(z^15+4), with incorrect nonzero
truthiness. A fresh audit isolated this issue, reran all125 examples, and
found no affected earlier polynomial/Laurent-series certificate. See the
[scoped audit metadata](../Research/audits/FIRST_INTEGRAL_ZERO_TEST_AUDIT_2026_09_06.md).

For a dormant potential c4(r)=c, so the nonzero-c chart covers every
geometric solution on this X. It remains necessary to translate the
original global regularity and coefficient bounds into that chart before
claiming any smaller enumeration algorithm.
