# One residue calculus for actual-source critical traces

[Statement](../../Theorems/cartier_and_spin/degree140_actual_source_traces.md).
The local charts and pole profiles are the accepted
[normalization report](../../../litt3-computation-data/september29_evening_replies/actual_ramification/REPORT.md),
Sections3,4,12, and the
[normalized criterion](degree140_normalized_critical_trace.md).
The calculations in that report are inputs, not new verification runs.

## Actual splitting and the trace dual

Over R=k[[r]] an actual etale source splits, with integral source roots
u_i and F_lambda=lambda*product_i(W-u_i). At a critical point of its
lambda fibre at least two roots have the same residue. Each summand of
the coefficient derivative
\[
\delta_0F_\lambda=-\lambda\sum_i(\delta_0u_i)
                              \prod_{j\ne i}(W-u_j)
\]
therefore vanishes at that point. Since phi is a unit there,
F_lambda=phi^2(lambda-Lambda) gives delta0Lambda=0. This uses the actual
split polynomial, with no division by a ramification index or eta.

If the two critical coordinates coincide, the three split source roots
form a monic cubic whose constant, linear and quadratic coefficients
lie in r^3R,r^2R,rR after translation. Its critical quadratic therefore
has discriminant in r^2R: an actual collision has ord_r(d)>=2.
The sharper local splitting criterion remains in
[the cubic-cluster theorem](degree140_critical_cubic_splitting.md).

At a critical collision the integral quadratic order is R[eta],
eta^2=d. A regular critical value has the form Lambda=A+k*d*eta:
division by the monic critical quadratic and its derivative forces the
odd coefficient to be divisible by d. Coefficient differentiation keeps
delta0Lambda in R[eta], since
delta0(d*eta)=(3/2)(delta0d)*eta. For J=j0+j1*eta,
\[
\operatorname{Tr}_{k(C)/k(X)}(J/\eta)=2j_1\in R.
\]
The identity retains both branches and every discriminant multiplicity.
The accepted reciprocal critical-coordinate chart has the same monic
division property, including collisions over scale zero.

For any finite lambda0, principal-part coefficients of U_f are sums of
residues of
\[
f\,(\delta_0\Lambda)^2(\Lambda-\lambda_0)^{j-1}
                                    \omega_0/\eta,\qquad j\ge1.
\]
Their quadratic traces are regular by the trace-dual identity, so the
paired sum of residues above each base point is zero. Residue
compatibility with field trace is valid also
in wild characteristic. The constant term at an actual nonzero scale
is the analogous residue with exponent -1. It is zero by
[split-source critical residue integrality](critical_residues_primitive_derivative.md),
using S''=-2eta and the actual split clusters of size two or three.
This replaces the earlier separate equal/unequal-discriminant-order
arguments. It does not assert regularity of each divided summand.

For T_f,Q_f the accepted finite-value and reciprocal charts make the
traced functions regular. Their zero values on an actual fibre give
nilpotent multiplication operators on that fibre algebra, hence zero
traces, including nonreduced fibres. All three traces are consequently
polynomials with the asserted necessary vanishing.

## A single pole table

Let e be the Lambda pole order, r_pi the index of C->X, and s the phi
order at an affine pole. Pullback of the affine unit omega0 has order
r_pi-1, giving pole(delta0Lambda)<=e+r_pi. At ordinary phi zeros e=2s;
at type A the data are(e,r_pi,s)=(1,1,3); at type B they are(5,2,5).
The local trace inequality pole(Tr(g))<=floor(pole(g)/e) gives affine
degree bounds2 for T and5 for Q. For U, the eta trace-dual identity
gives the affine bound2 even when eta vanishes. Explicitly, if
J=phi*S+t^3 is a unit and delta0Lambda=G/phi^3, then
\[
\frac{(\delta_0\Lambda)^2}{\eta\Lambda^{n+1}}
=\frac{(-1)^{n+1}G^2\phi^{2n-4}}{\eta J^{n+1}},\qquad n\ge3.
\]
The quadratic trace is regular. Type B has eta order1 on C, Lambda
pole5 and divided-function pole at most8, contributing degree at most1.

Above O the cover is unramified, omega0 has order16, eta has pole16,
Lambda has poles4,7, and delta0Lambda has poles21,24. Phi has poles20,7.
Subtracting these pole orders and adding p gives all three degree rows
in the statement. For U_(t*x^j), p=9+3j, yielding degrees3,4,5.
At ordinary phi poles the preceding regularity identity already applies
at n=2 after multiplying by t; hence coefficients of degree at least2
come entirely from infinity.

If Lambda=c0*z^-4+c1*z^-3+O(z^-2) at O4, residue expansion gives
[ell^5]T_1=3*c1*c0^-5. The accepted jets are
c0=<164100>h^3,c1=<259583>h^3w, giving <333905>w*h^-12.
For T_x only O4 contributes in degree6: using
omega0=-z^16*Y^-2 dz and Lambda'=c0*z^-5+O(z^-4),
x*delta0Lambda*dLambda/Lambda^7=-c0^-5*z^-1 dz+O(1)dz.
Negating its residue gives c0^-5. These are unit leading coefficients.

## Endpoint cancellation instead of a moving denominator

The two type-A eta-values in the
[endpoint-multiplier calculation](degree140_endpoint_multiplier_traces.md)
are4b and b. Replacing its eta weight by eta^-1 divides both simple
residues by the same b^2. Its old correction3*f*k*J*a*b^2 becomes
3*f*k*J*a, or in original coordinates4*f*t'*U0*G2/y^5.
Cubic trace with y^3=P gives the stated fixed-algebra correction C_j.
The two scale-degree-one corrections cancel; all later corrections are
zero. The final formula inverts no moving coefficient, so the generic
rational identity extends across type-B and intersecting strata through
the regular trace presentation.

Changing to the short primitive coordinate adds a base scalar times
eta^-1 to the polynomial-part correction. Its quadratic trace is zero.
Infinity inversion uses only h,w,Psi, and C_j is linear in G2; cubic
covariance therefore puts w*V_j(w*mu) in the stated H,q coefficient ring.
This argument transfers with the extra factor v in the root-nine proof;
it does not presume that the short coordinate is integral everywhere.

The first infinity jets give the three V_j leading terms. The same
correction for t*x^i*y^k replaces G2^(2) by G2^(2-k), and normalization
at scale degree n is w^(n+1-k).

## Exact inputs and retained checks

All new-data records for this calculus are in
[the trace evidence directory](../../../litt3-computation-data/seventeen_hour_continuation_20260929/traces/).
The original source and receipt pairs are retained:

| Formula or construction | Source under scripts/arithmetic | Evidence |
| --- | --- | --- |
| T_1 infinity jets | degree140_actual_derivative_leading_20260930.sage | actual_derivative_leading.json |
| U direct/residue comparison | degree140_inverse_eta_trace_probe_20260930.cpp, degree140_inverse_eta_residue_20260930.cpp | inverse_eta_probe_h2_w7.json, inverse_eta_residue_h2_w7.json |
| V leading residues | degree140_inverse_eta_multiplied_leading_20260930.sage | inverse_eta_multiplied_leading.sobj |
| Short residue engine | degree140_inverse_eta_short_20260930.hpp | inverse_eta_short_h2_w7.json |
| Proved support box and exact grid | degree140_inverse_eta_multiplied_bounds_20260930.cpp, degree140_inverse_eta_grid_20260930.cpp | inverse_eta_short_bounds.json, inverse_eta_global_equations.sobj, inverse_eta_global_rational_coefficients.sobj |

The two implementations agree on18 fixed-ratio evaluations. Those checks
test formulas, not geometric exhaustion. The global15 coefficients were
reconstructed in a proved62-by382 interpolation box, in26.64 seconds;
their cleared equation degrees are(32,170,3),(39,202,4),(47,231,5).
No computation was rerun for this consolidation. The reusable change is
one paired-residue proof in place of separate collision-case arguments.
