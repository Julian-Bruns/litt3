# Proof: exact calibration leaves one odd-numerator parameter

Version1,3 October2026. New necessary stratum form, whole scoped review PASS. No calculation is used. [Root audit](../../Research/audits/Q0_TENSOR_DEGREE_FIVE_WHOLE_RECOGNITION_AUDIT_2026_10_03.md).

Let the two simple infinity poles have distinct z-coordinates a,d. The actual z-map has degree TWO, ramified at R1,R2, so use its quadratic coordinate y²=Φ with simple zero ZERO and infinity pole FIVE in genus TWO, THREE in genus ONE. The exact poles give
\[
x_1=A_1/(zJ)+b_0y/(z^2J),\quad
x_2=A_2/J+c_0y/J,\quad J=(z-a)(z-d),
\]
with deg Ai≤THREE. The odd numerators are of degree at most ONE for genus TWO, TWO for genus ONE, and c0 has full degree. Their values at a,d are nonzero. At an ordinary pole, otherwise an even residue would also create a pole at the unwanted conjugate point. At a Weierstrass pole an odd numerator is necessary for its actual order-ONE pole.

In genus TWO, b0,c0 cannot be proportional. Indeed at each actual simple pole the q-leading identity gives a c0(a)²=b0(a)² and d c0(d)²=b0(d)². A constant ratio would force a=d. Thus they are coprime linears. In the specified elliptic case write b0=h b,c0=h c with h linear and residual b,c coprime linears. Its common root cannot be ZERO,a,d by the actual pole conditions. Put Y=h y,Ψ=h²Φ. In genus TWO set h=ONE. Normalize c=z+u,b=vz+w. The odd coefficient of the cube identity gives A1=cL,A2=bL with deg L≤TWO. The even coefficient is
\[
M(\Psi-zL^2)=D z(z^3-1)J^2,\qquad M=zc^2-b^2.
\]
M is monic cubic. At both a,d it vanishes. At an ordinary pole, cancellation at its unwanted conjugate yields Ψ(a)=aL(a)². At a Weierstrass pole, the even order-TWO polar term must vanish, yielding L(a)=ZERO and also Ψ(a)=ZERO. These statements imply that the multiplicity of a in M is at most ONE plus its multiplicity in z³−ONE; the same holds at d. Every remaining M-root belongs to z³−ONE. Consequently
\[
M=(z-r)J,\qquad r^3=1,\qquad
\Psi=z[L^2+D(z^2+rz+r^2)J].
\]
This reasoning includes r=a or r=d; it does not assume branch-coordinate disjointness.

The [exact calibration lemma](actual_q0_tensor_simple_infinity_calibration.md) gives a³=d³. Choose d=ωa by exchanging labels/primitive ω. Normalize r to ONE by a µ3 z-coordinate change and the corresponding y,L scaling, then normalize D to ONE by common centered xi scaling. Coefficient comparison gives w²=ωa². A centered x1 sign fixes w=ω²a. Since M has root ONE and b,c are coprime, b(ONE),c(ONE) are nonzero and b(ONE)=δc(ONE), δ=±ONE.

At each of a,d, the actual pole-leading ratio is a b(a)/c(a) or d b(d)/c(d). For an ordinary pole this follows by canceling the residue at the unused conjugate point; for a Weierstrass pole it follows from the odd order-ONE polar term and M(a)=ZERO. Calibration says those two ratios agree. Substituting d=ωa,w=ω²a gives
\[
u(v-1)=\omega^2va.
\]
The z² coefficient of M and b(ONE)=δc(ONE) yield
\[
(2\delta-1)\omega^2 a=(v-\delta)^2.
\]
For δ=ONE this gives a=ω(v−ONE)²,u=v(v−ONE),w=(v−ONE)². For δ=−ONE it gives a=3ω(v+ONE)²,u=(v+ONE)(ONE+2v). The calibration equation then forces (v+ONE)(v²−v+ONE)=ZERO. The first factor would make a=ZERO. In the second case u=−ONE and w=−v, so b,c have common root ONE, also impossible. Thus only δ=ONE survives. The asserted J,b,c follow. Their common-root determinant is
\[
w-vu=-(v-1)(v^2-v+1).
\]
This accounts for the stated v exclusions except ZERO. If v=ZERO, then b=ONE,c=z,J=z²+z+ONE. At R1, x2's odd part starts in order THREE, so its even derivative forces L1=L0. At R2, x1's odd part starts in order THREE, so its even derivative forces L1=L2. Hence L=λJ and Ψ=(λ²+ONE)zJ² has rational quadratic function field, contrary to genus ONE or TWO. This argument also handles the singular elliptic presentation. Therefore v≠ZERO. The normalized polynomials retain the possible r=a or r=d edges permitted by the remaining actual opens.

If both simple poles are Weierstrass, their even order-TWO polar terms must vanish, so L(a)=L(d)=ZERO. Thus L=λJ. If λ=ZERO, both xi are purely odd under the actual quadratic involution, which sends xi to−xi. For elliptic B, a pure-three degree-FIVE map has FOUR distinct finite branch values; for genus TWO it has FIVE. Each finite branch value contains at most one index-THREE point. Reflection preserves this finite set, and has at most one fixed value, so it contains at least TWO distinct reflected pairs with equal sum. All these values are roots of the fixed P. The accepted [strong-Sidon branch arithmetic](../curve_arithmetic/fixed_x_branch_strong_sidon.md) excludes such pairs. Thus λ≠ZERO; this uses actual fixed-P branching, not an arbitrary local model.

Write t=λ²,s=v−ONE and H=tJ+(z²+z+ONE), so Ψ=zJH. Smoothness at both actual Weierstrass poles forces H(a)H(d)≠0. Since J vanishes there, this is equivalent to Res(J,z²+z+ONE)≠0. The exact resultant equals(s²−ONE)²(s⁴+s²+ONE), whose vanishing is exactly s6=ONE. Also J(0)=s4≠0, Φ's leading coefficient is t+ONE and its simple-zero coefficient is s4(ts4+ONE), giving the listed physical opens.

For a possible necessary two-parameter test define
\[
V=2b'zJH+b[(-3J-zJ')H+zJH'],
\quad W=2c'zJH+c[(J-zJ')H+zJH'].
\]
Differentiation gives δx1=(V−2λuYJ)/(2z²J), δx2=(W+2λvYJ)/(2J), where δ=Yd/dz. The exact norm numerators are
\[
V^2-4tu^2\Psi J^2,\qquad W^2-4tv^2\Psi J^2.
\]
They have degree TEN with nonzero square leading coefficients v²(t+ONE)² and4(t+ONE)². Their denominators are squares. The same even-divisor norm argument used in the other degree-five forms forces both numerators to be quintic squares. An elliptic common-root presentation contributes only the additional square norm h², so it is included without a false smooth genus-two claim. These equations are necessary only and do not supply the fixed-P identities or a Y-leg.
