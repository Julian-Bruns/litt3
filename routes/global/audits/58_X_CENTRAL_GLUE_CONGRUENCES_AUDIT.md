# Audit: central gluing congruences for `J(X)`

**Verdict:** **PASS.**  No breaking mathematical or computational objection
found.

**Auditor and date:** `/root/degree45_family_endpoint`, 2026-09-04.

## Checks performed

- Ran
  `sage routes/global/58_X_CENTRAL_GLUE_CERTIFICATE.sage` successfully
  with SageMath 10.9.  It reproduced
  \[
  C_2\times C_{16}^2,
  \qquad C_3\times C_9^3,
  \qquad C_7^2\times C_{49}^2
  \]
  for the three Sylow groups and found no spectrum satisfying all three
  congruences.  Runtime was about 29 seconds on one CPU core.
- Independently checked that the three residual quadratics are separable
  and irreducible and that each of their roots has the asserted order
  \(3,8,48\), respectively.  The implicit derivative is a unit in each
  row, so corresponding lifted roots differ with valuations exactly
  \(2,1,1\), not merely at least those values.
- Checked Lemma 58.1 directly after the unramified quadratic splitting.
  If bases are chosen for the two axis-intersection lattices, a glued
  rank-two lattice has the displayed one-parameter normal form.  Its
  gluing depth is at most the valuation \(a\) by Frobenius stability.  The
  reduction is a single Jordan block exactly at depth \(a\), and a scalar
  pair preserves that lattice only when its difference is divisible by
  \(\ell^a\).  Thus the lemma gives the claimed congruence.
- For each prime, the third rational Frobenius factor is separated
  integrally because its reduction is coprime to the colliding quadratic.
  The reported dimensions of \(J(X)(\mathbf F_{5^n})[\ell]\) therefore
  decide between the only two possible four-dimensional modules,
  \(k[T]/(q^2)\) and \(k[T]/(q)^{\oplus2}\).  At \(\ell=3,7\), the
  noncolliding factor contributes exactly two fixed dimensions; at
  \(\ell=2\), a split colliding pair alone would already contribute four,
  exceeding the total dimension three.  Hence all three colliding modules
  are cyclic, as required.
- The finite group calculations certify themselves: the resultant gives
  the full Jacobian order, and the generated subgroup is asserted to have
  exactly its full Sylow order before invariant factors are accepted.
  Randomness affects only how generators are found.
- The use of the \(\mathbf F_5\)-Frobenius for geometric endomorphisms is
  valid.  The geometric rational endomorphism algebra from file 53 is a
  product of three commutative fields, so every geometric endomorphism
  commutes with this Frobenius and preserves the relevant rational
  summands and their Tate-lattice intersections.
- Lagrange interpolation in \(S=F+V\) gives exactly
  \(28e_1,12e_2,21e_3\).  The three congruences give the reverse
  divisibilities, so these are the primitive integral positive symmetric
  multiples of the central projectors.  The standard norm-endomorphism
  correspondence for elliptic subvarieties of a principally polarized
  Jacobian then gives maps of degrees \(28,12,21\), and the norm of any
  other elliptic quotient in the corresponding isogeny class proves
  minimality.
- Independently enumerated the spectra allowed by Theorem 56.1.  The
  mod-4 and mod-7 congruences leave only
  \((-9,3,-2)\) and \((-2,2,-9)\) in the \(e=1\) case and nothing for
  \(e=3\); both remaining triples fail the mod-3 congruence.  Thus
  Theorem 58.4 follows exhaustively.

## Non-breaking suggestions and objections

- In (58.5), ``,quad`` should be ``,\quad``.  More substantively, saying
  explicitly that \(e_1,e_2\) generate the two **axis-intersection**
  lattices would make the lattice normal form immediately transparent.
- Corollary 58.3 uses a standard norm-endomorphism criterion.  A citation,
  or one sentence explicitly noting positivity of \(d_i e_i\), would help
  readers distinguish “primitive integral projector multiple” from an
  arbitrary symmetric endomorphism.
- The certificate's final comment refers to “Theorem 57.3”; this is only a
  stale numbering typo and does not affect the calculation.

**Audited SHA-256 hashes:**

- theorem: `e89b4c5e329b22d991be614ef2f2f676551e083209b7699a056af5dcc253326e`
- certificate: `3db3b138db75e86c95528dd8d156192f2ecf18694f0824db3feef554c652dabc`
