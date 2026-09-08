# Exact computation status for a no-cored-cover decision

Snapshot: 2026-09-08 03:50 CEST. Read from the saved production manifests,
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

| Representative | Adopted original-equation certified charts | Count |
|---|---|---:|
| orbit0000 |22,23,29,30,31|5|
| invariant0 |22,23,27,28,29,30,31|7|
| invariant1 |22,23,27,28,29,30,31|7|
| invariant2 |28,29,30,31|4|
| orbit0001 |29,30,31|3|
| invariant3 |28,29,30,31|4|
| orbit0002 |29,30,31|3|
| orbit0003 |29,30,31|3|
| invariant4 |28,29,30,31|4|
| invariant5 |28,29,30,31|4|
| orbit0004 |30,31|2|
| orbit0006 |29,30,31|3|
| orbit0007 |30,31|2|
| orbit0005 and deferred orbit0008--0011 |none|0|
| TOTAL ADOPTED | |51|

One additional UNIQUE chart has an exact external certificate not adopted
at this snapshot: first-oper28, in `atlas-mixed-certificates/chart-28/result.json`.
Thus52 distinct chart exclusions are known, of which51 are adopted. The
older external first29 and original-field orbit7chart31 certificates
duplicate adopted charts and are not counted again. First-oper tensor hash:
`bcc027f5e4c283d35f71bc0cdd58a404ee880a5f65b6df1685a62fa670339a06`.
Orbit7 tensor hash:
`32f4bed4816c53a49259dbb0535d62e59a2981547d0ef15fec8924f7f6bdeb9d`.
Orbit7 charts31 and30 were solved after checked coefficient descent
1320->440 over F5, lifted to all97 ORIGINAL rows, and freshly replayed
from the original JSON in31.46s and62.05s. The descent is a search
representation only, not a weakened certificate. Unit-basis candidates
are not counted as certificates.

The saved production queue reports64 completed chart calculations:51
adopted certificates and13 unverified basis records. One of those13 is
the externally certified first28 just noted. Neither these partial chart
counts nor basis candidates exclude any whole representative.

All14 selected full coefficient tensors exist. Native searches can now
read checked coefficient caches directly, so exporting all32 text charts
is no longer a prerequisite for each representative.
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
The native-coefficient path uses `verify_native_original_atlas.sage` for a
fresh no-solver reconstruction and replay of all97 original rooted rows.
Search-only caches, cubic gradings and affine eliminations are not trusted
as substitutes for that identity. There is not yet a standalone universal
Lean certificate verifier.

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

At this snapshot the selected14 run is STOPPED, under the user's new
ONE CPU core TOTAL policy. Last controller26046 and all owned exporter
descendants have exited; no automatic restart is scheduled. Deferred8--11
remain unchanged. A not-run one-worker command and the preserved orbit6
exporter PARI-result-thread failure are documented in
[ATLAS_OPERATION_LOGGING.md](ATLAS_OPERATION_LOGGING.md). That operational
failure produced no chart manifest or affected completed certificate.
The six specifically approved legacy-packing holds were recovered
only after every original direction round-tripped and all192 old native
binaries remained hash-identical. The original orbit2/6 cleanup recoveries
adopted only original-row certificates with fresh replays. All failed
mathematical/time/memory attempts remain preserved, not silently retried.
The restart preserved all1008 inventoried tensor, direction and proof
artifacts (1,857,303,568 bytes), with a separate six-case packing inventory.
Raw Laurent fixtures pass in
all18 intrinsic fields plus the actual orbit1 tower, including degree14648
overF5. The bug concerns exact monomial series in native large fields;
all previously completed production fields pass the raw fixture. No
affected tensor or original-equation certificate has been identified.
The NEW shared-root cache separately passes26 fresh-process fixtures:
all18 intrinsic fields and all eight genuine chosen cubic extensions,
including degree14648 and4308. Every3072-slot fixture has24 selected
coefficient positions, not a dense full tensor. Independent scalar
fifth-power/inverse checks, negative inputs and exact cache reuse pass;
this is arithmetic coverage, not new chart or whole-representative evidence.
The legacy F4 fallback's32.5year forecast is not an ETA validated for the
new native method. Ten-core stage gains do not establish whole-run
completion. Performance changes and proof-preserving validations are tracked separately
in [ATLAS_OPERATION_LOGGING.md](ATLAS_OPERATION_LOGGING.md).
