# Remove the moving content denominator from the divided traces

30 September2026.
[Statement](../../Theorems/cartier_and_spin/degree140_divided_endpoint_traces.md).
Use the [divided-trace theorem](degree140_inverse_discriminant_quadratic_traces.md)
and the already established two-branch calculation in
[endpoint multiplication](degree140_endpoint_multiplier_traces.md).
The argument below changes the weight in that calculation; no incoming
verification program is rerun.

## Degree and necessity

The pole order of t*x^j at O is9+3j. The divided-trace bound therefore
gives degrees3,4,5. Its paired-residue proof gives necessity at every
actual nonzero etale scale, including critical discriminant collisions.

At a generic type-A finite endpoint eta is a unit. Multiplication by t
lowers the bound on the endpoint contribution by one. At type B it
lowers the pole order by two; Lambda has pole order five there. Ordinary
phi poles contribute nothing to coefficients of degree at least two:
the trace-dual calculation in the divided-trace proof applies already
at n=2, because its factor phi^(2n-4) is then integral. Thus every
coefficient of degree at least two is obtained at the two points over O.

## Exact endpoint correction

In the notation of the endpoint-multiplier proof, the two critical
eta-values are4b and b. After multiplying by t, every surviving pole
in the difference between the proper polar replacement and the actual
differential is simple. The previous calculation with weight eta gave
the endpoint correction3*f*k*J*a*b^2. Replacing eta by eta^-1 divides
each of its two contributions by the SAME number b^2. Hence the new
answer is simply3*f*k*J*a. In original coordinates this is
\[
4f\,t' U_0 G_2/y^5.
\]
Since y^3=P, the cubic trace of G_2/y^5 is3*G_2^(2)/P. Summing over
the three x-endpoints gives the displayed C_j. The same replacement
preserves the equality of the two simple residues for scale coefficient
one, so its correction is zero; all later corrections were already zero.

This computation is first made where the two critical roots are distinct
and the chosen local coordinates are units. Its final expression in the
fixed etale algebra inverts no moving coefficient. The generic rational
identity therefore extends to every valid parameter by the actual trace
presentation. In particular it does not remove type-B parameters or
codimension-two intersections from the statement.

## The shorter coordinate remains valid

The change W_old=W_new+(B_0-L_0)/y changes only the polynomial-part
subtraction in scale coefficient zero. As computed in the earlier
endpoint-multiplier proof, that change is a scalar pulled back from X
times the chosen weight. Here the weight is eta^-1 and
\[
\operatorname{Tr}_{k(C)/k(X)}(\eta^{-1})=0.
\]
Therefore its two residues above every point of X cancel. No additional
branch-point correction appears. This concerns summed residues; it does
not assert that the shorter coefficient frame is everywhere integral.

Infinity series inversion now uses only h,w,Psi, and C_j is linear in the
supplied G_2. Thus the full coefficients have only these original unit
denominators. The supplied cubic covariance, with the weight eta^-1,
makes w*V_j(w*mu) invariant under w->zeta*w,h->zeta^-1*h and gives
the asserted H,q coefficient ring.

## Leading terms and compact exact construction

At O4, the first three terms of eta and Lambda suffice for the three
top coefficients. The O7 pole bound is smaller than each target degree.
The new script
[short leading calculation](../../scripts/arithmetic/degree140_inverse_eta_multiplied_leading_20260930.sage)
gives the three coefficients in the statement in1.21 seconds. It retains
the actual eta orientation. The exact rational expressions are in
`../../../litt3-computation-data/seventeen_hour_continuation_20260929/traces/inverse_eta_multiplied_leading.sobj`.

The [short residue engine](../../scripts/arithmetic/degree140_inverse_eta_short_20260930.hpp)
uses this proof's fixed-algebra correction. At h=2,w=7 it agrees with
18 new direct degree140-algebra trace evaluations, covering all three
polynomials beyond their degree bounds. Its receipt is
`../../../litt3-computation-data/seventeen_hour_continuation_20260929/traces/inverse_eta_short_h2_w7.json`.
This tests the new formula at one parameter and is not the global proof.

The [support-bound source](../../scripts/arithmetic/degree140_inverse_eta_multiplied_bounds_20260930.cpp)
propagates Laurent exponent intervals through the exact residue circuit.
Its coefficient-specific bounds are retained in `inverse_eta_short_bounds.json`
in the same external directory. Every inversion has a known monomial
leading term in h,w,Psi. The precision tracker rejects insufficient
series bounds; prescribed leading cancellations use the supplied exact
family identities. No shifted low coefficient is discarded.

After clearing the stated denominators, these bounds put the15 coefficients
in a box of H-degree at most61 and q-degree at most381. The
[new global grid](../../scripts/arithmetic/degree140_inverse_eta_grid_20260930.cpp)
uses62 by382 distinct allowed parameter values, with two calculation
threads and resumable completed columns. Polynomial interpolation in
that proved box reconstructs the global coefficients exactly; it is not
a finite-field search for solutions. It completed in26.64 seconds.
Rational compression gives cleared equation degrees(32,170,3),
(39,202,4),(47,231,5) in H,q,mu. The exact equations and coefficient
denominators are retained as `inverse_eta_global_equations.sobj` and
`inverse_eta_global_rational_coefficients.sobj` in the external directory.

No elimination or zero-locus decision is part of this result.
