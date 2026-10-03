import Theorems.Deformations.OriginalRankOneFrobeniusTruncation
import Solutions.Deformations.RankOnePreparedTruncation
import Solutions.Deformations.OriginalSeriesRectangularQuadraticCoefficients

set_option synthInstance.maxHeartbeats 100000
set_option maxHeartbeats 800000

namespace Litt3.Deformations

variable (K : Type*) [Field K] [Invertible (2 : K)]
  (p : ℕ) [Fact p.Prime] [CharP K p]

/-- The entire ORIGINAL arbitrary formal series in a selected rank-one
linear frame. Preparation derives the weighted remainder and length;
no formal splitting or normal-form equivalence is supplied. -/
theorem original_selected_rank_one_series_truncation_finrank
    (n T : ℕ) (positiveT : 0 < T) (odd : Odd (p ^ n)) (bound : 4 * T < p ^ n + 3)
    (f : MvPowerSeries (Fin 3) K)
    (quadratic : f ∈ IsLocalRing.maximalIdeal (MvPowerSeries (Fin 3) K) ^ 2)
    (selected : MvPowerSeries.coeff (Finsupp.single 0 2) f ≠ 0)
    (mixed : MvPowerSeries.coeff (Finsupp.single 0 1 + Finsupp.single 1 1) f = 0)
    (second : MvPowerSeries.coeff (Finsupp.single 1 2) f = 0) :
    Module.finrank K (MvPowerSeries (Fin 3) K ⧸
      (seriesVariablePowerIdeal K 3 (Fin.cons (p ^ n) ![p ^ n, T]) ⊔
        Ideal.span ({f} : Set _))) = 2 * p ^ n * T := by
  have prime : p.Prime := Fact.out
  have positive : ∀ i : Fin 3, 0 < (Fin.cons (p ^ n) ![p ^ n, T] : Fin 3 → ℕ) i := by
    intro i
    induction i using Fin.cases with
    | zero => exact pow_pos prime.pos n
    | succ j =>
      fin_cases j
      · exact pow_pos prime.pos n
      · exact positiveT
  have selectedSurvives : 2 < p ^ n := by
    obtain ⟨m, exponent⟩ := odd.exists_bit1
    omega
  let P := MvPowerSeries.trunc' K
    (originalTruncationRectangle (Fin 3) (Fin.cons (p ^ n) ![p ^ n, T])) f
  have support := original_series_rectangular_quadratic_support K (Fin 3)
    (Fin.cons (p ^ n) ![p ^ n, T]) f quadratic
  have selectedP : P.coeff (Finsupp.single 0 2) ≠ 0 := by
    rw [original_series_rectangular_coefficient K (Fin 3) _ positive f]
    · exact selected
    · intro i
      induction i using Fin.cases with
      | zero => simpa using selectedSurvives
      | succ j =>
        fin_cases j
        · simpa using pow_pos prime.pos n
        · simpa using positiveT
  have mixedP : P.coeff (Finsupp.single 0 1 + Finsupp.single 1 1) = 0 :=
    original_series_rectangular_coefficient_zero K (Fin 3) _ f _ mixed
  have secondP : P.coeff (Finsupp.single 1 2) = 0 :=
    original_series_rectangular_coefficient_zero K (Fin 3) _ f _ second
  let equivalence := seriesTruncatedHypersurfaceEquiv K 3 _ positive f
  rw [equivalence.toLinearEquiv.finrank_eq]
  exact original_selected_rank_one_polynomial_truncation_finrank K p n T positiveT odd bound
    P support selectedP mixedP secondP

end Litt3.Deformations
