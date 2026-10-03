# A cyclic-five wild étale positive trace leaves only the degree-forty target

Version1,3 October2026. Author proof, pending whole-scope review. This concerns an ÉTALE spin target; it does not reuse the different table for a ramified spin carrier.

Retain ALL actual minimal-source and positive full rank-four degree-one trace hypotheses of the [étale determinant-character theorem](etale_spin_determinant_character_and_even_degree.md), including both original finite étale maps from T, the faithful extracted target φ:T→Z of degree e, M¹⁶≅ω_Z, and k(T)=k(Y)k(Z). Suppose Z→Z/G is WILD and its wild first ramification group has order FIVE.

Then the coarse quotient is P¹ and has EXACTLY TWO branch values, one wild and one tame. Before using endpoint ordinarity, its complete necessary local rows are

| e | wild inertia order i | tame inertia order j | cyclic-five lower break b | wild different δ |
|---|---|---|---|---|
| TEN | TEN | TWO | TWO | SEVENTEEN |
| TWENTY | TWENTY | FOUR | TWO | TWENTY-SEVEN |
| FORTY | FORTY | EIGHT | TWO | FORTY-SEVEN |

The first TWO rows are impossible on BOTH selected endpoints by [ordinary cyclic TWO/FOUR covers](../jacobians/ordinary_covers/selected_cyclic_two_four_ordinarity.md). Hence only the FORTY row can remain in this scope.

More precisely, for EVERY row the actual determinant-character quotient inside T gives a connected cyclic finite étale cover Y_h→Y of degree h=i/FIVE=j. It has a separating rational function t with h poles of order FIVE and
\[
\operatorname{div}(dt)=2\sum_{\nu=1}^h P_\nu.
\]
Thus dt is a NONZERO regular exact differential and Y_h is nonordinary. In the remaining FORTY row this is an ACTUAL nonordinary cyclic degree-EIGHT cover of the selected Y, a necessary obstruction not yet excluded. No ordinarity of arbitrary étale refinements or degree-EIGHT covers is presumed.

The two other local inertia groups are C₅⋊C₄ and C₅⋊C₈, with respective conjugation images of orders TWO andFOUR and central tame kernel TWO. Only the order-TEN group is cyclic. Wild first ramification groups larger than FIVE are outside the theorem.

Inputs: [native determinant character](etale_spin_determinant_character_and_even_degree.md), [half-spin stabilizer lcm](etale_spin_half_spin_stabilizer_lcm.md), and [selected cyclic-cover ordinarity](../jacobians/ordinary_covers/selected_cyclic_two_four_ordinarity.md).
[Proof](../../Proofs/cartier_and_spin/wild_cyclic_five_etale_positive_full_reduction.md).
