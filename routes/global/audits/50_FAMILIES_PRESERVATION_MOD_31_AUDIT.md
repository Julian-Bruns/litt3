# Audit: mod-31 shadow of families preservation

**Verdict:** **PASS.** No breaking objection.

**Auditor and date:** `/root/families_notes_audit`, 2026-09-04.

**Non-breaking suggestions and objections:**

- In Proposition 50.2, say “for the fixed normalizing permutation
  \(\sigma\)” rather than introducing \(\sigma\) a second time. The proof
  uses the same permutation as Lemma 50.1.
- Equation (50.1) can be made fully self-contained by giving the one-line
  Kummer calculation
  \(H^1(S,\mu_{31})=\operatorname{Pic}(S)[31]\simeq
  (\mathbf Z/31)^2\). The stated answer and inertia relation are correct.
- The phrase “fails already after passage to the mod-31 quotient” means
  that no \(S_3\)-normalization yields the single-scalar relation (50.4).
  Stating that interpretation explicitly would avoid reading it as a claim
  about an induced quotient isomorphism.
- Strategically, proving full families preservation is unnecessary here:
  its formal normality consequence already fixes a common ambient-normal
  core and gives an admissible subgroup by Proposition 21.1. The useful new
  content of this note is therefore the sharper finite test: in degrees
  \(32\)--\(44\), partition alignment plus vanishing of the two Kummer
  discrepancies already implies visibility.

The audit checked the exact definition of families preservation, passage to
the elementary abelian quotient, the index argument in degree 31, the
projective scalar lemma, root-stack inertia orientations, the common
three-part partition, the two Kummer ratios and their divisors, the
degree-at-most-two conclusion, uniqueness of the hyperelliptic pencil, and
the two endpoint limitations. All deductions are valid with the conventions
used in the note.

**Audited revision:** SHA-256
`fa33a7d97ebf6284d034f8f9c59daceda66a98010bfd1492bcf3d84e5f4e0ee8`.

