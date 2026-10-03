import Solutions.QuotientGeometry.FiniteParameterFields

namespace Litt3.QuotientGeometry

theorem parameter_laurent_map_constant
    {k : Type*} [Field k] (b : PowerSeries k)
    (hb : PowerSeries.constantCoeff b = 0)
    (hinj : Function.Injective (PowerSeries.subst b : PowerSeries k → PowerSeries k)) (a : k) :
    parameterLaurentMap b hb hinj (HahnSeries.C a) = HahnSeries.C a := by
  have h := parameter_laurent_map_power_series b hb hinj (PowerSeries.C a)
  have hc := (PowerSeries.substAlgHom
    (PowerSeries.HasSubst.of_constantCoeff_zero' hb) :
      PowerSeries k →ₐ[k] PowerSeries k).commutes a
  change (PowerSeries.substAlgHom (PowerSeries.HasSubst.of_constantCoeff_zero' hb))
    (PowerSeries.C a) = PowerSeries.C a at hc
  rw [PowerSeries.coe_substAlgHom] at hc
  rw [hc] at h
  simpa only [PowerSeries.coe_C] using h

theorem parameter_laurent_map_parameter
    {k : Type*} [Field k] (b : PowerSeries k)
    (hb : PowerSeries.constantCoeff b = 0)
    (hinj : Function.Injective (PowerSeries.subst b : PowerSeries k → PowerSeries k)) :
    parameterLaurentMap b hb hinj (HahnSeries.single 1 1) = (b : LaurentSeries k) := by
  have h := parameter_laurent_map_power_series b hb hinj PowerSeries.X
  rw [PowerSeries.subst_X (PowerSeries.HasSubst.of_constantCoeff_zero' hb)] at h
  simpa only [PowerSeries.coe_X] using h

theorem parameter_laurent_map_pole
    {k : Type*} [Field k] (b : PowerSeries k)
    (hb : PowerSeries.constantCoeff b = 0)
    (hinj : Function.Injective (PowerSeries.subst b : PowerSeries k → PowerSeries k)) (a : k) :
    parameterLaurentMap b hb hinj (HahnSeries.single (-1) a) =
      HahnSeries.C a * (b : LaurentSeries k)⁻¹ := by
  have hpole : (HahnSeries.single (-1) a : LaurentSeries k) =
      HahnSeries.C a * (HahnSeries.single 1 1)⁻¹ := by
    simp [HahnSeries.C_apply, HahnSeries.inv_single, HahnSeries.single_mul_single]
  rw [hpole, map_mul, map_inv₀, parameter_laurent_map_constant,
    parameter_laurent_map_parameter]

end Litt3.QuotientGeometry
