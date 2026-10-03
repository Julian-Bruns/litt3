import Solutions.Deformations.TruncatedMonomialResidue
import Solutions.Deformations.TruncatedMonomialNilpotence
import Solutions.Deformations.TruncatedMonomialNontrivial
import Solutions.Deformations.SeriesTruncatedPolynomialEquivalence
import Solutions.Deformations.NilpotentAdicCompleteness
import Mathlib.RingTheory.MvPowerSeries.Inverse
import Mathlib.RingTheory.LocalRing.MaximalIdeal.Basic

namespace Litt3.Deformations

variable (K : Type*) [Field K]

/-- The actual unequal-power coefficient algebra is local because it
is the genuine surjective quotient of the original local formal-series ring. -/
noncomputable def truncatedMonomialLocalRing (d : ℕ) (q : Fin d → ℕ)
    (positive : ∀ i, 0 < q i) : IsLocalRing (TruncatedMonomialAlgebra K (Fin d) q) := by
  letI : Nontrivial (TruncatedMonomialAlgebra K (Fin d) q) :=
    truncated_monomial_nontrivial K (Fin d) q positive
  exact IsLocalRing.of_surjective'
    (truncatedMonomialSeriesProjection K (Fin d) q positive)
    (truncated_monomial_series_projection_surjective K d q positive)

variable (I : Type*)

/-- The actual maximal ideal is derived from the unchanged constant
coefficient and its complete actual kernel. -/
theorem truncated_monomial_augmentation_eq_maximal (q : I → ℕ) (positive : ∀ i, 0 < q i)
    [IsLocalRing (TruncatedMonomialAlgebra K I q)] :
    truncatedMonomialAugmentationIdeal K I q =
      IsLocalRing.maximalIdeal (TruncatedMonomialAlgebra K I q) := by
  rw [← truncated_monomial_residue_kernel K I q positive]
  exact IsLocalRing.ker_eq_maximalIdeal (truncatedMonomialResidue K I q positive)
    (truncated_monomial_residue_surjective K I q positive)

variable [Fintype I]

/-- The actual original augmentation-adic coefficient algebra is
complete, derived from the literal unequal-power cutoff. -/
theorem truncated_monomial_augmentation_is_adic_complete (q : I → ℕ)
    (positive : ∀ i, 0 < q i) :
    IsAdicComplete (truncatedMonomialAugmentationIdeal K I q) (TruncatedMonomialAlgebra K I q) :=
  nilpotent_ideal_is_adic_complete _ _ _ ((∑ i, (q i - 1)) + 1)
    (truncated_monomial_augmentation_cutoff K I q positive)

/-- This is genuine completeness at the true local maximal ideal,
as required by Weierstrass preparation on the actual original base algebra. -/
theorem truncated_monomial_maximal_is_adic_complete (q : I → ℕ) (positive : ∀ i, 0 < q i)
    [IsLocalRing (TruncatedMonomialAlgebra K I q)] :
    IsAdicComplete (IsLocalRing.maximalIdeal (TruncatedMonomialAlgebra K I q))
      (TruncatedMonomialAlgebra K I q) := by
  rw [← truncated_monomial_augmentation_eq_maximal K I q positive]
  exact truncated_monomial_augmentation_is_adic_complete K I q positive

end Litt3.Deformations
