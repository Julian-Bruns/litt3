# A quartic first coefficient and its nilpotent square

29 September2026. [Statement](../../Theorems/cartier_and_spin/degree140_root9_all_scale_bound.md).
The primitive bound12/21 is the
[critical-cover theorem](degree140_root9_critical_scale_budget.md).
Ratios lying on one of the excluded incidence loci have empty square
scheme, so consider any other nonprimitive ratio carrying a square.

By the [endpoint-content structure](degree140_root9_endpoint_content_structure.md),
choose an endpoint b at which exactly one cubic sheet has simple
content. On that sheet the first residual coefficient is quadratic
in mu with nonzero leading term; on the other two sheets the
constant residuals are nonzero affine-linear polynomials. Therefore
the cubic norm R has
\[
R(b,\mu)=0,\qquad P_b(\mu):=\partial_xR(b,\mu)\ne0,
\qquad\deg P_b\le4.
\]
The equality and bound are polynomial identities in the free scale.
The fixed leading x140 coefficient is a nonzero ratio scalar,
independent of scale; dividing by it does not change the argument.

At a geometric square value R=B2, the equation R(b)=0 implies B(b)=0,
so P_b(mu)=0. This gives at most four geometric scale values.

For scheme length, work in the actual normalized square coordinate
ring A, with its monic degree70 square root B supplied uniquely by
the triangular coefficient recursion. There one has
\[
B(b)^2=0,\qquad P_b=2B(b)B'(b),\qquad P_b^2=0.
\]
Thus the eliminated square ideal in k[mu,mu^-1] contains the nonzero
polynomial P_b squared, of degree at most eight. Its length is at
most eight. This step deliberately retains possible nilpotents in
B(b); replacing P_b squared by P_b would be unjustified. Combining
this bound with the primitive21 bound proves the uniform assertion.

## The field of an actual content scale

Use the field of the actual h,w coefficients, so that the equation
of X, the chosen cubic identification and the residual are all defined
over k0. Every root of t lies in K. Above a root b carrying content,
there is exactly one content point. Frobenius over k0 preserves that
point, so it is k0-rational. All its local source coefficients are
therefore in k0. The [local étale theorem](root9_content_etale_scale.md)
forces the scale to be its single explicit rational value, hence to
belong to k0 as well.

The [binary Frobenius theorem](../../Theorems/jacobians/isogeny_sieves/trigonal_constant_norm_obstruction.md)
says that every nonzero element of J(X)[2] has Frobenius25 orbit171.
Its orbit over k0 is171/gcd(171,d). A nonzero discriminant-half class
defined over k0 consequently requires171|d. Passing from the
cubic-invariant ratios to actual h,w enlarges the coefficient field
by at most three, giving57 as the necessary divisor downstairs.

For the weaker even-divisor square-scale condition, no local étale
splitting is assumed. Its scale orbit has at most four elements.
The orbit171/gcd(171,d) of a nonzero half-divisor class divides that
scale orbit. Among divisors of171 the only possibilities at most
four are1 and3, so57 divides d. This is the same argument as the
[earlier orbit filter](square_scale_frobenius_orbit_filter.md), with
the sharper positive-content scale bound. The trivial class still
means a square in the geometric function field of X; it is not
excluded by this arithmetic argument.
