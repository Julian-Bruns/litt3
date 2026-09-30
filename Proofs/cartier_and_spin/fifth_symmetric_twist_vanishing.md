# Proof of all-twist fifth symmetric and first-Frobenius vanishing

Use the actual K, its C3-linearization and the all-Pic0-twist vanishing
in degrees1 through4 proved in
[the lower-degree theorem](../../Theorems/cartier_and_spin/low_degree_twist_vanishing.md).
The degree-one case follows there from the stronger K(O) vanishing.
Write k(X)=F0, to distinguish this function field from Frobenius.

## The complete Sym15 section space

The accepted exact Cech reconstruction is applied to Sym15 K. Its
359-by351 coefficient matrix has rank348 over F25 and independently
rank696 after restriction of scalars to F5. The three free columns
(i,r,m), using the established y^r*x^m convention, are
\[
(10,1,6),\qquad(10,1,7),\qquad(10,1,8).
\]
Descending the actual triangular transition reconstructs each of the
three sections on both charts. Every coordinate is zero except at
binary indices0,5,10,15. The transition and all required infinity
orders are checked directly for each reconstructed vector.

It follows that the complete geometric section space is contained in
the Frobenius subbundle F^*(Sym^3 K) of Sym15 K. This is a support
statement about all sections, not vanishing. Matrix rank and basis
support remain valid after extending the constant field.

The source is
[k_fifth_twist_probe.py](../../scripts/arithmetic/k_fifth_twist_probe.py).
It reuses the accepted full coordinate system, reconstructs the kernel
and independently eliminates the restricted-scalar F5 matrix. Generated
matrix, basis vectors, both affine charts and executed outcomes are
`k_fifth_twist_probe.json` and `.log` in
[the evidence directory](../../../litt3-computation-data/overnight_three_replies_20260926/).
Run the script with `--output` naming that external JSON path. Despite
its historical probe filename, the support and rank assertions are exact
and concern the whole section space.

## A fifth-degree section cannot factor over the function field

Let s be a nonzero section of Sym5 K tensor a degree-zero line L.
Let M be its saturated line in Sym5 K. Then deg M>=0.
Suppose its homogeneous binary polynomial over F0 factored into
positive degrees a,b<5. Saturate the two rational factor lines to
M_a in Sym^a K and M_b in Sym^b K. Their product is saturated: over
each local DVR the product of two primitive polynomials is primitive,
as is immediate by reducing modulo the maximal ideal. Therefore
M=M_a tensor M_b.

Every line subbundle in Sym^a K for1<=a<=4 has negative degree.
Indeed, a nonnegative-degree line would, after an effective twist
of its dual to degree zero, contradict the established all-twist
vanishing. Thus deg M_a+deg M_b<0, a contradiction. The generic
binary quintic of s is consequently irreducible over F0.

## The cubic orbit product forces Frobenius support

The three conjugate twisting lines have trivial product because the
C3 quotient of X is P1. Using the actual equivariant structure on K,
form the nonzero section
\[
s\,\gamma(s)\,\gamma^2(s)\in H^0(X,\operatorname{Sym}^{15}K).
\]
Its two formal binary derivatives vanish, by the complete support
calculation. Each factor is an irreducible binary quintic over F0;
each distinct factor occurs with multiplicity at most three.

In the polynomial UFD F0[U,V], an irreducible factor of multiplicity
prime to five in a polynomial with both derivatives zero must itself
have both derivatives zero. Reduce the differentiated product modulo
that factor; divisibility of its derivative would otherwise contradict
its lower degree. Thus s has generic form a U^5+b V^5.

The inclusion F^*K -> Sym5 K is a subbundle, as its two extreme
monomials give a locally free quotient. Generic membership therefore
extends over the whole curve, proving
H0(Sym5 K tensor L)=H0(F^*K tensor L) for every degree-zero L.
No fifth root of a function-field coefficient has been taken.

## All cubic-invariant degree-zero twists of F^*K vanish

Write P=(11,22,18,5,19,20,15,16,9,22,1) in ascending F25 codes,
and c=(2,16,16,7,1,2,7,1,24,11). The field is
F25=F5[a]/(a^2-a-3), with code n0+5n1 for n0+n1*a.
The actual first Frobenius extension has lines O(-25O), O(30O)
and class
\[
e^5=yP^3x^{-50}C_5(x),\qquad
C_5(x)=\sum_{m=1}^{10}[c_m]^5x^{5(10-m)}.
\]
Let R_1,...,R_10 be the cubic branch points. Every C3-invariant
degree-zero line is represented by
\[
D_s=\sum_i s_i(R_i-O),\qquad s_i\in\{0,1,2\},\quad s_{10}=0.
\]
Indeed an invariant line can be linearized, and an invariant rational
section gives an invariant divisor. Nonfixed orbits are fibers of x.
The relations 3(R_i-O)=0 and sum(R_i-O)=0 reduce to these19683
representatives. This is the same exhaustive invariant-twist reduction
used for the accepted K calculation.

Put A_s=product_{s_i=1}(x-r_i), B_s=product_{s_i=2}(x-r_i),
w=deg A_s+2deg B_s, and D_0=1,D_1=B_s,D_2=A_s B_s.
The character-j source basis for O(30O+D_s) is y^j*x^i/D_j,
where 0<=i<=floor((30-w-10j+3deg D_j)/3). The target H1
character is j+1 mod3. In its analogous basis for O(-25O+D_s),
the exponents are strictly between
floor((-25-w-10(j+1 mod3)+3deg D_(j+1 mod3))/3) and zero.
Multiplication by the actual class uses C_5*x^-50 and the factors
\[
P^3B_s,\qquad P^3A_s,\qquad P^4/(A_sB_s)
\]
in source characters0,1,2. Thus all connecting maps are exact finite
linear systems, not a generic-extension or splitting-type test.

The [complete verifier](../../scripts/arithmetic/k_first_frobenius_invariant_twists.py)
constructs all19683 maps over the splitting field F_(5^8).
Each has source dimension22, target dimension33 and rank22.
Every kernel is zero. A
[separate checker](../../scripts/arithmetic/check_k_frobenius_invariant_twists.py)
reconstructs16 specified full maps using the literal fifth power of
the Laurent class and restricts scalars to F5; all have rank176.
That second run checks the implementation; full coverage comes from
the first exhaustive run. The negative source line has no sections,
so H0(F^*K tensor L)=0 for every invariant degree-zero L.

## A small isotypic section space excludes every other line

Apply the
[cyclic determinant-section lemma](../../Theorems/cartier_and_spin/cyclic_determinant_section_reduction.md)
to E=F^*K, with det E=O(5O). Its only additional input is the full
space H0(F^*K(5O)). The original Laurent reconstruction gives a
28-by27 coefficient matrix of rank24, independently of rank48 after
restriction of scalars to F5. Its three free columns are
\[
(5,0,9),\qquad(5,0,10),\qquad(5,0,11).
\]
Every reconstructed section has affine coordinates(y*C(x),B(x)).
The linearization of K is diag(zeta,1), because
T(e)*diag(zeta,1)=diag(zeta,1)*T(zeta^2 e). Its first Frobenius
pullback is diag(zeta^2,1). Therefore every one of these sections
has character0, and the full section space is isotypic.

The determinant-section lemma proves that any saturated line of
nonnegative degree in F^*K has invariant isomorphism class. Subtracting
its degree times O then gives an invariant degree-zero line mapping
into F^*K, contrary to the preceding exhaustive calculation. Thus
H0(F^*K tensor L)=0 for every geometric degree-zero line. The already
proved Frobenius-support equality gives the same conclusion for Sym5 K.

Source:
[the section reconstruction](../../scripts/arithmetic/k_shifted_seven_zero_sections.py)
with `--twist 5`. Its three complete sections, both charts, exact
matrix, independent F5 rank and character check are in
`k_frobenius_five_zero_sections.json` in the external evidence directory.
This replaces the need for a geometric square-locus calculation in
the all-twist argument; it does not change the verified result below.

## Retained stronger fact: the cubic net has no geometric square

The three basis vectors above give every section of Sym3(F^*K).
In its affine binary frame every such section has the form
\[
a(x)U^3+y^2b(x)U^2V+yc(x)UV^2+d(x)V^3,
\]
where a,b,c,d depend linearly on three constant parameters. Its
discriminant, in characteristic five, is
\[
\Delta=P^2b^2c^2+Pa c^3+P^2b^3d+3a^2d^2+3Pabcd.
\]
Exact cancellation gives deg_x Delta<=10. Its eleven coefficients
are homogeneous quartics in the three parameters. The
[net reconstruction](../../scripts/arithmetic/k_frobenius_cubic_discriminant.py)
recovers these quartics by interpolation on an invertible15-point
evaluation matrix and separately checks five further parameter values.
This determines polynomial identities: it is not a finite search for
square points over the algebraic closure.

Cover the parameter projective plane by (1,b,c), (0,1,c), (0,0,1).
For each chart introduce z_0,...,z_5 and all eleven equations
\[
\Delta_n=\sum_{i+j=n}z_i z_j,\qquad0\le n\le10.
\]
These include every lower-degree square and the zero polynomial.
The [geometric-locus computation](../../scripts/arithmetic/k_frobenius_discriminant_square_locus.py)
gives the unit ideal on all three charts. A
[separate prime-field computation](../../scripts/arithmetic/check_k_frobenius_square_locus.py)
adjoins a with a^2-a-3=0 and retains explicit Bezout identities for1.
Their term counts are210835,1615,117 respectively. The
[standard-library replay](../../scripts/arithmetic/verify_k_frobenius_square_bezout.py)
independently multiplies these identities using only F5 polynomial
arithmetic; all three give exactly1. Consequently no nonzero member
of the cubic net has square discriminant in k[x], including Delta=0.

The exact matrix and sections, net coefficients, three Bezout witnesses,
exhaustive invariant-twist outcomes and independent replays are retained
in [the evidence directory](../../../litt3-computation-data/overnight_three_replies_20260926/).
The files are `k_fifth_twist_probe.json`,
`k_first_frobenius_invariant_twists.json`,
`k_frobenius_invariant_twists_independent.json`,
`k_frobenius_cubic_discriminant.json`,
`k_frobenius_discriminant_square_locus.json`,
`k_frobenius_square_bezout.json`, and
`k_frobenius_square_elementary_check.json`; the relevant logs are
alongside them. The focused audit records the run commands and scopes.

This stronger net exclusion also gave the original proof: a noninvariant
line would have three conjugate generic factors, hence a cyclic cubic
with square discriminant. The new isotypic argument establishes the
needed vanishing without that elimination. The full geometric-net
certificate is retained for its separate, stronger assertion.

## Consequences for finite coefficients

The lower-degree rank-three polynomial-restriction lemma immediately
excludes degree-five finite semi-invariants. For an irreducible rank-five
finite coefficient with five permuted lines, the orbit is transitive.
On an étale trivializing cover a nonzero map to K cannot kill any of
the five lines identically, since it would kill their whole orbit.
Their image product is nonzero and descends to a section of Sym5 K
twisted by a finite character, again impossible.

The following geometric argument is retained separately: it explains
why the Frobenius-support reduction alone already excludes degree-p
semi-invariants in rank three, without the square-locus computation.

## A moving-line lemma for constant degree-p forms

Let W be a three-dimensional vector space over an algebraically closed
field of characteristic p. Let I be a nonzero homogeneous degree-p
polynomial on W^*. Suppose a nonconstant irreducible family of projective
lines L in P(W^*) has the property that I restricted to each L has
zero binary derivative.

If the three partial derivatives of I are all zero, I is the p-th
power of a linear form, since the constant field is perfect. Otherwise,
choose a member L0 which is not a component of their common zero locus.
That locus meets L0 in finitely many points. Along any family member L,
the gradient of I annihilates its two-dimensional vector plane, so
where nonzero it is proportional to the equation defining L.
At L intersect L0 for two distinct members the gradient must therefore
vanish. Every such intersection lies in that fixed finite set on L0.

The intersection map from the irreducible parameter curve to L0 has
finite image and is constant. Hence the entire family of lines passes
through one fixed projective point. This argument includes singular
or reducible I; only the case of identically zero gradient is separated.
It requires no separability of the parameter curve's map to the dual
projective plane.

## Application to rank-three finite coefficients

Suppose an irreducible finite coefficient R of rank three maps
nontrivially to K. The established image theorem makes the map a
surjection. Trivialize R and the character of a degree-five semi-invariant
on a connected finite étale cover pi:S->X. The invariant is now a
fixed nonzero polynomial I on the constant three-dimensional W^*.

Its restriction to K^* is nonzero by the rank-three restriction lemma
in the lower-degree proof. It is a section of Sym5 K twisted by a
degree-zero character, so it lies in F^*K by the preceding result.
After pullback to S every fiber restriction has zero binary derivative.
The subbundle pi^*K^* in W^* tensor O_S gives a nonconstant family
of projective lines: a constant plane would make pi^*K^* trivial,
contrary to its negative degree.

If I has nonzero gradient, the moving-line lemma supplies a fixed
vector in every plane, hence a nonzero section of pi^*K^*. This is
impossible. The accepted positive Frobenius presentation of K implies
that every line quotient on a finite cover has strictly positive degree;
in particular pi^*K has no nonzero map to O_S.

If I has zero gradient, it is the fifth power of a linear form. Its
semi-invariance makes the line of this linear form invariant: equality
of fifth powers over the perfect constant field has a unique fifth
root. This contradicts irreducibility of R. Both cases are excluded.

The moving-line argument is valid with5 replaced by any characteristic
p. The exact support calculation and lower-degree vanishing used to
reach it are specific to the displayed bundle K. No bound on all
possible finite monodromy groups is inferred.
