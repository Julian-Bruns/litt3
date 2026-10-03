import Solutions.QuotientGeometry.PoleShiftCoordinates

namespace Litt3.QuotientGeometry

theorem scaled_pole_power_series_coordinates
    {k : Type*} [Field k] (ζ : k) (hζ : ζ ≠ 0) :
    ∃ (e : PowerSeries k ≃ₐ[k] PowerSeries k) (E : LaurentSeries k ≃ₐ[k] LaurentSeries k),
      (∀ f : PowerSeries k, E (f : LaurentSeries k) = (e f : PowerSeries k)) ∧
      E (HahnSeries.single (-1) 1) = HahnSeries.C ζ * HahnSeries.single (-1) 1 := by
  let b : PowerSeries k := PowerSeries.C ζ⁻¹ * PowerSeries.X
  have hb : PowerSeries.constantCoeff b = 0 := by simp [b]
  have hblinear : PowerSeries.coeff 1 b = ζ⁻¹ := by simp [b]
  obtain ⟨e, he⟩ := parameter_power_series_automorphism b hb (by rw [hblinear]; exact inv_ne_zero hζ)
  obtain ⟨E, hE⟩ := parameter_laurent_automorphism b hb (by rw [hblinear]; exact inv_ne_zero hζ)
  refine ⟨e, E, fun f => by rw [hE, he], ?_⟩
  have hx : E (HahnSeries.single 1 1) =
      HahnSeries.C ζ⁻¹ * HahnSeries.single 1 1 := by
    have h := hE PowerSeries.X
    rw [PowerSeries.subst_X (PowerSeries.HasSubst.of_constantCoeff_zero' hb)] at h
    simpa only [b, PowerSeries.coe_X, PowerSeries.coe_mul, PowerSeries.coe_C] using h
  have hv : (HahnSeries.single (-1) (1 : k) : LaurentSeries k) =
      (HahnSeries.single 1 1)⁻¹ := by simp [HahnSeries.inv_single]
  rw [hv, map_inv₀, hx, mul_inv_rev,
    ← map_inv₀ (HahnSeries.C : k →+* LaurentSeries k), inv_inv]
  exact mul_comm _ _

/-- Every genuine affine change of the pole coordinate extends
compatibly to both the whole power-series ring and Laurent field. -/
theorem affine_pole_power_series_coordinates
    {k : Type*} [Field k] (ζ b : k) (hζ : ζ ≠ 0) :
    ∃ (e : PowerSeries k ≃ₐ[k] PowerSeries k) (E : LaurentSeries k ≃ₐ[k] LaurentSeries k),
      (∀ f : PowerSeries k, E (f : LaurentSeries k) = (e f : PowerSeries k)) ∧
      E (HahnSeries.single (-1) 1) =
        HahnSeries.C ζ * HahnSeries.single (-1) 1 + HahnSeries.C b := by
  obtain ⟨eS, ES, hES, hS⟩ := pole_shift_power_series_coordinates (PowerSeries.C b)
  obtain ⟨eM, EM, hEM, hM⟩ := scaled_pole_power_series_coordinates ζ hζ
  refine ⟨eS.trans eM, ES.trans EM, ?_, ?_⟩
  · intro f
    change EM (ES (f : LaurentSeries k)) = (eM (eS f) : PowerSeries k)
    rw [hES, hEM]
  · change EM (ES (HahnSeries.single (-1) 1)) = _
    rw [hS, PowerSeries.coe_C, map_add, hM]
    have h := EM.commutes b
    simpa only [LaurentSeries.algebraMap_apply] using congrArg
      (fun z : LaurentSeries k => HahnSeries.C ζ * HahnSeries.single (-1) 1 + z) h

end Litt3.QuotientGeometry
