# Proof Approach: Lift Through Y

Combined retrieval file. Consult `01_MASTER_INDEX.md` first; each section below keeps its original archive item ID.

---
id: LEM-GENUS-Y
type: lemma
title: "Genus and atlas of Y→S"
status: locked
approach: proof-approach/lift-through-Y
depends_on: [DEF-S-TRIANGLE-STACK]
implies: [PROP-CONDITIONAL-COMMON-COVER]
review_status: "stable"
source: [S1, S6]
last_updated: 2026-05-26
---

# Statement

Let

`Y : y^31 = x(x-1)`

over `k = \bar F_5`, and let `C31` act by `y ↦ ζy`.

Then:

1. `Y` has genus `15`.
2. The quotient stack is `S = [Y/C31]`.
3. The map `Y → S` is a representable finite étale `C31`-torsor.

# Context / motivation

This is the bridge between the stack `S = P^1(31,31,31)` and the ordinary curve `Y`. It is used in lift-through-`Y` arguments and in the conditional common-cover consequence.

# Proof or evidence

The genus computation is the standard cyclic-cover Riemann–Hurwitz calculation for the degree-`31` cover `Y→P^1` branched at the three points `0,1,∞`, each with full ramification index `31`.

The Riemann–Hurwitz formula gives

`2g(Y)-2 = 31(-2) + 3(31-1) = -62 + 90 = 28`,

so `g(Y)=15`.

Since `S=[Y/C31]`, the atlas map `Y→S` is the quotient torsor in the stack sense. It is representable finite étale because the stack structure of `S` records exactly the stabilizers of the branched coarse cover.

# Dependencies

- `DEF-S-TRIANGLE-STACK`.

# Failure points / caveats

- The coarse map `Y→P^1` is ramified; the stack map `Y→S` is finite étale. Do not confuse these two statements.
- The finite étale claim is a stack statement, not a statement about the coarse curve map.

# How this is used

This lemma is used in `PROP-CONDITIONAL-COMMON-COVER`: if a genus-three curve had a common finite étale cover with `Y`, the cover can be translated into a correspondence involving `S`, after which the commensurator bottleneck would force descent through `S0`.

# Related items

`DEF-S-TRIANGLE-STACK`; `PROP-CONDITIONAL-COMMON-COVER`; `CONJ-COMMON-COVER-NEGATIVE`; `BRANCH-LIFT-THROUGH-Y`.
