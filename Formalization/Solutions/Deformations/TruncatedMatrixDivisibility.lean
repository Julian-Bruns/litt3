import Theorems.Deformations.TruncatedMatrixDivisibility
import Solutions.Deformations.TruncatedResidueSymmetry
import Solutions.Deformations.TruncatedMatrixLifting

namespace Litt3.Deformations

variable {k : Type*} [CommRing k]

theorem truncated_matrix_restriction_surjective {ι κ : Type*} (N j : ℕ) (bound : j ≤ N) :
    Function.Surjective (truncatedMatrixRestriction k N j bound :
      Matrix ι κ (TruncatedCoefficientRing k N) → Matrix ι κ (TruncatedCoefficientRing k j)) := by
  intro S
  choose P hP using fun i j' => truncated_restriction_surjective (k := k) N j bound (S i j')
  refine ⟨P, ?_⟩
  ext i j'
  exact hP i j'

/-- Vanishing of the actual whole residue matrix is exactly
actual divisibility by the actual parameter; no entry table is needed. -/
theorem truncated_matrix_divisibility {ι κ : Type*} (N : ℕ) (positive : 0 < N) :
    Specifications.TruncatedMatrixDivisibility (k := k) (ι := ι) (κ := κ) N positive := by
  intro B
  constructor
  · intro h
    have hentry : ∀ i j, ∃ y : TruncatedCoefficientRing k N,
        B i j = truncatedParameter k N * y := by
      intro i j
      obtain ⟨y, hy⟩ := truncated_scalar_decomposition N positive (B i j)
      have hz : truncatedResidue k N positive (B i j) = 0 :=
        congrArg (fun M : Matrix ι κ k => M i j) h
      rw [hz, map_zero, zero_add] at hy
      exact ⟨y, hy⟩
    choose B' hB' using hentry
    refine ⟨B', ?_⟩
    ext i j
    exact hB' i j
  · rintro ⟨B', rfl⟩
    ext i j
    change truncatedResidue k N positive (truncatedParameter k N * B' i j) = 0
    rw [map_mul, truncated_residue_parameter, zero_mul]

theorem truncated_residue_matrix_restriction {ι κ : Type*} (N j : ℕ) (bound : j ≤ N)
    (positiveN : 0 < N) (positivej : 0 < j) (P : Matrix ι κ (TruncatedCoefficientRing k N)) :
    truncatedResidueMatrix k j positivej (truncatedMatrixRestriction k N j bound P) =
      truncatedResidueMatrix k N positiveN P := by
  ext i j'
  exact truncated_residue_restriction N j bound positiveN positivej (P i j')

end Litt3.Deformations
