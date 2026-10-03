import Solutions.QuotientGeometry.CompletedDVRMaps
import Solutions.Jacobians.UnramifiedDVRPullbacks
import Solutions.QuotientGeometry.CompletedAutomorphismOrders

namespace Litt3.QuotientGeometry

open IsLocalRing

variable {k R K : Type*} [Field k]
  [CommRing R] [IsDomain R] [IsDiscreteValuationRing R] [Algebra k R]
  [Field K] [Algebra R K] [IsFractionRing R K]

/-- The actual DVR embeds into its constructed entire power-series chart. -/
noncomputable def completedDVRStalkEmbedding
    (d : DVRCompletionParameters k R) : R →ₐ[k] PowerSeries k :=
  { d.chart.symm.toRingHom.comp (algebraMap R (AdicCompletion (maximalIdeal R) R)) with
    commutes' := by
      intro c
      change d.chart.symm (algebraMap k (AdicCompletion (maximalIdeal R) R) c) = _
      exact d.chart.symm.commutes c }

theorem completedDVRStalkEmbedding_injective
    (d : DVRCompletionParameters k R) : Function.Injective (completedDVRStalkEmbedding d) := by
  intro a b h
  apply AdicCompletion.of_injective (I := maximalIdeal R) (M := R)
  exact d.chart.symm.injective h

@[simp] theorem completedDVRStalkEmbedding_parameter
    (d : DVRCompletionParameters k R) : completedDVRStalkEmbedding d d.parameter = PowerSeries.X := by
  change d.chart.symm (AdicCompletion.of _ R d.parameter) = _
  rw [← dvrPowerSeriesAlgChart_X d.parameter d.irreducible d.residue_surjective]
  exact d.chart.symm_apply_apply PowerSeries.X

/-- The literal function-field embedding into the actual completed Laurent
field, constructed from the genuine fraction-field and DVR data. -/
noncomputable def dvrFunctionFieldCompletion
    (d : DVRCompletionParameters k R) : K →+* LaurentSeries k :=
  IsFractionRing.map (A := R) (B := PowerSeries k)
    (j := (completedDVRStalkEmbedding d).toRingHom) (completedDVRStalkEmbedding_injective d)

theorem dvrFunctionFieldCompletion_ring
    (d : DVRCompletionParameters k R) (r : R) :
    dvrFunctionFieldCompletion (K := K) d (algebraMap R K r) =
      (completedDVRStalkEmbedding d r : PowerSeries k) := by
  change IsFractionRing.map _ (algebraMap R K r) = _
  rw [IsFractionRing.map, IsLocalization.map_eq]
  rfl

@[simp] theorem dvrFunctionFieldCompletion_parameter
    (d : DVRCompletionParameters k R) :
    dvrFunctionFieldCompletion (K := K) d (algebraMap R K d.parameter) =
      (PowerSeries.X : PowerSeries k) := by
  rw [dvrFunctionFieldCompletion_ring, completedDVRStalkEmbedding_parameter]

theorem completedDVRStalkEmbedding_order
    (d : DVRCompletionParameters k R) (r : R) :
    PowerSeries.order (completedDVRStalkEmbedding d r) = IsDiscreteValuationRing.addVal R r := by
  by_cases hr : r = 0
  · simp [hr, IsDiscreteValuationRing.addVal_zero]
  obtain ⟨n, u, hu⟩ := IsDiscreteValuationRing.eq_unit_mul_pow_irreducible hr d.irreducible
  rw [IsDiscreteValuationRing.addVal_def r u d.irreducible n hu, hu, map_mul, map_pow,
    completedDVRStalkEmbedding_parameter, PowerSeries.order_mul,
    PowerSeries.order_zero_of_unit (u.isUnit.map (completedDVRStalkEmbedding d)),
    PowerSeries.order_pow, PowerSeries.order_X]
  simp

theorem completedDVRStalkEmbedding_valuation
    (d : DVRCompletionParameters k R) (r : R) :
    (Litt3.Jacobians.discreteValuationPlace (PowerSeries k)).intValuation
      (completedDVRStalkEmbedding d r) =
      (Litt3.Jacobians.discreteValuationPlace R).intValuation r := by
  by_cases hr : r = 0
  · simp [hr]
  obtain ⟨n, u, hu⟩ := IsDiscreteValuationRing.eq_unit_mul_pow_irreducible hr d.irreducible
  have hunit : (Litt3.Jacobians.discreteValuationPlace (PowerSeries k)).intValuation
      (completedDVRStalkEmbedding d u.val) = 1 :=
    Litt3.Jacobians.dvr_unit_adic_value_one (u.map (completedDVRStalkEmbedding d).toMonoidHom)
  simp only [hu, map_mul, map_pow, completedDVRStalkEmbedding_parameter,
    Litt3.Jacobians.dvr_uniformizer_adic_value (PowerSeries.X : PowerSeries k)
      PowerSeries.X_irreducible,
    Litt3.Jacobians.dvr_uniformizer_adic_value d.parameter d.irreducible,
    Litt3.Jacobians.dvr_unit_adic_value_one u, hunit]

/-- Genuine normalized valuation compatibility for the constructed entire
function-field completion map. It is derived, not supplied. -/
theorem dvrFunctionFieldCompletion_valuation
    (d : DVRCompletionParameters k R) (f : K) :
    (Litt3.Jacobians.discreteValuationPlace (PowerSeries k)).valuation (LaurentSeries k)
      (dvrFunctionFieldCompletion d f) =
      (Litt3.Jacobians.discreteValuationPlace R).valuation K f := by
  obtain ⟨a, b, _, rfl⟩ := IsFractionRing.div_surjective (A := R) f
  rw [map_div₀, dvrFunctionFieldCompletion_ring, dvrFunctionFieldCompletion_ring,
    map_div₀, map_div₀]
  change (Litt3.Jacobians.discreteValuationPlace (PowerSeries k)).valuation (LaurentSeries k)
      (algebraMap (PowerSeries k) (LaurentSeries k) (completedDVRStalkEmbedding d a)) /
    (Litt3.Jacobians.discreteValuationPlace (PowerSeries k)).valuation (LaurentSeries k)
      (algebraMap (PowerSeries k) (LaurentSeries k) (completedDVRStalkEmbedding d b)) = _
  simp only [IsDedekindDomain.HeightOneSpectrum.valuation_of_algebraMap,
    completedDVRStalkEmbedding_valuation]

end Litt3.QuotientGeometry
