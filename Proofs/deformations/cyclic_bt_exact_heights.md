# Proof: transfer the complete marked height calculation to actual groups

This is the BT-height supporting argument for the
[all-six cyclic theorem](../../Theorems/deformations/cyclic_descent/all_cyclic_five_fourth_obstructions.md).
The all-height dictionary extends the selected-cover calculation to
all six cyclic degree-five quotients and their higher cyclic covers.

The [all-six calculation](cyclic_descent/all_cyclic_five_fourth_obstructions.md)
retains each actual cover equation, the original second tuple,
the nonsplit periodicity line, and coefficient Frobenius. Its
[rational-orbit input](cyclic_descent/cyclic_five_fourth_obstruction.md)
has secondary trace \(3/\mu\) on every third repair; the other
orbit has a trace of norm \(3/\mu\). Hence every degree-five quotient
has compatible third solutions and no fourth solution. The
abelian-defect and neutral two-digit descent theorems in the same
calculation give exact marked Witt height \(a+2\) on every actual
cyclic \(5^a\) cover.

The [all-height actual dictionary](all_height_bt_hodge_dictionary.md)
pairs all actual marked BT$_N$ extensions of the same $q_a^*H$ with
the complete compatible Hodge solution space through $W_{N+1}$.
It respects the predecessor and truncation. Hence existence at
Witt length $a+2$ gives actual BT$_{a+1}$, whereas an actual
BT$_{a+2}$ would give the excluded length $a+3$. This proves both
inequalities, including the assertion that no choice in the first
repair family avoids the obstruction.

A full group would have truncations at every finite level, so it
is excluded without needing an inverse-limit existence argument.
Any determinant character congruent to the normalized finite one
can be removed by the allowed rank-one inverse-square-root twist;
it leaves the first marking unchanged. The prime-to-five character
twists realizing the other BT1s lift through every finite level,
so twisting and untwisting transfers the exact bound to them as well.

No additional numerical replay of the fourth obstruction is needed:
the new statement uses the accepted computation and the new audited
object-level dictionary. The rational model's arithmetic cover-class
calculation is independent of this height argument.
