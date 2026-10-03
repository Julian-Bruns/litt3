import Solutions.QuotientGeometry.WeakLaurentLinearization

namespace Litt3.QuotientGeometry

/-- The normalizing translation does not change either negative
coefficient in the original Laurent expansion. -/
theorem weak_linearized_negative_coefficients
    {k : Type*} [Field k] (p : ℕ) [CharP k p] (hp : 1 < p)
    (α γ : k) (w : PowerSeries k) (f : LaurentSeries k)
    (hf : f = HahnSeries.C α * (HahnSeries.single (-1) 1 + (w : LaurentSeries k)) ^ p +
      HahnSeries.C γ * (HahnSeries.single (-1) 1 + (w : LaurentSeries k))) :
    f.coeff (-(p : ℤ)) = α ∧ f.coeff (-1) = γ := by
  haveI := laurent_series_charP (k := k) p
  haveI : Fact p.Prime := ⟨CharP.char_is_prime_of_two_le k p (by omega)⟩
  let r : PowerSeries k := PowerSeries.C α * w ^ p + PowerSeries.C γ * w
  have hnormal : f = HahnSeries.single (-(p : ℤ)) α + HahnSeries.single (-1) γ +
      (r : LaurentSeries k) := by
    rw [hf, add_pow_char, mul_add, mul_add]
    have hα : (HahnSeries.C α : LaurentSeries k) * (HahnSeries.single (-1) 1) ^ p =
        HahnSeries.single (-(p : ℤ)) α := by
      simp [HahnSeries.single_pow, HahnSeries.C_apply, HahnSeries.single_mul_single]
    have hγ : (HahnSeries.C γ : LaurentSeries k) * HahnSeries.single (-1) 1 =
        HahnSeries.single (-1) γ := by
      simp [HahnSeries.C_apply, HahnSeries.single_mul_single]
    rw [hα, hγ]
    simp only [r, PowerSeries.coe_add, PowerSeries.coe_mul, PowerSeries.coe_pow, PowerSeries.coe_C]
    ring
  constructor
  · rw [hnormal]
    simp [PowerSeries.coeff_coe, show p ≠ 0 by omega,
      show -(p : ℤ) ≠ -1 by omega]
  · rw [hnormal]
    simp [PowerSeries.coeff_coe, show (-1 : ℤ) ≠ -(p : ℤ) by omega]

end Litt3.QuotientGeometry
