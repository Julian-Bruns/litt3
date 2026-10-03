# Proof: the third triple-pole coefficient fixes the common finite part

Version1,3 October2026. The common-triple calculation is accepted in the [Version2 jet-budget review](../../Research/audits/Q0_DEGREE_SIX_NONREAL_AND_JET_BUDGET_AUDIT_2026_10_03.md). See the [statement](../../Theorems/cartier_and_spin/actual_q0_tensor_common_triple_value_and_overlap_bound.md).

Use the accepted actual [common triple jet](actual_q0_tensor_common_triple_infinity_jet.md) and [all-degree second-jet budget](actual_q0_tensor_all_degree_infinity_second_jet_budget.md). In an actual source uniformizer u at a common triple pole write
\[
x=l u^{-3}+m u^{-2}+n u^{-1}+k_0+k_1u+\cdots,
\quad a=m/l,\quad b=n/l,\quad c_0=k_0/l.
\]
The fixed normalized target tensor is T(x)(dx)³, with T(x)=x^-4(ONE+A/x+B/x²+…). Through degree THREE of its regular normalized source bracket,
\[
x^{-4}=l^{-4}u^{12}(1+a u+b u^2+c_0u^3+\cdots),
\]
because (ONE+s)^-4=(ONE+s)/(ONE+s)5 in characteristic FIVE. Also
\[
(dx)^3=(-3l)^3u^{-12}
\left(1+2a u+(b+3a^2)u^2+(4a^3+3ab)u^3+\cdots\right).
\]
The A/x term first contributes A u³/l; B/x² starts at degree SIX. Multiplication gives
\[
T(x)(dx)^3=\frac3l
\left[1+3a u+2b u^2+
\left(\frac{k_0+A}{l}+2a^3+ab\right)u^3+\cdots\right](du)^3.
\]
The common leading scalar gives l2=ρl1. The accepted TWO preceding coefficients give m2=ρm1,n2=ρn1, hence the ratios a,b are common. Comparison of the displayed third coefficients therefore gives
\[
k_{0,2}-\rho k_{0,1}=\rho A_1-A_2=\xi_0.
\]
The earlier cancellation of negative powers made ξ regular here; its value is exactly this constant. This is the SAME global constant as at shared simple poles, not a choice depending on Q.

The accepted interpolation function F(z)=ξ0+C(z³−ρ²)/(THREE ρ²) has F(a)=ξ0 at every common triple point, since its z-value still satisfies a³=ρ². Thus ξ−F vanishes there to order at leastONE. It has double zeros at all u shared simple points. If C≠ZERO its exact poles are THREE R1+SIX R2, so degree of its zero divisor gives TWO u+c≤NINE r′. If C=ZERO or the first-jet sector is critical, use ξ−ξ0 instead. Its poles are THREE R1+THREE R2 and its simple-point zeros are still double by the accepted source-parameter second jet. This gives TWO u+c≤SIX r′ in the entire ρ²=ONE sector. The constant-function exception forces joint degree at mostTHREE as before and is outside d>THREE. When u=ZERO, the same common-triple zeros and pole bounds remain valid; no local z-parameter at a simple point is required.

For the local z-index use the exact identity
\[
q(x_2)-\rho^2q(x_1)=2\rho x_1\xi+\xi^2+1-\rho^2,
\quad q(x)=x^2+1.
\]
If K≠ZERO then ξ0=THREE Kp≠ZERO, so its right side has exact pole THREE at Q, while q(x1) has pole SIX. Therefore z³−ρ² has exact order THREE. The cubing map is étale at the nonzero z-value, so z has exact local index THREE. If K=ZERO then ρ²=ONE and ξ(Q)=ZERO. The first right-side term now has pole at mostTWO, while the other terms have no poles. Thus z³−ρ², and hence z−a, have order at leastFOUR. This proves both local assertions without using an inverse-cube source parameter.

The exact global divisor of z is TWO R1−TWO R2, so deg z=TWO r′. The function is separating: its residual valuation TWO is not divisible by FIVE. If r′=ONE and any common triple point exists, its local index at leastTHREE exceeds its degree TWO, a contradiction. The all-common case r′=ZERO was already excluded by the constant q-ratio and d>THREE. Hence c>ZERO forces r′≥TWO.

Finally the source coefficient involving k1/l at degree FOUR cancels: x^-4 supplies k1/l, while differentiating x supplies minus k1/l after cubing the derivative bracket. Thus no derivative-zero conclusion for ξ follows from this next coefficient. This cancellation is recorded to prevent an unsupported increase of the common-triple zero multiplicity or a claimed higher-ratio restriction. Both original maps and the original Y-leg remain on their same source throughout.
