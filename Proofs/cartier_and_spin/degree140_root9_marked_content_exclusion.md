# Local parity closes the whole marked-content curve

29 September2026. [Statement](../../Theorems/cartier_and_spin/degree140_root9_marked_content_exclusion.md).
The field is the accepted K=F_(5^8), with the original base25 quartic-tower
codes. Put q=w3, u=h*w2, H=u/q. The original units include q,u,D0(q),
the degree140 leading coefficient and the nonzero scale. The only root
of D0 is [118020]. No extra ratio factor is silently inverted.

## The exact marked-branch expansion

Use z=y/w as parameter at Q9. There is a unique series
\(x=[9]+qz^3/P'([9])+\cdots\) satisfying P(x)=qz3. Transform the
critical polynomial by the accepted Z=yW-B0 translation, retain its
fixed degrees(10,2), and clear the original source denominator to the
twelfth power. The
[new local constructor](../../scripts/arithmetic/root9_marked_content_20260929.sage)
computes its three scale rows through z5. Their common z3 factor is
the prescribed division by x-[9], times a unit. Consequently their
z3 rows determine fixed content, and their z4 rows determine the next
valuation after that division.

Up to original units, the z3 rows factor as
\[
a_3=(H-[42135])^2(H-[356769])^3\mathscr J(H,q),\qquad
b_3=(H-[42135])^4\mathscr J(H,q),\qquad c_3=0.
\]
Here \(\mathscr J\) is irreducible and has H/q degrees6/5. Its leading
H coefficient is q3([74211]+[260505]q), an original unit. For an
unambiguous compact specification write \(\mathscr J=\sum_{j=0}^5j_j(H)q^j\),
where the ascending coefficient rows of j0,...,j5 are
\[
\begin{aligned}
&(9732,235068),\\
&(30760,81660,293549),\\
&(241797,239014,63489,32248),\\
&(46652,184265,100795,55211,0,110509,74211),\\
&(70022,291915,0,0,0,65171,260505),\\
&(1,345132,347547).
\end{aligned}
\]
All entries are K-codes. The rows come from exact factorization of the
actual source, not interpolation from finitely many parameter points.

On H=[42135], both scale-dependent z4 rows vanish, whereas the constant
z4 row is a nonzero constant times q24(q-[118020])12. The residual
therefore has valuation exactly one at Q9 for every scale. The valuation
of its norm at x=[9] is also one: the unique point has residue degree
one in the totally ramified cubic extension. A polynomial square cannot
have that valuation. This excludes the whole line.

## Parity determines the scale on the remaining curve

On \(\mathscr J=0\), the next row is a4+b4*mu; the quadratic-scale row
still vanishes to this order. An even norm valuation at Q9 requires
a4+b4*mu=0. Exact reduction modulo the curve gives
\[
\frac{a_4}{b_4}
=\frac{[159354](H-[356769])^3}
       {[101967](H-[42135])^2}.
\]
The equality is a rational-function identity on the entire curve. Its
compact numerator and denominator were recovered by linear algebra and
then checked by an exact polynomial remainder, not inferred from degree
or sample values.

The possible base points a4=b4=0 are retained. With only qD0 inverted,
their exact algebra is reduced of length65 and has residue degrees
1,6,8,50. In every residue field the original C71,C72 scale polynomials
have a polynomial combination equal to1. All four identities were
independently multiplied in Sage. Thus no base point can be a square,
even after a geometric field extension. This proves the displayed
formula for mu in the statement at every remaining square.

The denominator B=[101967](H-[42135])2 is a unit on the original curve:
its H-resultant with \(\mathscr J\) is a nonzero constant times
q2(q-[118020])2. This controls its full boundary, rather than presuming
that a convenient denominator is nonzero.

## Exact function-field elimination, including its exceptional fibre

Work in the rank-six algebra over K(q) defined by \(\mathscr J\),
substituting the forced mu. Its coefficients, reductions and source
denominators use only q and D0. The
[native function-field constructor](../../scripts/arithmetic/root9_marked_function_field_20260929.cpp)
reconstructs the accepted high residual coefficients. It retains the
unnormalized tails
\[
T_n=[T^n](T^{140}R(T^{-1}))^{63},\qquad n=71,72,73.
\]
A square makes all three vanish: if R=B2 with degree(B)=70, its63rd
power is B126=B*B125, whose coefficients in that range vanish.
Equivalently these tails are the normalized tails times lc(R)63.
No unjustified cancellation of a lower leading-coefficient power is used.

Multiplication by each tail gives a6-by6 matrix over K(q). Clear its
row denominators, supported only on qD0, and compute its determinant
by exact fraction-free elimination. Removing powers of q and D0 gives
polynomial norms N71,N72 of degrees18045,18111. Their exact gcd is
\[
G(q)^{375},\qquad G=(9732,30760,241797,46652,70022,1).
\]
G is irreducible of degree five. The full polynomial Bezout identity
is retained and was independently multiplied. A putative square
therefore lies above a root of G; no generic-function-field conclusion
is substituted for this boundary calculation.

Over K[q]/G, take the polynomial gcd in H of \(\mathscr J\) and all
three actual tails. It is exactly H. Explicit polynomial multipliers
give H, and the identity was checked literally. Thus every geometric
point on the exceptional fibre satisfying these necessary square
conditions has H=0. Since u=qH is an original unit, none is allowed.
This proves the whole marked-content exclusion.

## Focused checks and provenance

The source/model comparison checks all74 required residual coefficients
and all three raw tails on the complete rank-six H algebras at q=2,3,25.
These are regressions for the exact function-field construction, not a
parameter search or the reason for global exclusion. The marked local
rows were also compared with the full critical residual; all three have
one common unit factor, confirming the same scale normalization.

One serialization defect was found and corrected during these checks:
the rational-arithmetic engine uses monic denominator factors, while an
initial metadata export listed the original scalar multiple of D0.
The arithmetic model and determinant computations already used the monic
factors. The metadata, complete exceptional-fibre calculation and source
comparisons were corrected/rechecked before this theorem was recorded.

Source and new exact evidence are linked below. Accepted source programs
and incoming long certificates were not replayed.

- [Local parity](../../scripts/arithmetic/root9_marked_parity_20260929.sage),
  [compact scale identity](../../scripts/arithmetic/root9_marked_rational_scale_20260929.sage),
  [complete base-point incidence](../../scripts/arithmetic/root9_marked_scale_exceptions_20260929.sage).
- [Curve export](../../scripts/arithmetic/root9_marked_curve_export_20260929.sage),
  [exact norm matrices](../../scripts/arithmetic/root9_marked_curve_norms_20260929.cpp),
  [exceptional-fibre decision](../../scripts/arithmetic/root9_marked_curve_boundary_20260929.sage).
- [Independent norm/coverage check](../../scripts/arithmetic/verify_root9_marked_curve_norms_20260929.sage),
  [full-source comparisons](../../scripts/arithmetic/root9_marked_function_field_check_20260929.cpp),
  [local normalization check](../../scripts/arithmetic/check_root9_marked_normalization_20260929.sage).
- [Exact data and receipts](../../../litt3-computation-data/conceptual_continuation_20260929/root9_marked_content/).

The remaining endpoint-content cases and the content-free square problem
are separate. No actual common source or shared-object extraction is
claimed here.
