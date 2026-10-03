import Solutions.QuotientGeometry.CompletedAutomorphismOrders
import Solutions.QuotientGeometry.LaurentPoleCoordinates

namespace Litt3.QuotientGeometry

noncomputable def affineUniformizerDisplacementOrder
    {k : Type*} [Field k] (ζ b : k) : ℕ∞ := by
  classical
  exact if ζ ≠ 1 then 1 else if b ≠ 0 then 2 else ⊤

theorem compatible_affine_pole_uniformizer
    {k : Type*} [Field k]
    (e : PowerSeries k ≃ₐ[k] PowerSeries k) (E : LaurentSeries k ≃+* LaurentSeries k)
    (hE : ∀ f : PowerSeries k, E (f : LaurentSeries k) = (e f : PowerSeries k))
    (ζ b : k) (hζ : ζ ≠ 0)
    (hpole : E (HahnSeries.single (-1) 1) =
      HahnSeries.C ζ * HahnSeries.single (-1) 1 + HahnSeries.C b) :
    e PowerSeries.X = PowerSeries.X * (PowerSeries.C ζ + PowerSeries.C b * PowerSeries.X)⁻¹ := by
  let q : PowerSeries k := PowerSeries.C ζ + PowerSeries.C b * PowerSeries.X
  have hq : PowerSeries.constantCoeff q ≠ 0 := by simpa [q] using hζ
  have hX : (HahnSeries.single 1 (1 : k) : LaurentSeries k) ≠ 0 :=
    HahnSeries.single_ne_zero one_ne_zero
  have hXinv : (HahnSeries.single 1 (1 : k) : LaurentSeries k) =
      (HahnSeries.single (-1) 1)⁻¹ := by simp [HahnSeries.inv_single]
  have hx : (e PowerSeries.X : PowerSeries k) =
      (HahnSeries.C ζ * HahnSeries.single (-1) 1 + HahnSeries.C b : LaurentSeries k)⁻¹ := by
    rw [← hE, PowerSeries.coe_X, hXinv, map_inv₀, hpole]
  have hqL : (q : LaurentSeries k) = HahnSeries.single 1 1 *
      (HahnSeries.C ζ * HahnSeries.single (-1) 1 + HahnSeries.C b) := by
    simp only [q, PowerSeries.coe_add, PowerSeries.coe_mul, PowerSeries.coe_C,
      PowerSeries.coe_X, mul_add, HahnSeries.C_apply]
    simp [HahnSeries.single_mul_single, mul_comm, mul_left_comm]
  apply (HahnSeries.ofPowerSeries_injective (Γ := ℤ) (R := k))
  rw [hx, PowerSeries.coe_mul, power_series_coe_inverse q hq, PowerSeries.coe_X, hqL,
    mul_inv_rev]
  rw [mul_comm (HahnSeries.single 1 (1 : k)), mul_assoc, inv_mul_cancel₀ hX, mul_one]

theorem affine_uniformizer_displacement_order
    {k : Type*} [Field k] (ζ b : k) (hζ : ζ ≠ 0) :
    PowerSeries.order (PowerSeries.X *
      (PowerSeries.C ζ + PowerSeries.C b * PowerSeries.X)⁻¹ - (PowerSeries.X : PowerSeries k)) =
      affineUniformizerDisplacementOrder ζ b := by
  classical
  unfold affineUniformizerDisplacementOrder
  let q : PowerSeries k := PowerSeries.C ζ + PowerSeries.C b * PowerSeries.X
  have hq : PowerSeries.constantCoeff q ≠ 0 := by simpa [q] using hζ
  have hqi : PowerSeries.order q⁻¹ = 0 :=
    PowerSeries.order_zero_of_unit (PowerSeries.isUnit_iff_constantCoeff.mpr
      (isUnit_iff_ne_zero.mpr (by simpa using inv_ne_zero hq)))
  have hfactor : PowerSeries.X * q⁻¹ - (PowerSeries.X : PowerSeries k) =
      PowerSeries.X * (1 - q) * q⁻¹ := by
    calc
      PowerSeries.X * q⁻¹ - PowerSeries.X =
          PowerSeries.X * q⁻¹ - PowerSeries.X * (q * q⁻¹) := by
            rw [PowerSeries.mul_inv_cancel q hq, mul_one]
      _ = PowerSeries.X * (1 - q) * q⁻¹ := by ring
  change PowerSeries.order (PowerSeries.X * q⁻¹ - PowerSeries.X) = _
  rw [hfactor, PowerSeries.order_mul, PowerSeries.order_mul, PowerSeries.order_X, hqi, add_zero]
  by_cases hζone : ζ ≠ 1
  · have hunit : IsUnit (1 - q) := PowerSeries.isUnit_iff_constantCoeff.mpr
      (isUnit_iff_ne_zero.mpr (by simp [q]; exact sub_ne_zero.mpr hζone.symm))
    rw [PowerSeries.order_zero_of_unit hunit, add_zero, if_pos hζone]
  · have hζeq : ζ = 1 := not_ne_iff.mp hζone
    have hnum : 1 - q = PowerSeries.C (-b) * PowerSeries.X := by
      simp [q, hζeq, sub_eq_add_neg]
    rw [hnum, if_neg hζone]
    by_cases hb : b ≠ 0
    · have hunit : IsUnit (PowerSeries.C (-b)) := PowerSeries.isUnit_iff_constantCoeff.mpr
        (isUnit_iff_ne_zero.mpr (by simpa using neg_ne_zero.mpr hb))
      rw [PowerSeries.order_mul, PowerSeries.order_zero_of_unit hunit,
        PowerSeries.order_X, zero_add, if_pos hb]
      norm_num
    · simp [not_ne_iff.mp hb]

end Litt3.QuotientGeometry
