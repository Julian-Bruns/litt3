import Definitions.CartierAndSpin.TruncatedTaylorCoefficients
import Mathlib.Tactic

namespace Litt3.CartierAndSpin

open Polynomial Finset

variable {L : Type*} [Field L]

theorem coeff_mod_by_X_power (P : L[X]) (n j : ℕ) (hj : j < n) :
    (P %ₘ X ^ n).coeff j = P.coeff j := by
  rw [modByMonic_eq_sub_mul_div P (monic_X_pow n), coeff_sub, coeff_X_pow_mul']
  simp only [if_neg hj.not_ge, sub_zero]

theorem truncated_taylor_coefficient_mk (p e j : ℕ) (hj : j < p ^ e) (P : L[X]) :
    truncatedTaylorCoefficient L p e j (AdjoinRoot.mk (X ^ (p ^ e)) P) = P.coeff j := by
  change (AdjoinRoot.modByMonicHom (monic_X_pow (p ^ e))
    (AdjoinRoot.mk (X ^ (p ^ e)) P)).coeff j = P.coeff j
  rw [AdjoinRoot.modByMonicHom_mk, coeff_mod_by_X_power P _ j hj]

/-- Literal truncated coefficients obey the genuine convolution rule,
including the nilpotent quotient, in every degree below its truncation. -/
theorem truncated_taylor_coefficient_mul (p e j : ℕ) (hj : j < p ^ e)
    (a b : TruncatedFieldTaylor L p e) :
    truncatedTaylorCoefficient L p e j (a * b) =
      ∑ ij ∈ Finset.antidiagonal j,
        truncatedTaylorCoefficient L p e ij.1 a *
          truncatedTaylorCoefficient L p e ij.2 b := by
  obtain ⟨P, rfl⟩ := AdjoinRoot.mk_surjective (g := (X ^ (p ^ e) : L[X])) a
  obtain ⟨Q, rfl⟩ := AdjoinRoot.mk_surjective (g := (X ^ (p ^ e) : L[X])) b
  rw [← map_mul, truncated_taylor_coefficient_mk p e j hj, coeff_mul]
  apply Finset.sum_congr rfl
  intro ij hij
  have hsum : ij.1 + ij.2 = j := Finset.mem_antidiagonal.mp hij
  have hi : ij.1 < p ^ e := by omega
  have hk : ij.2 < p ^ e := by omega
  rw [truncated_taylor_coefficient_mk p e ij.1 hi,
    truncated_taylor_coefficient_mk p e ij.2 hk]

end Litt3.CartierAndSpin
