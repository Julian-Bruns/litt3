# Full BT existence can appear after an actual cyclic-five etale cover

Version2,21 September2026. Work over $k=\overline{\mathbf F}_5$.
There are smooth proper connected curves $D,W$ of genera three and
eleven, an ACTUAL connected cyclic etale map $q:W\to D$ of degree five,
and an actual everywhere-versal height-two, dimension-one BT1 $H_D$
such that
\[
H_D\text{ has no BT2 extension},\qquad
q^*H_D\simeq G_W[5]
\]
for an ACTUAL full height-two, dimension-one $5$-divisible group $G_W$.
Thus even potential existence of a full prolongation does not descend
through a cyclic-five etale cover. The conclusion concerns existence
of ANY full group downstairs, not merely descent of a prescribed one.

More precisely, use the F625 genus-two example $H_C/C$ of
[the finite-level counterexample](etale_p_witt_obstruction.md),
with $\tau^4+4\tau^3+\tau^2+4\tau+3=0$ and
$v^2=u(u-1)(u-2)(u-3)(u-\tau)$. Take the exceptional quadratic
resolvent $D\to C$, given by adjoining $\sqrt{u-\tau}$, in the
[actual dihedral construction](cyclic_descent/explicit_non_galois_neutral_five.md).
Its closure $W\to C$ has group $D_{10}$, and its reflection quotient
$T$ has genus six. The maps $W\to D$ and $T\to C$ are etale of
degree five, the latter non-Galois. Then
\[
H_C\text{ has no BT2},\quad H_D=H_C|_D\text{ has no BT2},\quad
H_C|_T\simeq G_T[5],\quad G_W=G_T|_W.
\]
All first markings and finite determinant characters can be retained
on these actual curves. No additional tame source refinement is used.

The compatible full Hodge tower is constructed over the FIXED field
$\mathbf F_{625^3}=\mathbf F_{5^{12}}$, above a specified third
tuple on $T$. Its initially certified fourth digit may change during
prolongation. The complete late response is already bijective over
this field: its negative block has restriction-of-scalars determinant
one over $\mathbf F_5$. After ONE fixed finite extension accommodating
the original tame line and marking choices, the exact full groups
and the whole counterexample are defined over a finite field. No
sequence of growing coefficient fields is needed. This separates the exceptional fifteenth cover
from the [fourteen finite-height families](all_neutral_dihedral_bt_heights.md).

The diagram is cored, with quotient $C$. It is not a common cover of
either original candidate pair, and neither unmarked problem is solved.

[Proof and reproducible certificates](../../Proofs/deformations/explicit_full_bt_existence_descent_failure.md).
