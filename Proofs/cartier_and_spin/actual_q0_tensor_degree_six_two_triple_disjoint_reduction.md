# Proof: neither overlap boundary survives the actual infinity jets

Version1,3 October2026. Frozen pending independent review; see the [statement](../../Theorems/cartier_and_spin/actual_q0_tensor_degree_six_two_triple_disjoint_reduction.md).

The [actual cubic coarse theorem](actual_q0_tensor_cubic_coarse_curve_reduction.md) gives [B:Bx] in {ONE,THREE}, with Bx=k(x1,x2), each xi of degree SIX and local indices ONE orTHREE. If [B:Bx]=THREE, each separating Bx→P1 has degree TWO. Its local indices divide those of B→P1 and are at most TWO, hence are all ONE. This would be an unramified degree-TWO map to P1, impossible by Hurwitz. Thus B=Bx. The accepted elliptic Hodge bound, rather than Hurwitz for xi alone, gives
\[
3g(B)\le d^2/2-d+3-u=18-6+3=15
\]
at d=SIX,u=ZERO. Hence g(B)≤FIVE.

Let D_i be the reduced divisor of the TWO triple infinity poles of xi. The common reduced q0-zero divisor U has degree TWELVE, and div q_i=U−SIX Di. Since z³=q2/q1,
\[
\operatorname{div}(z)=2D_1-2D_2.
\]
Both overlap boundaries must be retained before computing its degree. If D1=D2, then z is constant; the quadratic relation x2²+ONE=z³(x1²+ONE) gives [k(x1,x2):k(x1)]≤TWO. This contradicts B=Bx and the degree-SIX xi projection.

If the divisors share exactly ONE point Q, then z is nonconstant of degree TWO. At Q both xi have poles of exact order THREE. The [actual common-triple infinity jet lemma](actual_q0_tensor_common_triple_infinity_jet.md) forces the local index of z at Q to be at least THREE, impossible for a degree-TWO map. Thus this overlap boundary is also excluded.

The divisors are therefore disjoint and the displayed z-divisor has total pole degree FOUR. Its valuations are all even. In characteristic FIVE the normalization given by t²=z is étale over B: locally units have square roots over algebraically closed residue fields and even valuations give no ramification. Globally it can split when z is a square; that possibility is retained. This auxiliary cover is not substituted for either original source leg, and the remaining degree-FOUR z-map profile is not excluded here.
