import Definitions.CartierAndSpin.TruncatedODE

namespace Litt3.CartierAndSpin

open Polynomial Finset

variable {K : Type*} [Field K]

theorem truncated_ode_coefficient_zero (F : K[X]) : truncatedODECoefficient F 0 = 1 := by
  rw [truncatedODECoefficient]

theorem truncated_ode_coefficient_succ (F : K[X]) (n : ℕ) :
    truncatedODECoefficient F (n + 1) = (n + 1 : K)⁻¹ * ∑ i : Fin (n + 1),
      F.coeff (n - i.val) * truncatedODECoefficient F i.val := by
  rw [truncatedODECoefficient]

theorem truncated_ode_polynomial_coefficient (F : K[X]) (p n : ℕ) :
    (truncatedODEPolynomial F p).coeff n =
      if n < p then truncatedODECoefficient F n else 0 := by
  classical
  rw [truncatedODEPolynomial, finset_sum_coeff]
  by_cases hn : n < p
  · rw [if_pos hn, sum_eq_single (⟨n, hn⟩ : Fin p)]
    · simp
    · intro i _ hi
      have hne : i.val ≠ n := by intro h; exact hi (Fin.ext h)
      simp [coeff_monomial, hne]
    · simp
  · rw [if_neg hn]
    apply sum_eq_zero
    intro i _
    have hne : i.val ≠ n := by omega
    simp [coeff_monomial, hne]

theorem truncated_ode_polynomial_constant (F : K[X]) (p : ℕ) (hp : 0 < p) :
    (truncatedODEPolynomial F p).coeff 0 = 1 := by
  rw [truncated_ode_polynomial_coefficient, if_pos hp, truncated_ode_coefficient_zero]

theorem truncated_ode_polynomial_degree (F : K[X]) (p : ℕ) :
    (truncatedODEPolynomial F p).degree < (p : WithBot ℕ) := by
  apply (degree_lt_iff_coeff_zero _ p).mpr
  intro n hn
  rw [truncated_ode_polynomial_coefficient, if_neg (by omega)]

end Litt3.CartierAndSpin
