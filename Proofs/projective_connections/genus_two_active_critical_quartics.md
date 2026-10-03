# Proof: active connections from critical quartics

[Statement](../../Theorems/projective_connections/genus_two_active_critical_quartics.md).
Author proof,2026-09-09–13; verification scopes are in the statement.

## 1. Exhaustion by branch pairs

Every active genus-two regular nilpotent connection is admissible by
[nilpotent_scalar_model](../../Theorems/projective_connections/nilpotent_scalar_model.md).
Its normalized quartic s has divisor2E with E reduced of degree4.
The scalar model's automorphism corollary makes the Hasse invariant
hyperelliptic-invariant, so s=A(u)eta^4 with deg A<=4.

At O, ord(s)=8-2deg A. Thus deg A is3 or4. A finite branch root of
A has multiplicity1, and every finite nonbranch root has multiplicity2.
Hence, after retaining its nonzero scalar, A=R0 H² with R0 a squarefree
factor of F, H squarefree and coprime to F. If deg R0 is odd, O belongs
to E. The split case is R0=1. In a nonsplit case E therefore has either:

- two Weierstrass points and the two points of a nonbranch u-fiber; or
- four Weierstrass points.

The fifteen pairs of Weierstrass points represent the fifteen nonzero
two-torsion classes. Their square roots are sqrt(R), with the finite
root convention in the statement. Complementary branch subsets represent
the same class because F=v². This also proves distinctness: the symmetric
difference of two different pair subsets is neither empty nor all six
points, so their ratio is neither a square in k(u) nor F times a square.

For a fixed pair R, the two possibilities for A are consequently

    A=a² R(u)(u-h)², a!=0, F(h)!=0;   or   A=a² S, a!=0.

This classification checks infinity as well as the finite branch points;
there is no lost degree-three polynomial chart.

## 2. Cartier reduces the fiber case to D'(h)=0

For the first possibility, adjoin w^4=A, and put

    kappa=w²/(a(u-h)),  kappa²=R,  z=vw/kappa.

Then z^4=R S² a²(u-h)², and the tautological root differential is
alpha=a(u-h)du/z. The normalized quartic condition is equivalent to
Cartier(alpha)=alpha, by the Cartier projection formula and injective
separable pullback. Using z^5=z*z^4 gives

    alpha=z^-5 a³ D(u)(u-h)³ du,       D=RS².

The polynomial has degree at most12, so Cartier extracts only its u^4
and u^9 coefficients. Put

    c0(h)=D_1-3hD_2+3h²D_3-h³D_4,
    K(h)=D_6-3hD_7+3h²D_8-h³D_9=D^[6](h).

Comparison with a(u-h)du/z is exactly

    a²=K(h),       c0(h)+h^5 K(h)=0.

In characteristic5 the second polynomial is IDENTICALLY D'(h).
But D'=S(R'S+2RS')=SJ. Also gcd(J,F)=1: at a root of R its value
is R'S!=0, and at a root of S it is2RS'!=0. Since deg R is1 or2,
the leading coefficient of J is respectively4 or3, so deg J=4.
This proves that the permitted abscissas are exactly J(h)=0 with K(h)!=0.
The scalar a² is uniquely K(h), so the normalized tensor is the displayed
one, independent of either square-root choice for a. Its divisor has the
required four double zeros, including O when deg R=1.

For the four-branch case interchange R and S, keep H=a constant, and
make the same root construction. Now the polynomial before Cartier is
a³ S R², of degree at most7. Only its u^4 coefficient contributes.
The condition is exactly a²=c. This proves both necessity and sufficiency
of the stated list. The scalar nilpotent dictionary reconstructs the
actual regular connection. There is no assertion that root maps to Y
are etale: they are auxiliary ramified maps used for the coefficient check.

## 3. A zero normalization factor is dormant pointed incidence

Set $a=1$ in the root constructions of Section2, BEFORE imposing
the normalized Cartier condition. For $J(h)=0$ the calculation gives
$C(\alpha)=K(h)^{1/5}\alpha$; the constant case gives
$C(\alpha)=c^{1/5}\alpha$. Put
\[
q_h=\sqrt R(u-h)/F,\quad q_b=\sqrt S/F,\quad
r_h=q_h''/q_h,\quad r_b=q_b''/q_b.
\]
The scalar identity $E(r)=2D^4v/v$, with $\alpha=v\,du$, therefore gives
\[
E(r_h)=3K(h)R(u)(u-h)^2/F^2,\qquad
E(r_b)=3cS/F^2.
\]
These identities remain valid at $K(h)=0$ or $c=0$; no vanishing
factor was divided out. The same scalar regularity argument applies,
since the nonzero unnormalized quartic has four double zeros even
when its curvature vanishes. These zero orders cancel possible double
poles in the scalar inverse formula. A remaining simple pole of $r$
would give a third-order pole in $r''-3r^2$, contradicting the displayed
regular curvature. Thus a zero factor gives a REGULAR DORMANT connection and a horizontal
quadratic coefficient in the indicated nonzero two-torsion class.

Conversely the [Bol kernel](dormant_bol_complex.md) and complete
quadratic basis give every such twisted section in one of these
linear/constant components. A constant numerator in the $R$-component,
or a linear numerator vanishing at a branch value, would have a multiple
zero and give a double pole at infinity or that branch point. Regularity
excludes both. At a nonbranch simple zero $u=h$, the remaining polar
coefficient vanishes exactly when $J(h)=0$. The curvature identity then
makes dormancy equivalent to $K(h)=0$; the complementary constant
component similarly gives $c=0$. On this family the trivial twist never contributes, by the
[complete elliptic incidence theorem](genus_two_dormant_parameter_curve.md).
Consequently, over ordinary parameters, all fifteen $J,K$ are
coprime and all $c$ are nonzero exactly when
\[
Q(A)=A^3+3A^2+4\ne0.
\]
This replaces the former fifteen-class normalization-factor tests.

## 4. Two collision orbits give one invariant census locus

In $z=1/(u+1)$ the fixed branch set is $\mathbf F_5$.
The [affine-family symmetry](../../Theorems/curve_arithmetic/prime_field_branch_family.md)
preserves $A$, the intrinsic root classes and critical-root collisions.
Its two pair orbits have representatives $R=u$ and $R=u-t$.
Up to nonzero constants their discriminants and induced $A$-polynomials are:

| $R$ | $\operatorname{Disc}(J)$ | Minimal polynomial of $A$ at its roots |
| --- | --- | --- |
| $u$ | $t^6+t^5+2t^4+2t^2+t+1$ | $H(A)=A^3+2A^2+1$ |
| $u-t$ | $t^4+4t^3+t^2+4t+3$ | $A-2$ |

Both displayed parameter polynomials are irreducible. These small
identities follow by reducing $A=((t+1)^{-5}-(t+1)^{-1})^4$
in the respective degree-six and degree-four quotient algebras.
The first has all three roots of $H$ among its $A$-values.
Every ordinary $A$-fiber is one twenty-point affine orbit.
Transporting these representative collisions therefore proves
that some $J$ is non-squarefree exactly when $(A-2)H(A)=0$.

Each nonzero root class has at most one branch datum and four fiber
data. The family has five reduced dormant connections and hence ten
split active connections by the canonical-double theorem. It therefore
has85 active points exactly when each of the fifteen nonzero classes
attains its five-point maximum: every $J$ squarefree, $\gcd(J,K)=1$
and $c\ne0$. Combining this with Section3 gives
\[
(A-2)H(A)Q(A)=(A-2)(A^6+A^4+A^2+4)\ne0.
\]
No separate resultant or backup solution list enters this criterion.

An excluded parameter transforms by an affine symmetry to a root of
one of the two displayed polynomials, or is a cubic first-height bad
parameter. Affine transformations preserve parameter degree, so
degree greater than six still suffices. For the actual backup
$\alpha^3+\alpha+1=0$, one has $A=\alpha+1$ and
\[
H(A)=\alpha+3,\qquad Q(A)=(\alpha+1)(\alpha+2),\qquad A-2=\alpha-1,
\]
all nonzero. Thus every original endpoint choice is retained, and
the same count holds on the entire invariant open locus.

## 5. Counts and local lengths

The [universal dormant quintic](../../Theorems/projective_connections/genus_two_dormant_quintic.md)
has resultant with its derivative -[t(t-1)(t-2)(t-3)]². Thus this family
has exactly five reduced dormant connections at every smooth parameter.
The [canonical-double theorem](../../Theorems/projective_connections/etale_double_dormant_pairs.md)
then gives ten split active connections. It also gives, for each nonzero
two-torsion class L,

    #Dorm(Y_L)=5+2 #Active_L(Y)=15.

The [scalar determinant theorem](nilpotent_scalar_model.md#2-n-equations-their-exact-length-and-infinity)
gives a zero-dimensional complete intersection of length125 on Y.
At a dormant point the determinant of p-curvature has no linear term,
so its three local equations lie in the square of the maximal ideal.
Its local length is at least2³=8. The85 distinct active points each
contribute at least1. Equality5·8+85=125 forces all these bounds to
be equalities: dormant multiplicity8 and85 reduced, hence ordinary,
active points. This works on the entire invariant open locus and replaces the
older backup solution-list census.

The dormant scheme on the genus-three Y_L has length15. Its fifteen
geometric points therefore all have length1.

Finally a dormant tangent space on Y_L at the pullback of a base dormant
connection splits into the untwisted and L-twisted base tangent spaces.
Both vanish, giving the stated uniform Pic[2] test. This is the previously
proved counting implication, now applicable to every parameter in
the invariant open locus, including the selected high-degree and backup curves.

The [focused independent review](../../Research/audits/CRITICAL_FAMILY_DORMANT_HINDSIGHT_AUDIT_2026_10_03.md)
checks the unnormalized Cartier bridge, exact invariant criterion and
all earlier scopes. The [small symbolic identities](../../../litt3-computation-data/archive_cleanup_20260930/critical_family_invariant_hindsight/verification_receipt.json)
verify only the two discriminants and invariant residues. Original
[generic critical and twist evidence](../../../litt3-computation-data/legacy_workspace_computations/genus_two_affine_twist_certificate.json),
[backup nonsplit table](../../../litt3-computation-data/legacy_workspace_computations/backup_nonsplit_twists.json)
and [full backup table](../../../litt3-computation-data/legacy_workspace_computations/backup_active_twist_table.json)
remain provenance. The obsolete critical-resultant and normalized-root
replay block is removed from the shared source. Its full generic
twist calculation and actual backup bad-twist calculation remain needed
and unchanged.
