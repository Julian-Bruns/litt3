# Proof: proper torsion incidence, one good fiber, and a degree bound

[Statement](../Theorems/Thm_family_small_torsion_specialization.md).
Author /root,2026-09-08. This is a bounded-weight transfer principle,
not a bound on arbitrary root orders or finite etale covers.

## 1. An exact good fiber

Let alpha^3+alpha+1=0 and q=125. Exact point counting for C_alpha gives
118 points over F125 and15926 over F15625, hence Weil polynomial

    P(T)=T^4-8T^3+182T^2-1000T+15625.

Both P(1)=14800 and P(-1)=16816 have2-adic valuation4. The six
Weierstrass points are rational and generate J[2], so Frobenius pi
on T2J is I+2U for an integral matrix U. The two valuations say that
U and I+U are both invertible. Consequently

    pi^2-I=4U(I+U),                                     (1)

with U(I+U) a2-adic unit. For x=[P-O] in J[8], gamma=pi^2 satisfies
(gamma-I)^2 x=0. The quadratic rigidity lemma of
[low_pencil_torsion_rigidity](../Theorems/Thm_low_pencil_torsion_rigidity.md)
applies with r=1 and the hyperelliptic pencil: every function of degree
at most2 is in k(u), gamma fixes the ramification and commutes with the
involution. Thus gamma x=x. Equation(1) gives4x=0.

But L(4O)=<1,u,u^2>. If4P-4O were principal for a nonbranch P, its
function in k(u) would vanish equally at P and iota(P), a contradiction.
Therefore C_alpha meets J[8] only in its six Weierstrass classes. This
uses only the elementary quadratic-divisor part of the cited lemma,
not an assertion about effectiveness of separate primary projections.

## 2. Why one fiber suffices generically, without losing a boundary

Work over S=Spec F5[t,1/(t^5-t)]. Its relative Jacobian J/S is an
abelian scheme, and J[8] is finite etale. The subgroup J[2] is open
and closed in J[8], so H=J[8] minus J[2] is finite etale and CLOSED
in J. The Abel embedding C->J is a closed immersion. Hence

    B=C x_J H

is a closed subscheme of H and is finite over S. Its image is closed.
Section1 shows that image misses the alpha fiber; it is therefore
a proper closed subset of the connected smooth base curve, hence finite.
No extra points can escape into a removed Weierstrass boundary: the
entire J[2] component has been removed inside the FINITE ETALE group.
On any fiber Abel(C) meets J[2] exactly at Weierstrass classes, since
2P~2O iff P is Weierstrass. Thus B is exactly the nonbranch8-torsion
incidence, not a smaller convenient open subset.

The same reasoning proves the general finite-etale torsion-incidence
principle in the statement. It requires a good fiber for the chosen
N; it gives no simultaneous assertion for unbounded N.

## 3. A finite complete polynomial model and its uniform degree bound

For a nonbranch P=(b,c) with8[P-O]=0, choose the unique function
f with div(f)=8P-8O and normalize its leading coefficient at O.
The semigroup<2,5> forces

    f=A(u)+v B(u), A=u^4+A3 u^3+A2 u^2+A1 u+A0,
    B=B1 u+B0.

There is no cancellation of the leading pole8, since the vB part
has odd pole order at most7. Taking norms gives the exact identity

    A^2-F_t B^2=(u-b)^8.                            (2)

Moreover B(b)!=0: otherwise A(b)=0 also and f would vanish on both
sheets above b, contrary to its divisor. Conversely(2), F_t(b)B(b)!=0
and t^5-t!=0 give EXACTLY such a divisor: at b only one sheet is zero,
the other is a unit, so the norm's entire order8 is on that sheet.
Its ordinate is c=-A(b)/B(b). No norm-only false positive is retained.

Use the nine scalar variables

    t,b,A0,A1,A2,A3,B0,B1,z.

The eight coefficient equations of(2) below u^8 and

    z(t^5-t)F_t(b)B(b)=1

cut out precisely this normalized incidence. Every geometric fiber is
finite, because J[8] is finite and the normalized function for P is
unique. By Section2 the entire affine solution set is finite. Each of
the nine equations has total degree at most13 (the first eight at most8).
Affine Bezout therefore bounds its number of geometric points by13^9;
its image in the t-line has no more points. This bound counts all affine
solutions even if a homogenized system has excess components at infinity;
only the standard inequality for isolated affine zeros is used.

For the affine degree inequality see Heintz's Bezout inequality, also
formulated in [Hashemi--Heintz--Pardo--Solerno, Section1](https://arxiv.org/html/1701.04341).
The equations are over F5, so the finite exceptional set is Frobenius
stable. A parameter of degree greater than13^9 cannot lie in it.

## 4. All double-zero Cartier eigenforms are excluded throughout the family

With eta=du/v, regular forms having a double zero are eta (zero at O)
and (u-b)eta, for b=0,1,2,3,t (zero at W_b). Relative Cartier has
matrix [[c4,c3],[c9,c8]] from family_singleton_root_exclusion. The
eigenline condition for (u-b)eta, allowing eigenvalue zero, is

    c3-b c4+b^5 c8-b^6 c9=0.

For b=0,1,2,3,t the left sides respectively factor as

    -2t(t+1), (t-1)(t+1), -(t-2)(t+1),
    2(t-3)(t+1), -2(t+1)^2(t^5-t).

They are all nonzero on S. For eta the condition is c9=-2(t+1)=0,
also impossible. This is an actual semilinear Cartier eigenline test;
the fifth powers of b are essential when b=t.

## 5. The same-source consequence

Let X<-Z->C_t be an actual coreless span with a singleton clump image
on C_t. The canonical_intersection theorem supplies a primitive shared
tensor s with div(s_C)=2dP, and cartier_generator gives5 not dividing d.
If its eligible Cartier image is zero, the AUDITED family singleton
exclusion is an immediate contradiction. Otherwise
fixed_x_nonzero_cartier_profiles gives d=2 or4, so8[P-O]=0.
Sections1--3 make P Weierstrass for a sufficiently high-degree t.
Its tensor is then a scalar dth power of the double-zero one-form at P.
The one-endpoint power rule of cartier_generator makes that one-form
a Cartier eigenform, contradicting Section4. Both actual maps remain
in the primitive-generator and fixed-X steps; no endpoint datum alone
is asserted to be a realized span.

A clump with two-point image has e=d by er=2d, hence forces a core
by shared_tensor_core. A three-point image would give e+d=5d/3,
an integer divisible by5, forbidden by cartier_generator. Thus the
remaining image size is at least four, as stated in Version2.

For the high-prime-degree partner already chosen by the no-cored theorem,
K>B^2=112896000000>13^9, and its degree r over F25 is at most its
degree over F5. Thus no new parameter change or additional computation
is required. The no-cored theorem remains independent of this corollary.

## Evidence and limitations

[family_torsion_specialization_certificate.sage](../scripts/family_torsion_specialization_certificate.sage)
checks both point counts over their entire fields, the exact Weil
polynomial and2-adic valuations, all nine equation-degree bounds, and
the six symbolic eigenline tests. It runs on one CPU and contains no
Groebner solver or enumeration of the exceptional set. The properness
and finite-incidence argument above is the proof of completeness.
This author-prose corollary uses the stated author-prose low-pencil
and fixed-X Cartier-profile inputs; no inherited audit is claimed.
