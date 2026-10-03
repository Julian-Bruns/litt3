import Definitions.CartierAndSpin.OrderedCommutatorStacks
import Mathlib.Algebra.MvPolynomial.CommRing
import Mathlib.Tactic

namespace Litt3.CartierAndSpin

open scoped BigOperators

variable {R σ n : Type*} [CommRing R] [Fintype n] [DecidableEq n]

/-- Degree bounds for actual matrix products over a polynomial ring;
zero terms and cancellation require no separate nonvanishing premise. -/
theorem polynomial_matrix_mul_degree_bound (A B : Matrix n n (MvPolynomial σ R))
    (a b : ℕ) (hA : ∀ i j, (A i j).totalDegree ≤ a)
    (hB : ∀ i j, (B i j).totalDegree ≤ b) :
    ∀ i j, ((A * B) i j).totalDegree ≤ a + b := by
  intro i j
  rw [Matrix.mul_apply]
  apply MvPolynomial.totalDegree_finsetSum_le
  intro t _
  exact (MvPolynomial.totalDegree_mul _ _).trans (Nat.add_le_add (hA i t) (hB t j))

theorem polynomial_matrix_pow_degree_bound (A : Matrix n n (MvPolynomial σ R))
    (a : ℕ) (hA : ∀ i j, (A i j).totalDegree ≤ a) (r : ℕ) :
    ∀ i j, ((A ^ r) i j).totalDegree ≤ r * a := by
  induction r with
  | zero =>
    intro i j
    simp only [pow_zero, Matrix.one_apply]
    split_ifs <;> simp
  | succ r hr =>
    rw [pow_succ]
    simpa only [Nat.succ_mul] using polynomial_matrix_mul_degree_bound (A ^ r) A
      (r * a) a hr hA

theorem polynomial_matrix_commutator_degree_bound (U V : Matrix n n (MvPolynomial σ R))
    (a b : ℕ) (hU : ∀ i j, (U i j).totalDegree ≤ a)
    (hV : ∀ i j, (V i j).totalDegree ≤ b) :
    ∀ i j, ((U * V - V * U) i j).totalDegree ≤ a + b := by
  intro i j
  apply (MvPolynomial.totalDegree_sub _ _).trans
  apply max_le
  · exact polynomial_matrix_mul_degree_bound U V a b hU hV i j
  · simpa only [Nat.add_comm] using polynomial_matrix_mul_degree_bound V U b a hV hU i j

/-- The original ordered-stack degree bound, proved uniformly in the
matrix size, number of variables, coefficient ring and word cutoff. -/
theorem linear_ordered_commutator_stack_degree_bound
    (U V : Matrix n n (MvPolynomial σ R)) (d : ℕ)
    (hU : ∀ i j, (U i j).totalDegree ≤ 1)
    (hV : ∀ i j, (V i j).totalDegree ≤ 1) :
    ∀ i j, (orderedCommutatorStack U V d i j).totalDegree ≤ d + 2 := by
  intro i j
  have hC := polynomial_matrix_commutator_degree_bound U V 1 1 hU hV
  have hUa := polynomial_matrix_pow_degree_bound U 1 hU i.1.1.val
  have hVb := polynomial_matrix_pow_degree_bound V 1 hV i.1.2.val
  simp only [Nat.mul_one] at hUa hVb
  have hCU := polynomial_matrix_mul_degree_bound (U * V - V * U) (U ^ i.1.1.val)
    2 i.1.1.val hC hUa
  have hCUV := polynomial_matrix_mul_degree_bound
    ((U * V - V * U) * U ^ i.1.1.val) (V ^ i.1.2.val)
    (2 + i.1.1.val) i.1.2.val hCU hVb i.2 j
  exact hCUV.trans (by have ha := i.1.1.isLt; have hb := i.1.2.isLt; omega)

theorem linear_power_commutator_degree_bound
    (U V : Matrix n n (MvPolynomial σ R))
    (hU : ∀ i j, (U i j).totalDegree ≤ 1)
    (hV : ∀ i j, (V i j).totalDegree ≤ 1) (a b : ℕ) :
    ∀ i j, ((U ^ a * V ^ b - V ^ b * U ^ a) i j).totalDegree ≤ a + b := by
  have hUa := polynomial_matrix_pow_degree_bound U 1 hU a
  have hVb := polynomial_matrix_pow_degree_bound V 1 hV b
  simp only [Nat.mul_one] at hUa hVb
  exact polynomial_matrix_commutator_degree_bound (U ^ a) (V ^ b) a b hUa hVb

end Litt3.CartierAndSpin
