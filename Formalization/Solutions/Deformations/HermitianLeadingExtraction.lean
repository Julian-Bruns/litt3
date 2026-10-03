import Theorems.Deformations.HermitianLeadingExtraction
import Solutions.Deformations.TruncatedMatrixValuation
import Solutions.Deformations.TruncatedMatrixLifting

namespace Litt3.Deformations

variable {k ι : Type*} [CommRing k]

/-- Every nonzero actual Hermitian matrix has an actual
primitive leading factor in the correct shorter quotient, with
its whole signed symmetry and its nonzero residue retained. -/
theorem hermitian_primitive_division (N : ℕ) (positive : 0 < N)
    (A : Matrix ι ι (TruncatedCoefficientRing k N)) (nonzero : A ≠ 0)
    (hermitian : truncatedHermitianTranspose k N A = A) :
    Specifications.HermitianPrimitiveDivision N A := by
  obtain ⟨e, less, B, factorization, i, j, primitive⟩ :=
    truncated_matrix_valuation N positive A nonzero
  have relation : (truncatedParameter k N ^ e • B).conjTranspose =
      (1 : TruncatedCoefficientRing k N) • (truncatedParameter k N ^ e • B) := by
    rw [one_smul, ← factorization]
    exact hermitian
  refine ⟨e, less, B, factorization, ?_, i, j, ?_⟩
  · have h := truncated_divided_matrix_symmetry N e (Nat.le_of_lt less) 1 B relation
    simpa only [map_one, mul_one] using h
  · change truncatedResidue k (N - e) (Nat.sub_pos_of_lt less)
      (truncatedRestriction k N (N - e) (Nat.sub_le _ _) (B i j)) ≠ 0
    rw [truncated_residue_restriction N (N - e) (Nat.sub_le _ _) positive
      (Nat.sub_pos_of_lt less)]
    exact primitive

end Litt3.Deformations
