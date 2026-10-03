# Proof: the genus-two degree-four hyperelliptic normal form

Version1,3 October2026. Necessary form used in the independently accepted [whole genus-two exclusion](../../Research/audits/Q0_FOUR_GENUS_TWO_WHOLE_AUDIT_2026_10_03.md). This is not a finite gate computation or a whole exclusion.

The actual [coarse reduction](actual_q0_tensor_cubic_coarse_curve_reduction.md) gives a common q-zero divisor and q2/q1=z³. An unramified infinity point for one map is unramified for the other: its q-valuation−2 must match modulo THREE and cannot meet a common q-zero. If all FOUR infinity points were unramified, z would be constant, and q2=Cq1 would give a joint x-curve of degree at most TWO. Hence both maps have poles3Ri+Q, with Q common. If R1=R2 the same contradiction applies. Thus div(z)=2R1−2R2. Since B has genus TWO, this degree-two function is its hyperelliptic map; R1,R2 are Weierstrass, and Q has a finite nonzero image a distinct from them.

Choose y²=Φ(z), with squarefree Φ of degree FIVE and Φ(0)=0. Resolve each Xi into its invariant and anti-invariant parts under the hyperelliptic involution. Both parts can have poles only at Ri,Q and the conjugate of Q. At R1 the pole bounds give a denominator z in the invariant part and z² in the anti-invariant part, since y has order ONE there. At Q a denominator z−a suffices, including at a Weierstrass Q: y has order ONE and z−a order TWO there. At R2 the orders of z,y are−2,−5. Consequently
\[
X_1=\frac{A(z)}{z(z-a)}+\frac{by}{z^2(z-a)},\qquad
X_2=\frac{B(z)}{z-a}+\frac{cy}{z-a},
\]
with deg A,deg B≤2. The coefficients b,c are nonzero, because the actual poles at R1,R2 have odd order THREE. Equating odd parts in X2²+D=z³(X1²+D) gives Bc=Ab. Put κ=c/b. This is the asserted pair of formulas. Equating even parts gives
\[
b^2\Phi(z)=\frac{zA(z)^2}{\kappa^2}
 +\frac{D z(1-z^3)(z-a)^2}{\kappa^2z-1}.
\]
Because Φ is polynomial, evaluation at z=κ⁻² forces either a=κ⁻² or κ⁶=1.

When Q is not Weierstrass, its conjugate is a different point and neither Xi has a pole there. Cancellation in both displayed numerators gives aA(a)+by(ιQ)=0 and A(a)+κ²by(ιQ)=0. Here b,y(ιQ),A(a) are all nonzero. Therefore aκ²=1.

When Q is Weierstrass, the invariant parts must be regular there, since their possible poles have even order while the actual pole has order ONE. Thus A(a)=0. Suppose a≠κ⁻². The preceding polynomiality argument then gives κ⁶=1, so (1−z³)/(κ²z−1) is polynomial. Both terms in the formula for Φ are divisible by (z−a)², because A(a)=0. This contradicts squarefreeness. Hence a=κ⁻² in this case as well. After cancellation the formula becomes
\[
b^2\Phi=a z\bigl(A^2+D(1-z^3)(z-a)\bigr).
\]
If Q is Weierstrass, its root must be simple. Since A(a)=0, the derivative of b²Φ there is Da²(1−a³), which is nonzero precisely when κ⁶≠1. If Q is not Weierstrass, the same formula gives b²Φ(a)=a²A(a)²≠0.

Squaring z²(z−a)X1=zA+by, substituting the formula for Φ, and cancelling z(z−a) gives the stated quartic. Its coefficient of z4 is (X1−A2)². Its constant coefficient is A0²−Da; nonvanishing follows from the simple root of Φ at ZERO. The degree-FIVE condition on Φ is A2²−D≠0.

The formula for X1 reconstructs y rationally from z,X1; hence k(B)=k(z,X1). Its degree over k(X1) is the actual FOUR, so the quartic is irreducible. The local ramification of X1 is only ONE or THREE, and the actual monodromy is A4 by the accepted coarse reduction. In characteristic FIVE the usual discriminant square character is the sign of the permutation action on the four roots, so its discriminant belongs to k(X1)×².

No sufficiency has been asserted: square discriminant alone does not impose the selected P-branch set, the second P-cube identity, or equality of the tensor differentials. The retained actual maps are the antecedent, and an original Y-leg stays on its original source.
