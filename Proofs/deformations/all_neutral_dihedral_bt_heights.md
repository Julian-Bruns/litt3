# Proof: complete retained fourth values and cyclic trace constancy

[Statement](../../Theorems/deformations/all_neutral_dihedral_bt_heights.md).
21 September2026. The arithmetic below was executed in the complete
fourteen-cover census of11 September; the new step is its scoped
integration and the actual BT interpretation.

## Actual models and exact values

Write $\tau^4+4\tau^3+\tau^2+4\tau+3=0$. The fifteen
[actual dihedral models](cyclic_descent/explicit_non_galois_neutral_five.md)
are indexed by pairs in $(0,1,2,3,\tau,\infty)$; fourteen are neutral.
The model constructor retains the original etale map, first marking,
flat line and oper, with an independently checked characteristic-five
comparison. The exceptional pair is omitted below.

In the stored dual basis, the fourth obstruction at the chosen
actual third repair has the following coefficients in the basis
$(1,\tau,\tau^2,\tau^3)$:
| Pair | Coefficient vector |
| --- | --- |
| $0,1$ | $(1,0,0,3)$ |
| $0,2$ | $(2,1,2,2)$ |
| $0,3$ | $(4,2,1,3)$ |
| $0,\tau$ | $(1,3,4,1)$ |
| $0,\infty$ | $(4,3,4,0)$ |
| $1,2$ | $(0,2,1,1)$ |
| $1,3$ | $(1,4,3,3)$ |
| $1,\tau$ | $(1,3,2,2)$ |
| $1,\infty$ | $(0,2,4,0)$ |
| $2,3$ | $(2,1,0,3)$ |
| $2,\tau$ | $(1,3,0,3)$ |
| $2,\infty$ | $(2,4,2,0)$ |
| $3,\tau$ | $(1,3,3,4)$ |
| $3,\infty$ | $(4,4,4,3)$ |

Every value is nonzero. The producer constructs the actual primary
repair and normalized corrected frames, checks the complete W2 jet
transition, then forms the fourth normal cocycle using the genuine
coefficient Frobenius. It checks the next connection gluing modulo125
and an independent iterated p-connection Taylor formula. The result
agrees with the sum of the divided linear carry, quadratic first
repairs, weighted jet, cubic Taylor derivative, and preceding oper
potential. A separate weighted-jet formula is checked as well.

The [retained census](../../../litt3-computation-data/dihedral5-family-w4-20260911/census/summary.json)
and [changed-Frobenius replay](../../../litt3-computation-data/dihedral5-family-w4-20260911/changed_frobenius/summary.json)
contain all28 successful comparisons, at Laurent precisions3500 and
3800. All fourteen complete values agree between the two runs. The
[model audit](../../Research/computations/dihedral5_family_model_independent_audit.json)
checks the original first marking and flat comparison. The selected
row additionally has the old independent
[fourth-obstruction calculation](cyclic_descent/neutral_five_fourth_obstruction.md)
and its [audit](../../Research/audits/RETURNED_NEUTRAL5_W4_AUDIT_2026_09_11.md);
that audit is not relabelled as a whole-family audit.

The current
[provenance checker](../../scripts/deformations/cyclic/verify_dihedral5_w4_family.py)
verifies all140 output hashes, model hashes, explicit decomposition
sums and required successful checks. Its
[fresh receipt](../../../litt3-computation-data/bt_obstruction_transport_20260921/dihedral_family_provenance_check.json)
passes. Two source hashes differ from the historical names ONLY by
the exact import-path relocation: removing that prelude and those
named import prefixes reproduces the original hashes byte for byte.
No mathematical source change is accepted by this normalization.
Thus the existing successful computations need not be repeated.

## Why a single value covers every third repair

Let $D$ be the quadratic resolvent, $W_1$ the cyclic-five closure
over $D$, and $T_1$ its reflection quotient. On each neutral row,
\[
d_C=d_D=d_{T_1}=1,\qquad d_{W_1}=2.
\]
The actual cyclic obstruction module is $k[e]/e^2$. Its coinvariants
identify with $O_D$, and the reflection acts as $+1$ there: pullback
$O_C\to O_D$ is an isomorphism since its degree is two and both
spaces have dimension one.

The involution inverts the cyclic generator. On $k[e]/e^2$ this
implies that its invariant line maps isomorphically to the
coinvariants; its anti-invariant line is $eO_{W_1}$. Pullback
identifies $O_{T_1}$ with that invariant line. Hence cyclic trace,
restricted to the image of $O_{T_1}$, is an isomorphism.

The audited [secondary-trace theorem](cyclic_descent/cyclic_five_secondary_trace.md)
is constant on the WHOLE two-dimensional third-repair plane of $W_1$.
Apply it first to the pullback of the computed third repair of $T_1$.
The table and the preceding isomorphism make its trace nonzero.
Thus every third repair on $W_1$ has nonzero fourth obstruction.
In particular no third repair on $T_1$ has a fourth extension.
This proves whole-family exclusion over the algebraic closure,
without extrapolating from a finite sample of repair parameters.

## Higher covers and actual groups

The audited
[neutral dihedral height translation](cyclic_descent/neutral_dihedral_height_translation.md)
now gives exact Witt height $a+2$ on every $T_a$. On $W_1$ the
same height is three by the cyclic trace argument. The further
cyclic-five closure steps are defect-neutral, and the accepted
two-digit descent and obstruction-pullback induction give exact
Witt height $a+2$ on every $W_a$.

The [all-height actual dictionary](all_height_bt_hodge_dictionary.md)
subtracts one to give BT height $a+1$, retaining all markings and
predecessors. A full group would give all finite levels and is
excluded. The allowed finite-character twists and determinant
normalization do not change these heights.
