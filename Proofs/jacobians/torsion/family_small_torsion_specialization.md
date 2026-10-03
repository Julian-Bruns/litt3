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

## 3. Later torsion information supplies the good fiber

Let α³+α+1=0. The later
[backup arithmetic](../../curve_arithmetic/backup_curve_arithmetic.md)
excludes non-Weierstrass eight-torsion and six-torsion Abel points.
It makes H1(α,b) and H2(α,b) coprime without a Euclidean computation.

At a nonbranch common zero, if A4 is nonzero, the identity
\[
A4(A6^2-A5 A7)=A5 H2-A6 H1
\]
makes the third maximal minor vanish. The exact matrix criterion
would give eight-torsion. If A4=0, H1=0 gives A5=0. The Taylor
expansion of v at either point over b then agrees with its cubic
truncation B3 through degree five. The nonzero function v-B3 lies
in L(6O) and vanishes to order at least six at that point, forcing
div(v-B3)=6P-6O. This gives the excluded six-torsion instead.

At a branch point write f1=F′(b), nonzero. The recursion gives
A4=0, A5=2f1^5, hence H1=4f1^10≠0. There are therefore no
common roots at all. The constant leading coefficient1/4 of H1
also prevents loss at infinity, and
R(t)=Res_b(H1,H2) is nonzero. Its degree satisfies
\[
\deg R\le40\cdot11+43\cdot10=870.
\]
Every admissible parameter with a nonbranch point killed by eight
is a root of R. The exceptional set is Frobenius-stable, so a
parameter of degree greater than870 avoids it. The old Euclidean
search is unnecessary.

## 4. The earlier Cartier input is independent of torsion

The [singleton-root theorem](family_singleton_root_exclusion.md)
now states the all-parameter double-zero eigenline exclusion
directly from its explicit Cartier matrix. Its five finite
Weierstrass tests and infinity test use only polynomial identities.
That earlier input is independent of the backup torsion theorem;
in particular the good-fiber replacement above is not circular.

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
by the canonical marked quotient theorem. A three-point image would give e+d=5d/3,
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

The recurrence and degree bounds retain their original
[bounded audit](../../../Research/audits/HASSE_TORSION_BOUND_AUDIT_2026_09_13.md)
checks of the matrix criterion and resultant argument. The new good-fiber
step is reviewed locally from the later backup torsion theorem; no
numerical search is used. Original proof evidence and its provenance
are retained externally. The clump consequences keep their scope.
