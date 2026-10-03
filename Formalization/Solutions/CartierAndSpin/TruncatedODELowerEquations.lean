import Solutions.CartierAndSpin.TruncatedODECoefficients
import Mathlib.Algebra.BigOperators.NatAntidiagonal
import Mathlib.Algebra.CharP.Basic

namespace Litt3.CartierAndSpin

open Polynomial Finset

variable {K : Type*} [Field K]

theorem truncated_ode_product_coefficient (F : K[X]) (p n : ℕ) (hn : n < p) :
    (F * truncatedODEPolynomial F p).coeff n =
      ∑ i : Fin (n + 1), F.coeff (n - i.val) * truncatedODECoefficient F i.val := by
  rw [mul_comm F, coeff_mul, Finset.Nat.sum_antidiagonal_eq_sum_range_succ_mk,
    ← Fin.sum_univ_eq_sum_range]
  apply sum_congr rfl
  intro i _
  have hi : i.val < p := by omega
  rw [truncated_ode_polynomial_coefficient, if_pos hi]
  ring

/-- Every one of the first p-1 ODE equations is obtained from the
literal recursion, using only nonzero denominators 1 through p-1. -/
theorem truncated_ode_lower_equation (p : ℕ) [Fact p.Prime] [CharP K p]
    (F : K[X]) (n : ℕ) (hn : n + 1 < p) :
    (truncatedODEPolynomial F p).derivative.coeff n =
      (F * truncatedODEPolynomial F p).coeff n := by
  have hnum : (n + 1 : K) ≠ 0 := by
    have hcast : ((n + 1 : ℕ) : K) ≠ 0 := by
      intro hzero
      have hdiv := (CharP.cast_eq_zero_iff K p (n + 1)).mp hzero
      have hle := Nat.le_of_dvd (Nat.succ_pos n) hdiv
      omega
    simpa only [Nat.cast_add, Nat.cast_one] using hcast
  rw [coeff_derivative, truncated_ode_polynomial_coefficient, if_pos hn,
    truncated_ode_coefficient_succ, truncated_ode_product_coefficient F p n (by omega)]
  field_simp

end Litt3.CartierAndSpin
