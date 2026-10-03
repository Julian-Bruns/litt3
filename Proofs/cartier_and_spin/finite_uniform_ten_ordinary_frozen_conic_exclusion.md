# Proof: actual differential comparison forces an impossible order-ten contact

Version2, 3 October 2026. [Independent whole-scope audit PASS](../../Research/audits/OCT03_FINITE_TEN_ORDINARY_FROZEN_CONIC_EXCLUSION_AUDIT_2026_10_03.md), including q0-zero points, with no required corrections. Neither actual finite étale endpoint map is replaced. See the [statement](../../Theorems/cartier_and_spin/finite_uniform_ten_ordinary_frozen_conic_exclusion.md).

## Actual local necessity and the exact tensor phase

Use k=bar F5, β²=β+3 and coefficient encoding [a+5b]=a+bβ. The fixed monic polynomial P has ascending coefficient list
\[
[11,22,18,5,19,20,15,16,9,22,1].
\]
Put Xi=xi+1, q_i=Xi²+d0 with d0=[23], and s=z(P)³. Work at the stated ordinary finite open: Xi and y_i are units, and dx1 is a local differential frame because h1 is étale and P(x1)≠0. Put v=ord(q1), which is zero or one since q1 has unit derivative2X1. The two q_i have the same valuation because z is a unit. The degree-ten local different and the actual tower through Q give ord(dz)≥13; the Q/z different, if any, only increases it.

Differentiating q2=z³q1 and using the actual θ1=κz⁸θ2 yields
\[
\left(\frac{q'_2y_2^2}{\kappa z^8y_1^2}-z^3q'_1\right)dx_1
=3z^2q_1\,dz.
\]
Let a,b be the two unit terms in parentheses. Then a−b has order at least13+v. Since a≡b modulo the maximal ideal and3≠0, a²+ab+b² is a unit; hence a³−b³ has the same order. Cubing clears the y-values using y_i³=P(x_i), and κ³=1 is explicitly retained. Since q'_i=2Xi, multiplying by the unit z²⁴P(x1)²/8 gives the ACTUAL polynomial numerator
\[
K=X_2^3P(X_2-1)^2-z^{33}X_1^3P(X_1-1)^2,
\qquad\operatorname{ord}(K)\ge13+v.
\]
No division by a q_i is used. On the q_i-unit sublocus this is equivalently the rational-function comparison for H(X)=X³P(X−1)²/(X²+d0)¹¹, but that rational comparison is unnecessary at a q0-zero. There is no unlabelled phase replacement in this step.

Choose the unique local frozen branch V with V(P)=X2(P) and
\[
V^2=sX_1^2+d_0(s-1).
\]
It exists since2X2(P) is a unit. The actual z-index is at least ten, so z³−s has order at least ten. Consequently
\[
(X_2-V)(X_2+V)=(z^3-s)q_1
\]
has order at least10+v, with X2+V a unit. Thus X2−V has order at least10+v. Polynomial evaluation gives V³P(V−1)²−X2³P(X2−1)² of order at least10+v, and z³³−s¹¹ has order at least ten. Combining these with K gives
\[
\operatorname{ord}\big(V^3P(V-1)^2-s^{11}X_1^3P(X_1-1)^2\big)\ge10.
\]
Because X1−X1(P) is an actual source parameter on this ordinary open, this is polynomial contact order at least ten in the X1-coordinate, including v1 at q0-zero points. In particular the argument includes the finite C10 different25 case at d25; its stronger actual order at least25 is not needed for the frozen bound.

## A polynomial norm and fixed-degree principal subresultants

Write R(V)=P(V−1)²=R_even(V²)+V R_odd(V²), and set
\[
T=sX^2+d_0(s-1),\quad
A=T^2R_{\rm odd}(T),\quad B=TR_{\rm even}(T),\quad
C=A-s^{11}X^3R(X).
\]
The frozen numerator is F=C+VB and its actual quadratic norm is
\[
N(X,s)=C^2-TB^2\in\mathbf F_{25}[s][X].
\]
At a fixed s and a local branch V, the polynomial contact gives ord F(V)≥10. The conjugate branch F(−V) is regular, so ord N≥10. A conjugate collision can increase that order; the norm condition is used only as necessary. All actual clearing factors in K were units even at q0-zero points; no rational H denominator is needed.

The polynomial N has exact X-degree46 and leading coefficient
\[
\operatorname{lc}_X(N)=s^{22}(1-s).
\]
Indeed the top terms are s²²X⁴⁶ from C² and s²³X⁴⁶ from TB². Since46≡1 modulo5, ∂N/∂X has degree45 and the same leading coefficient. Thus every geometric s outside0,1 preserves both degrees. These degree-drop parameters are explicitly retained rather than removed by an unsupported specialization argument.

A root of N of multiplicity at least ten makes gcd(N,∂N/∂X) have degree at least nine. In characteristic five the derivative may vanish to even higher order, which strengthens this necessary bound. For two fixed-degree polynomials, a gcd of degree at least nine forces their integral principal subresultant coefficients PSC0,…,PSC8 to vanish. In particular PSC7=PSC8=0.

## Exact executed certificate and its verification

The [bounded source](../../scripts/oct03_frozen_conic_principal_subresultant_probe.sage) implements the integral schoolbook subresultant recurrence from the installed Sage source, with exact coefficient divisions. If the preceding polynomial has degree d and its pseudo-remainder B degree e, B is S_(d−1); when d−e>1, the scaled C is S_e and intervening principal coefficients are zero. This preserves the subresultant index even at deficient remainders.

Before the large recurrence, the SAME executed process checked a tiny deficient example
\[
f=W^4+W^2+W+1,\qquad g=W^3+W.
\]
Its S2 has degree one and PSC2 is zero. The indexed recurrence agreed with installed Sage's nonzero subresultants, and its PSC0,PSC1,PSC2 agreed exactly with direct Sylvester principal minors. This check and every large-recurrence checkpoint are recorded in the [complete fresh output](../../../litt3-computation-data/oct03_frozen_conic_principal_subresultant_probe/stdout.jsonl).

The large calculation produced PSC8 of s-degree1689 and PSC7 of s-degree1734. Their common factor away from s0,s1 is ONE. Complete field-coded coefficient lists for both polynomials are in the output. Therefore no geometric s outside0,1 can make both vanish, and the necessary order-ten norm gate is impossible.

The [receipt](../../../litt3-computation-data/oct03_frozen_conic_principal_subresultant_probe/receipt.json) records the exact source SHA256, command, six one-thread environment settings, hard external thirty-second timeout, successful exit and6.21-second elapsed time. The actual mathematical recurrence reached its decision in3.34 seconds. No Gröbner basis, group enumeration or parameter sampling was run. The earlier23 F25 samples are separate exploratory evidence and are not a dependency of the present arbitrary-geometric decision.

The [independent verifier](../../scripts/verify_oct03_frozen_conic_psc_certificate.py) used only standard-library F25 Euclidean arithmetic on the recorded PSC7/8 arrays. Its single authorized bounded audit process passed in0.417 seconds. It stripped s⁹⁸⁸(s−1)⁷⁷ from PSC7 and s⁹⁸⁰(s−1)⁷⁵ from PSC8, leaving degrees669 and634, and checked an explicit Bézout identity ONE. The [complete independent certificate](../../../litt3-computation-data/oct03_frozen_conic_principal_subresultant_probe/independent_gcd_bezout.json) stores those remaining arrays and the two Bézout coefficients. It did not reconstruct N or repeat the successful subresultant calculation.

## Applying the ordinary gate at the residual-twenty equality boundary

The audited [common-infinity confinement](canonical_ten_residual_twenty_common_infinity_confinement.md) forces at d25 three full quadratic π-fibers over the three values z³=1. Each of the fifteen common points has source z-index exactly four. Since z:C→P1 has degree twenty, these points account for all sixty zeros of z³−1. Its poles are the ten D2 points of order six. Thus
\[
\operatorname{div}(z^3-1)=4J-6D_2.
\]
No finite point has z³=1. In particular s1 cannot occur at the finite uniform-ten point of the exceptional profile.

The same common leading coefficient ratioρ=1 gives the exact phase κ³=1: if x_i has leading coefficient l_i at a common triple pole, then cubing dx_i/y_i² gives leading coefficient proportional to l_i^(-17), so the ratio of the two θ³ leading coefficients isρ^17=1. At that point z³=ρ²=1, and θ1³=κ³z²⁴θ2³ forces κ³=1. This is a consequence of the actual comparison and its leading data, not a freely chosen phase.

The ordinary finite C10 locus, including q0-zero points, is therefore excluded at d25. The argument deliberately retains finite P-branch points and shifted-coordinate zeros, where the local coordinate, unit clearing or frozen branch hypothesis changes. These local gate limits are preserved; the complete retained residual-twenty packet is separately closed by the [all-degree parity theorem](canonical_ten_nonsplit_residual_twenty_all_degree_exclusion.md). Both actual endpoint maps stay on C and on the original T; no whole d25 or unrestricted common-cover conclusion is drawn.
