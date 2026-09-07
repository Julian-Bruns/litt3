# Retained legacy proof guide

Historical sources are searchable through the metadata inventory, not
automatically proved dependencies. Current work follows
[STATE.md](../STATE.md). Audit verdicts below are inherited metadata;
this guide is not a new audit.

## Reusable bundles

| Bundle | Retained inputs and limits |
| --- | --- |
| Triangle visibility | [10](../../routes/global/10_PROOF_SELF_CORRESPONDENCE.md) and [14](../../routes/global/14_PROOF_LIFT_THROUGH_Y.md): explicit genus15 atlas and visibility implication. No simultaneous envelope. |
| Wild ramification | [13](../../routes/global/13_PROOF_LOCAL_RAMIFICATION.md): Swan and tame-character divisibility, leading commutator, filtration summation. No automatic global elimination. |
| Profile-4 local algebra | [Route index](../../STRUCTURE.md): high-point reduction, Cartier logarithmic lifting, norm identities, cubic determinant normalization, simple-layer responses. Missing normal forms, tower extraction and terminal coverage remain missing. |
| Cartier foundation | [22](../../routes/global/22_CARTIER_BUNDLE_ETALE_FUNCTORIALITY_AND_LIMITS.md) and [symmetric cube/matching boundary](../../routes/global/DORMANT_OPER_ORDINARITY_DOES_NOT_SUPPLY_TWO_LEG_MATCHING.md): base change, Frobenius filtration, normalized rank-four reduction and cyclic-cover quantifiers. Universal HN spectra do not make these constructions disposable. |
| Signed-orbit method | [Full orbit and Hadamard sieve](../../routes/global/81_FULL_ORBIT_INTERPOLATION_AND_CUBIC_SIGN_MONODROMY.md), with both original PASS2026-09-04 scopes retained: all square-root choices, the all-prime genus bound and the corrected short-degree sieve. |
| Deck rigidity | [Abelian rigidity/toolkit](../../routes/global/91_ARBITRARY_ABELIAN_DECK_RIGIDITY.md), [prime-power and branch rigidity](../../routes/global/92_BRANCH_RIGID_ABELIAN_PRIME_POWER_COVERS.md), [nonabelian counterexample](../../routes/global/93_NONABELIAN_DECK_RIGIDITY_BOUNDARY.md): all original scoped PASS records retained, including the distinct cyclic Sylow theorem without branch rigidity. |
| Endomorphism packets | [95](../../routes/global/95_ABELIAN_ETALE_TOWERS_AND_ENDOMORPHISM_FIELDS.md), [96](../../routes/global/96_NONABELIAN_PACKET_SCHUR_INDEX_DOMINATION_BOUND.md), [98](../../routes/global/98_FULL_SIGNED_FROBENIUS_GROUP_AND_SHARP_PACKET_RANGE.md), [99](../../routes/global/99_SIGNED_GALOIS_CERTIFICATE_FOR_GEOMETRIC_ENDOMORPHISMS.md): checked restricted-monodromy obstructions, not all common covers. Retain their arithmetic certificates. |
| Non-Galois descent | [Connecting classes](../../routes/global/105_NONGALOIS_DESCENT_THROUGH_THE_CONNECTING_MAP.md): strict descent has PASS metadata using the retained author-only generation/equality inputs, not a re-audit. [Incidence and norm coordinates](../../routes/global/MINIMAL_COMMON_COVER_AND_INCIDENCE_DESCENT.md) preserve the integral reconstruction and missing second-leg boundary. |
| Jacobian map stabilization | [Orthogonality](../../routes/global/NONGALOIS_JACOBIAN_ORTHOGONALITY_AND_ETALE_MAP_STABILIZATION.md) distinguishes whole-Jacobian from one-factor conclusions. [Uniform target descent](../../routes/global/FINITE_RESTRICTED_THETA_CHARACTERS_FORCE_UNIFORM_ETALE_TARGET_DESCENT.md) is an author proof conditional on finite bad characters. |
| Restricted torsion towers | [Pruefer, finite-support torsion and growth](../../routes/global/BOXALL_PRUFER_TORSION_AND_EVERY_CYCLIC_TOWER.md): retain fixed finite support and prime restrictions. Scoped checks do not audit the full author torsion-coset/growth generalization. |
| Non-Galois p-rank | [Amplification and factorization](../../routes/global/112_P_RANK_ONE_NONGALOIS_FACTORIZATION.md): full modular proof, original rank-one proof and positive-rank quantitative tower retained together. The later Tango audit covers its exact input chain, not every packet example. A p-power-degree cover need not be Galois. |
| Effective orbifolds | [Partner finiteness](../../Theorems/Thm_bounded_atlas_partner_finiteness.md), [local two-branch bound](../../Theorems/Thm_fixed_x_two_branch_bound.md), headers PASS: the latter remains a needed supporting calculation. |
| Endpoint torsion | [Hyperelliptic descent](../../routes/global/HYPERELLIPTIC_LOW_DEGREE_TWO_PRIMARY_TORSION_DESCENDS.md), [W3](../../Theorems/Thm_two_primary_w3.md), [fixed-Y W6](../../routes/global/FIXED_Y_TWO_PRIMARY_W6_HAS_ONLY_TWO_TORSION.md), [Cartier eigenforms](../../Theorems/Thm_fixed_x_cartier_eigenforms.md): retain exact endpoint certificates and parameter hypotheses. |
| Counterexamples | [Tango](../../routes/global/IGUSA_TANGO_COUNTEREXAMPLE_AND_RETAINED_SECTION_BOUNDARY.md), [singleton](../../routes/global/CORELESS_PROJECTIVE_ETALE_SINGLETON_TANGO_COUNTEREXAMPLE.md), [degree9](../../routes/global/DEGREE_NINE_FREE_CHARACTER_QUOTIENT_COUNTEREXAMPLE.md), [double-zero](../../routes/global/UNBOUNDED_DOUBLE_ZERO_HECKE_LEAVES_ON_A_FIXED_GENUS17_CURVE.md): block distinct proposed repairs, not Litt itself. |
| One-sided and Galoisization limits | [Universal spectrum](../../routes/global/UNIVERSAL_ONE_SIDED_DOMINATION_FORCES_FULL_ETALE_JACOBIAN_SPECTRUM.md) permits a ramified second map; [97](../../routes/global/97_GALOIS_TO_NONGALOIS_PASSAGE_IN_COMMON_COVER_RESULTS.md) is literature/mechanism guidance, not an automatic simultaneous Galois closure. |

## Scope hazards

- The cross-correspondence rank obstruction in
  [48](../../routes/global/48_M9_CROSS_CORRESPONDENCE_RANK_OBSTRUCTION.md)
  assumes all six cross maps are birational; its unconditional version failed.
- The corrected [coefficient sieve](../../routes/global/68_PRIME_RATIO_DIAMOND_AND_ALL_DEGREE_COEFFICIENT_SIEVE.md)
  does not infer an intersection degree from a compositum degree.
- A file named CERTIFICATE can contain only an unreproduced transcript.
  [Missing inputs](../../MISSING_INPUTS.md) and the route READMEs keep the
  repeated-layer, terminal-extraction and coverage prerequisites explicit.
- [Parked tasks](../../tasks/README.md) are not the active continuation queue.
  Withdrawn prompts, dated status snapshots and duplicated terminal logs
  have been removed. Their useful mathematical warnings and regression data
  are retained in the corresponding proof records; Git preserves history.
- Preserve each audited special case until a genuinely stronger result has
  adequate evidence. Change scope and evidence explicitly; no old-path aliases.
