import Definitions.Deformations.SeriesVariablePowerIdeal
import Mathlib.Data.Finsupp.Order

namespace Litt3.Deformations

variable (R : Type*) [CommRing R] (d : ℕ)

/-- The actual shifted formal factor selects precisely one first
overflowing original coordinate, retaining its exact original coefficient. -/
theorem series_first_overflow_coefficient (q : Fin d → ℕ)
    (f : MvPowerSeries (Fin d) R) (i : Fin d) (a : Fin d →₀ ℕ) :
    MvPowerSeries.coeff a (MvPowerSeries.X i ^ q i * seriesFirstOverflowFactor R d q f i) =
      if q i ≤ a i ∧ (∀ j : Fin d, j < i → a j < q j) then MvPowerSeries.coeff a f else 0 := by
  classical
  rw [MvPowerSeries.X_pow_eq, MvPowerSeries.coeff_monomial_mul]
  simp only [Finsupp.single_le_iff]
  by_cases bound : q i ≤ a i
  · rw [if_pos bound, one_mul]
    have index : a - Finsupp.single i (q i) + Finsupp.single i (q i) = a :=
      tsub_add_cancel_of_le (Finsupp.single_le_iff.mpr bound)
    have earlier : (∀ j : Fin d, j < i → (a - Finsupp.single i (q i)) j < q j) ↔
        (∀ j : Fin d, j < i → a j < q j) := by
      apply forall_congr'
      intro j
      apply imp_congr_right
      intro small
      have different : i ≠ j := ne_of_gt small
      simp only [Finsupp.tsub_apply, Finsupp.single_eq_of_ne different.symm, tsub_zero]
    change (if ∀ j : Fin d, j < i → (a - Finsupp.single i (q i)) j < q j then
      MvPowerSeries.coeff (a - Finsupp.single i (q i) + Finsupp.single i (q i)) f else 0) = _
    simp only [index, earlier, bound, true_and]
  · rw [if_neg bound]
    simp only [bound, false_and, if_false]

end Litt3.Deformations
