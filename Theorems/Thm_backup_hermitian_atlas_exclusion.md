# The small backup has no Hermitian quotient atlas

Version1,2026-09-08. Use the explicitly defined
[genus-two curve C_alpha](../Definitions/Def_backup_genus_two_curve.md).
Let H:X_0^6+X_1^6+X_2^6=0 and P=PGU_3(5).

There is NO representable finite etale map

    C_alpha -> [H/P].

This includes every cubic determinant character in Pic(C_alpha)[3].
In particular there is no atlas to [H/PSU_3(5)]. The complete calculation
uses all five dormant opers and all81 cubic torsion classes, grouped into
five Frobenius orbits of sizes5,40,120,120,120. All twenty disjoint
projective charts have exact polynomial unit certificates against their
ORIGINAL equations, not just a unit Groebner basis or a sampled rank.

This excludes the two large Hermitian common-orbifold cases for the pair
X,C_alpha using the existing orbifold classification. It does NOT exclude
all smaller cored spans, or any arbitrary coreless span. It does not say
that C_alpha and H cannot have some common etale cover.

Audit: PASS, fresh Astra-medium auditor
`/root/audit_backup_atlas_bridge_medium`,2026-09-08; no material objections.
Scope includes geometric candidate exhaustion, twisted bundle/section/
cohomology completeness, finite precision, all original charts, and
certificate composition. Prose/code audit, not Lean verification.
[Audit metadata](../Research/audits/BACKUP_ATLAS_BRIDGE_AUDIT_2026_09_08.md)
is reference-only; open its body only for a concrete doubt.

[Proof and exact certificates](../Solutions/Sol_backup_hermitian_atlas_exclusion.md).
