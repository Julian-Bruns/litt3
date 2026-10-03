import Solutions.QuotientGeometry.DVRStalkDifferentials
import Solutions.QuotientGeometry.DVRCompletedFractionMaps

namespace Litt3.QuotientGeometry

variable {k B R : Type*} [Field k]
  [CommRing B] [IsDomain B] [IsDiscreteValuationRing B] [Algebra k B]
  [CommRing R] [IsDomain R] [IsDiscreteValuationRing R] [Algebra k R]

theorem completedDVRPowerSeriesMap_parameter_stalk
    (dB : DVRCompletionParameters k B) (dR : DVRCompletionParameters k R)
    (χ : B →ₐ[k] R) [IsLocalHom χ.toRingHom] :
    completedDVRPowerSeriesMap dB dR χ PowerSeries.X =
      completedDVRStalkEmbedding dR (χ dB.parameter) := by
  have hs := completedDVRPowerSeriesMap_stalk dB dR χ dB.parameter
  change completedDVRPowerSeriesMap dB dR χ
      (completedDVRStalkEmbedding dB dB.parameter) =
    completedDVRStalkEmbedding dR (χ dB.parameter) at hs
  simpa only [completedDVRStalkEmbedding_parameter] using hs

/-- An actual polar identity in the original local rings determines
the complete Laurent expansion of the actual downstairs inverse
parameter. No Laurent expansion is assumed. -/
theorem dvr_polar_function_identity_expands
    (dB : DVRCompletionParameters k B) (dR : DVRCompletionParameters k R)
    (χ : B →ₐ[k] R) [IsLocalHom χ.toRingHom] (hinj : Function.Injective χ)
    (g : R) (m n : ℕ)
    (hrel : χ dB.parameter * g ^ m = dR.parameter ^ n) :
    completedDVRLaurentMap dB dR χ hinj (HahnSeries.single (-1) 1) =
      HahnSeries.single (-(n : ℤ)) 1 * (completedDVRStalkEmbedding dR g : LaurentSeries k) ^ m := by
  let δ := completedDVRPowerSeriesMap dB dR χ
  have he := congrArg (completedDVRStalkEmbedding dR) hrel
  simp only [map_mul, map_pow, completedDVRStalkEmbedding_parameter] at he
  rw [← completedDVRPowerSeriesMap_parameter_stalk dB dR χ] at he
  have heL : (δ PowerSeries.X : LaurentSeries k) *
      (completedDVRStalkEmbedding dR g : LaurentSeries k) ^ m =
      (PowerSeries.X : PowerSeries k) ^ n := by
    simpa only [map_mul, map_pow] using congrArg (algebraMap (PowerSeries k) (LaurentSeries k)) he
  have hδ : (δ PowerSeries.X : LaurentSeries k) ≠ 0 := by
    intro hzero
    apply completedDVRPowerSeriesMap_parameter_ne_zero dB dR χ hinj
    apply HahnSeries.ofPowerSeries_injective (Γ := ℤ)
    simpa only [map_zero] using hzero
  have hX : ((PowerSeries.X : PowerSeries k) : LaurentSeries k) ≠ 0 := by
    intro hz
    have hPS : (PowerSeries.X : PowerSeries k) = 0 := by
      apply HahnSeries.ofPowerSeries_injective (Γ := ℤ)
      simpa only [map_zero] using hz
    exact PowerSeries.X_ne_zero hPS
  have hmonomial : (HahnSeries.single (-1) 1 : LaurentSeries k) =
      ((PowerSeries.X : PowerSeries k) : LaurentSeries k)⁻¹ := by
    simp only [PowerSeries.coe_X, HahnSeries.inv_single, inv_one]
  rw [hmonomial, map_inv₀, completedDVRLaurentMap_power_series]
  calc
    _ = (completedDVRStalkEmbedding dR g : LaurentSeries k) ^ m /
        (((PowerSeries.X : PowerSeries k) : LaurentSeries k) ^ n) := by
      apply (eq_div_iff (pow_ne_zero n hX)).mpr
      rw [← heL]
      change (δ PowerSeries.X : LaurentSeries k)⁻¹ *
        ((δ PowerSeries.X : LaurentSeries k) * _) = _
      rw [← mul_assoc, inv_mul_cancel₀ hδ, one_mul]
    _ = _ := by
      simp only [div_eq_mul_inv, PowerSeries.coe_X, HahnSeries.single_pow,
        nsmul_eq_mul, mul_one, one_pow, HahnSeries.inv_single, inv_one]
      rw [mul_comm]

end Litt3.QuotientGeometry
