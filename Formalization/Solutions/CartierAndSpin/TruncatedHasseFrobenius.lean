import Solutions.CartierAndSpin.TruncatedHasseDerivatives
import Mathlib.Algebra.Polynomial.Expand

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Polynomial

variable {L : Type*} [Field L] {p : ℕ} [Fact p.Prime] [CharP L p]

theorem polynomial_frobenius_power_coefficient (P : L[X]) (r j : ℕ) :
    (P ^ (p ^ r)).coeff j =
      if p ^ r ∣ j then (P.coeff (j / (p ^ r))) ^ (p ^ r) else 0 := by
  rw [← map_expand_pow_char p P r, coeff_map,
    coeff_expand (pow_pos (Fact.out : p.Prime).pos r)]
  split_ifs
  · rw [← iterateFrobenius_eq_pow, iterateFrobenius_def]
  · simp

/-- Actual higher Taylor coefficients of a Frobenius power vanish off
the corresponding power-of-p indices. The nonzero indices are the
literal Frobenius powers of the lower coefficients. -/
theorem truncated_hasse_frobenius_power (b : PowerPBasis L p) (e r j : ℕ)
    (hj : j < p ^ e) (a : L) :
    truncatedHasseDerivative b e j (a ^ (p ^ r)) =
      if p ^ r ∣ j then
        (truncatedHasseDerivative b e (j / (p ^ r)) a) ^ (p ^ r) else 0 := by
  change truncatedTaylorCoefficient L p e j
    (truncatedFieldTaylorMap b e (a ^ (p ^ r))) = _
  rw [map_pow]
  obtain ⟨P, hP⟩ := AdjoinRoot.mk_surjective (g := (X ^ (p ^ e) : L[X]))
    (truncatedFieldTaylorMap b e a)
  rw [← hP, ← map_pow, truncated_taylor_coefficient_mk p e j hj,
    polynomial_frobenius_power_coefficient]
  split_ifs with hdiv
  · have hlt : j / (p ^ r) < p ^ e := lt_of_le_of_lt (Nat.div_le_self _ _) hj
    change (P.coeff (j / (p ^ r))) ^ (p ^ r) =
      (truncatedTaylorCoefficient L p e (j / (p ^ r))
        (truncatedFieldTaylorMap b e a)) ^ (p ^ r)
    rw [← hP, truncated_taylor_coefficient_mk p e _ hlt]
  · rfl

end Litt3.CartierAndSpin
