# Picard common-cover example: independent audit

- Verdict: PASS.
- Auditor: `/root/picard_simple_pair_audit`, fresh bounded agent.
- Date: 2026-09-07.
- Scope: version 1 of [the statement](../../Theorems/Thm_picard_simple_common_cover.md),
  its [proof](../../Solutions/Sol_picard_simple_common_cover.md), and the
  [fixed-pair certificate](../computations/picard_cubic_common_cover_certificate.json).
- Verification: independent prose audit and exact computational rerun;
  not formal proof verification.

The Kummer classes are independent. All five branch points, including
infinity, have the stated axis inertia; both diagonal subgroup actions
are free. The two displayed functions generate the actual invariant
fields, and give the stated genus-seven source, genus-three endpoints,
degree-three etale Galois legs, and rational core.

The verifier was rerun with its output write replaced by exact comparison
against the saved JSON; every assertion and the complete comparison passed.
Source SHA256: `f28805d3c0ed7e0b8e5a3e65d285d7b573f5b59a738b12eb678e851ccb9002cd`.
A separate integer-pair implementation of F25 independently reproduced
the base-field counts 26 and 17. The resultant construction, removal of
exactly six diagonal roots, and exhaustive cyclotomic bound were checked.
Irreducibility and no self root-of-unity ratios prove absolute simplicity
without ordinarity; the cross test proves geometric Hom-zero. The Newton
polygon vertices are (0,6),(2,2),(4,0),(6,0), yielding normalized slopes
0,0,1/2,1/2,1,1 and p-rank two for both endpoints.

Nonblocking editorial objection: the proof's computation-record link
initially named the retired `PICARD_CUBIC_COMMON_COVER_SEARCH.md`; the
current record is `PICARD_CUBIC_COMMON_COVER_CERTIFICATE.md`. The author was
notified to update this link. No mathematical blocking objection found.
