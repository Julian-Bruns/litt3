# Genus-two atlas dynamics completion audit

- Verdict: PASS.
- Auditor: `/root/genus_two_dynamics_completion_audit`, fresh bounded independent agent.
- Date: 2026-09-07.
- Target: [genus_two_atlas_dynamics](../../Theorems/Thm_genus_two_atlas_dynamics.md) and its [proof](../../Solutions/Sol_genus_two_atlas_dynamics.md).
- Objections: none material.

The exact verification script `sage scripts/genus_two_atlas_dynamics.sage`
completed successfully in 2.2 seconds. It expands four certificates in
the thirteen original generators, proves the full reduced row-space
equality, checks all signs in the quadratic map and normalization,
and substitutes the universal eight-tuple in all thirteen equations
over the entire rank-33 algebra. No candidate Groebner basis is read or
used as a certificate.

Exhaustiveness was checked independently in the prose: normalization
excludes the zero extension; the two forms A,B are independent;
F(1,0) is nonzero; Q1,Q2 have no common projective zero; and E is
nonzero on every fixed direction. Hence the z=x/y chart misses no
solution and all inversions are justified. Scaling gives c with weight
-9, p with weight -4, and ell with weight -3, so lambda^3=h has the
stated sign and orientation. Conversely z=b2/b3 and lambda=b3 recover
each original solution uniquely. The audited intrinsic finite/reduced
prerequisite, or the reversible reconstruction with these units, supplies
the scheme assertion; it is not inferred just from sampled points.

The displayed f and h agree with the exact export. Squarefreeness and
the unit h make the rank-33 algebra reduced. The five linear and two
irreducible cubic factors, with h a nonzero cube in every residue field,
give fifteen degree-one and six degree-three closed points. The Mobius
coordinate has nonzero determinant and the verified rational conjugacy
extends across its poles, so its infinity fixed point is accounted for.

Scope: the underlying tensor and intrinsic geometric criterion are
accepted from their existing independent audits. This audit covers the
new completion argument for one fixed genus-two oper and j0. It does
not count unmarked isomorphism classes and makes no exclusion for the
fixed common-cover problem, which remains unsolved.
