# Audit: virtual-surface families rigidity for the root-stack group

**Verdict:** **PASS.** No breaking objection.

**Auditor and date:** `/root/families_notes_audit`, 2026-09-04.

**Non-breaking suggestions and objections:**

- Lemma 50.2 is correct, including in the presence of wild automorphisms.
  It would benefit from an explicit citation for the graph-diagonal form of
  the \(\ell\)-adic Lefschetz formula. If an automorphism acted trivially on
  \(H^1\), that formula would give the impossible negative intersection
  \(2-2g\) of two distinct effective curves.
- In Section 2, say explicitly that specialization identifies \(P_U\)
  abstractly with a characteristic-zero pro-31 surface group; it does not
  assert an equivariant lift of the whole deck action. The subsequent proof
  correctly handles the finite extension directly.
- The original draft shared number 50 with
  `50_FAMILIES_PRESERVATION_MOD_31_TEST.md`; it was subsequently renumbered
  as file 52 without changing the mathematics.
- This theorem is not a duplicate of the unnumbered smooth-curve theorem:
  it concerns the root-stack group and controls a finite deck extension.
  Nevertheless, it is strategically redundant for visibility, because
  families preservation already implies normality and hence supplies an
  admissible common core through file 21. Retain it only as a standalone
  ambient-innerness theorem; otherwise consolidate its application boundary
  into the literature note.

The audit checked the torsion-free atlas and cofinal kernels, faithfulness of
the deck action on \(\operatorname{Out}(\pi_1^{(31)})\), the centralizer and
no-finite-normal-subgroup arguments, promotion of internal
indecomposability across the finite extension, construction of the free
normal subgroup, the exact hypotheses of Minamide--Sawada--Tsujimura
Theorem 2.4, descent of families preservation, and the compactness argument
of their Lemma 2.5. The proof is valid.

**Audited revision:** SHA-256
`5a235411834b3a5e73575060d9f9bd555fdff5602bc1cac804fb851da2af7efc`.
No theorem-file edit was made by this auditor.
