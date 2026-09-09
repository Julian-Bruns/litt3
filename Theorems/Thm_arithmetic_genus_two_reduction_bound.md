# An explicit arithmetic genus-two reduction bound

Use the [arithmetic reduction conventions](../Definitions/Def_arithmetic_curve_reductions.md).
There are fewer than 2^2000000 compact arithmetic complex genus-two
curve classes, including all noncongruence and non-derived lattices.
For EVERY prime p,

    |E_(2,p)| <= |S_2| < 2^2000000 < 2^(2^1000).

The same count covers all potential good reductions, places, twists and
geometric residue conjugates. It is an explicit upper bound, not an
executed classification. It uses no curve/oper polynomial enumeration.

The universal degree-16 mod-two homology cover has genus17 and embeds
in a maximal-order norm-one arithmetic group; the original genus-two
lattice need not have that property.

Version1,2026-09-09. User-supplied Pro proof, primary inputs checked by
/root. PASS independent arithmetic audit, /root/audit_arithmetic_reduction_bound,
2026-09-09, for p=5; the identical argument for arbitrary p is an author
corollary. No blocking objections; clarified cover descent and residue
Galois action. [Audit metadata](../Research/audits/ARITHMETIC_REDUCTION_BOUND_AUDIT_2026_09_09.md)
is reference-only. No Lean verification.
[Proof](../Solutions/Sol_arithmetic_genus_two_reduction_bound.md).
