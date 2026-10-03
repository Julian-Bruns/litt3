import Theorems.Deformations.OriginalRankOneFrobeniusTruncation
import Solutions.Deformations.OriginalSelectedRankOneTruncation
import Solutions.Deformations.OriginalPlaneQuadraticFrames
import Solutions.Deformations.FrobeniusTruncationArithmetic

set_option synthInstance.maxHeartbeats 100000
set_option maxHeartbeats 800000

namespace Litt3.Deformations

variable (K : Type*) [Field K] [Invertible (2 : K)]
  (p : ℕ) [Fact p.Prime] [CharP K p]

/-- The WHOLE original rank-one plane clause. Actual linear
diagonalization preserves every original power, and actual preparation
derives the weighted remainder and length with arbitrary higher terms. -/
theorem original_rank_one_frobenius_truncation_length
    (n T : ℕ) (positiveT : 0 < T) (odd : Odd (p ^ n)) (bound : 4 * T < p ^ n + 3) :
    Specifications.OriginalRankOneFrobeniusTruncationLength K p n T := by
  intro f quadratic rankOne nonzero
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
  let q : Fin 3 → ℕ := Fin.cons (p ^ n) ![p ^ n, T]
  let P := MvPowerSeries.trunc' K (originalTruncationRectangle (Fin 3) q) f
  have support := original_series_rectangular_quadratic_support K (Fin 3) q f quadratic
  have coefficient (a : Fin 3 →₀ ℕ) (first : a 0 < p ^ n)
      (second : a 1 < p ^ n) (third : a 2 < T) :
      P.coeff a = MvPowerSeries.coeff a f := by
    apply original_series_rectangular_coefficient K (Fin 3) q positive f a
    intro i
    induction i using Fin.cases with
    | zero => exact first
    | succ j =>
      fin_cases j
      · exact second
      · exact third
  have aCoeff : P.coeff (Finsupp.single 0 2) = MvPowerSeries.coeff (Finsupp.single 0 2) f :=
    coefficient _ (by simpa using selectedSurvives) (by simpa using pow_pos prime.pos n)
      (by simpa using positiveT)
  have bCoeff : P.coeff (Finsupp.single 0 1 + Finsupp.single 1 1) =
      MvPowerSeries.coeff (Finsupp.single 0 1 + Finsupp.single 1 1) f :=
    coefficient _ (by simp; omega) (by simp; omega) (by simpa using positiveT)
  have cCoeff : P.coeff (Finsupp.single 1 2) = MvPowerSeries.coeff (Finsupp.single 1 2) f :=
    coefficient _ (by simpa using pow_pos prime.pos n) (by simpa using selectedSurvives)
      (by simpa using positiveT)
  have rankP : P.coeff (Finsupp.single 0 1 + Finsupp.single 1 1) ^ 2 =
      4 * P.coeff (Finsupp.single 0 2) * P.coeff (Finsupp.single 1 2) := by
    rwa [bCoeff, aCoeff, cCoeff]
  have nonzeroP : P.coeff (Finsupp.single 0 2) ≠ 0 ∨ P.coeff (Finsupp.single 1 2) ≠ 0 := by
    rwa [aCoeff, cCoeff]
  have two : (2 : K) ≠ 0 := (isUnit_of_invertible (2 : K)).ne_zero
  obtain ⟨P', ⟨frame⟩, support', selected', mixed', second'⟩ :=
    original_plane_quadratic_rank_one_quotient_frame K p two 1 q n rfl rfl
      P support nonzeroP rankP
  let original := seriesTruncatedHypersurfaceEquiv K 3 q positive f
  rw [original.toLinearEquiv.finrank_eq, frame.toLinearEquiv.finrank_eq]
  exact original_selected_rank_one_polynomial_truncation_finrank K p n T positiveT odd bound
    P' support' selected' mixed' second'

omit [Invertible (2 : K)] in
/-- Odd prime characteristic supplies invertibility of two and oddness
of the actual Frobenius power, without algebraic closure. -/
theorem original_rank_one_frobenius_truncation_length_odd_characteristic
    (oddCharacteristic : p ≠ 2) (n T : ℕ) (positiveT : 0 < T)
    (bound : 4 * T < p ^ n + 3) :
    Specifications.OriginalRankOneFrobeniusTruncationLength K p n T := by
  have prime : p.Prime := Fact.out
  have twoNonzero : (2 : K) ≠ 0 := by
    intro zero
    have divides : p ∣ 2 := (CharP.cast_eq_zero_iff K p 2).mp zero
    have small : p ≤ 2 := Nat.le_of_dvd (by decide) divides
    exact oddCharacteristic (by have := prime.two_le; omega)
  letI : Invertible (2 : K) := invertibleOfNonzero twoNonzero
  exact original_rank_one_frobenius_truncation_length K p n T positiveT
    ((prime.odd_of_ne_two oddCharacteristic).pow) bound

omit [Invertible (2 : K)] in
/-- The entire original unequal-power rank-one specialization p≥5,
including lower exponent one, with its weighted inequality derived. -/
theorem original_rank_one_unequal_frobenius_truncation_length
    (largeCharacteristic : 5 ≤ p) (n a : ℕ) (smaller : p ^ a < p ^ n) :
    Specifications.OriginalRankOneFrobeniusTruncationLength K p n (p ^ a) := by
  apply original_rank_one_frobenius_truncation_length_odd_characteristic K p (by omega)
    n (p ^ a) (pow_pos (Fact.out (p := p.Prime)).pos a)
  exact unequal_frobenius_rank_one_bound p a n largeCharacteristic smaller

end Litt3.Deformations
