# Proof Approach: Over-Orbifold Classification

Combined retrieval file. Consult `01_MASTER_INDEX.md` first; each section below keeps its original archive item ID.

---
id: DEF-FINITE-OVER-ORBIFOLD
type: definition
title: "Finite étale over-orbifold of S"
status: locked
approach: proof-approach/over-orbifold-classification
depends_on: [DEF-S-TRIANGLE-STACK]
implies: [LEM-FIBER-DIFFERENT-BOOKKEEPING, THM-OVER-ORBIFOLD-TAME]
review_status: "stable"
source: [S2, S3, S4]
last_updated: 2026-05-26
---

# Statement

A finite étale over-orbifold of `S` is a representable finite étale map

`f : S → O`

to a smooth proper connected Deligne–Mumford curve `O`.

# Context / motivation

The over-orbifold classification is one of the main completed-looking components of the project. It asks which stack quotients or over-targets `O` can receive a representable finite étale map from `S`.

The classification is useful for the main theorem only if arbitrary self-correspondences `C⇉S` can be reduced to finite over-orbifolds in a valid way.

# Proof or evidence

This is a definition. It is stable in the archive.

The current classification program distinguishes:

- tame over-orbifolds, controlled by the triangle-group commensurator;
- weakly ramified wild over-orbifolds, excluded by a locked-looking argument;
- non-weak wild over-orbifolds, excluded by local Swan divisibility and arithmetic checks, but still requiring referee audit.

# Dependencies

- `DEF-S-TRIANGLE-STACK`.

# Failure points / caveats

- An over-orbifold `S→O` is not the same as an arbitrary self-correspondence `C⇉S`.
- Riemann–Hurwitz and local ramification exclusions apply after such an `O` exists.
- The false finite-envelope route consisted partly in assuming such an `O` is automatic from arbitrary common-cover data.

# How this is used

This definition supports:

- `LEM-FIBER-DIFFERENT-BOOKKEEPING`;
- `LEM-ATMOST-ONE-WILD`;
- `PROP-WEAK-WILD-EXCLUSION`;
- `PROP-NONWEAK-WILD-EXCLUSION`;
- `THM-OVER-ORBIFOLD-TAME`.

# Related items

`THM-OVER-ORBIFOLD-TAME`; `PROP-CORRESPONDENCE-TO-OVER-ORBIFOLD`; `FALSE-GENERAL-FINITE-ENVELOPE`; `DISCARD-RH-WITHOUT-ENVELOPE`.

---

---
id: LEM-FIBER-DIFFERENT-BOOKKEEPING
type: lemma
title: "Fiber degree and different bookkeeping for S→O"
status: locked
approach: proof-approach/over-orbifold-classification
depends_on: [DEF-FINITE-OVER-ORBIFOLD]
implies: [LEM-ATMOST-ONE-WILD, PROP-WEAK-WILD-EXCLUSION, PROP-NONWEAK-WILD-EXCLUSION]
review_status: "locked but local stack conventions should be checked"
source: [S2, S3, S4]
last_updated: 2026-05-26
---

# Statement

Let

`f : S → O`

be a finite étale over-orbifold. For a point `y ∈ O`, write:

- `N_y` for the stabilizer order at `y`;
- `δ_y` for the local different exponent;
- `m_y` for the number of ordinary points of `S` above `y`;
- `n_y ∈ {0,1,2,3}` for the number of stacky `C31`-points of `S` above `y`.

Then the local fiber-degree bookkeeping is

`d = N_y(m_y + n_y/31)`,

and the local contribution to the coarse different is

`D_y = m_y δ_y + n_y(δ_y - 30)/31`.

Globally,

`Σ_y D_y = 2d - 2`.

# Context / motivation

This is the numerical foundation for the over-orbifold classification. It translates a finite étale stack map `S→O` into constraints on stabilizers, wild inertia, and local different contributions.

# Proof or evidence

The archive treats this bookkeeping as locked, though it notes that local stack conventions should be checked. The subtraction of `30` reflects the existing `C31` stack structure upstairs at the three stacky points of `S`.

# Dependencies

- `DEF-FINITE-OVER-ORBIFOLD`.

# Failure points / caveats

- Must keep ordinary preimages and stacky `C31` preimages separate.
- Must not apply this bookkeeping before an over-orbifold `S→O` has actually been constructed.
- Local wild inertia conventions and different normalization should be checked when auditing the over-orbifold proof.

# How this is used

This lemma is used to prove:

- at most one wild target point can occur;
- weakly ramified wild over-orbifolds are excluded;
- non-weak wild over-orbifolds reduce to local ramification arithmetic.

# Related items

`DEF-FINITE-OVER-ORBIFOLD`; `LEM-ATMOST-ONE-WILD`; `PROP-WEAK-WILD-EXCLUSION`; `PROP-NONWEAK-WILD-EXCLUSION`; `THM-OVER-ORBIFOLD-TAME`.

---

---
id: LEM-ATMOST-ONE-WILD
type: lemma
title: "At most one wild target point on a finite over-orbifold"
status: locked
approach: proof-approach/over-orbifold-classification
depends_on: [LEM-FIBER-DIFFERENT-BOOKKEEPING, LEM-TAME-CHARACTER-GRADED]
implies: [PROP-WEAK-WILD-EXCLUSION, PROP-NONWEAK-WILD-EXCLUSION]
review_status: "verify inequalities for n_y>0 and ord_31(5)=3; otherwise stable"
source: [S2, S3, S4]
last_updated: 2026-05-26
---

# Statement

For a finite étale over-orbifold

`S → O`,

there is at most one wild stacky point on `O`.

The project summary records the key inequality as:

any wild stacky point of `O` contributes more than `d` to the coarse different, while the total coarse different is `2d-2`.

# Context / motivation

This lemma reduces the wild part of the over-orbifold classification to a single local wild inertia group. Without it, the local ramification analysis would have to handle multiple interacting wild points.

# Proof or evidence

The proof uses the fiber/different bookkeeping for `S→O` and the tame-character constraints on local graded pieces. The archive treats the result as locked but recommends checking inequalities, especially in cases where a wild target point has stacky `C31` points of `S` above it.

# Dependencies

- `LEM-FIBER-DIFFERENT-BOOKKEEPING`;
- `LEM-TAME-CHARACTER-GRADED`.

# Failure points / caveats

- Check the inequality in the cases `n_y > 0`.
- Check how `ord_31(5)=3` enters the lower bound.
- Do not use this lemma outside the over-orbifold setting; it assumes a finite étale map `S→O`.

# How this is used

It splits the wild over-orbifold exclusion into:

- weakly ramified wild case, `P_2=1`;
- non-weak wild case, `P_2≠1`.

# Related items

`LEM-FIBER-DIFFERENT-BOOKKEEPING`; `PROP-WEAK-WILD-EXCLUSION`; `PROP-NONWEAK-WILD-EXCLUSION`; `THM-OVER-ORBIFOLD-TAME`.

---

---
id: PROP-WEAK-WILD-EXCLUSION
type: proposition
title: "Weakly ramified wild over-orbifolds excluded"
status: locked
approach: proof-approach/over-orbifold-classification
depends_on: [LEM-FIBER-DIFFERENT-BOOKKEEPING, LEM-ATMOST-ONE-WILD]
implies: [THM-OVER-ORBIFOLD-TAME]
review_status: "proof appears complete; independent arithmetic audit recommended"
source: [S3, S4]
last_updated: 2026-05-26
---

# Statement

There is no finite étale over-orbifold S→O whose unique wild inertia P satisfies P2=1.

# Context / motivation

This removes the weakly ramified wild case in the over-orbifold classification.

# Proof or evidence

With Q=|P|=5^q, weak ramification gives different exponent Qt+Q−2 and t|Q−1. The canonical equation forces exactly one additional tame stacky point. Congruence and divisibility reduce to Q≥125 with ell≤4 contradiction, plus explicit Q=5,25 checks.

# Dependencies

LEM-FIBER-DIFFERENT-BOOKKEEPING, LEM-ATMOST-ONE-WILD

# Failure points / caveats

Arithmetic should be independently checked, but proof is complete-looking in the notes.

# How this is used

Feeds THM-OVER-ORBIFOLD-TAME.

# Related items

LEM-FIBER-DIFFERENT-BOOKKEEPING; LEM-ATMOST-ONE-WILD

---

---
id: PROP-NONWEAK-WILD-EXCLUSION
type: proposition
title: "Non-weak wild over-orbifolds excluded"
status: needs-referee
approach: proof-approach/over-orbifold-classification
depends_on: [THM-LOCAL-SWAN-DIVISIBILITY, LEM-SUMMATION-BY-PARTS-TAME, LEM-SAME-RESIDUE-LIE, COMP-LOCAL-ARITHMETIC-CHECKS]
implies: [THM-OVER-ORBIFOLD-TAME]
review_status: "needs full referee audit because earlier notes left a finite table proof caveat; later completion note claims proof"
source: [S3, S5, S11]
last_updated: 2026-05-26
---

# Statement

Claim: there is no finite étale over-orbifold S→O whose unique wild inertia P has P2≠1.

# Context / motivation

This is the hard local-arithmetic part of the over-orbifold classification.

# Proof or evidence

Reduction gives variables Q=5^s, g|28, D=28/g, alpha,K,M,w with alpha+D=MK, Q+M=alpha w, epsilon=Kw; residual expansion, tame-character, common-residue and tail Swan-divisibility constraints then eliminate M≥2 and M=1,n=3 branches in later notes.

# Dependencies

THM-LOCAL-SWAN-DIVISIBILITY, LEM-SUMMATION-BY-PARTS-TAME, LEM-SAME-RESIDUE-LIE, COMP-LOCAL-ARITHMETIC-CHECKS

# Failure points / caveats

Earlier text left a finite table as not fully handwritten; later completion claims it is done. Mark needs-referee until audited.

# How this is used

Together with weak exclusion, removes all wild over-orbifolds.

# Related items

COMP-LOCAL-ARITHMETIC-CHECKS; THM-LOCAL-SWAN-DIVISIBILITY; THM-OVER-ORBIFOLD-TAME

---

---
id: THM-OVER-ORBIFOLD-TAME
type: theorem
title: "All finite étale over-orbifolds of S are tame and controlled by S0"
status: needs-referee
approach: proof-approach/over-orbifold-classification
depends_on: [LEM-ATMOST-ONE-WILD, PROP-WEAK-WILD-EXCLUSION, PROP-NONWEAK-WILD-EXCLUSION, THM-TAME-COMMENSURATOR]
implies: [PROP-CORRESPONDENCE-TO-OVER-ORBIFOLD]
review_status: "major completed-looking part; not enough by itself for self-correspondences; audit required"
source: [S2, S3]
last_updated: 2026-05-26
---

# Statement

Every representable finite étale map S→O to a smooth proper connected DM curve has tame target O and is controlled by S→S/S3 in the tame commensurator category.

# Context / motivation

This is the major local/global classification of possible over-orbifolds of S.

# Proof or evidence

Uses fiber/different bookkeeping, at-most-one-wild-point, weak wild exclusion, non-weak wild exclusion, and the tame triangle commensurator.

# Dependencies

LEM-ATMOST-ONE-WILD, PROP-WEAK-WILD-EXCLUSION, PROP-NONWEAK-WILD-EXCLUSION, THM-TAME-COMMENSURATOR

# Failure points / caveats

Marked needs-referee because non-weak arithmetic and the exact relation to self-correspondences require audit. It does not by itself prove Comm_alg(S)=S3.

# How this is used

Potentially finishes the main theorem if PROP-CORRESPONDENCE-TO-OVER-ORBIFOLD is verified.

# Related items

PROP-WEAK-WILD-EXCLUSION; PROP-NONWEAK-WILD-EXCLUSION; THM-TAME-COMMENSURATOR
