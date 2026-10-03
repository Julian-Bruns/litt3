import Definitions.CartierAndSpin.LinearMatrixFamilies
import Definitions.CartierAndSpin.PowerCommutatorStacks
import Solutions.CartierAndSpin.PolynomialMatrixDegrees

namespace Litt3.CartierAndSpin

open scoped BigOperators

variable {R σ n : Type*} [CommRing R] [Fintype σ] [Fintype n] [DecidableEq n]

theorem linear_matrix_fiber_formula (coeff : σ → Matrix n n R) (z : σ → R) :
    linearMatrixFiber coeff z = fun i j => ∑ r : σ, coeff r i j * z r := by
  ext i j
  simp [linearMatrixFiber, linearPolynomialMatrix]

theorem linear_matrix_fiber_zero (coeff : σ → Matrix n n R) :
    linearMatrixFiber coeff 0 = 0 := by
  rw [linear_matrix_fiber_formula]
  ext i j
  simp

theorem linear_matrix_fiber_smul (coeff : σ → Matrix n n R) (z : σ → R) (a : R) :
    linearMatrixFiber coeff (a • z) = a • linearMatrixFiber coeff z := by
  simp only [linear_matrix_fiber_formula]
  ext i j
  simp only [Pi.smul_apply, smul_eq_mul, Matrix.smul_apply, Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro r _
  ring

variable [Nontrivial R]

theorem linear_polynomial_matrix_degree_bound (coeff : σ → Matrix n n R) :
    ∀ i j, (linearPolynomialMatrix coeff i j).totalDegree ≤ 1 := by
  intro i j
  apply MvPolynomial.totalDegree_finsetSum_le
  intro r _
  exact (MvPolynomial.totalDegree_mul _ _).trans (by simp)

theorem linear_polynomial_ordered_stack_degree_bound
    (coeffU coeffV : σ → Matrix n n R) (d : ℕ) :
    ∀ i j, (orderedCommutatorStack (linearPolynomialMatrix coeffU)
      (linearPolynomialMatrix coeffV) d i j).totalDegree ≤ d + 2 :=
  linear_ordered_commutator_stack_degree_bound _ _ d
    (linear_polynomial_matrix_degree_bound coeffU)
    (linear_polynomial_matrix_degree_bound coeffV)

theorem linear_polynomial_power_stack_degree_bound
    (coeffU coeffV : σ → Matrix n n R) :
    ∀ i j, (powerCommutatorStack (linearPolynomialMatrix coeffU)
      (linearPolynomialMatrix coeffV) i j).totalDegree ≤ 2 * (Fintype.card n - 1) := by
  intro i j
  have h := linear_power_commutator_degree_bound
    (linearPolynomialMatrix coeffU) (linearPolynomialMatrix coeffV)
    (linear_polynomial_matrix_degree_bound coeffU)
    (linear_polynomial_matrix_degree_bound coeffV)
    (i.1.1.val + 1) (i.1.2.val + 1) i.2 j
  exact h.trans (by have ha := i.1.1.isLt; have hb := i.1.2.isLt; omega)

end Litt3.CartierAndSpin
