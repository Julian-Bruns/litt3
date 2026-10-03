import Theorems.Deformations.OriginalQuadraticFrobeniusTruncation
import Solutions.Deformations.SelectedTruncatedHypersurfaceQuotients
import Solutions.Deformations.SelectedOriginalQuadraticCoefficients
import Solutions.Deformations.PreparedQuadraticTruncation
import Solutions.Deformations.FrobeniusTruncationArithmetic

set_option synthInstance.maxHeartbeats 100000
set_option maxHeartbeats 800000

namespace Litt3.Deformations

variable (K : Type*) [Field K] [Invertible (2 : K)] (p : ℕ) [Fact p.Prime] [CharP K p]

/-- The whole ORIGINAL selected-quadratic multivariate formal
hypersurface length. Actual original quotient equivalences, coefficient
transport and genuine preparation derive the length, without a normal
form or formal coordinate change hypothesis. Lower powers may be arbitrary
positive integers; algebraic closure is unnecessary. -/
theorem original_quadratic_frobenius_truncation_length (d : ℕ) (q : Fin d → ℕ)
    (positive : ∀ i, 0 < q i) (n : ℕ) (odd : Odd (p ^ n))
    (degreeBound : (∑ i, (q i - 1)) < p ^ n - 1) :
    Specifications.OriginalQuadraticFrobeniusTruncationLength K d p n q := by
  intro f quadratic selected
  have quadraticSurvives : 2 < p ^ n := by
    obtain ⟨m, exponent⟩ := odd.exists_bit1
    omega
  let P := MvPowerSeries.trunc' K
    (originalTruncationRectangle (Fin (d + 1)) (Fin.cons (p ^ n) q)) f
  let g : PowerSeries (TruncatedMonomialAlgebra K (Fin d) q) :=
    selectedTruncatedCoefficientPolynomial K d q P
  have coefficients := selected_original_quadratic_coefficients K d (p ^ n) q positive
    quadraticSurvives f quadratic selected
  have length := finite_coordinate_prepared_quadratic_truncation_finrank_of_original_coefficients
    K p d q positive n odd degreeBound g coefficients.1 coefficients.2.1 coefficients.2.2
  let e := selectedTruncatedSeriesHypersurfaceEquiv K d (p ^ n) q
    (by omega) positive f
  rw [e.toLinearEquiv.finrank_eq, Ideal.span_pair_comm]
  exact length

omit [Invertible (2 : K)] in
/-- The whole ORIGINAL source clause in odd prime characteristic.
Invertibility of two and oddness of the selected Frobenius power are
derived from the actual characteristic rather than extra hypotheses. -/
theorem original_quadratic_frobenius_truncation_length_odd_characteristic
    (oddCharacteristic : p ≠ 2) (d : ℕ) (q : Fin d → ℕ)
    (positive : ∀ i, 0 < q i) (n : ℕ)
    (degreeBound : (∑ i, (q i - 1)) < p ^ n - 1) :
    Specifications.OriginalQuadraticFrobeniusTruncationLength K d p n q := by
  have prime : p.Prime := Fact.out
  have twoNonzero : (2 : K) ≠ 0 := by
    intro zero
    have divides : p ∣ 2 := (CharP.cast_eq_zero_iff K p 2).mp zero
    have small : p ≤ 2 := Nat.le_of_dvd (by decide) divides
    have twoLe := prime.two_le
    exact oddCharacteristic (by omega)
  letI : Invertible (2 : K) := invertibleOfNonzero twoNonzero
  exact original_quadratic_frobenius_truncation_length K p d q positive n
    ((prime.odd_of_ne_two oddCharacteristic).pow) degreeBound

omit [Invertible (2 : K)] in
/-- The ORIGINAL arbitrary formal hypersurface has the exact source
length for a unique largest Frobenius exponent whenever the number of
lower coordinates is at most p. This includes lower exponents equal one. -/
theorem original_quadratic_unique_largest_frobenius_truncation_length
    (oddCharacteristic : p ≠ 2) (d n : ℕ) (positive : 0 < n)
    (a : Fin d → ℕ) (smaller : ∀ i, a i < n) (dimension : d ≤ p) :
    Specifications.OriginalQuadraticFrobeniusTruncationLength K d p n (fun i => p ^ a i) := by
  have prime : p.Prime := Fact.out
  apply original_quadratic_frobenius_truncation_length_odd_characteristic K p oddCharacteristic
    d (fun i => p ^ a i) (fun _ => pow_pos prime.pos _) n
  exact unique_largest_frobenius_degree_bound (Fin d) p n prime.one_lt positive a smaller
    (by simpa using dimension)

end Litt3.Deformations
