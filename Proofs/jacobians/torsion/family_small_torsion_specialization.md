# Proof: Hasse jets, one good specialization and a resultant bound

[Statement](../../../Theorems/jacobians/torsion/family_small_torsion_specialization.md).

## 1. The polynomial jet matrix

Use the [superelliptic jet criterion](superelliptic_single_point_torsion_test.md)
with covering exponent2, polynomial degree5 and torsion order8.
Work over S=Spec F5[t,1/(t^5−t)]. Put f_i=[z^i]F_t(b+z), f0=F_t(b),
and normalize the local square root by

    H(s)²=F_t(b+f0 s)/f0,       H(0)=1.

Writing H=ΣA_n s^n gives polynomials A_n∈F5[t,b], with A0=1 and

    2A_n=f_n f0^(n−1)−Σ_(j=1)^(n−1) A_j A_(n−j),  1≤n≤7,

where f_n=0 for n>5. At a nonbranch abscissa b the exact criterion
for 8[P−O]=0 is a nonzero kernel of

    (A5,A4), (A6,A5), (A7,A6).

Thus the first two maximal minors give necessary equations

    H1=A5²−A4 A6=0,       H2=A5 A6−A4 A7=0.             (1)

The third minor A6²−A5 A7 completes the exact test. The first two
already suffice for the parameter bound.

## 2. Degree bounds

Since each f_i is linear in t, induction gives deg_t A_n≤n.
In the b-variable, f_i has degree≤4−i for 1≤i≤4, and f5=1.
The same recursion gives

    n:          1  2  3  4  5  6  7
    deg_b A_n: ≤3 ≤7 ≤11 ≤15 20 ≤23 ≤27.

Only f5 f0^4 contributes the b^20 term of A5, whose coefficient is
1/2. Hence H1 has b-degree40 with constant leading coefficient1/4;
H2 has b-degree at most43. Their t-degrees are at most10 and11.

## 3. One Euclidean identity bounds every exceptional parameter

Let α³+α+1=0 in F125. The
[short exact certificate](../../../scripts/arithmetic/family_torsion_specialization_certificate.sage)
computes a Euclidean identity

    U(b)H1(α,b)+V(b)H2(α,b)=1.

Thus R(t)=Res_b(H1,H2) is nonzero. The constant leading coefficient
of H1 prevents loss of this conclusion under specialization, even
if H2 drops degree. The Sylvester determinant gives

    deg R≤40·11+43·10=870.

Every admissible parameter with a nonbranch point killed by8 satisfies
(1), hence is a root of R. This proves the bound870 without computing
R or enumerating any Jacobian. The exceptional set is Frobenius-stable,
so no parameter of degree>870 over F5 belongs to it.

The exceptional set is not empty: at α²+4α+2=0 the same certificate
finds a degree-three gcd of all three minors, coprime to F_α(b).
The matrix test supplies nonbranch points killed by8 at that parameter.

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
a Cartier eigenform, contradicting Section4.

A clump with two-point image has e=d by er=2d, hence forces a core
by shared_tensor_core. A three-point image would give e+d=5d/3,
an integer divisible by5, forbidden by cartier_generator. Thus the
remaining image size is at least four.

For the high-prime-degree partner already chosen by the no-cored theorem,
K>B^2=112896000000>870, and its degree r over F25 is at most its
degree over F5. Thus no new parameter change or additional computation
is required. The no-cored theorem remains independent of this corollary.
## 6. The general incidence principle

Prime-to-characteristic torsion in the relative Jacobian is finite
étale. Removing an open-and-closed collection of allowed components
leaves a finite closed subscheme H. Its intersection with the relative
Abel curve is closed and finite over the base. The image is therefore
closed; a missed fiber makes it a proper closed subset of a connected
smooth curve, hence finite. Removing whole torsion components keeps
the excluded boundary from reappearing in specialization.

The certificate checks the recursion, degree bounds, Euclidean identity,
degree-two exceptional example and six Cartier eigenline identities.
The [bounded audit](../../../Research/audits/HASSE_TORSION_BOUND_AUDIT_2026_09_13.md)
checks the matrix criterion and resultant argument. Original point-count
and norm-presentation evidence is preserved in the cleanup archive;
the Cartier/clump consequences above retain their original proof status.
