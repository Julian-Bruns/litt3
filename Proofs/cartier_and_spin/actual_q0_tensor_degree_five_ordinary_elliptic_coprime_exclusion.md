# Proof: four univariate square gates have no ordinary residue

Version1,3 October2026. New whole elliptic-coprime stratum exclusion, whole scoped review PASS; see the [statement](../../Theorems/cartier_and_spin/actual_q0_tensor_degree_five_ordinary_elliptic_coprime_exclusion.md). This is a fresh bounded necessary-equation calculation, not a replay of settled inputs. [Root audit](../../Research/audits/Q0_TENSOR_DEGREE_FIVE_WHOLE_RECOGNITION_AUDIT_2026_10_03.md).

## Complete one-parameter scope

The [full ordinary parameter theorem](actual_q0_tensor_degree_five_ordinary_parameter_forms.md) supplies p²=ν,ν²=ν+THREE,ω=ONE+TWO ν, and the TWO µ6 transversals
\[
U_0(r)=r^3-1,\qquad U_1(r)=r^3+2\omega^2r^2+2\omega r+1.
\]
For each type j and independent first-copy sign ε=±ONE, factor
\[
f(r)=U_j(r)(r-t)(r-\omega^2t)=r c(r^2)+b(r^2),
\]
and put J=z²+ω²t²z+ωt4,ρ=−t³,K=ερ−ONE. The genuine pole opens include tK≠ZERO and c(t²)c(ωt²)≠ZERO. In particular c is invertible modulo J. The unique linear H satisfying Hc=z²J′/ρ modulo J gives ℓ=KH and the smooth cubic
\[
\Phi=z[\nu\ell^2+J],\qquad y^2=\Phi.
\]
The two SAME original centered/scaled functions are
\[
x_1=\frac{pc\ell}{zJ}+\frac{by}{z^2J},\qquad
x_2=\frac{pb\ell}{J}+\frac{cy}{J}.
\]
The transversal label changes do not create extra types: the explicit z-rotation gauge leaves BOTH xi unchanged, while complement is exactly the retained ε sign. A pole can coincide with a µ6 point when c stays nonzero there. No t6−ONE open is imposed. The leading coefficient of b is allowed to vanish.

## Both necessary norm squares, including infinity degree drop

Set A=cℓ,B=bℓ, and define
\[
U=A'zJ-A(J+zJ'),\qquad
V=(b'\Phi+b\Phi'/2)zJ-b\Phi(2J+zJ'),
\]
\[
C=B'J-BJ',\qquad
W=(c'\Phi+c\Phi'/2)J-c\Phi J'.
\]
Direct differentiation gives dx1/dz=pU/(z²J²)+V/(y z³J²) and dx2/dz=pC/J²+W/(yJ²). Hence the two quadratic norm numerators, up to a nonzero scalar sign, are
\[
N_1=(V^2-\nu z^2\Phi U^2)/z^2,\qquad
N_2=W^2-\nu\Phi C^2.
\]
The first numerator is divisible by z². Their degrees are at most TWELVE and exactly TWELVE, respectively.

Both must be polynomial squares up to scalar. Indeed each actual xi:B→P¹ has ONLY indices ONE or THREE, so its differential divisor has EVEN orders, including poles. Norming dx_i/dz gives odd parity precisely at the branch divisor of the hyperelliptic z-map. The displayed denominator Φ contributes that branch parity; all remaining denominator factors have even exponents. Thus every finite zero of N_i has even multiplicity. Over the algebraically closed field this is the required polynomial-square condition.

The nonzero leading root for N2 is Φ3, because its leading coefficient is Φ3². For N1 use the reversed degree-TWELVE polynomial
\[
\widehat N_1(z)=z^{12}N_1(1/z).
\]
Its leading coefficient is [b0 Φ1 J0]², a nonzero actual pole coefficient. A polynomial of degree at most TWELVE is a square if and only if this reversed polynomial is a square. This retains degree-TEN N1 specializations when the leading coefficient of b vanishes; it does not saturate that coefficient away.

For either norm start its degree-SIX candidate square root at the stated leading root. Its next SIX coefficients are uniquely determined by matching degrees ELEVEN through SIX, dividing only by twice that nonzero leading root. The SIX remaining coefficients give necessary equations. Both norms together yield TWELVE rational univariate equations for each j,ε.

## Exact new calculation and physical boundaries

The [source](../../scripts/genus_two/oct03_q0_degree_five_ordinary_elliptic_coprime_gate.py) derives these equations directly over F25(t). It asserts M=zc²−b²=(z³−ONE)J, the defining interpolation identity, exact division by z², both norm degrees and both leading-square identities. It records every equation numerator, the exact candidate roots, physical opens, and an executed Bezout identity for their raw gcd. Every cleared equation denominator is checked to be supported on the explicitly physical opens.

Those opens are t,K,Norm(c modulo J), the cubic leading coefficient Φ3, its simple-zero coefficient Φ1, the discriminant of Φ/z, and the two known nonzero leading roots. Thus the source never excludes a valid pole/µ6 coincidence or an allowed leading coefficient drop. The cubic smoothness open is legitimate because B is the ACTUAL elliptic curve, rather than a singular auxiliary genus-two model.

The [receipt](../../../litt3-computation-data/oct03_q0_degree_five_ordinary_elliptic_coprime_gate/gate.json) records the following raw monic gcds. Both norm systems are included in every row:

| Type | ε | Raw gcd of the TWELVE numerator equations |
| --- | --- | --- |
| U0 | +ONE | ONE |
| U0 | −ONE | t6+THREE t3+ONE=(t³−ONE)² |
| U1 | +ONE | ONE |
| U1 | −ONE | t²+(ν+THREE)t+THREE ν+THREE=(t−ω)² |

The first and third rows already exclude all t. In the other rows K=t³−ONE. Their only zeros therefore have K=ZERO, impossible for either actual ordinary residue. Removing only physical-open factors gives gcd ONE in ALL FOUR cases. The source independently asserts each recorded Bezout combination equals the raw gcd and records every removed factor; no Gröbner basis or finite candidate sweep is used.

The one sequential worker completed ALL FOUR cases in0.778122 mathematical CPU seconds, with no timeout. A hard OS ten-CPU-second guard backed the Python timer. No completed earlier gate was repeated.

This excludes the entire ordinary elliptic coprime-quadratic stratum. Both original finite étale maps stay on the SAME original source throughout, and no parameter solution is promoted to a Y-map. The TWO-parameter genus-two and elliptic shared-root models remain unexcluded.
