# Proof: two scalar-normalized source resultants have unit gcd

Version1,3 October2026. Independently accepted in the [nonreal and jet-budget audit](../../Research/audits/Q0_DEGREE_SIX_NONREAL_AND_JET_BUDGET_AUDIT_2026_10_03.md); see the [statement](../../Theorems/cartier_and_spin/actual_q0_tensor_degree_six_nonreal_involution_exclusion.md).

Retain the complete actual [ONE-uniform signed reduction](actual_q0_tensor_degree_six_one_uniform_elliptic_reduction.md). For the FOUR nonreal r choices put u0=a+a^-1,v0=a−a^-1,h=v0/u0,α=h². Both u0,v0 are nonzero and
\[
\alpha\in\{2,3\},\quad U=u_0^2=4/(1-\alpha),\quad
u_r=r^{-1}-r=u_0v_0=Uh.
\]
Write λ=h l and retain μ arbitrary. A change of the a-root scales the actual x-map by minus ONE, which does not affect a necessary norm-square equation. The TWO h-signs are also both covered: after this substitution every even norm coefficient lies in F5[l,μ], and every odd coefficient is h times that ring. The fresh source asserts this coefficient statement, so its equations apply to either h-root without presuming an automorphism of an original X-map.

Up to the nonzero scalar u0/TWO, the actual second x-map is
\[
f=(ht-1)L+(t+h)Y,\quad L=hl(t^2-1)+\mu t,
\quad Y^2=\Phi=A(t^4+1)+B(t^3-t)+Ct^2,
\]
\[
A=1+\alpha l^2,\quad B=h(2l\mu-U),\quad
C=\mu^2-2\alpha l^2+3,\quad
K=1+(1-\alpha)\alpha l^2.
\]
The actual source Hasse coefficient is the monic degree-FOUR μ polynomial
\[
I=2A^2-2B^2+C^2
=(\alpha l^2-\mu^2)^2+(U\alpha l-\mu)^2+2=0.
\]
Only ordinary ZERO/infinity and the actual own-triple pole open are needed below: A K≠ZERO. Additional smoothness and free-involution opens are NOT saturated in the calculation.

The derivative norm under the actual degree-TWO t-map is
\[
N=D^2-(E')^2\Phi,\quad
E'=h(hl)(3t^2-1)+(2h\mu-2hl)t-\mu,
\]
\[
D=3At^4+2hAt^3+(2C+4hB)t^2+(B+hC)t+(A+2hB),
\quad n_8=4AK\ne0.
\]
The [source](../../scripts/genus_two/oct03_q0_degree_six_nonreal_involution_resultant_gate.py) directly asserts E′=((ht−ONE)L)′ and D=Φ+(t+h)Φ′/TWO, as well as the Hasse identity and leading coefficient. Actual finite local indices ONE orTHREE force N to be a square, by the divisor argument in the preceding signed proofs. A scalar normalization of f does not change that condition over the algebraically closed field.

Divide by n8 and recover the unique monic quartic root candidate from the FOUR top coefficients:
\[
q_3=P_7/2,\quad q_2=(P_6-q_3^2)/2,\quad
q_1=(P_5-2q_3q_2)/2,\quad
q_0=(P_4-2q_3q_1-q_2^2)/2,\quad P=N/n_8.
\]
Let e_j be the coefficient of t^j in P−(t4+q3t3+q2t2+q1t+q0)² for j=ZERO,ONE,TWO,THREE, dividing e1,e3 by the nonzero h. Each e_j is a polynomial in μ with rational l coefficients whose denominators are supported only on AK. Reduce it modulo the monic source polynomial I; no leading μ coefficient is inverted. Every actual physical solution remains a common root of I and all FOUR reduced e_j. Therefore all FOUR resultants
\[
R_j(l)=\operatorname{Res}_{\mu}(I,e_j\bmod I)
\]
must vanish there. Any denominator clearing again uses only AK. Resultant vanishing is used only as a NECESSARY condition; no claim that it reconstructs a common μ-root is needed.

The ONE newly authorized bounded gate gives the following exact results.

| α | U | resultant numerator degrees, j=ZERO throughTHREE | gcd of FOUR numerators |
| --- | --- | --- | --- |
| TWO | ONE | NINETY-TWO,NINETY,NINETY,SEVENTY-FOUR | ONE |
| THREE | THREE | NINETY-SIX,NINETY-SIX,NINETY-SIX,EIGHTY | ONE |

For each row the receipt records the full source coefficients, reduced equations, resultant numerators and exact Bézout weights; their linear combination is directly asserted to equal ONE. Thus there is no physical common solution, without removing even an additional AK factor from a gcd. All λ/μ ZERO boundaries are retained by the resultants. The [separate hand boundary proof](actual_q0_tensor_degree_six_nonreal_involution_zero_boundary_exclusion.md) independently records their elementary contradictions.

The [receipt](../../../litt3-computation-data/oct03_q0_degree_six_nonreal_involution_resultant_gate/gate.json) records a successful one-worker execution in 3.226279 mathematical CPU seconds under a ten-second hard guard, with no timeout, Gröbner basis, candidate sweep or follow-up job. Both original source maps remain actual throughout the preceding induced joint-source construction. This closes the FOUR nonreal negative packets and makes no statement about BOTH-nonuniform maps.
