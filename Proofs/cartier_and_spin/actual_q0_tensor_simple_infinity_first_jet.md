# Proof: the tensor fixes the finite part and the z-residue

Version1,3 October2026. New actual-source lemma, whole scoped review PASS. No finite calculation is used. [Root audit](../../Research/audits/Q0_TENSOR_DEGREE_FIVE_WHOLE_RECOGNITION_AUDIT_2026_10_03.md).

The [leading calibration](actual_q0_tensor_simple_infinity_calibration.md) gives x2/x1=ρ=c³ at every shared simple infinity pole. The EXACT coarse identities give the cubic differential identity
\[
\frac{q_0(x_2)^8dx_2^3}{P(x_2)^2}=c^{-3}\frac{q_0(x_1)^8dx_1^3}{P(x_1)^2}.
\]
For T(x)=q0(x)8/P(x)², monic leading coefficients yield
\[
T(x)=x^{-4}(1+A/x+O(x^{-2})),\qquad A=8q_1-2p_9=3q_1-2p_9.
\]
At Q choose a uniformizer u and write xi=li/u+mi+O(u). The derivative has no order-u−ONE term, and−FOUR=ONE in characteristic FIVE, so
\[
T(x_i)dx_i^3=-l_i^{-1}u^{-2}\left(1+\frac{m_i+A}{l_i}u+O(u^2)\right)du^3.
\]
Its leading comparison is l2=ρl1. Its next coefficient gives (m2+A)/l2=(m1+A)/l1, hence m2−ρm1=(ρ−ONE)A. This is ξ(Q), independent of the common local parameter choice.

Write z=a+κu+O(u²). The q-cube identity's order-u−ONE coefficient, using ρ²=a³, is
\[
2(m_2-\rho m_1)+(1-\rho)q_1=3a^2\kappa l_1/\rho.
\]
The left side is (ρ−ONE)(2A−q1). In characteristic FIVE,
\[
2A-q_1=2(3q_1-2p_9)-q_1=p_9.
\]
This proves the asserted exact residue relation. Since a,l1,ρ are units and THREE is nonzero, κ=ZERO exactly when (ρ−ONE)p9=ZERO. The [fixed curve definition](../../Definitions/fixed_pair.md) gives p9=4α+TWO with α²+4α+TWO=ZERO. It is nonzero: p9=ZERO would give α=TWO, which does not satisfy that quadratic. Translating x preserves p9 because TEN=ZERO; common rescaling changes it only by a nonzero scalar. Thus the local normal forms retain p9≠ZERO.

For the degree-TWO z-map, κ=ZERO exactly at its Weierstrass points. A common simple pole which is Weierstrass forces ρ=ONE; an ordinary one forces ρ≠ONE. Because ρ is global, mixed positions cannot occur. For an ordinary pole u=z−a gives κ=ONE. Then the residue formula follows from a³=ρ². All these steps use the SAME actual two-map identities; no simultaneous Galois completion, scalar local normality assumption or one-leg substitution is made.

For separate coordinate signs or other necessary-condition changes of the two copies, expand each monic T_i=q_i8/P_i² with coefficient Ai=3q1,i−2p9,i. The same comparison gives ξ(Q)=ρA1−A2. The q-cube coefficient's left side is now2(ρA1−A2)+q1,2−ρq1,1, which in characteristic FIVE equalsρp9,1−p9,2. Hence the general-copy formulas in the statement hold. In particular κ vanishes at every shared pole or at none, since both transformed p9,i are nonzero and ρ is global. A separate centered sign changes one p9 coefficient, so the normalized Weierstrass condition is ρ=p9,2/p9,1, rather than necessarilyρ=ONE. Equality of ξ values at different shared poles remains unchanged.
