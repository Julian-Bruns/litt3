# Proof: the elliptic joint surface has a Frobenius leaf criterion

Version1,3 October2026. Pending independent review. No computation is needed.

Write L=k(X′×X′), F=H1−cH2. Since dHi=ηi is nonzero on its factor, dH1 and dH2 are independent at the generic point. Hence H1,F are a p-basis of L over L⁵. Define V by V(H1)=1,V(F)=0 and V(L⁵)=0. It has V⁵=0. The diagonal cubic action scales each Hi, and therefore F, by ζ, since ζ⁻⁵=ζ. It scales V by ζ⁻¹. Consequently U=H1V is invariant and descends to W. On the p-basis monomials H1^iF^j,0≤i,j<5, it acts by multiplication by i. Thus U⁵=U and ker_L U=L⁵(F). This is exactly the tangent direction annihilating dF, so it is the asserted foliation.

The invariant surface field is obtained by adjoining t=y2/y1 to k(E×E). Its cube is P2/P1. This is a genuine degree-three extension: its divisor along a vertical simple P-root has valuation−1. The formulas for a and J follow directly. On a tangent curve η1=cη2 gives
\[
\frac{\lambda_2}{\lambda_1}=c^{-1}\left(\frac{w_1}{w_2}\right)^{10}\left(\frac{y_2}{y_1}\right)^2=c^{-1}a^2.
\]
Cubing recovers the requested equation (λ2/λ1)³=c⁻³(q1/q2)¹⁰(P2/P1)².

For the exact constant field, [L⁵:k(W)⁵]=3 and [L⁵(F):L⁵]=5. The cubic invariants of L⁵(F) therefore have degree FIVE over k(W)⁵. They contain J=F³, which is not a fifth power in k(W): dJ=3F²dF is nonzero generically. Hence these invariants are exactly k(W)⁵(J). Since [k(W):k(W)⁵]=25, the asserted quotient degree is FIVE.

Apply now the actual [joint-field cubic alternative](actual_q0_tensor_elliptic_joint_field_cubic_alternative.md). Its proof gives t∈k(D), and k(C0′)=k(D)(y1) of degree ONE or THREE. This constructs the actual curve image in W. Along C0′, η1=cη2 is equivalent to F=K⁵ because the kernel of differentiation of a one-variable function field over perfect k is its fifth-power subfield. If the cubic index is THREE, its deck scales F by ζ; uniqueness of fifth roots then scales K by ζ². Therefore K³ is fixed and belongs to k(D). Thus J=(K³)⁵ belongs to k(D)⁵ in both cases. Conversely, if J=M⁵ with M∈k(D), then for F≠0,
\[
F=(M^2/F)^5.
\]
The case F=0 is immediate. This proves the equivalence without replacing the actual two maps by arbitrary maps or presuming a simultaneous Galois closure. The original Y-field, if present, remains only on S.

The distinction between a first integral and a constant restriction is substantive. For example, normalize a component of the curve
\[
H_1-cH_2=x_1^5
\]
in X′×X′. Both projections are generically separating, since the two sides differentiated in their respective factors give the nonzero differentials η1 and cη2. Along this curve η1=cη2, but J=x1¹⁵ is nonconstant and a fifth power. Its actual elliptic joint field contains t by the preceding tangent calculation. The identity F=x1⁵ then gives y1⁵∈k(D), while y1³=P1∈k(D); hence y1∈k(D), and its cubic index is ONE. Its normalization consequently has genus at least31 by a separating projection to X′. This is already a higher-genus elliptic joint image, rather than a genus-one inference from the tangent equation.

This example need not satisfy the actual étale condition. More explicitly, H1−x1⁵ has a pole at infinity and therefore has zeros; none is a q-root, since H1 vanishes there and x1 is nonzero. At such a zero its differential is η1, a unit, so the zero is simple. On the second factor H2 has a zero at a q-root of order FIVE if Q is nonzero there and of order ELEVEN otherwise. A component through this pair has a ramified first projection. It therefore illustrates precisely the separable-map gap, not a common-cover construction.

Finally, if a is constant on an actual étale root self-span, the tangent equation makes the two λ-lines proportional. The accepted [elliptic differential recognition](actual_q0_tensor_elliptic_differential_recognition.md) then identifies the original X-fields. Proving that every actual étale leaf has this property is the remaining structural question.
