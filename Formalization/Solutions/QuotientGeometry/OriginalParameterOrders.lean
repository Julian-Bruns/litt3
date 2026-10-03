import Solutions.QuotientGeometry.ParameterHomUniqueness
import Solutions.QuotientGeometry.LaurentUnitOrders

namespace Litt3.QuotientGeometry

theorem power_series_factor_of_laurent_order
    {k : Type*} [Field k] (b : PowerSeries k) (n : ℕ)
    (horder : (b : LaurentSeries k).order = (n : ℤ))
    (hb : b ≠ 0) :
    ∃ c : PowerSeries k, PowerSeries.constantCoeff c ≠ 0 ∧ b = PowerSeries.X ^ n * c := by
  have hbL : (b : LaurentSeries k) ≠ 0 := by
    intro hz
    apply hb
    apply HahnSeries.ofPowerSeries_injective (Γ := ℤ) (R := k)
    simpa using hz
  let c := LaurentSeries.powerSeriesPart (b : LaurentSeries k)
  have hc : PowerSeries.constantCoeff c ≠ 0 := by
    simpa only [c, ← PowerSeries.coeff_zero_eq_constantCoeff,
      LaurentSeries.powerSeriesPart_coeff, Nat.cast_zero, add_zero] using
      HahnSeries.coeff_order_ne_zero hbL
  refine ⟨c, hc, ?_⟩
  apply HahnSeries.ofPowerSeries_injective (Γ := ℤ) (R := k)
  have hpow : ((PowerSeries.X ^ n : PowerSeries k) : LaurentSeries k) =
      HahnSeries.single (n : ℤ) 1 := by
    simp only [PowerSeries.coe_pow, PowerSeries.coe_X, HahnSeries.single_pow, one_pow,
      nsmul_eq_mul, mul_one]
  rw [PowerSeries.coe_mul, hpow]
  exact (horder ▸ LaurentSeries.single_order_mul_powerSeriesPart (b : LaurentSeries k)).symm

theorem original_completed_parameter_order
    {k : Type*} [Field k] (φ : PowerSeries k →ₐ[k] PowerSeries k)
    (Ψ : LaurentSeries k →+* LaurentSeries k)
    (hΨ : ∀ r : PowerSeries k, Ψ (r : LaurentSeries k) = (φ r : PowerSeries k))
    (n : ℕ) (hpole : (Ψ (HahnSeries.single (-1) 1)).order = -(n : ℤ)) :
    (φ PowerSeries.X : LaurentSeries k).order = (n : ℤ) := by
  have hx : (φ PowerSeries.X : LaurentSeries k) =
      (Ψ (HahnSeries.single (-1) 1))⁻¹ := by
    rw [← hΨ, PowerSeries.coe_X]
    have hsingle : (HahnSeries.single 1 (1 : k) : LaurentSeries k) =
        (HahnSeries.single (-1) 1)⁻¹ := by simp [HahnSeries.inv_single]
    rw [hsingle, map_inv₀]
  rw [hx, laurent_order_inverse, hpole, neg_neg]

/-- The actual original completed homomorphism is identified on every
whole series and factored using its true pole order, before normalization. -/
theorem original_completed_parameter_factor_and_identification
    {k : Type*} [Field k] (φ : PowerSeries k →ₐ[k] PowerSeries k)
    (Ψ : LaurentSeries k →+* LaurentSeries k)
    (hΨ : ∀ r : PowerSeries k, Ψ (r : LaurentSeries k) = (φ r : PowerSeries k))
    (n : ℕ) (hn : 0 < n)
    (hpole : (Ψ (HahnSeries.single (-1) 1)).order = -(n : ℤ)) :
    ∃ (c : PowerSeries k) (hb0 : PowerSeries.constantCoeff (φ PowerSeries.X) = 0),
      PowerSeries.constantCoeff c ≠ 0 ∧ φ PowerSeries.X = PowerSeries.X ^ n * c ∧
      φ = PowerSeries.substAlgHom (PowerSeries.HasSubst.of_constantCoeff_zero' hb0) := by
  have horder := original_completed_parameter_order φ Ψ hΨ n hpole
  have hb : φ PowerSeries.X ≠ 0 := by
    intro hz
    rw [hz, PowerSeries.coe_zero, HahnSeries.order_zero] at horder
    have hn' : (0 : ℤ) < n := by exact_mod_cast hn
    omega
  obtain ⟨c, hc, hfactor⟩ := power_series_factor_of_laurent_order (φ PowerSeries.X) n horder hb
  have hb0 : PowerSeries.constantCoeff (φ PowerSeries.X) = 0 := by
    apply power_series_zero_constant_of_positive_laurent_order
    rw [horder]
    exact_mod_cast hn
  exact ⟨c, hb0, hc, hfactor, power_series_algHom_eq_substitution _ hb0 φ rfl⟩

end Litt3.QuotientGeometry
