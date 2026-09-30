# Proof: the short mixed step followed by neutral steps

[Statement](../../Theorems/deformations/abelian_bt_height_reduction.md).
21 September2026. Sections5--6 of the
[focused audit](../../Research/audits/SHORT_SMITH_CYCLIC_DESCENT_AUDIT_2026_09_21.md)
verify this application. All maps below are actual intermediate
quotients of the given Galois cover.

The [abelian node theorem](abelian_covers/abelian_p_defect_node.md)
gives the defect on a cover of type $(5^a,5^b)$:
\[
d_{a,b}=\begin{cases}2\cdot5^a-1,&a=b,\\
2\cdot5^b,&a>b.\end{cases}
\tag{1}
\]
For an actual relative cyclic-five step, augmentation identifies
the number of nonunit Smith factors with the lower defect, and
their total lengths with the upper defect. Pullback on actual
obstruction cokernels is represented by the norm $e^4$. In
particular it vanishes when all nonunit factors have length less
than five. These are the actual quotient and norm identities, not
dimension-only assertions about abstract modules.

## The family with group $C_{5^a}\times C_5$

Every such cover has the same maximal elementary quotient $D_{1,1}$,
since the genus-two base has p-rank two. The
[whole rank25 fifth exclusion](elementary_covers/rank25_whole_fifth_exclusion.md)
and its fourth-lift witness give exact marked Witt height4 there.
Its defect is9. On $D_{2,1}$ the defect is10, so the actual cyclic
step $D_{2,1}\to D_{1,1}$ has eight Smith factors $e$ and one $e^2$.

If a compatible upper $W_6$ existed, the
[short-Smith theorem](cyclic_descent/short_smith_cyclic_descent.md),
successively at $n=2,3,4$, would descend its GIVEN third, fourth and
fifth tuples. At the initial step a lower third reference exists
because a lower fourth tuple exists. This would contradict the
whole fifth exclusion downstairs. Thus the upper height is at most5.
Conversely, take a lower fourth tuple. Its next actual obstruction
pulls back to zero, since $e^4$ is in the image of every $e$ or
$e^2$ Smith block. Actual obstruction theory gives an upper fifth
tuple extending that pulled-back fourth tuple. Thus the height is5.

For $a\ge3$, each actual step
$D_{a,1}\to D_{a-1,1}$ is defect-neutral, both defects being10.
All nonunit Smith factors therefore have length one. The
[neutral two-digit theorem](neutral_galois_witt_descent.md) bounds
the new maximal Witt height by the preceding one plus one: a longer
GIVEN tower would descend its successive truncations to a forbidden
lower one. The opposite bound follows by pulling back an attained
maximal lower tuple and repairing its next obstruction, again killed
by $e^4$ in each Smith cokernel. Induction gives exact Witt height
$a+3$. The [actual all-height dictionary](all_height_bt_hodge_dictionary.md)
gives exactly BT level $a+2$. The upper bounds include every allowed
choice of the earlier repairs; the lower bounds construct compatible
tuples, not just isolated solutions at each level.

## All unbalanced abelian five-group cases

For $a>b\ge1$, first consider the actual step
\[
D_{b+1,b}\longrightarrow D_{b,b}.
\]
Its defects are $2\cdot5^b$ and $2\cdot5^b-1$. Hence exactly one
nonunit Smith factor has length two and all the others have length
one. The balanced base dominates $D_{1,1}$, so it has a compatible
third reference (indeed an inherited fourth tuple). A supplied full
upper tower descends by the short-Smith theorem. All subsequent
unbalanced cyclic-five steps are neutral and also descend a supplied
full tower. Conversely a full group on the actual balanced quotient
pulls back along the given intermediate maps.

The cyclic case $b=0$ is separately excluded by the
[all-six cyclic theorem](cyclic_descent/all_cyclic_five_fourth_obstructions.md)
and its all-height BT consequence; the genus-two
base itself has no BT2, so the short-Smith initial-reference clause
must not be used there. The balanced $b=1$ case is the rank25
exclusion. Balanced $b\ge2$ remains open.

Finally, $\pi_1(C)^{\mathrm{ab},5}\simeq\mathbf Z_5^2$.
A quotient of type $(\mathbf Z/5^b)^2$ and order $5^{2b}$ has kernel
exactly $5^b\mathbf Z_5^2$: it contains that subgroup and the indices
are equal. Thus the balanced quotient is canonical as a geometric
cover. This supplies a sequence of specific remaining covers, not
an exclusion or an existence claim on that sequence.

As with the cyclic result, allowed finite-character twists preserve
height, and an unnormalized determinant can be normalized by the
permitted rank-one twist without changing the first marking. No
prime-to-five or nonabelian full descent is inferred.
