# Cancelling the endpoint denominators before global elimination

30 September2026. [Statement](../../Theorems/cartier_and_spin/degree140_endpoint_multiplier_traces.md).
Use the proper polar replacement of
[the fixed-endpoint residue theorem](degree140_fixed_endpoint_residue_traces.md).
This proof is local at a generic type-A endpoint first. Every final
expression has only the original infinity-unit denominators, so the
actual primitive trace presentation extends it to the other valid
normalization strata.

## The constant coefficient on the pole branch

Use t as local parameter, put k=delta(t), and write phi=t^3 J. On the
critical branch reducing to phi=0, the source congruences give
\[
T+S\phi=t^5 K,\qquad T=t^3.
\]
Here J and K are units at a generic admitted parameter. Set B=delta phi,
Nplus=delta T+BS, and
\[
V=S Nplus-T\delta S=S\delta(T+S\phi)-(T+S\phi)\delta S.
\]
Characteristic five gives delta(t^5)=0, hence ord_t(V)>=5.

For m=0,n=0, let Psi_raw denote the polar sum before subtracting its
polynomial part in W. Direct geometric-series division gives
\[
\Omega_0-\Psi_{\rm raw}
=-f\eta\frac{V^2}{T^2(T+S\phi)}\omega_0.
\]
Its order is at least -1 before multiplying by t. For m=-1,n=0 the
corresponding identity is
\[
\Omega_0-\Psi_{\rm raw}
=f\eta\frac{S V^2}{T^3(T+S\phi)}\omega_0,
\]
of order at least -4 before multiplying by t^4. Thus the raw polar
replacement and Omega have the same residue on the pole branch after
the respective multipliers. The proper replacement still subtracts its
polynomial part; that subtraction must be retained.

## Computing the proper replacement on both branches

At t=0 translate the critical coordinate to Vc=W-W0. Write the specialized
cubic as
\[
S=-J^{-1}+b V_c^2+a V_c^3,\qquad \phi=V_c^5.
\]
The second critical root is Vc=b/a. The two eta-values are eta0=4b and
eta1=b=-eta0. These assertions can be made on the generic chart a b!=0;
the resulting answer below does not invert either coefficient.

For Tr(t f v), only the last term of the raw polar sum can contribute on
the nonpole branch. Its leading pole is
\[
4k^2t^{-2}\,S(1+JS)^2/\phi.
\]
As a rational function of Vc,
\[
S(1+JS)^2/\phi
=-J(b+aV_c)^2/V_c+J^2 V_c(b+aV_c)^3.
\]
Its proper part is -J b^2/Vc and its polynomial part at Vc=0 is -2Jab.
Subtracting this polynomial part on the pole branch, and adding the
proper part on the nonpole branch, gives the total endpoint residue
\[
2f\eta_0 kJab=3f kJab^2.
\]
Here f means its endpoint value. No derivative of f occurs, because
after multiplication by t each contributing pole is simple.

For Tr(t^4 f v/phi), the only possible raw pole on the other branch is
k^2*t^-5*S^2(1+JS)^2/phi. The proper part of S^2(1+JS)^2/phi is b^2/Vc,
and its polynomial part at Vc=0 is2ab. The same two-branch calculation
therefore gives
\[
2f\eta_0 kab=3f kab^2.
\]
This proves both constant-coefficient formulas in primitive coordinates.

## Positive coefficients have no endpoint correction

For m=0,n=1 the two raw polar terms are
4B^2/phi^2 and B*Nplus/(T phi). On the pole branch their only residue
after multiplication by t is eta0*k*f, exactly that of Omega1. The
other branch is regular. There is no polynomial part in W for these
terms. For n>=2, the multiplier t makes both residue contributions
regular or zero.

For m=-1,n=1 the three raw polar coefficients are
\[
4B^2,\qquad BNplus/T,\qquad
(\delta T)Nplus/T^2+B\delta S/T.
\]
The last polynomial has W-degree at most three, so again no polynomial
part is subtracted. At the pole branch use Nplus=delta(t^5K)-phi delta S.
The last coefficient is regular; the middle term, after dividing by
phi^2 and multiplying by t^4, is also regular. The first term gives
the residue eta0*k*f/J, which equals the Omega1 residue. The other
branch is regular after this multiplier. For n>=2, the valuation
bounds make every endpoint contribution zero. This covers every
positive scale coefficient, not just a bounded sample of them.

## Reduce the remaining constants to a fixed algebra

In the original coordinates set b0=G3-3L0*G2 at an endpoint x=r. The
primitive coefficients are a=G2/y^2 and b=b0/y^3. Also
k=3y^2*t'(r), J=U0(r)/y^5. The two endpoint contributions are therefore
\[
4f t' U_0 G_2b_0^2/y^{11},\qquad
4f t' G_2b_0^2/y^6.
\]
Since y^3=P, summing over the three cubic sheets extracts respectively
3r2/P^3 and3r0/P^2. Summing over the three roots of t proves the two
rank-three trace formulas in the statement. Only reduction modulo the
fixed cubic t and inversion of the fixed unit P are needed.

The coefficients G2,G3 are affine-linear in h and Laurent-polynomial in
w. Hence these constants have h-degree at most three. Cubic covariance
identifies the normalized coefficients with rational functions of H=hw
and q=w^3, as in the earlier global positive-trace proof. Infinity
inversions use only h,w,Psi. The displayed constants introduce no new
parameter denominators, so the same normalized function-field
specialization argument includes the exceptional primitive charts.

## A shorter infinity coordinate for the T traces

The native implementation uses (Z+L0)/y at infinity instead of
(Z+B0)/y. This reduces the coefficient pole orders of the cubic to
12,16,17,18. It does not silently discard poles at the cubic branch
points. To compare the two polar formulas put c=(B0-L0)/y, so the old
coordinate is the new coordinate plus c. Coefficient differentiation
changes delta S by (delta c)*S_W. On the critical curve this is zero.
Only the polynomial-part subtraction in the constant coefficient can
change: the difference in C3 is -2*Nplus*(delta c)*S_W/T. It has W-degree
five, so its quotient by phi is the constant -B*a^2*(delta c)/T.
The two differential formulas therefore differ by eta times a pullback
from X. Since Tr_(C/X)(eta)=0, their summed residues above EVERY point
of X agree. In particular the two infinity residues agree, and no new
finite correction is needed. The positive-coefficient formulas have no
polynomial part affected by this change.

This is a trace identity, not an assertion that the shorter coefficient
frame is affine regular on X. Its computational benefit is substantial:
the new three-trace profile uses a short infinity expansion and the
fixed rank-three endpoint algebra, rather than endpoint jets or the
degree140 finite algebra.

## The monic degree-thirteen condition

The pole order of x^2*t is15. The incoming trace bound gives degree13.
At O4, use the fixed parameter xi=x^3/y. The leading terms are
omega0=4xi^16 dxi, eta=epsilon*xi^-16, Lambda=L*xi^-4 with
L=-K0*h^3. Consequently v=4epsilon*L*xi^-37 and
x^2*t*v=4epsilon*L*xi^-52. The tame index four trace has leading
coefficient4*(4epsilon*L)/L^13=epsilon*L^-12. O7 contributes degree at
most floor(55/7)=7, and the finite endpoints contribute only to the
constant correction already computed. Thus this leading unit cannot
cancel. Necessity at a fully ramified fibre follows from the accepted
regular-vector-field trace criterion.

The
[native fixed-algebra implementation](../../scripts/arithmetic/degree140_endpoint_trace_native_20260929.hpp)
contains `closed_constants`. At h=2,w=3 both closed formulas agree with
the independently implemented local residue expansions in that file;
the local expansion itself had already been compared with the separate
Sage prototype. These checks concern new formulas only. No incoming
verification run was repeated. Compact receipts are in
`../../../litt3-computation-data/seventeen_hour_continuation_20260929/traces/endpoint_t_closed_2_3.json`
and `endpoint_t4_closed_2_3.json` in the same directory.

The full new
[degree11/12/13 engine](../../scripts/arithmetic/degree140_endpoint_multiplied_traces_20260929.hpp)
also agrees at sixteen distinct scale values with the independent
finite-algebra trace at h=2,w=3, and its degree13 coefficient is exactly
the displayed unit. Degree bounds make that a check of each complete
polynomial at this ratio. Its focused receipt is
`multiplied_new_check_2_3.json` in the same directory. A profile at
precision160 takes about0.0034 seconds on one CPU core in the recorded
run, with every requested Laurent coefficient inside the tracked
precision. This timing is implementation evidence, not a mathematical
assumption or an all-ratio exclusion.
