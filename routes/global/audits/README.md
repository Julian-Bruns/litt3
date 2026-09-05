# Audit index for the current global route

> **Context discipline for future agents:** do not open these audit records
> during ordinary reading of the route.  Rely on the verdict, auditor, date,
> and short objection/suggestion shown with the theorem.  Open a record only
> when there is a concrete reason to doubt the theorem (for example, a
> contradictory calculation, a stale revision hash, a dependency mismatch,
> or a suspected gap that needs investigation).  In particular, do not load
> the audit directory pre-emptively into the context window.

These records preserve the audit material delivered by research subagents
without putting it in the theorem files themselves.  Each record identifies
the checked revision by SHA-256, the auditor or recovered task role, the scope
of the check, the verdict, and any limitation or correction.

The records are audit reports, not exports of private scratch reasoning.  When
only a delivered summary survived, the record says **summary recovered**.  A
pending or self-check record is deliberately not presented as an independent
audit.

| File | Audit state | Record |
| --- | --- | --- |
| 38, coprime seven-diamond | pass; summary recovered | [record](38_COPRIME_DESCENT_AUDIT.md) |
| 39, Schwarzian reduction | pass with scope note; summary recovered | [record](39_SCHWARZIAN_AUDIT.md) |
| 40, Jacobian norm obstruction | pass; summary recovered | [record](40_JACOBIAN_NORM_AUDIT.md) |
| 41, full Sylow-seven norm | independent pass | [record](41_FULL_SYLOW_NORM_AUDIT.md) |
| 42, Rosati/polarization limit | author self-check; independent audit pending | [record](42_ROSATI_POLARIZATION_AUDIT.md) |
| 43, Cartier/Tango pushdown | composite pass by two independent helpers | [record](43_TANGO_PUSHDOWN_AUDIT.md) |
| 44, normed branch pencil | PASS; one harmless factor-two wording correction; `/root/norm_polarization_refinement`, 2026-09-04 | [record](44_NORMED_BRANCH_PENCIL_AUDIT.md) |
| 45, effective correspondences | PASS; minor clarifications only; `/root/effectivity_correspondence_audit`, 2026-09-04 | [record](45_EFFECTIVE_CORRESPONDENCE_AUDIT.md) |
| 46, norm system not a pencil | PASS; optional clarifications only; `/root/norm_pencil_dimension_audit`, 2026-09-04 | [record](46_NORM_PENCIL_DIMENSION_AUDIT.md) |
| 47, coefficient-field coarsening | PASS; one minor statement correction; `/root/coefficient_coarsening_audit`, 2026-09-04 | [record](47_COEFFICIENT_COARSENING_AUDIT.md) |
| 48, degree-nine cross rank | FAIL as originally stated; repaired to conditional result, re-audit pending; `/root/m9_rank_obstruction_audit`, 2026-09-04 | [record](48_M9_RANK_OBSTRUCTION_AUDIT.md) |
| 49, Frobenius trace lattice | PASS; two presentation clarifications only; `/root/frobenius_trace_lattice_audit`, 2026-09-04 | [record](49_FROBENIUS_TRACE_LATTICE_AUDIT.md) |
| 50, mod-31 families test | PASS; finite shadow already forces visibility in degrees 32--44; `/root/families_notes_audit`, 2026-09-04 | [record](50_FAMILIES_PRESERVATION_MOD_31_AUDIT.md) |
| 51, full characteristic-p families rigidity | PASS; correct standalone extension, does not bypass core alignment; `/root/families_notes_audit`, 2026-09-04 | [record](51_FAMILIES_PRESERVING_RIGIDITY_IN_CHARACTERISTIC_P_AUDIT.md) |
| 52, virtual-surface families rigidity | PASS; correct standalone theorem, strategically redundant; `/root/families_notes_audit`, 2026-09-04 | [record](52_VIRTUAL_SURFACE_FAMILIES_RIGIDITY_AUDIT.md) |
| 53, genus-one degree-nine coarsening | PASS; no breaking objection; `/root/audit_m9_hyperelliptic`, 2026-09-04 | [record](53_M9_GENUS_ONE_COARSENING_AUDIT.md) |
| 54, exact 31-adic endomorphism order | PASS; no breaking objection; `/root/audit_exact_31adic_order`, 2026-09-04 | [record](54_EXACT_31_ADIC_ENDOMORPHISM_ORDER_AUDIT.md) |
| 55, square-label collisions and spectral conductor | PASS; no breaking objection; `/root/audit_square_labels`, 2026-09-04 | [record](55_SQUARE_LABEL_COLLISIONS_AND_SPECTRAL_CONDUCTOR_AUDIT.md) |
| 56, genus-two degree-nine coarsening spectrum | PASS; no breaking objection; `/root/audit_m9_genus2_spectrum`, 2026-09-04 | [record](56_M9_GENUS_TWO_COARSENING_SPECTRUM_AUDIT.md) |
| 58, central gluing congruences for `J(X)` | PASS; minor exposition suggestions only; `/root/degree45_family_endpoint`, 2026-09-04 | [record](58_X_CENTRAL_GLUE_CONGRUENCES_AUDIT.md) |
| 57--58, degree-45 families endpoint | PASS; exhaustive certificate rerun, no breaking objection; `/root/x_elliptic_quotient_maps`, 2026-09-04 | [record](62_DEGREE45_FAMILIES_ENDPOINT_AUDIT.md) |
| 59, cyclic genus-one label rigidity | PASS; exact nine-class maximum 138, no breaking objection; `/root/x_elliptic_quotient_maps`, 2026-09-04 | [record](59_C14_ELLIPTIC_LABEL_RIGIDITY_AUDIT.md) |
| 60, anti-invariant Prym decomposition at `M=9` | PASS; minor exposition suggestions only; `/root/degree45_family_endpoint`, 2026-09-04 | [record](60_ANTI_INVARIANT_PRYM_DECOMPOSITION_AUDIT.md) |
| 61, dihedral genus-one row impossible | PASS; partition, Prym parity, and infinity checked; `/root/x_elliptic_quotient_maps`, 2026-09-04 | [record](61_D14_GENUS_ONE_ROW_IMPOSSIBLE_AUDIT.md) |
| 63, cyclic genus-one row impossible (archived; theorem superseded by weighted-grid interval theorem 66) | PASS; descent, delta counts, and Weil contradiction checked; `/root/x_elliptic_quotient_maps`, 2026-09-04 | [record](63_C14_GENUS_ONE_ROW_IMPOSSIBLE_AUDIT.md) |
| 64, Frobenius does not force families preservation | PASS; algebraic example, arithmetic/geometric distinction, and procyclic witness checked; `/root/x_elliptic_quotient_maps`, 2026-09-04 | [record](64_FROBENIUS_EQUIVARIANCE_DOES_NOT_FORCE_FAMILIES_AUDIT.md) |
| 66 and 68, quadratic-core field intersection | **FAIL as written**; compositum/intersection equality lacks linear disjointness; split-sign alternative requires full-orbit repair; `/root/c14_elliptic_translation`, 2026-09-04 | [record](66_68_QUADRATIC_CORE_FIELD_INTERSECTION_AUDIT.md) |
| 69 and 72, parameterized Honda sieve and degree-19 redesign | PASS; no breaking objection, certificates rerun; `/root/genus2_counterexample_variant`, 2026-09-04 | [record](69_72_PARAMETERIZED_HONDA_AND_DEGREE19_AUDIT.md) |
| 73--75, endpoint pencils, Prym packing, and divisor refinement | PASS; no breaking objection; `/root/c14_elliptic_translation`, 2026-09-04 | [record](73_75_STRUCTURAL_REFINEMENTS_AUDIT.md) |
| 78, degree-six plane contact and spectral discriminant | PASS; plane-orbit, ADE resolution, Hodge bounds, and (S_3) exclusion checked; `/root/genus2_counterexample_variant`, 2026-09-04 | [record](78_M6_PLANE_CONTACT_AND_SPECTRAL_DISCRIMINANT_AUDIT.md) |
| Minimal common covers and rational incidence descent | PASS; descent, separability, and exact missing fixed-target map checked; /root/x_elliptic_quotient_maps/m9_incidence_profiles, 2026-09-04 | [record](MINIMAL_COMMON_COVER_AND_INCIDENCE_DESCENT_AUDIT.md) |
| Simple Jacobian, bidegree-two bi-etale self-correspondences | PASS in every characteristic; dihedral quotient and free-reflection argument checked; /root/x_elliptic_quotient_maps/m9_incidence_profiles, 2026-09-04 | [record](SIMPLE_JACOBIAN_BIDEGREE_TWO_AUDIT.md) |
| 81, full-orbit interpolation and cubic sign monodromy | PASS; repaired integral square, norm/genus bounds, signed-root groups, and M=6 recovery checked; `/root/c14_elliptic_translation`, 2026-09-04 | [record](81_FULL_ORBIT_INTERPOLATION_AND_CUBIC_SIGN_MONODROMY_AUDIT.md) |
| 82, signed-orbit congruences and repaired short-degree sieve | PASS; congruence, cyclic Hadamard case, inertia, genus bounds, and strict endpoints checked; `/root/x_elliptic_quotient_maps`, 2026-09-04 | [record](82_SIGNED_ORBIT_CONGRUENCES_AND_SHORT_DEGREE_REPAIR_AUDIT.md) |
| 83, sign norm branch carrier and coprime descent | PASS; canonical sign field, inertia, coprime descent, and spectral bounds checked; `/root/c14_elliptic_translation`, 2026-09-04 | [record](83_SIGN_NORM_BRANCH_CARRIER_AND_COPRIME_DESCENT_AUDIT.md) |
| 87, deck rigidity, hyperelliptic exclusion, and exact genus-nine application | PASS after normalizer proof repair; all characteristics and \(\ell=2\) checked; common-cover lifting, Honda--Tate/Torelli argument, and exhaustive branch certificate PASS; `/root/x_elliptic_quotient_maps/cyclic_cover_deck_normality_group_audit`, 2026-09-04 | [record](ODD_PRIME_DECK_NORMALITY_UNDER_RIGID_BRANCH_AUDIT.md) |
| 90, higher cyclic prime-power deck rigidity | PASS; semidirect-product calculation, wild inertia, Sylow and direct-product steps, and \(2^n/3^n\) consequences checked; `/root/x_elliptic_quotient_maps/abelian_deck_group_theory`, 2026-09-04 | [record](90_HIGHER_CYCLIC_PRIME_POWER_DECK_RIGIDITY_AUDIT.md) |
| 91, arbitrary finite abelian deck rigidity | PASS; minimal-overgroup Frobenius argument, wild inertia, simple-J uniqueness, hyperelliptic exclusion, and normal-complement boundary checked; `/root/x_elliptic_quotient_maps/abelian_deck_group_theory`, 2026-09-04 | [record](91_ARBITRARY_ABELIAN_DECK_RIGIDITY_AUDIT.md) |
| 92, branch-rigid abelian prime-power covers | PASS; Sylow/branch reduction, maximum-order Thompson subgroup, Glauberman--Thompson input, normal closure, and arbitrary second Galois deck group checked; `/root/x_elliptic_quotient_maps/abelian_p_index_group_audit`, 2026-09-04 | [record](92_BRANCH_RIGID_ABELIAN_PRIME_POWER_COVERS_AUDIT.md) |
| 93, nonabelian deck-rigidity boundary | PASS; tame characteristic-five Hurwitz transport, symplectic monodromy, automorphism argument, and exact PSL2(8) certificate checked; /root/x_elliptic_quotient_maps/abelian_p_index_group_audit, 2026-09-04 | [record](93_NONABELIAN_DECK_RIGIDITY_BOUNDARY_AUDIT.md) |
| 76/98, genus-25 target arithmetic and signed root-ratio lemma | PASS; isolated Sage Frobenius polynomial, branch splitting, modular signed cycles, absolute simplicity, and geometric endomorphism field checked; `/root/c14_elliptic_translation`, 2026-09-04 | [record](76_GENUS25_Y_ARITHMETIC_AND_SIGNED_RATIO_AUDIT.md) |
| 115, positive-rank-preserving Tango descent | PASS; Frobenius-root norm descent, Verschiebung-kernel torsors, embedded Cartier descent, and exact 111--113 dependency chain checked; `/root/x_elliptic_quotient_maps`, 2026-09-05 | [record](115_POSITIVE_RANK_PRESERVING_TANGO_DESCENT_AUDIT.md) |
| Hoshi custom-GF(25) Sage 10.9 matrix backend | BACKEND BUG CONFIRMED; current Hoshi conclusions survive scalar rechecks; `/root/x_elliptic_quotient_maps`, 2026-09-05 | [record](HOSHI_SAGE10_9_CUSTOM_GF25_MATRIX_BACKEND_AUDIT.md) |
| Maximal lower break/common residue lemma | PASS; exact Serre IV.2 Proposition 11, indexing and tail bound checked; `/root/x_elliptic_quotient_maps`, 2026-09-05 | [record](MAXIMAL_LOWER_BREAK_COMMON_RESIDUE_AUDIT.md) |
| Ordinary-atlas Cartier bounds and weak two-point power-of-two arithmetic | PASS/PASS; non-Galois local charts, Cartier decomposition, parameterized bound, and exact ten-row table checked; `/root/x_elliptic_quotient_maps`, 2026-09-05 | [record](ORDINARY_ATLAS_AND_WEAK_TWO_POINT_AUDIT.md) |
| Generic hyperelliptic bounded-exponent abelian covers | PASS; maximal Kummer cover, compact-type extension, nodal Frobenius, and moduli openness checked; `/root/x_elliptic_quotient_maps`, 2026-09-05 | [record](GENERIC_HYPERELLIPTIC_BOUNDED_ABELIAN_COVERS_ORDINARY_AUDIT.md) |
| Bounded atlas degree and finite orbifold partners | PASS; Galois closure over the assumed orbifold, effectiveness, and fixed-degree cover finiteness checked; `/root/x_elliptic_quotient_maps`, 2026-09-05 | [record](BOUNDED_ATLAS_DEGREE_GIVES_FINITE_ORBIFOLD_PARTNERS_AUDIT.md) |
| Ordinary genus-two uniform orbifold degree bound | PASS; degree-eight amplification, exceptional-row integrality, all coarse genera, and finite-partner corollary checked; `/root/x_elliptic_quotient_maps`, 2026-09-05 | [record](ORDINARY_GENUS_TWO_UNIFORM_ORBIFOLD_DEGREE_BOUND_AUDIT.md) |
| Bounded cored degrees and infinitely many coreless correspondences, Sections 1--6 | Focused PASS; no breaking objection; `/root/canonical_trace_algebra`, `/root/x_elliptic_quotient_maps`, and literature check by `/root/gluing_cohomology_rigidity`, 2026-09-05; later Section 7 is author-only | [record](BOUNDED_ORBIFOLD_QUOTIENTS_CORELESS_ITERATION_AUDIT.md) |
| Non-Galois Jacobian orthogonality, stabilization and coreless amplification | PASS; nonbreaking wording suggestions incorporated; `/root/x_elliptic_quotient_maps`, `/root/gluing_cohomology_rigidity`, 2026-09-05 | [record](NONGALOIS_JACOBIAN_STABILIZATION_AUDIT.md) |
| Boxall-style torsion intersection and every cyclic tower, Sections 1--3 | PASS; no breaking objection, restricted-theta properness retained; `/root/gluing_cohomology_rigidity`, 2026-09-05 | [record](BOXALL_PRUFER_CYCLIC_TOWER_AUDIT.md) |

If a theorem changes mathematically after its recorded hash, its audit is
stale until the record is refreshed.  Pure changes to an audit link or other
metadata should still be noted when practical.
