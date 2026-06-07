# Proof Approach: Profinite Orbifold Group

Combined retrieval file. Consult `01_MASTER_INDEX.md` first; each section below keeps its original archive item ID.

---
id: THM-TAME-COMMENSURATOR
type: theorem
title: "Tame/complex commensurator of Delta(31,31,31)"
status: conditional
approach: proof-approach/profinite-orbifold-group
depends_on: [DEF-S-TRIANGLE-STACK]
implies: [THM-OVER-ORBIFOLD-TAME, PROP-TAME-SELF-CORRESPONDENCE]
review_status: "external reference check needed: Singerman/Takeuchi; accepted as tame input in project files"
source: [S3, S4, S9]
last_updated: 2026-05-26
---

# Statement

In the prime-to-5 or complex Fuchsian category, the orientation-preserving commensurator of the triangle group

`Delta(31,31,31)`

is

`Delta(2,3,62)`,

with index `6`. Stack-theoretically, this corresponds to the quotient

`S → S/S3 ≃ P^1(2,3,62)`.

# Context / motivation

This is the tame model for the desired characteristic-5 algebraic commensurator theorem. It explains why the expected answer is exactly `S3`: the three equal order-31 stacky points have only the six visible permutations in the tame/complex commensurator.

# Proof or evidence

The archive treats this as standard external input, tied to classical triangle-group commensurator results attributed in the project notes to Singerman/Takeuchi-type classifications.

It has not yet been source-verified inside the archive. Therefore its status is `conditional`, not `locked`.

# Dependencies

- `DEF-S-TRIANGLE-STACK`.

# Failure points / caveats

- Need exact references for the inclusion `Delta(p,p,p) ⊂ Delta(2,3,2p)` and the relevant maximality/non-arithmetic statement for `p=31`.
- Need to verify that the orientation-preserving triangle-group statement translates exactly to the stack quotient `S/S3 ≃ P^1(2,3,62)`.
- Does not by itself prove the characteristic-5 theorem, because wild finite étale phenomena may exist.

# How this is used

Used in:

- the tame part of the over-orbifold classification;
- the conditional proposition that purely tame self-correspondences are killed by `pi0`;
- excluding the possibility that a tame over-orbifold larger than `S0` exists.

# Related items

`REF-SINGERMAN-TAKEUCHI`; `THM-OVER-ORBIFOLD-TAME`; `PROP-TAME-SELF-CORRESPONDENCE`; `DISCARD-CHARZERO-LIFTING`.

---

---
id: PROP-TAME-SELF-CORRESPONDENCE
type: proposition
title: "Tame self-correspondences are killed by pi0"
status: conditional
approach: proof-approach/profinite-orbifold-group
depends_on: [THM-TAME-COMMENSURATOR]
implies: [DEF-ALG-COMMENSURATOR]
review_status: "depends on exact meaning of tame finite étale category in characteristic 5"
source: [S4, S9]
last_updated: 2026-05-26
---

# Statement

Conditional proposition:

If a finite étale self-correspondence

`u, v : C → S`

is purely tame / prime-to-`5`, then the tame commensurator input forces

`pi0 ∘ u ≃ pi0 ∘ v`.

Equivalently, in the tame situation, `(u,v):C→S×S` factors through

`S ×_{S0} S`.

# Context / motivation

This is the tame analogue of the main characteristic-`5` commensurator statement. It records exactly what the complex/Fuchsian triangle-group calculation is allowed to prove without additional wild-local input.

The expected full theorem says every finite étale self-correspondence of `S` is one of the six `S3` symmetries after quotienting by `S0`. The tame theorem proves this only under a tameness restriction.

# Proof or evidence

The argument depends on `THM-TAME-COMMENSURATOR`: in the complex or prime-to-`5` orbifold category, the commensurator of `Delta(31,31,31)` is controlled by `Delta(2,3,62)`, corresponding to the quotient

`S → S/S3 ≃ P^1(2,3,62)`.

Thus a tame correspondence cannot introduce new commensurator elements beyond the visible `S3` symmetries.

# Dependencies

- `THM-TAME-COMMENSURATOR`.

# Failure points / caveats

- This proposition does not settle wild characteristic-`5` correspondences.
- The exact meaning of “purely tame / prime-to-`5` correspondence” must be fixed before using this as a formal theorem.
- Do not use this proposition as a replacement for the full algebraic commensurator theorem.
- The external triangle-group reference still needs verification through `REF-SINGERMAN-TAKEUCHI`.

# How this is used

This proposition supplies the tame endpoint once local or global arguments eliminate wild behavior. It is also a useful sanity check for proposed counterexamples: any valid non-`S3` correspondence must use genuine characteristic-`5` wild phenomena.

# Related items

`THM-TAME-COMMENSURATOR`; `DEF-ALG-COMMENSURATOR`; `BOTTLENECK-ALG-COMM-S31`; `DISCARD-CHARZERO-LIFTING`; `REF-SINGERMAN-TAKEUCHI`.

---

---
id: REF-SINGERMAN-TAKEUCHI
type: reference-needed
title: "Reference needed: Singerman/Takeuchi tame commensurator input"
status: open
approach: proof-approach/profinite-orbifold-group
depends_on: [THM-TAME-COMMENSURATOR]
implies: []
review_status: "source verification"
source: [S9, S4]
last_updated: 2026-05-26
---

# Statement

Reference-audit task:

Verify the exact classical input behind `THM-TAME-COMMENSURATOR`, namely:

1. the inclusion

   `Delta(p,p,p) ⊂ Delta(2,3,2p)`

   for the relevant orientation-preserving triangle groups;

2. the maximality / non-arithmetic commensurator statement for `p=31`;

3. the translation from the triangle-group statement to the stack quotient

   `S/S3 ≃ P^1(2,3,62)`.

# Context / motivation

The tame commensurator theorem is used as the classical endpoint of the over-orbifold classification and the tame self-correspondence argument. It is treated as standard in the project notes but still needs exact bibliographic verification.

# Proof or evidence

No source verification is included in this file. The project notes mention Singerman/Takeuchi-type results as the expected references.

# Dependencies

- `THM-TAME-COMMENSURATOR`.

# Failure points / caveats

- Need the exact orientation-preserving convention.
- Need to confirm the index is `6` and matches the `S3` quotient.
- Need to ensure the result applies to `p=31` and not only generically.
- Need to separate the complex/tame statement from the full characteristic-`5` algebraic commensurator theorem.

# How this is used

This file should be placed in the review queue before finalizing any proof depending on `THM-TAME-COMMENSURATOR`.

# Related items

`THM-TAME-COMMENSURATOR`; `PROP-TAME-SELF-CORRESPONDENCE`; `THM-OVER-ORBIFOLD-TAME`; `DISCARD-CHARZERO-LIFTING`.
