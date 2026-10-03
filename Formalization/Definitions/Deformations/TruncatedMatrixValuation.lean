import Definitions.Deformations.TruncatedSymmetry

namespace Litt3.Deformations

variable {k ι κ : Type*} [CommRing k]

/-- An actual common parameter power with a genuine nonzero
residue entry in the complete remaining matrix. -/
def HasTruncatedMatrixValuation (N : ℕ) (positive : 0 < N)
    (A : Matrix ι κ (TruncatedCoefficientRing k N)) : Prop :=
  ∃ e : ℕ, e < N ∧ ∃ B : Matrix ι κ (TruncatedCoefficientRing k N),
    A = truncatedParameter k N ^ e • B ∧
      ∃ i j, truncatedResidue k N positive (B i j) ≠ 0

end Litt3.Deformations
