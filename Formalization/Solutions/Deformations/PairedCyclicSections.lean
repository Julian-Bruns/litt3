import Theorems.Deformations.PairedCyclicSections
import Solutions.Deformations.StrictSkewPairing
import Solutions.Deformations.CanonicalCyclicParity
import Solutions.Deformations.HermitianKernelDimension

namespace Litt3.Deformations

variable {k : Type*} [Field k] [Invertible (2 : k)]

/-- Actual paired free-complex data and the actual section
identification suffice for the separate canonical cyclic
parities and the odd section-dimension bound. The Hermitian
model, complete decomposition and multiplicity uniqueness
are all proved, rather than included in the input data. -/
theorem paired_cyclic_section_conclusions (N : ℕ) (positive : 0 < N) (V : Type*)
    [AddCommGroup V] [Module k V] [Module (TruncatedCoefficientRing k N) V]
    [IsScalarTower k (TruncatedCoefficientRing k N) V]
    (model : CyclicPairedSectionModel (k := k) N positive V)
    (multiplicity : Fin (N + 1) → ℕ)
    (decomposition : V ≃ₗ[TruncatedCoefficientRing k N]
      TruncatedCyclicBlocks k N (N + 1) (canonicalCyclicDegree N) multiplicity) :
    Specifications.PairedCyclicSectionConclusions (k := k) N V multiplicity := by
  have two_ne_zero : (2 : k) ≠ 0 := (isUnit_of_invertible (2 : k)).ne_zero
  obtain ⟨B, hermitian, ⟨toHermitian⟩⟩ := minimal_skew_pairing_hermitian N positive
    model.differential model.paired_complex
  let sectionHermitian := model.sections.trans toHermitian
  constructor
  · exact hermitian_canonical_cyclic_parity two_ne_zero N positive model.d B hermitian
      multiplicity (sectionHermitian.symm.trans decomposition)
  · have dimension := (sectionHermitian.restrictScalars k).finrank_eq
    intro odd
    have bound := hermitian_odd_kernel_dimension two_ne_zero N positive model.d B hermitian
      (dimension ▸ odd)
    rwa [← dimension] at bound

end Litt3.Deformations
