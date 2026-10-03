import Theorems.Deformations.TruncatedMatrixLifting
import Solutions.Deformations.TruncatedSymmetry

namespace Litt3.Deformations

open Polynomial

variable {k : Type*} [CommRing k]

theorem truncated_residue_restriction (N j : ℕ) (bound : j ≤ N)
    (positiveN : 0 < N) (positivej : 0 < j) (x : TruncatedCoefficientRing k N) :
    truncatedResidue k j positivej (truncatedRestriction k N j bound x) =
      truncatedResidue k N positiveN x := by
  obtain ⟨P, rfl⟩ := AdjoinRoot.mk_surjective (g := (X : Polynomial k) ^ N) x
  rw [truncated_restriction_mk]
  simp only [truncatedResidue, AdjoinRoot.lift_mk]

/-- Actual quotient reduction reflects matrix units, because
the actual residue maps agree and their kernels are nilpotent. -/
theorem truncated_matrix_restriction_unit_iff {ι : Type*} [Fintype ι] [DecidableEq ι]
    (N j : ℕ) (bound : j ≤ N) (positivej : 0 < j)
    (P : Matrix ι ι (TruncatedCoefficientRing k N)) :
    IsUnit P ↔ IsUnit ((truncatedRestriction k N j bound).toRingHom.mapMatrix P) := by
  have positiveN : 0 < N := lt_of_lt_of_le positivej bound
  rw [truncated_matrix_unit_criterion N positiveN,
    truncated_matrix_unit_criterion j positivej]
  have h : (truncatedResidue k j positivej).mapMatrix
      ((truncatedRestriction k N j bound).toRingHom.mapMatrix P) =
        (truncatedResidue k N positiveN).mapMatrix P := by
    ext i j'
    exact truncated_residue_restriction N j bound positiveN positivej (P i j')
  rw [h]

/-- Surjectivity is proved on the actual invertible matrices,
not just on the underlying coefficients. -/
theorem truncated_matrix_unit_lifting {ι : Type*} [Fintype ι] [DecidableEq ι]
    (N j : ℕ) (bound : j ≤ N) (positivej : 0 < j) :
    Specifications.TruncatedMatrixUnitLifting (k := k) (ι := ι) N j bound := by
  intro S hS
  choose lift hlift using fun i j' =>
    truncated_restriction_surjective (k := k) N j bound (S i j')
  have h : (truncatedRestriction k N j bound).toRingHom.mapMatrix lift = S := by
    ext i j'
    exact hlift i j'
  refine ⟨lift, ?_, h⟩
  apply (truncated_matrix_restriction_unit_iff N j bound positivej lift).mpr
  rw [h]
  exact hS

end Litt3.Deformations
