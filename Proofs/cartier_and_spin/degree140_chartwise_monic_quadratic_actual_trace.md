# Seven divided traces and complete leading-quadratic exclusion

30 September2026.
[Statement](../../Theorems/cartier_and_spin/degree140_chartwise_monic_quadratic_actual_trace.md).
The residue proof of the divided endpoint traces applies to every affine
regular multiplier. For a multiplier of pole order p, the trace degree
is bounded by max(2,floor((5+p)/4),floor((8+p)/7)). This gives the seven
degrees in the statement. The endpoint correction for t*x^i*y^k is
\[
2\operatorname{Tr}_{K[x]/(t)}
\left(x^i t' U_0 G_{2,2-k}/P\right),\qquad 0\le k\le2.
\]
It is linear in the specified G_2. No moving endpoint denominator is
introduced. Coefficient normalization is w^(n+1-k) at scale degree n.

The [Laurent-support circuit](../../scripts/arithmetic/degree140_inverse_eta_seven_bounds_20260930.cpp)
proves rectangular parameter bounds. The
[exact grid reconstruction](../../scripts/arithmetic/degree140_inverse_eta_seven_grid_20260930.cpp)
uses79 by497 values, more than the separate degree bounds, and retains
all42 coefficients. This is interpolation with proved support bounds,
not a finite-field search for solutions.

The degree-six ty leading coefficient, the degree-five tx^2 leading
coefficient and the degree-four tx leading coefficient are units.
The t leading cubic coefficient is a unit after the already proved
leading-line exclusion. The
[row reduction](../../scripts/arithmetic/degree140_inverse_eta_quadratic_reduction_20260930.sage)
retains all coefficients and all four pivot operations. Reducing the
tx^3,tx^4,txy rows gives three quadratics.

After removing only common column units, their coefficient matrix is M
and the vector in its kernel is
\[
(H^6,\ Hq^{13}\Psi^6\mu,\ q^{26}\Psi^{12}\mu^2)^t.
\]
Thus for v=q^13*Psi^6*H^(-5)*mu the three equations have coefficients
(M_i0,M_i1,H^4*M_i2). All these coordinate changes are units on the
specified chart. In particular the leading-quadratic exception is the
common zero locus of the three M_i2.

After removing their allowed unit factors, these three polynomials have
bidegrees(30,134),(37,164),(38,174). Two resultants in H have proved
q-degree bounds9878 and10312. The
[native reconstruction](../../scripts/arithmetic/bivariate_three_resultants_20260930.cpp)
evaluates them at10313 distinct parameters with unchanged H-degrees and
interpolates the complete polynomial resultants. Leading-degree drops
omitted from the sampling are retained by this global polynomial
identity. The resultant degrees are7489 and7841, and their gcd has
degree3111.

Remove only q-factors already forbidden by the original chart. The
remaining gcd has degree1139 and irreducible factor degree/multiplicity
pairs
\[
(1,1),(1,1),(1,90),(1,90),(2,2),(3,1),(5,2),
(8,1),(10,90),(12,1),(20,1).
\]
Its geometric support has64 values. For each complete residue field,
the [fibre calculation](../../scripts/arithmetic/degree140_inverse_eta_leading_fibres_20260930.sage)
takes the gcd of all three H-polynomials, then removes only the specified
nonzero H,q,Psi,leading-cubic,chart and primitive-content factors.
Every resulting H-gcd is one. Thus no allowed geometric point has all
three leading coefficients zero. This includes arbitrary extension
fields and coefficient-drop cases.

Evidence is retained in
`../../../litt3-computation-data/seventeen_hour_continuation_20260929/traces/`:
`inverse_eta_seven_rational_coefficients.sobj`,
`inverse_eta_quadratic_reduction.sobj`,
`inverse_eta_leading_resultants.json`,
`inverse_eta_leading_projection.sobj`, and the eleven
`inverse_eta_leading_fibre_*.sobj` records. These retain the source
equations, factorization, exact Bezout identity and every removed factor.
The resultant reconstruction took1.52 seconds on one core; factorization
and the complete residue-field lifting took about25 seconds together.

One leading coefficient is therefore invertible locally at every allowed
point. The associated monic quadratic makes the common trace algebra a
quotient of a free rank-two algebra over that open chart, so its
projection is finite with fibre length at most two when zero scale is
retained. Removing zero scale preserves quasi-finiteness, not necessarily
finiteness. If the three rows
have rank two at a geometric parameter, the corresponding two independent
polynomials of degree at most two have gcd of degree at most one.
Any nonempty common fibre is consequently a single reduced scale.
