# The entire squarefree common-pole branch is empty

Version 1, 24 September 2026. Use the fixed P,A and comparison
normalization of [the normal form](new_line_comparison_normal_form.md).
There is no smooth quadratic cover s:S->P1, unramified at zero and
infinity, with nonconstant separating x1,x2 satisfying
\[
s^{13}A(x_2)=\varepsilon^4 A(x_1),\qquad
(dx_2/dx_1)^3P(x_1)^2=\varepsilon^{-17}s^{48}P(x_2)^2,
\]
where x1 has poles of order three at both infinity points, x2 has
poles of order three at both zero points, and all other poles are
common simple poles over mu29. The other function is regular at
each endpoint. Coefficients may lie anywhere in the algebraic closure.

This excludes the entire squarefree-minimal-denominator subcase of
comparison pole degree six, without a genus or covering-degree bound
and even before imposing the additional ramification profile of x_i.
Possible quadratic ramification at a simple common pole is excluded
by the identities, rather than removed by a hypothesis.

The exact proof classifies 787176 endpoint configurations. It retains
all 30 consistent linear systems and 42 moment vectors. Every Fourier
row has at least four distinct residues, whereas actual simple-pole
weights belong to {0,1,2}. All 787146 inconsistency witnesses were
checked independently using left-null vectors.

[Proof](../../Proofs/cartier_and_spin/squarefree_common_pole_exclusion.md).
The remaining double-pole case is restricted further in
[the degree-55 theorem](pole_six_degree_fifty_five.md). The original
unmarked common-cover question is not decided.
