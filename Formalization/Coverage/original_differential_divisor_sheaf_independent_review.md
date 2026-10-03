# Independent original differential/divisor whole-sheaf readback

Reviewer: `/root/deformations`, 3 October 2026. **Accepted** for the exact
eight-file extension below. Each new file was read in full, together with the
actual differential-sheaf definition, local lifting and injectivity interfaces,
the new original-open linearity proof, normalized field-line coordinates,
actual rational-function sheaf/evaluation/open equivalence, the actual divisor
open submodule and restrictions, and the empty-cover section argument.
The settled original differential-order/divisor chain is reused from
`original_differential_divisor_independent_review.md`; this is no numerical
replay or reopening of that accepted chain.

The whole isomorphism retains the actual associated sheaf of universal
relative differentials of the original structure sheaf and the actual
valuation-bounded divisor sheaf inside the original rational-function sheaf.
Both use the same original scheme, structure morphism and function field.
For an integral compact scheme smooth of relative dimension one over an
algebraically closed field, and any nonzero original rational form omega,
the original coefficient map constructs the genuine module-sheaf isomorphism
Omega ≅ O(div omega) on every original open. Every characteristic is allowed.
Compactness supplies the already proved finite divisor; properness is absent.

Scope-critical checks pass:

* The arbitrary-open closed/all-point equivalence uses the genuine open
  regularity locus and the Jacobson closed-point intersection theorem on
  the actual locally closed intersection. Smoothness supplies Jacobsonness.
  Recovery of a rational field value is correctly stated only on nonempty
  opens: actual local representatives are restricted to the chosen open,
  their overlaps contain the original generic point, rational injectivity
  proves compatibility, and genuine sheaf gluing constructs the section.
* Coefficients are linear over the **original** Gamma(X,U), through its
  genuine generic-stalk algebra map. The field-line equivalence is
  normalized by the same original nonzero form, with inverse literally
  a ↦ a•omega. No compatibility or linearity conclusion is assumed.
* The valuation inequality has the correct sign. For nonzero a, regularity
  is ord(a)+ord(omega)≥0, hence v(a)≤exp(ord(omega)); a=0 is separately
  proved by the original valuation and the full original local module's
  zero element. The entire stalk image is retained.
* Every divisor-bound section produces the original rational form
  a•omega. Closed-stalk recovery on the chosen open constructs an actual
  differential section with exactly that image. Normalized reconstruction
  proves surjectivity of its full coefficient map. Injectivity uses actual
  generic realization and genuine field-line injectivity.
* Empty opens are handled by the actual module sheaf's unique section,
  derived from its empty-cover gluing property. Neither sheaf is replaced
  there by the function field. Restriction naturality includes maps to
  empty opens; the nonempty-smaller-open case derives nonemptiness of its
  larger open and compares the actual unchanged field values.
* The restricted coefficient maps are genuine module maps into the actual
  divisor subsheaf. Their actual restriction squares construct a presheaf
  isomorphism, and the original sheaf-of-modules category inherits both
  inverse identities. No divisor presentation, local freeness or H0
  identification is an input to the isomorphism.
* `OriginalCanonicalLineSheaf` constructs a nonzero original rational form
  from the derived smooth generic coordinate. The accepted actual divisor
  local frames and whole-sheaf isomorphism give actual local rank-one
  freeness of the original differential sheaf. Its canonical class is the
  literal class of that sheaf among **all** original line sheaves; any
  nonzero original rational form gives the same class through the actual
  whole-sheaf isomorphism. The accepted original Picard/tensor-power
  interface identifies its n-fold multiple with actual tensor-power
  triviality, including n=0. This proves neither a canonical degree nor
  the existence of a root of the canonical sheaf.
* `DifferentialTensorDivisorSheaves` transports actual whole module-sheaf
  isomorphisms through the genuine sheafified tensor product at each power.
  The true rational multiplication isomorphism gives O(D) tensor powers
  O(nD), with the actual original structure-sheaf unit at n=0. Consequently
  every actual tensor power of the original differential sheaf is
  O(n div omega), and its literal original line class is represented by
  that divisor. Neither an H0-only model nor an affine-only tensor is used.
* `OriginalCanonicalSheafRoots` keeps the genuine full tensor power of
  an arbitrary original line sheaf. Its exact Picard multiple criterion,
  divisor criterion and existential criterion follow from the accepted
  classification of **all** original line sheaves and the actual whole
  tensor/divisor isomorphisms. The original principal-divisor quotient
  relation is retained. These are equivalences with an unresolved class
  divisibility condition; no solution of that equation or degree shortcut
  is supplied, including at n=0.

This accepts the actual whole-sheaf bridge. It does not claim canonical
degree, Riemann–Roch, finite-etale divisor transport, or a resolution of the
unmarked common-cover problem.

Focused report
`../litt3-computation-data/formalization-20261003/verification/20261003T120734Z/report.json`
built the first five-file whole-sheaf bridge and audited 1000 transitive
Litt3 theorem declarations, standard three axioms only, zero forbidden
dependencies and zero source changes. Root records a further focused
report for the final canonical class/tensor/root consequences at
`../litt3-computation-data/formalization-20261003/verification/20261003T121339Z/report.json`:
1386 transitive Litt3 theorem declarations, standard three axioms only,
zero forbidden dependencies and zero source changes. Independently
rehashing all **290** captured local files found zero mismatches. The exact
accepted source hashes are:

| File | SHA256 |
| --- | --- |
| `Solutions/SharedTensors/SchemeDifferentialOpenRecovery.lean` | `af631b75e2824bd5a22b991eafe7ab1855241b538f64280b7a9d476c7375bb4e` |
| `Solutions/SharedTensors/DifferentialRationalCoefficientSheaves.lean` | `10224a1029c04137a0044fb505029372231486cdb4d32dd4c33d32bdc0e05168` |
| `Solutions/SharedTensors/DifferentialDivisorCoefficientBounds.lean` | `bbd3d7ae31f8e95a601f722ba2d45f899da5324b409d35b350b8ae6114121461` |
| `Solutions/SharedTensors/DifferentialDivisorSheafMaps.lean` | `22b5bd8ee86b84dd242abbf51bcecd9ae8edd7590ac0008b3256771642d0efa7` |
| `Solutions/SharedTensors/DifferentialDivisorSheafIsomorphisms.lean` | `2aa21ae035d0862815cd0001f13d937c20a90b8bbf021bc8c2a7eb91d7f1a2ad` |
| `Solutions/SharedTensors/OriginalCanonicalLineSheaf.lean` | `8bfac112543436ed84f579bac7190a98b0b051b9eb97ccf3c34e6005c5d2d18e` |
| `Solutions/SharedTensors/DifferentialTensorDivisorSheaves.lean` | `723b40ff5114756fc8745c386e513a0efd5ede8fa595fe5db59e762ebceeba8e` |
| `Solutions/SharedTensors/OriginalCanonicalSheafRoots.lean` | `bf01d2b75d65a9c08d1180e6e314d1bc1d2b785333a31a72e42ec90fa04c97bf` |
