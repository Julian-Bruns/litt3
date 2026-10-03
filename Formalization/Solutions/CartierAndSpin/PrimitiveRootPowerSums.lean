import Solutions.CartierAndSpin.FiniteRootPolynomial
import Mathlib.FieldTheory.KummerExtension

namespace Litt3.CartierAndSpin

open Finset Polynomial

variable {K : Type*} [Field K]

/-- Exact power sums of the actual finite powers of a primitive root. No
finite-field enumeration or root listing is used. -/
theorem primitive_root_power_sum (q : ℕ) (zeta : K) (hzeta : IsPrimitiveRoot zeta q)
    (k : ℕ) :
    (∑ j : Fin q, (zeta ^ (j : ℕ)) ^ k) = if q ∣ k then (q : K) else 0 := by
  classical
  have hswap : ∀ j : ℕ, (zeta ^ j) ^ k = (zeta ^ k) ^ j := by
    intro j
    simp only [← pow_mul, Nat.mul_comm j k]
  simp only [hswap]
  by_cases hdiv : q ∣ k
  · have hpower : zeta ^ k = 1 := (hzeta.pow_eq_one_iff_dvd k).mpr hdiv
    simp [hdiv, hpower]
  · rw [if_neg hdiv, Fin.sum_univ_eq_sum_range]
    have hnonone : zeta ^ k ≠ 1 := fun h => hdiv ((hzeta.pow_eq_one_iff_dvd k).mp h)
    have hperiod : (zeta ^ k) ^ q = 1 := by
      rw [← pow_mul, Nat.mul_comm k q, pow_mul, hzeta.pow_eq_one, one_pow]
    apply eq_zero_of_ne_zero_of_mul_left_eq_zero (sub_ne_zero.mpr hnonone.symm)
    rw [mul_neg_geom_sum, hperiod, sub_self]

theorem primitive_root_scaled_power_sum (q : ℕ) (zeta a : K)
    (hzeta : IsPrimitiveRoot zeta q) (k : ℕ) :
    finitePowerSum (fun j : Fin q => zeta ^ (j : ℕ) * a) k =
      if q ∣ k then (q : K) * a ^ k else 0 := by
  classical
  simp only [finitePowerSum, mul_pow, ← sum_mul, primitive_root_power_sum q zeta hzeta k]
  split_ifs <;> simp

/-- The full actual root polynomial for a scaled primitive-root orbit. -/
theorem finiteRootPolynomial_primitive_root_orbit (q : ℕ) (hq : 0 < q)
    (zeta a : K) (hzeta : IsPrimitiveRoot zeta q) :
    finiteRootPolynomial (fun j : Fin q => zeta ^ (j : ℕ) * a) = X ^ q - C (a ^ q) := by
  classical
  unfold finiteRootPolynomial
  dsimp only
  rw [Fin.prod_univ_eq_prod_range (fun j : ℕ => (X - C (zeta ^ j * a) : K[X])) q]
  exact (X_pow_sub_C_eq_prod hzeta hq rfl).symm

end Litt3.CartierAndSpin
