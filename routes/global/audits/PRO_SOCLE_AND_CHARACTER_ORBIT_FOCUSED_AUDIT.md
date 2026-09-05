# Pro socle and character-orbit focused checks

Date: 2026-09-05. Recorder: /root, from delivered audit summaries.
Open only to investigate a concrete doubt.

## Pro criterion

Theorem: [socle criterion](../SOCLE_CRITERION_FOR_RESTRICTED_RAYNAUD_THETA.md).
SHA-256: 54ca99b47a072b44184d88c802e881bed490b45c5490f8b47a290ecdcff2f266.
Provenance: user-supplied GPT 6 Pro response.
Auditor: /root/gluing_cohomology_rigidity, 2026-09-05.
Verdict: PASS on Pro's criterion and dimension gap. No correction needed.
Checked modular torsor descent, semicontinuity, character twists, and
actual intermediate-cover descent. The auditor authored the additional
multipoint and projective-module bridge, so these additions are not
thereby independently audited.

Scope notes: generic twisted section dimension is not p-rank defect;
small a(Z) does not bound the Galois-closure a-number; minimality has not
been shown to imply the criterion.

## Root's character-orbit and non-Galois refinements

Theorem: [character-orbit tests](../CHARACTER_ORBITS_AND_NONGALOIS_RESTRICTED_THETA_TESTS.md).
SHA-256: 3ef735c6346028d49a0bbf091d24d45dd02994454b51d568479bc7d1276ee60e.
Auditor: /root/gluing_cohomology_rigidity, 2026-09-05.
Verdict: PASS; no breaking or nonbreaking correction requested.
This is a focused check, not an independent audit of all shared inputs.

Checked: generic Hom multiplicities constant on character orbits;
complete-orbit lower bound; simple submodules of images of the actual
permutation module in modular characteristic; exact weighted formula
when p does not divide the group order; and the ordinary quotient by
an abelian direct factor.

The modular numerical bound uses a(W); only the separate prime-to-p
fixed-vector formula supplies the stated bound involving a(Z).
