import Solutions.SharedTensors.LaurentPBasisGeneration

namespace Litt3.SharedTensors

open scoped LaurentSeries
open Litt3.CartierAndSpin

variable {k : Type*} [Field k]
  {p : ℕ} [Fact p.Prime] [CharP k p]

theorem laurent_frobenius_shift (f : LaurentSeries k) :
    f ^ p = HahnSeries.single ((p : ℤ) * f.order) 1 *
      ((f.powerSeriesPart ^ p : PowerSeries k) : LaurentSeries k) := by
  conv_lhs => rw [← LaurentSeries.single_order_mul_powerSeriesPart f]
  rw [mul_pow, HahnSeries.single_pow]
  simp only [one_pow, nsmul_eq_mul, PowerSeries.coe_pow]

/-- Frobenius multiplies the exponent of every coefficient of the full
Laurent series by p, including negative exponents. -/
theorem laurent_frobenius_coeff_multiple (f : LaurentSeries k) (n : ℤ) :
    (f ^ p).coeff ((p : ℤ) * n) = (f.coeff n) ^ p := by
  rw [laurent_frobenius_shift, laurent_single_mul_coefficient, one_mul]
  have hs : (p : ℤ) * n - (p : ℤ) * f.order =
      (p : ℤ) * (n - f.order) := by ring
  rw [hs]
  have hp : 0 < (p : ℤ) := by exact_mod_cast (Fact.out : p.Prime).pos
  by_cases hn : f.order ≤ n
  · obtain ⟨m, hm⟩ := Int.eq_ofNat_of_zero_le (show 0 ≤ n - f.order by omega)
    have he : (p : ℤ) * (n - f.order) = ((p * m : ℕ) : ℤ) := by
      rw [hm, Nat.cast_mul]
    rw [he, LaurentSeries.coeff_coe_powerSeries, power_series_frobenius_coeff,
      if_pos (dvd_mul_right p m), Nat.mul_div_right m (Fact.out : p.Prime).pos]
    congr 1
    rw [LaurentSeries.powerSeriesPart_coeff]
    congr 1
    omega
  · have hnegative : (p : ℤ) * (n - f.order) < 0 :=
      mul_neg_of_pos_of_neg hp (by omega)
    rw [PowerSeries.coeff_coe, if_pos hnegative,
      HahnSeries.coeff_eq_zero_of_lt_order (by omega), zero_pow (Fact.out : p.Prime).ne_zero]

/-- Every coefficient outside a p-multiple exponent vanishes under
Frobenius on the entire Laurent field. -/
theorem laurent_frobenius_coeff_nonmultiple (f : LaurentSeries k) (n : ℤ)
    (hn : ¬ (p : ℤ) ∣ n) : (f ^ p).coeff n = 0 := by
  rw [laurent_frobenius_shift, laurent_single_mul_coefficient, one_mul]
  by_cases hneg : n - (p : ℤ) * f.order < 0
  · rw [PowerSeries.coeff_coe, if_pos hneg]
  · obtain ⟨m, hm⟩ := Int.eq_ofNat_of_zero_le (show 0 ≤ n - (p : ℤ) * f.order by omega)
    rw [hm, LaurentSeries.coeff_coe_powerSeries, power_series_frobenius_coeff]
    rw [if_neg]
    intro hd
    apply hn
    have hdm : (p : ℤ) ∣ (m : ℤ) := by exact_mod_cast hd
    have hsum : (p : ℤ) ∣ (m : ℤ) + (p : ℤ) * f.order :=
      dvd_add hdm (dvd_mul_right (p : ℤ) f.order)
    convert hsum using 1 <;> omega

end Litt3.SharedTensors
