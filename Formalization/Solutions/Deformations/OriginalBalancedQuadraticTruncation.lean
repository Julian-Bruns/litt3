import Theorems.Deformations.OriginalBalancedQuadraticTruncation
import Solutions.Deformations.OriginalBalancedQuadraticDiagonal
import Solutions.Deformations.OriginalPlaneQuadraticFrames

set_option maxHeartbeats 1000000
set_option synthInstance.maxHeartbeats 100000

namespace Litt3.Deformations

variable (K : Type*) [Field K] [Invertible (2 : K)]
  (p : ℕ) [Fact p.Prime] [CharP K p]

/-- The WHOLE original balanced binary nondegenerate-quadratic clause.
Actual invertible linear frames, original rectangular quotient transport,
genuine preparation and its retained nonzero socle power prove the exact
original length. Cutoff ONE is included explicitly. -/
theorem original_balanced_quadratic_truncation_length (n : ℕ) (odd : Odd (p ^ n)) :
    Specifications.OriginalBalancedQuadraticTruncationLength K p n := by
  classical
  intro f quadratic nondegenerate
  have positive : ∀ _i : Fin 2, 0 < p ^ n := fun _ => pow_pos (Fact.out : p.Prime).pos _
  let q := fun _ : Fin 2 => p ^ n
  let P := MvPowerSeries.trunc' K (originalTruncationRectangle (Fin 2) q) f
  have support := original_series_rectangular_quadratic_support K (Fin 2) q f quadratic
  let e := seriesTruncatedHypersurfaceEquiv K 2 q positive f
  rw [e.toLinearEquiv.finrank_eq]
  by_cases one : p ^ n = 1
  · exact original_balanced_binary_polynomial_cutoff_eq_one K (p ^ n) one P support
  · have large : 2 < p ^ n := by
      obtain ⟨m, exponent⟩ := odd.exists_bit1
      omega
    have coefficientA : P.coeff (Finsupp.single 0 2) =
        MvPowerSeries.coeff (Finsupp.single 0 2) f := by
      apply original_series_rectangular_coefficient K (Fin 2) q positive f
      intro i
      fin_cases i <;> simp [q] <;> omega
    have coefficientB : P.coeff (Finsupp.single 0 1 + Finsupp.single 1 1) =
        MvPowerSeries.coeff (Finsupp.single 0 1 + Finsupp.single 1 1) f := by
      apply original_series_rectangular_coefficient K (Fin 2) q positive f
      intro i
      fin_cases i <;> simp [q] <;> omega
    have coefficientC : P.coeff (Finsupp.single 1 2) =
        MvPowerSeries.coeff (Finsupp.single 1 2) f := by
      apply original_series_rectangular_coefficient K (Fin 2) q positive f
      intro i
      fin_cases i <;> simp [q] <;> omega
    have nondegenerateP : P.coeff (Finsupp.single 0 1 + Finsupp.single 1 1) ^ 2 -
        4 * P.coeff (Finsupp.single 0 2) * P.coeff (Finsupp.single 1 2) ≠ 0 := by
      rwa [coefficientA, coefficientB, coefficientC]
    have two : (2 : K) ≠ 0 := by
      intro hz
      have impossible := mul_invOf_self (2 : K)
      have hz' : (2 : K) * ⅟(2 : K) = 0 := by
        calc
          _ = 0 * ⅟(2 : K) := congrArg (fun a : K => a * ⅟(2 : K)) hz
          _ = 0 := zero_mul _
      rw [hz'] at impossible
      exact zero_ne_one impossible
    obtain ⟨P', ⟨eFrame⟩, bound', selected', mixed', lower'⟩ :=
      original_plane_quadratic_nondegenerate_quotient_frame K p two 0 q n rfl rfl
        P support nondegenerateP
    rw [eFrame.toLinearEquiv.finrank_eq]
    exact balanced_prepared_original_binary_polynomial_finrank K p n odd large
      P' bound' selected' mixed' lower'

omit [Invertible (2 : K)] in
/-- Odd prime characteristic derives every two-invertibility and odd
power input for the whole ORIGINAL balanced binary clause. Algebraic
closure and a selected/nondegenerate normal form are unnecessary. -/
theorem original_balanced_quadratic_truncation_length_odd_characteristic
    (oddCharacteristic : p ≠ 2) (n : ℕ) :
    Specifications.OriginalBalancedQuadraticTruncationLength K p n := by
  have prime : p.Prime := Fact.out
  have twoNonzero : (2 : K) ≠ 0 := by
    intro zero
    have divides : p ∣ 2 := (CharP.cast_eq_zero_iff K p 2).mp zero
    have small : p ≤ 2 := Nat.le_of_dvd (by decide) divides
    have twoLe := prime.two_le
    exact oddCharacteristic (by omega)
  letI : Invertible (2 : K) := invertibleOfNonzero twoNonzero
  exact original_balanced_quadratic_truncation_length K p n
    ((prime.odd_of_ne_two oddCharacteristic).pow)

end Litt3.Deformations
