import Solutions.QuotientGeometry.LaurentUnitOrders

namespace Litt3.QuotientGeometry

theorem affine_pole_inverse_parameter_image
    {k : Type*} [Field k] (E : LaurentSeries k ≃+* LaurentSeries k) (ζ b : k)
    (hζ : ζ ≠ 0)
    (hpole : E (HahnSeries.single (-1) 1) =
      HahnSeries.C ζ * HahnSeries.single (-1) 1 + HahnSeries.C b) :
    E (HahnSeries.single 1 1) = HahnSeries.single 1 1 *
      ((PowerSeries.C ζ + PowerSeries.C b * PowerSeries.X : PowerSeries k) : LaurentSeries k)⁻¹ := by
  let v : LaurentSeries k := HahnSeries.single (-1) 1
  let x : LaurentSeries k := HahnSeries.single 1 1
  have hv : v⁻¹ = x := by simp [v, x, HahnSeries.inv_single]
  have hproduct : HahnSeries.C ζ * v + HahnSeries.C b =
      ((PowerSeries.C ζ + PowerSeries.C b * PowerSeries.X : PowerSeries k) : LaurentSeries k) * v := by
    simp only [PowerSeries.coe_add, PowerSeries.coe_mul, PowerSeries.coe_C, PowerSeries.coe_X, mul_add, add_mul]
    simp [v, HahnSeries.single_mul_single, mul_assoc]
  change E x = _
  rw [← hv, map_inv₀, hpole, hproduct, mul_inv_rev, hv]

/-- Actual nontrivial wild translations move the inverse coordinate
in exact order two: this is the lower-break-one calculation. -/
theorem affine_translation_parameter_difference_order
    {k : Type*} [Field k] (E : LaurentSeries k ≃+* LaurentSeries k) (b : k) (hb : b ≠ 0)
    (hpole : E (HahnSeries.single (-1) 1) = HahnSeries.single (-1) 1 + HahnSeries.C b) :
    (E (HahnSeries.single 1 1) - HahnSeries.single 1 1).order = 2 := by
  let x : LaurentSeries k := HahnSeries.single 1 1
  let q : PowerSeries k := PowerSeries.C 1 + PowerSeries.C b * PowerSeries.X
  have hq : PowerSeries.constantCoeff q = 1 := by simp [q]
  have hqorder : (q : LaurentSeries k).order = 0 := power_series_coe_unit_order q (by rw [hq]; exact one_ne_zero)
  have hqunit : IsUnit q := PowerSeries.isUnit_iff_constantCoeff.mpr (by rw [hq]; exact isUnit_one)
  have hqne : (q : LaurentSeries k) ≠ 0 := (hqunit.map (HahnSeries.ofPowerSeries ℤ k)).ne_zero
  have hx : x ≠ 0 := HahnSeries.single_ne_zero one_ne_zero
  have hbC : (HahnSeries.C b : LaurentSeries k) ≠ 0 := by simpa only [HahnSeries.C_apply] using HahnSeries.single_ne_zero hb
  have hE : E x = x * (q : LaurentSeries k)⁻¹ := by
    apply affine_pole_inverse_parameter_image E 1 b one_ne_zero
    simpa only [HahnSeries.C_one, one_mul] using hpole
  have hqcoe : (q : LaurentSeries k) = 1 + HahnSeries.C b * x := by
    simp only [q, PowerSeries.coe_add, PowerSeries.coe_mul, PowerSeries.coe_C, PowerSeries.coe_X,
      HahnSeries.C_one]
    rfl
  have hdiff : E x - x = -(HahnSeries.C b) * x ^ 2 * (q : LaurentSeries k)⁻¹ := by
    rw [hE]
    apply (mul_right_cancel₀ hqne)
    simp only [sub_mul, mul_assoc, inv_mul_cancel₀ hqne, mul_one]
    rw [hqcoe]
    ring
  change (E x - x).order = 2
  rw [hdiff, HahnSeries.order_mul (mul_ne_zero (neg_ne_zero.mpr hbC) (pow_ne_zero 2 hx)) (inv_ne_zero hqne),
    HahnSeries.order_mul (neg_ne_zero.mpr hbC) (pow_ne_zero 2 hx), HahnSeries.order_neg,
    HahnSeries.C_apply, HahnSeries.order_single hb, HahnSeries.order_pow, HahnSeries.order_single one_ne_zero,
    laurent_order_inverse, hqorder]
  norm_num

theorem affine_tame_parameter_difference_order
    {k : Type*} [Field k] (E : LaurentSeries k ≃+* LaurentSeries k) (ζ b : k)
    (hζ : ζ ≠ 0) (hζone : ζ ≠ 1)
    (hpole : E (HahnSeries.single (-1) 1) =
      HahnSeries.C ζ * HahnSeries.single (-1) 1 + HahnSeries.C b) :
    (E (HahnSeries.single 1 1) - HahnSeries.single 1 1).order = 1 := by
  let x : LaurentSeries k := HahnSeries.single 1 1
  let q : PowerSeries k := PowerSeries.C ζ + PowerSeries.C b * PowerSeries.X
  let r : PowerSeries k := 1 - q
  have hq : PowerSeries.constantCoeff q = ζ := by simp [q]
  have hr : PowerSeries.constantCoeff r = 1 - ζ := by simp [r, hq]
  have hrconstant : PowerSeries.constantCoeff r ≠ 0 := by
    rw [hr]
    exact sub_ne_zero.mpr hζone.symm
  have hqorder : (q : LaurentSeries k).order = 0 := power_series_coe_unit_order q (by rwa [hq])
  have hrorder : (r : LaurentSeries k).order = 0 := power_series_coe_unit_order r hrconstant
  have hqunit : IsUnit q := PowerSeries.isUnit_iff_constantCoeff.mpr (by rw [hq]; exact isUnit_iff_ne_zero.mpr hζ)
  have hrunit : IsUnit r := PowerSeries.isUnit_iff_constantCoeff.mpr (isUnit_iff_ne_zero.mpr hrconstant)
  have hqne : (q : LaurentSeries k) ≠ 0 := (hqunit.map (HahnSeries.ofPowerSeries ℤ k)).ne_zero
  have hrne : (r : LaurentSeries k) ≠ 0 := (hrunit.map (HahnSeries.ofPowerSeries ℤ k)).ne_zero
  have hx : x ≠ 0 := HahnSeries.single_ne_zero one_ne_zero
  have hE : E x = x * (q : LaurentSeries k)⁻¹ :=
    affine_pole_inverse_parameter_image E ζ b hζ hpole
  have hdiff : E x - x = x * (r : LaurentSeries k) * (q : LaurentSeries k)⁻¹ := by
    rw [hE]
    apply mul_right_cancel₀ hqne
    simp only [sub_mul, mul_assoc, inv_mul_cancel₀ hqne, mul_one]
    simp only [r, PowerSeries.coe_sub, PowerSeries.coe_one]
    ring
  change (E x - x).order = 1
  rw [hdiff, HahnSeries.order_mul (mul_ne_zero hx hrne) (inv_ne_zero hqne),
    HahnSeries.order_mul hx hrne, HahnSeries.order_single one_ne_zero,
    hrorder, laurent_order_inverse, hqorder]
  norm_num

end Litt3.QuotientGeometry
