# Audit: families-preserving rigidity for full characteristic-p curve groups

**Verdict:** **PASS.** No breaking objection.

**Auditor and date:** `/root/families_notes_audit`, 2026-09-04.

**Non-breaking suggestions and objections:**

- Rename the auxiliary prime in the invocation of
  Minamide--Sawada--Tsujimura explicitly: their theorem is applied with
  auxiliary prime \(\ell\ne p\) and with the formation of finite groups of
  order prime to the characteristic \(p\).
- “The cover lifts uniquely with \(C\)” should be read as: after choosing a
  proper smooth mixed-characteristic lift of \(C\), its finite etale cover
  extends uniquely over that fixed lift. The lift of \(C\) itself is not
  claimed to be unique.
- A standard SGA/EGA citation for finite-etale invariance over a complete
  henselian base and proper-smooth prime-to-\(p\) specialization would be
  more direct than relying only on the cited deformation paper.
- The theorem is a useful standalone positive-characteristic extension, but
  it does not advance the triangle-root-stack application: in that
  application, families preservation already implies normality, and
  normality fixes the intersection of the two ambient cores, which is the
  admissible subgroup needed in file 21.

The audit checked simultaneous lifting of each finite-etale Galois cover,
the prime-to-characteristic specialization isomorphism on the corresponding
open subgroup, identification of each \(Q_N\) as an almost
pro-\(\mathcal C_{p'}\) characteristic-zero surface quotient, preservation
of \(R_N\), applicability of Theorem 3.11(iii), directedness and trivial
intersection of the kernels, and the compact inverse-limit step via Lemma
2.5. These steps are valid.

**Audited revision:** SHA-256
`e74336cdd837f8e1777f5262e4371d3d8c8d926ec3f3daf1572e08179efab882`.
