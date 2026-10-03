import Solutions.QuotientGeometry.ParameterCoordinates
import Solutions.QuotientGeometry.WeakLaurentLinearization

namespace Litt3.QuotientGeometry

theorem power_series_coe_inverse
    {k : Type*} [Field k] (q : PowerSeries k)
    (hq : PowerSeries.constantCoeff q ≠ 0) :
    (q⁻¹ : PowerSeries k) = (q : LaurentSeries k)⁻¹ := by
  apply eq_inv_of_mul_eq_one_left
  rw [← PowerSeries.coe_mul, PowerSeries.inv_mul_cancel q hq, PowerSeries.coe_one]

/-- Removing a regular tail from a pole-one parameter is an actual
automorphism of the entire Laurent field, preserving its constants. -/
theorem laurent_pole_one_parameter_automorphism
    {k : Type*} [Field k] (w : PowerSeries k) :
    ∃ e : LaurentSeries k ≃ₐ[k] LaurentSeries k,
      e (HahnSeries.single (-1) 1) = HahnSeries.single (-1) 1 + (w : LaurentSeries k) := by
  let q : PowerSeries k := 1 + PowerSeries.X * w
  let b : PowerSeries k := PowerSeries.X * q⁻¹
  have hq : PowerSeries.constantCoeff q = 1 := by simp [q]
  have hb : PowerSeries.constantCoeff b = 0 := by simp [b]
  have hblinear : PowerSeries.coeff 1 b = 1 := by
    simp [b, PowerSeries.coeff_one_mul, hq]
  obtain ⟨e, he⟩ := parameter_laurent_automorphism b hb (by rw [hblinear]; exact one_ne_zero)
  refine ⟨e, ?_⟩
  have hx : e (HahnSeries.single 1 1) = (b : LaurentSeries k) := by
    simpa only [PowerSeries.coe_X, PowerSeries.subst_X
      (PowerSeries.HasSubst.of_constantCoeff_zero' hb)] using he PowerSeries.X
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
    e (HahnSeries.single (-1) 1) = e ((HahnSeries.single 1 1)⁻¹) := congrArg e hsingle
    _ = (e (HahnSeries.single 1 1))⁻¹ := map_inv₀ e _
    _ = ((b : LaurentSeries k))⁻¹ := congrArg Inv.inv hx
    _ = HahnSeries.single (-1) 1 + (w : LaurentSeries k) := by rw [hbcoe, inv_inv]

/-- The weak-pole normal form is realized by an actual constant-preserving
field automorphism, rather than just a new element with the right pole. -/
theorem weak_laurent_field_normal_form
    {k : Type*} [Field k] [IsAlgClosed k] (p : ℕ) [CharP k p] (hp : 1 < p)
    (f : LaurentSeries k) (horder : f.order = -(p : ℤ))
    (hderiv : (LaurentSeries.derivative k f).order = -2) :
    ∃ (α γ : k) (e : LaurentSeries k ≃ₐ[k] LaurentSeries k), α ≠ 0 ∧ γ ≠ 0 ∧
      f = HahnSeries.C α * e (HahnSeries.single (-1) 1) ^ p +
        HahnSeries.C γ * e (HahnSeries.single (-1) 1) := by
  obtain ⟨α, γ, w, hα, hγ, _, hf⟩ := weak_laurent_linearized_normal_form p hp f horder hderiv
  obtain ⟨e, he⟩ := laurent_pole_one_parameter_automorphism w
  refine ⟨α, γ, e, hα, hγ, ?_⟩
  rw [he]
  exact hf

end Litt3.QuotientGeometry
