# Proof: all four rational degree-five partitions fail

Version1,3 October2026. Independently accepted in the [whole rational degree-five audit](../../Research/audits/Q0_TENSOR_DEGREE_FIVE_RATIONAL_AUDIT_2026_10_03.md). Two bounded new necessary-equation tests suffice; no fixed arithmetic or old certificate is replayed.

The [complete necessary normal form](actual_q0_tensor_degree_five_rational_form.md) supplies FOUR types and six exact square-coefficient equations per type. Write J=(v−a)(v−b),N1=F−hG,N2=F+hG. Each actual candidate lies in one of these types:
\[
F=J^2(v-1),\quad G=(v^6-1)/(v-1),
\]
or
\[
F=(v-a)^2U,\quad G=(v-b)^2V,\quad UV=v^6-1,
\]
where U has the alternating, consecutive, or mixed triple of roots in cyclic order 1,−ω,ω²,−1,ω,−ω². The factorization proof retains any coincidence of a,b with a sixth root, subject only to the opposite factor being nonzero at that actual simple pole.

Use exactly the six equations derived there for the reversed first derivative and the second derivative. The saturation polynomial is
\[
a b(a-b)h L_1L_2\operatorname{Opp}(a,b),
\]
where L1=Q1(0)≠0,L2=lead(Q2)≠0 and Opp=G(a)G(b) in the same-factor case, Opp=V(a)U(b) in an opposite-factor case. Every factor is an actual pole, distinctness, or nonzero normalization requirement. There is no assumption that all poles avoid µ6 and no condition on the degree-six leading term of the unreversed Q1. Hence its permitted degree-FOUR edge is retained.

The first [source](../../scripts/genus_two/oct03_q0_degree_five_rational_square_gate.py) worked over F5 with ω as a polynomial variable and relation ω²+ω+1. Its [receipt](../../../litt3-computation-data/oct03_q0_degree_five_rational_square_gate/square_gate.json) records a completed basis[ONE] for the opposite alternating type. It then derived the consecutive equations and reached its ten-CPU-second alarm during that basis calculation. Mixed and same-factor types were not reached. Total CPU including finalization was10.056769 seconds. An initial zero-polynomial degree-wrapper failure occurred before any basis calculation and was corrected; its separate [failure receipt](../../../litt3-computation-data/oct03_q0_degree_five_rational_square_gate/zero_polynomial_wrapper_failure.json) is preserved. The timed-out case itself supplies no exclusion.

A separately authorized [unresolved-only source](../../scripts/genus_two/oct03_q0_degree_five_rational_unresolved_gate.py) constructs the genuine coefficient field F25=F5[ω]/(ω²+ω+1), so there is no extra ω variable or relation in the parameter ideals. It derives the SAME six equations and physical saturation in a,b,h, and computes each basis with Sage/libSingular. It does not run the previously completed alternating case. Its [receipt](../../../litt3-computation-data/oct03_q0_degree_five_rational_square_gate/unresolved_gf25_gate.json) records all THREE remaining completed bases, each exactly[ONE]: opposite consecutive, opposite mixed, and same factor. The whole mathematical phase completed in3.855613 CPU seconds, with one worker and a ten-CPU-second limit; no timeout occurred. The equations, two polynomial derivative numerators, factor polynomials and exact saturation are retained separately for every type.

These four unit ideals cover the complete rational normal form. Thus no rational degree-five quotient can satisfy even the necessary pure-three local ramification condition. No claim that the equations alone construct actual X-maps is needed. In particular, no fixed-P cube test, simultaneous Galois closure, one-leg replacement or endpoint arithmetic is used.

The original TWO actual X-maps and any original actual Y-map are retained on the SAME source. Only its rational coarse-quotient alternative is excluded; the elliptic and genus-two alternatives remain unresolved.
