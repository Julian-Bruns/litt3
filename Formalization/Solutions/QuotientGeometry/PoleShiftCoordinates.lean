import Solutions.QuotientGeometry.LaurentPoleCoordinates

namespace Litt3.QuotientGeometry

/-- The pole shift is simultaneously an actual power-series coordinate
change and its compatible constant-preserving Laurent field change. -/
theorem pole_shift_power_series_coordinates
    {k : Type*} [Field k] (w : PowerSeries k) :
    ∃ (e : PowerSeries k ≃ₐ[k] PowerSeries k) (E : LaurentSeries k ≃ₐ[k] LaurentSeries k),
      (∀ f : PowerSeries k, E (f : LaurentSeries k) = (e f : PowerSeries k)) ∧
      E (HahnSeries.single (-1) 1) = HahnSeries.single (-1) 1 + (w : LaurentSeries k) := by
  let q : PowerSeries k := 1 + PowerSeries.X * w
  let b : PowerSeries k := PowerSeries.X * q⁻¹
  have hq : PowerSeries.constantCoeff q = 1 := by simp [q]
  have hb : PowerSeries.constantCoeff b = 0 := by simp [b]
  have hblinear : PowerSeries.coeff 1 b = 1 := by simp [b, hq]
  obtain ⟨e, he⟩ := parameter_power_series_automorphism b hb (by rw [hblinear]; exact one_ne_zero)
  obtain ⟨E, hE⟩ := parameter_laurent_automorphism b hb (by rw [hblinear]; exact one_ne_zero)
  refine ⟨e, E, fun f => by rw [hE, he], ?_⟩
  have hx : E (HahnSeries.single 1 1) = (b : LaurentSeries k) := by
    simpa only [PowerSeries.coe_X, PowerSeries.subst_X
      (PowerSeries.HasSubst.of_constantCoeff_zero' hb)] using hE PowerSeries.X
  have hqcoe : (q : LaurentSeries k) =
      HahnSeries.single 1 1 * (HahnSeries.single (-1) 1 + (w : LaurentSeries k)) := by
    simp only [q, PowerSeries.coe_add, PowerSeries.coe_one, PowerSeries.coe_mul,
      PowerSeries.coe_X, mul_add, HahnSeries.single_mul_single]
    simp
  have hbcoe : (b : LaurentSeries k) =
      (HahnSeries.single (-1) 1 + (w : LaurentSeries k))⁻¹ := by
    rw [show b = PowerSeries.X * q⁻¹ from rfl, PowerSeries.coe_mul,
      power_series_coe_inverse q (by rw [hq]; exact one_ne_zero), PowerSeries.coe_X, hqcoe,
      mul_inv_rev]
    rw [mul_comm, mul_assoc, inv_mul_cancel₀]
    · simp
    · exact HahnSeries.single_ne_zero one_ne_zero
  have hsingle : (HahnSeries.single (-1) (1 : k) : LaurentSeries k) =
      (HahnSeries.single 1 1)⁻¹ := by simp [HahnSeries.inv_single]
  calc
    E (HahnSeries.single (-1) 1) = E ((HahnSeries.single 1 1)⁻¹) := congrArg E hsingle
    _ = (E (HahnSeries.single 1 1))⁻¹ := map_inv₀ E _
    _ = ((b : LaurentSeries k))⁻¹ := congrArg Inv.inv hx
    _ = HahnSeries.single (-1) 1 + (w : LaurentSeries k) := by rw [hbcoe, inv_inv]

end Litt3.QuotientGeometry
