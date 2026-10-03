import Theorems.Deformations.HilbertCoefficients
import Lean.Elab.Tactic.Omega
import Mathlib.Algebra.BigOperators.Fin

namespace Litt3.Deformations

open Polynomial Finset

@[simp] theorem intervalPolynomial_coeff (m n : ℕ) :
    (intervalPolynomial m).coeff n = if n < m then 1 else 0 := by
  simp [intervalPolynomial, finset_sum_coeff, coeff_X_pow]

@[simp] theorem intervalPolynomial_eval_one (m : ℕ) :
    (intervalPolynomial m).eval 1 = m := by
  simp [intervalPolynomial]

theorem intervalPolynomial_succ (m : ℕ) :
    intervalPolynomial (m + 1) = intervalPolynomial m + X ^ m := by
  simp only [intervalPolynomial, sum_range_succ]

theorem weightedIntervalPolynomial_succ (m : ℕ) :
    weightedIntervalPolynomial (m + 1) = weightedIntervalPolynomial m + X ^ (2 * m) := by
  simp only [weightedIntervalPolynomial, sum_range_succ]

/-- The adjacent-layer operation turns the weight-two interval
factor into one consecutive interval of twice the length. -/
theorem weighted_interval_adjacent (m : ℕ) :
    (1 + X) * weightedIntervalPolynomial m = intervalPolynomial (2 * m) := by
  induction m with
  | zero => simp [weightedIntervalPolynomial, intervalPolynomial]
  | succ m ih =>
    rw [weightedIntervalPolynomial_succ, mul_add, ih]
    rw [show 2 * (m + 1) = (2 * m + 1) + 1 by omega,
      intervalPolynomial_succ, intervalPolynomial_succ]
    simp only [add_mul, one_mul, ← pow_succ', add_assoc]

theorem heisenberg_adjacent_polynomial (p : ℕ) :
    (1 + X) * heisenbergHilbertPolynomial p = heisenbergWidthPolynomial p := by
  unfold heisenbergHilbertPolynomial heisenbergWidthPolynomial
  rw [← mul_assoc, mul_comm (1 + X) (intervalPolynomial p ^ 2),
    mul_assoc, weighted_interval_adjacent]

theorem heisenberg_adjacent_coefficient (p n : ℕ) :
    (heisenbergHilbertPolynomial p).coeff n +
      (heisenbergHilbertPolynomial p).coeff (n + 1) =
        (heisenbergWidthPolynomial p).coeff (n + 1) := by
  rw [← heisenberg_adjacent_polynomial, add_mul, one_mul, coeff_add, coeff_X_mul,
    Nat.add_comm]

/-- The product polynomial is the genuine weight-generating sum
of the p-cubed ordered monomial indices. -/
theorem heisenberg_monomial_weight_polynomial (p : ℕ) :
    (∑ j : Fin p × Fin p × Fin p,
      (X : Polynomial ℕ) ^ heisenbergMonomialWeight p j) =
        heisenbergHilbertPolynomial p := by
  have hI : intervalPolynomial p = ∑ i : Fin p, (X : Polynomial ℕ) ^ i.val := by
    unfold intervalPolynomial
    rw [Finset.sum_range]
  have hW : weightedIntervalPolynomial p =
      ∑ i : Fin p, (X : Polynomial ℕ) ^ (2 * i.val) := by
    unfold weightedIntervalPolynomial
    rw [Finset.sum_range]
  rw [heisenbergHilbertPolynomial, pow_two, hI, hW]
  simp only [Fintype.sum_prod_type, heisenbergMonomialWeight, pow_add,
    mul_assoc, ← Finset.mul_sum, ← Finset.sum_mul]

theorem intervalPolynomial_natDegree_le (m : ℕ) :
    (intervalPolynomial m).natDegree ≤ m - 1 := by
  apply natDegree_sum_le_of_forall_le
  intro j hj
  simp only [natDegree_X_pow]
  have := mem_range.mp hj
  omega

/-- Any initial coefficient sum of a natural-coefficient polynomial
is bounded by its entire value at one. -/
theorem polynomial_initial_coefficient_sum_le (P : Polynomial ℕ) (n : ℕ) :
    (∑ i ∈ range n, P.coeff i) ≤ P.eval 1 := by
  let N := max n (P.natDegree + 1)
  have hd : P.natDegree < N := by
    exact lt_of_lt_of_le (Nat.lt_succ_self _) (le_max_right _ _)
  rw [Polynomial.eval_eq_sum_range' hd]
  simp only [one_pow, mul_one]
  exact sum_le_sum_of_subset (range_mono (le_max_left _ _))

/-- Multiplication by an interval polynomial never makes a
coefficient exceed the total of the original coefficients. -/
theorem interval_convolution_coefficient_le (P : Polynomial ℕ) (m n : ℕ) :
    (P * intervalPolynomial m).coeff n ≤ P.eval 1 := by
  rw [coeff_mul, Finset.Nat.sum_antidiagonal_eq_sum_range_succ
    (fun i j => P.coeff i * (intervalPolynomial m).coeff j) n]
  apply le_trans _ (polynomial_initial_coefficient_sum_le P (n + 1))
  apply sum_le_sum
  intro i hi
  rw [intervalPolynomial_coeff]
  split_ifs <;> simp

/-- Once the interval contains every degree of the original
polynomial, its coefficient at the interval's far edge contains
every original coefficient exactly once. -/
theorem interval_convolution_central_coefficient (P : Polynomial ℕ) (m : ℕ)
    (degree_fits : P.natDegree < m) :
    (P * intervalPolynomial m).coeff (m - 1) = P.eval 1 := by
  unfold intervalPolynomial
  rw [mul_sum, finset_sum_coeff]
  have hm : 0 < m := lt_of_le_of_lt (Nat.zero_le _) degree_fits
  calc
    (∑ j ∈ range m, (P * X ^ j).coeff (m - 1)) =
      ∑ j ∈ range m, P.coeff (m - 1 - j) := by
        apply sum_congr rfl
        intro j hj
        rw [coeff_mul_X_pow', if_pos]
        have := mem_range.mp hj
        omega
    _ = ∑ j ∈ range m, P.coeff j := sum_range_reflect _ _
    _ = P.eval 1 := by
      rw [Polynomial.eval_eq_sum_range' degree_fits]
      simp

/-- Exact all-p maximum of the weight Hilbert polynomial. This
symbolic proof uses no bounded coefficient or group enumeration. -/
theorem heisenberg_hilbert_maximum (p : ℕ) (positive : 0 < p) :
    Specifications.HeisenbergHilbertMaximum p := by
  have hd : (intervalPolynomial p ^ 2).natDegree < 2 * p := by
    rw [pow_two]
    have hmul : (intervalPolynomial p * intervalPolynomial p).natDegree ≤
        (intervalPolynomial p).natDegree + (intervalPolynomial p).natDegree :=
      natDegree_mul_le
    have hdegree := intervalPolynomial_natDegree_le p
    omega
  constructor
  · intro n
    have h := interval_convolution_coefficient_le (intervalPolynomial p ^ 2) (2 * p) n
    simpa [heisenbergWidthPolynomial] using h
  · have h := interval_convolution_central_coefficient (intervalPolynomial p ^ 2) (2 * p) hd
    simpa [heisenbergWidthPolynomial] using h

/-- The exact maximum of adjacent dimensions encoded by the
weight-one, weight-one, weight-two Hilbert polynomial, for every
positive p. Actual group-filtration identification is kept separate. -/
theorem heisenberg_adjacent_hilbert_maximum (p : ℕ) (positive : 0 < p) :
    (∀ n, (heisenbergHilbertPolynomial p).coeff n +
      (heisenbergHilbertPolynomial p).coeff (n + 1) ≤ p ^ 2) ∧
    (heisenbergHilbertPolynomial p).coeff (2 * p - 2) +
      (heisenbergHilbertPolynomial p).coeff (2 * p - 2 + 1) = p ^ 2 := by
  obtain ⟨hbound, hexact⟩ := heisenberg_hilbert_maximum p positive
  constructor
  · intro n
    rw [heisenberg_adjacent_coefficient]
    exact hbound (n + 1)
  · rw [heisenberg_adjacent_coefficient]
    have hindex : 2 * p - 2 + 1 = 2 * p - 1 := by omega
    rw [hindex]
    exact hexact

end Litt3.Deformations
