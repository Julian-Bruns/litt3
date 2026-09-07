# Exact computation status for a no-cored-cover decision

Snapshot: 2026-09-07 22:27 CEST. Read from the saved production manifests,
run records and named original-equation certificates, not a runtime forecast.
The original common-cover problem is UNSOLVED. Both actual finite etale
maps must have the SAME smooth projective source.

## Actual results

**Whole oper representatives excluded: 0 of18. Whole atlas solutions found
and reconstructed by this run: 0.** No representative has all32 charts
certified empty. Consequently neither A14 nor A18 is a theorem.

The separate rank-two oper enumeration IS complete:28990 distinct geometric
opers, total scheme length29375;55 points have multiplicity8 and28935 have
multiplicity1. Frobenius and the actual cubic deck symmetry give18 untwisted
representatives. All18 original oper-equation checks passed. This enumerates
opers, not atlases or common covers, and proves no atlas emptiness.

| Representative | Exact constant certificates | Exact polynomial unit certificates | Unique certified charts |
|---|---|---|---:|
| orbit0000 |30,31|22,23,28,29|6|
| invariant0 |29,31|22,23|4|
| invariant1 |29,31|22,23|4|
| invariant2 |29,31|none|2|
| orbit0001 |30,31|none|2|
| invariant3 |29,31|none|2|
| Other12 representatives |none|none|0|
| TOTAL |12|8|20|

The production queue has adopted18 of these20 certificates. The extra two
are the already-verified first-oper28/29 identities in external
`atlas-mixed-certificates/chart-28/result.json` and `chart-29/result.json`;
their tensor hash is
`bcc027f5e4c283d35f71bc0cdd58a404ee880a5f65b6df1685a62fa670339a06`.
The additional first29 affine-trail certificate proves the same chart,
not a21st chart. Unit-basis candidates are not counted as certificates.

The saved queue reports37 completed chart calculations:18 adopted
certificates and19 bases still labelled `basis_needs_verification`.
Two of those19 have the external certificates just noted, leaving17
additional unverified chart results. Invariant2 chart30 also has a saved
unit-basis candidate behind a reporting failure; it is not promoted here.

Six full coefficient tensors exist. Five representatives have all32 chart
exports; invariant3 has10. Orbit2 has only partial preparation checkpoints.
Selected14 means448 charts; all18 means576. Orbits8..11 remain deferred.
Preparation, a rank test, a bounded failed certificate search, or a timeout
is never counted as an exclusion.

## What a successful or unsuccessful run would imply

* All14 selected untwisted systems empty proves A14 only; four untwisted
  representatives still remain.
* All18 untwisted systems empty closes the untwisted Hermitian/PSU atlas
  branch under the proved geometric reduction. It does NOT prove that the
  fixed pair has no cored common cover.
* Nontrivial PGU twists remain: tau ranges in Pic(X)[3]. The same rank-two
  census is reusable, but the rank-three compatibility equations change.
  The fullPGU case remains; excluding216-monodromy in orbits10/11 for every
  tau is not an exclusion of those whole oper/twist systems.
* The smaller cored signatures with deg(X/S)<=2240 are not all excluded.
  The separate small-degree sieve excludes <=8, not every bounded case.
* A reconstructed atlas solution defeats this particular non-atlas
  obstruction; it does not by itself construct a common cover of the
  fixed genus-nine X and fixed genus25 Y.

Even excluding every cored case would leave the coreless branch of the
original problem. Conversely, changing the partner using the audited
`bounded_atlas_partner_finiteness` construction can avoid all cored cases
without A18, but is a different target choice. The active pair is unchanged.
Exact boundaries and theorem IDs are in [AFTER_ENUMERATION.md](AFTER_ENUMERATION.md).

## Certificate replay and remaining trust

The portable mathematical certificate is a finite polynomial identity
`sum_i H_i f_i = 1` for the ORIGINAL rooted chart rows, with an explicitly
specified finite field, variable order and projective chart substitution.
Constant certificates are the special case with constant H_i. Every full
atlas solution satisfies those rows, so such an identity excludes the
entire chart, including nongeneric/higher-corank points.

Current files contain field moduli/power-basis conventions, original tensor
hashes, chart indices, row order and explicit multiplier polynomials.
`export_rooted_atlas.sage` verifies constant combinations and exact field/text
roundtrips. `mixed_atlas_certificate.sage` reconstructs multipliers from
native provenance and checks the identity against original N/s rows.
`rooted_atlas_chart29_certificate.sage` is a small dedicated first29 replay.
There is not yet a standalone universal Lean certificate verifier.

For Lean, replay sparse exponent/coefficient arrays in the stated quotient
field and check the resulting polynomial is exactly1. A verified identity
need not trust the Groebner/native search algorithm or its timing/status.
Hashes identify data; hashes and saved `verified:true` flags are not proofs.
One must additionally formalize/check coefficient-field irreducibility,
the completeness of the oper census and32-chart cover, exact tensor
derivation from the curve/oper, and the geometric atlas-to-cored reduction.
Those are currently audited/author prose and exact Sage/CAS computations,
not Lean theorems. Current replay still trusts Sage's polynomial/finite-field
arithmetic and parser, and the relevant native arithmetic libraries.

At this snapshot the main queue is checkpoint-safely paused for a Sage10.9
Laurent-indexing audit. Raw fixtures pass with the new guarded accessor in
all18 intrinsic fields plus the actual orbit1 tower, including degree14648
overF5. The bug concerns exact monomial series in native large fields;
all previously completed production fields pass the raw fixture. No
affected tensor or original-equation certificate has been identified.
Performance changes and proof-preserving validations are tracked separately
in [ATLAS_OPERATION_LOGGING.md](ATLAS_OPERATION_LOGGING.md).
