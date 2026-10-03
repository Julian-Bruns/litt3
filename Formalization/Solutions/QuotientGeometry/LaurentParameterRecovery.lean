import Solutions.QuotientGeometry.ParameterFieldMapUniqueness

namespace Litt3.QuotientGeometry

theorem power_series_equiv_preserves_zero_constant
    {k l : Type*} [Field k] [Field l]
    (e : PowerSeries k ≃+* PowerSeries l) (f : PowerSeries k)
    (hf : PowerSeries.constantCoeff f = 0) : PowerSeries.constantCoeff (e f) = 0 := by
  by_contra h
  have hu : IsUnit (e f) := PowerSeries.isUnit_iff_constantCoeff.mpr (isUnit_iff_ne_zero.mpr h)
  have hfu : IsUnit f := by
    have hfu' := hu.map e.symm.toRingHom
    change IsUnit (e.symm (e f)) at hfu'
    simpa only [e.symm_apply_apply] using hfu'
  have hz := hfu.map PowerSeries.constantCoeff
  rw [hf] at hz
  exact not_isUnit_zero hz

/-- Actual compatible completed-ring maps are equal on the full
fraction field as soon as they agree on the downstairs pole parameter.
The hypothesis refers to actual maps, not abstract field labels. -/
theorem laurent_field_maps_eq_of_pole_image
    {k : Type*} [Field k]
    (φ χ : PowerSeries k →ₐ[k] PowerSeries k)
    (Ψ Ω : LaurentSeries k →+* LaurentSeries k)
    (hΨ : ∀ f : PowerSeries k, Ψ (f : LaurentSeries k) = (φ f : PowerSeries k))
    (hΩ : ∀ f : PowerSeries k, Ω (f : LaurentSeries k) = (χ f : PowerSeries k))
    (hb : PowerSeries.constantCoeff (φ PowerSeries.X) = 0)
    (hpole : Ψ (HahnSeries.single (-1) 1) = Ω (HahnSeries.single (-1) 1)) : Ψ = Ω := by
  have hinv : (HahnSeries.single 1 (1 : k) : LaurentSeries k) =
      (HahnSeries.single (-1) 1)⁻¹ := by simp [HahnSeries.inv_single]
  have hx : (φ PowerSeries.X : PowerSeries k) = χ PowerSeries.X := by
    apply HahnSeries.ofPowerSeries_injective (Γ := ℤ) (R := k)
    rw [← hΨ, ← hΩ, PowerSeries.coe_X, hinv, map_inv₀, map_inv₀, hpole]
  have hφ := power_series_algHom_eq_substitution (φ PowerSeries.X) hb φ rfl
  have hχ := power_series_algHom_eq_substitution (φ PowerSeries.X) hb χ hx.symm
  have heq : φ = χ := hφ.trans hχ.symm
  apply IsFractionRing.ringHom_ext (A := PowerSeries k)
  intro f
  change Ψ (f : LaurentSeries k) = Ω (f : LaurentSeries k)
  rw [hΨ, hΩ, heq]

end Litt3.QuotientGeometry
