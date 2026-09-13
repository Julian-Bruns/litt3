# Explicit low-genus arithmetic counts and a genus-three partner bound

Use the [arithmetic reduction conventions](../../Definitions/arithmetic_curve_reductions.md).
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

The same method in genus three gives, for every prime p,

                    |E_(3,p)| <= |S_3| < 2^80000000.

Its mod-two homology cover has degree64, genus129, and area512pi.
The complete changes to the numerical bounds are in Section5 of the
proof; no new lattice or polynomial enumeration is needed.

Moreover, for ANY fixed smooth proper hyperbolic curve A over ANY
algebraically closed characteristic-zero field, there are fewer than
2^80000000 genus-three curves admitting a common finite etale cover
with A. If A is arithmetic this follows from the genus-three count;
if A is nonarithmetic, the sharper bound2^17000 follows by counting
index-at-most168 subgroups of its single commensurator. This bound
does not require the given correspondence to be coreless.

Version2,2026-09-10 adds the genus-three count and the uniform fixed-
partner bound, with focused medium audit PASS
/root/audit_defect_preserving_descent. The original genus-two
statement retains its earlier scoped audit; it has not been replaced
by an unaudited generalization. User-supplied genus-two Pro proof,
primary inputs checked by
/root. PASS independent arithmetic audit, /root/audit_arithmetic_reduction_bound,
2026-09-09, for p=5; the identical argument for arbitrary p is an author
corollary. No blocking objections; clarified cover descent and residue
Galois action. [Audit metadata](../../Research/audits/ARITHMETIC_REDUCTION_BOUND_AUDIT_2026_09_09.md)
is reference-only. No Lean verification.
[Proof](../../Proofs/curve_arithmetic/arithmetic_genus_two_reduction_bound.md) ·
[Genus-three scope audit](../../Research/audits/DEFECT_PRESERVING_ETALE_DESCENT_AUDIT_2026_09_10.md).
