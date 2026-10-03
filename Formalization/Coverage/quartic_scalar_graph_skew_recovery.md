# Quartic scalar-graph recovery clause mapping

Canonical Version 1 snapshot:
`Theorems/cartier_and_spin/quartic_scalar_graph_skew_recovery.md`, SHA256
`1361a0cb477a963a6552376b6716893f2e153c997c56ad5e26d968728466a573`.
Status is `complete` after independent full-source readback and a focused
transitive axiom audit. Every canonical mathematical clause is
bundled in `Solutions.CartierAndSpin.QuarticScalarGraph` as
`quarticScalarGraphRecovery_of_char_ne_two`, proving the exact explicit Prop
`Specifications.QuarticScalarGraphRecovery`.

* `TraceZeroProjection` constructs the actual normalized trace, its kernel and
  projection. It proves dimension n−1, symmetry, and actual nondegeneracy for
  any separable degree-n field extension with n nonzero in the base field.
* `TraceCompression` constructs multiplication followed by the actual
  projection as an endomorphism of the actual trace-zero space and proves it
  self-adjoint. The projected direction is nonzero exactly for a scalar outside
  the embedded base field.
* `ScalarGraphAdjoint` constructs the actual adjoint through the nondegenerate
  pairing, proves the rank-one adjoint/skew identity, derives independence and
  surjectivity from nonzero skew, and proves the self-adjoint boundary
  a=κ B(e,−). No rank or independence hypothesis is silently assumed.
* `SkewThreeDimension.quartic_nonzero_skew_finrank_kernel` proves the source
  kernel-line clause for arbitrary M with nonzero skew, with no scalar-graph
  hypothesis. It uses only separable degree four and characteristic different
  from two. The underlying alternating-form theorem holds in every
  characteristic.
* `TraceScalarGraph.trace_scalar_graph_skew_kernel_recovers_ratio` proves
  ε=(M k)/k for every actual graph and every nonzero actual skew-kernel
  element. `ScalarGraph.scalarGraphRatio_rescale` proves independence from
  rescaling by a nonzero base scalar. The actual compression basis criterion
  constructs the entire linear form from basis membership.
* `TraceScalarGraphTests` connects this actual basis criterion to the actual
  scalar-shift equations and to the denominator-free span tests. Independence
  of k,z is proved equivalent to z/k lying outside the embedded base field.
  The bundled `ActualQuarticScalarGraph` predicate includes the outside-base
  requirement itself; the criterion covers every candidate, including those
  inside the base field.
* `AlternatingThreeRank` proves the exact symbolic cofactor kernel and rank;
  `AlternatingThreeForm` transports it to any actual three-dimensional
  alternating pairing.

* `KummerTrace` constructs the full actual power basis from an actual
  generating element and degree four, then computes trace(t), trace(t²), and
  trace(t³) from its actual multiplication matrices.
* `KummerPairing` constructs the actual trace-zero basis t,t²,t³ and proves its
  Gram matrix is m times the reverse identity. `QuarticKummerRecovery`
  converts the actual field-generation condition K(t)=L into the needed
  algebra generation, with no assumed basis or trace values.
* `KummerMatrixSkew` proves the exact symbolic cofactor coordinates and their
  zero criterion. `KummerSkewRecovery` transports these through the actual
  pairing and constructed adjoint. `QuarticKummerRecovery` proves the stated
  field element k, its skew-kernel membership, and k=0 iff M=M*.
* `KummerCompression` proves the displayed multiplication compression matrix
  from the actual relation t⁴=m. `KummerBoundary` derives a=κ B(e,−) from
  actual self-adjoint graph data and proves the entire displayed boundary
  matrix, including nonzero direction (b,c,d).

The Kummer clauses are proved in every characteristic different from two,
which includes the source characteristic-five case. No coordinate formula,
kernel membership, trace identity, or graph conclusion is an input axiom.
The canonical endpoint-incidence paragraph states a remaining matching
condition, not a feasibility result; the formalization does not assert that
the boundary is empty or that endpoint incidence is solved.

The proofs use symbolic ring/field identities, exact finite bases, trace
nondegeneracy, and rank-nullity. No project theorem is an axiom, and there is
no numerical enumeration or native computation certificate.

Build evidence: `lake build Solutions.CartierAndSpin.QuarticScalarGraph`
passed on 2026-10-03; this imports and checks the complete dependency chain.

Independent full-source review accepted every canonical clause; see
[scope review](quartic_scalar_graph_scope_review.md). Focused verification
20261003T000813Z checked 136 declarations with only Classical.choice,
Quot.sound, and propext, no forbidden declarations, and no source changes.
The source record is complete for the SHA256 snapshot above.
