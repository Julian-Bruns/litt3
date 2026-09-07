# Ordinary absolutely simple common-cover audit

- Verdict: PASS.
- Auditor: `/root/ordinary_simple_pair_audit`, fresh bounded independent review.
- Date: 2026-09-07.
- Reviewed statement: [ordinary_simple_common_cover, Version1](../../Theorems/Thm_ordinary_simple_common_cover.md).
- Reviewed proof: [Sol_ordinary_simple_common_cover.md](../../Solutions/Sol_ordinary_simple_common_cover.md), including its explicit Section3 arithmetic dependency in the Picard proof.
- Geometry verified: independent Kummer classes; connected smooth projective genus10 source; six inertia axes and no inertia at infinity; free diagonal/anti-diagonal actions; invariant fields exactly the displayed genus4 endpoints; actual degree3 finite etale Galois maps from the same source; field intersection exactly k(t).
- Arithmetic verified: full fixed verifier rerun with output writing replaced by exact comparison against the saved JSON; identical entire certificate, including extension counts through degree4, irreducibility, self/cross resultants and all127 eligible cyclotomic gcd tests. Script SHA256: `f056d9192fec281810d58eba184adf60d3b4c93a1ad91d7b062ba12856cca9c3`. Separate elementary F25 arithmetic reproduces33/33 points. Reciprocal reductions give p-ranks2/4. The exact root-ratio certificates imply both absolute simplicities and geometric Hom-zero as claimed.
- Blocking objections: none.
- Nonblocking objections: none.
- Scope: prose and exact computational audit, not Lean verification. This positive example does not solve Litt3 and establishes no coreless span for these endpoints.
