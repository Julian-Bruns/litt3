# Exact finite heights and no full lift in an entire actual dihedral tower

Version2,2026-09-11. Quotient height is the existing author corollary;
the extension to arbitrary closure towers passed the focused audit by
/root/audit_cyclic5_returned_w4. This explicitly enlarges Version1.

Take the selected R=u(u-1) tower W_a,T_a of
[neutral_dihedral_towers](neutral_dihedral_towers.md), always with
the ORIGINAL marked pulled-back second lifts and full previous tuple.
For every a>=0, with q=5^a and T_0=C,

    g(T_a)=q+1,       defect(T_a)=1,       H(T_a)=a+2.

Here H is the maximum Witt length to which SOME compatible extension
of that marked T_(a,2) exists. Thus there is a compatible W_(a+2)
extension, but NO compatible W_(a+3) extension. No T_a in this tower
has a full compatible marked Witt tower.

For every a≥1, the selected original cyclic closures also satisfy

    g(W_a)=2*5^a+1,       defect(W_a)=2,       H(W_a)=a+2.

This excludes arbitrary compatible marked full towers on these W_a;
no reflection action on their repaired lifts is required. The assertion
is for the W_a of the specified selected neutral dihedral construction,
not all cyclic covers of its genus-three resolvent.

Consequently defect one does not bound finite compatible Witt height,
even among actual covers in this single family, although no fixed
source in the family continues indefinitely. Equivalently, sources
of degree5^a have exactly a additional available digits over C.

No assertion is made about other markings, other connections, the
remaining thirteen resolvent towers, or unmarked common covers of the
main/backup pair. These are not counterexamples to full-tower descent.

Proof: H(C)=2 by explicit_genus_two_witt_obstruction. The selected
neutral_five_fourth_obstruction gives H(T_1)=3. Apply the exact
neutral_dihedral_height_translation formula H(T_a)=H(T_1)+a-1.
For W_1, the new cyclic secondary-trace lemma is constant on the whole
repair plane. Its value is nonzero at the point pulled back from T_1:
the nonzero obstruction injects as the reflection-positive line, which
maps isomorphically to the cyclic coinvariants. Thus H(W_1)=3. The
neutral cyclic steps W_a→W_(a-1) then each add exactly one digit.

[Proof](../../Solutions/deformations/neutral_dihedral_sharp_height.md) ·
[Scoped closure audit](../../Research/audits/CYCLIC5_FOURTH_LIFT_AUDIT_2026_09_11.md).
