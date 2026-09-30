# Complete common-critical incidence for the linear-v family

29 September2026. [Statement](../../Theorems/cartier_and_spin/degree140_root9_common_critical_exclusion.md).
The accepted source is reused. Only the new incidence and all-scale
exclusions are computed here; older source certificates are not replayed.

## Regular equations at the cubic branches

Write z=y/w,q=w^3,u=h*w^2. The accepted scaled source has
\(G_i=w\widehat G_i(x,z)/(qD_0(q))\), with z^3=P/q.
Its first numerator is P*L(x)+D(x)*z^2. Thus the regular numerator
of g2, up to an original nonzero scalar, is q*L*z+D.
For each z-component define
\[
T_{3,j}=(2B_0\widehat G_{2,j}+\widehat G_{3,j})/P,
\qquad
T_{4,j}=3B_0^2\widehat G_{2,j}+3B_0\widehat G_{3,j}
 +\widehat G_{4,j}.
\]
The divisions defining T3, T4,1/P, T4,2/P and T4,0/P2 are exact
polynomial divisions. Regular numerators for g3 and g4 are
\[
q\sum_{j=0}^2T_{3,j}z^j,
\qquad qT_{4,1}/P+q(T_{4,2}/P)z+q^2(T_{4,0}/P^2)z^2.
\]
Their omitted factors are powers of w and the original qD0 unit.
These equations retain the actual regular lattices at y=0.

The [incidence constructor](../../scripts/arithmetic/root9_common_critical_20260929.sage)
checks every division. Off P*t, it may use the simpler unbarred
G3,G4: the coordinate translation and y-divisions are invertible
there once g2=0. Adjoin one inverse of q*P*t*(qD0) and the equation
qz3=P. The exact Groebner computation gives a zero-dimensional
algebra of length304. FGLM gives four linear coordinate equations
and a monic squarefree q-polynomial of degree304, with the eight
factor degrees in the statement.

For y=0, P splits into ten distinct roots over K. The
[branch calculation](../../scripts/arithmetic/root9_branch_critical_20260929.sage)
substitutes each actual root into the regular equations above and
sets z=0. Each ideal, with only qD0 inverted, is the unit ideal;
saved polynomial multipliers multiply to1 exactly. This proves the
branch exclusion without assuming P invertible in the conclusion.

At t=0, P is a unit. The
[endpoint calculation](../../scripts/arithmetic/root9_endpoint_critical_20260929.sage)
instead substitutes each of the three t-roots, retaining z,u,q and
qz3=P, and inverts only qD0. Each complete algebra has length36.
Its shape polynomial is squarefree, with the three sets of residue
degrees in the statement. The marked incidences, rather than an
unjustified list of distinct ratio pairs, are what these lengths count.

The [exporter](../../scripts/arithmetic/root9_common_critical_export_20260929.sage)
checks every original incidence equation in every factor field. No
bounded rational-point search occurs. The exact CAS basis computations
and their full algebraic inputs are saved and reproducible; they are
not inferred solely from checking selected specializations.

## Every scale is excluded on every incidence block

On each of the eighteen residue fields reconstruct the original
degree140 residual from the accepted source. The original u and F6
units remain nonzero. The normalized square-root tails
\(C_n=[T^n](T^{140}R(T^{-1})/\operatorname{lc}R)^{63}\)
satisfy deg(C71)=53 and deg(C72)=54 in the independent scale.
A square must make both tails zero, since 2*63=126=1 modulo125.

The [native constructor](../../scripts/arithmetic/root9_common_critical_scales_20260929.cpp)
produces polynomials U,V in that same complete residue field with
\[
U C_{71}+V C_{72}=1.
\]
Every block passed. Its use of the accepted weighted source routine
retains all coefficients needed for these tails; it does not assert
that discarded low residual coefficients have been reconstructed.
The [independent Sage checker](../../scripts/arithmetic/verify_root9_common_critical_20260929.sage)
multiplies all eighteen identities literally and verifies that their
moduli cover exactly the factorization of the complete incidence.
It does not call the native arithmetic or the native Euclidean routine.

All scales, including geometric extensions, are therefore excluded.
Since the marked ratio algebras are reduced, the component identities
also exclude the entire incidence scheme. No nonempty finite-type
nilpotent thickening can survive with empty geometric support.

## Consequences and remaining support

The homogeneous critical quadratic is nonzero on every fibre of
the projective line bundle over affine X. It consequently cuts out
a relative effective Cartier divisor of degree two, finite and flat.
Generic nonsplitting is already proved by the critical-cover theorem.

At a point with t*(x-[9]) nonzero, write s for the minimum valuation
of g2,g3,g4. Factoring a uniformizer to power s from the quadratic
contributes10s to its fixed-degree resultant. The remaining quadratic
is nonzero over the residue field with transcendental scale. A common
finite root with the degree-ten polynomial would force its scale
coefficient phi2 to vanish, hence phi=0 and then t3=0, impossible.
At an infinite critical root the leading polynomial coefficient is
lambda*(x-[9]), also nonzero. The remaining resultant is a unit.
The common-critical exclusion gives s=0. Thus fixed content can occur
only over t=0 or at the marked branch x=[9]. No conclusion about those
remaining content conditions is inserted into this argument.

Evidence is retained under
[the new common-critical directory](../../../litt3-computation-data/conceptual_continuation_20260929/root9_common_critical/),
[the branch certificates](../../../litt3-computation-data/conceptual_continuation_20260929/root9_branch_critical/),
and [the three endpoint algebras](../../../litt3-computation-data/conceptual_continuation_20260929/root9_endpoint_critical/).
The initial larger all-branch elimination was stopped once the disjoint
branch decomposition gave the complete faster computation. It supplies
no additional claim or assumed result.
