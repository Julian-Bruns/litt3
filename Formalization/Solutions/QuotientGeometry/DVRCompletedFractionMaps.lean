import Solutions.QuotientGeometry.CompletedDVRMaps
import Solutions.QuotientGeometry.PowerSeriesFieldEmbeddings

namespace Litt3.QuotientGeometry

open IsLocalRing

variable {k R S : Type*} [Field k]
  [CommRing R] [IsDomain R] [IsDiscreteValuationRing R] [Algebra k R]
  [CommRing S] [IsDomain S] [IsDiscreteValuationRing S] [Algebra k S]

theorem completedDVRPowerSeriesMap_parameter_image
    (dR : DVRCompletionParameters k R) (dS : DVRCompletionParameters k S)
    (φ : R →ₐ[k] S) [IsLocalHom φ.toRingHom] :
    dS.chart (completedDVRPowerSeriesMap dR dS φ PowerSeries.X) =
      AdicCompletion.of (maximalIdeal S) S (φ dR.parameter) := by
  change dS.chart (dS.chart.symm (adicAlgMap _ _ φ (local_map_maximal_ideal_le φ)
    (dR.chart PowerSeries.X))) = _
  rw [dS.chart.apply_symm_apply]
  change adicAlgMap _ _ φ (local_map_maximal_ideal_le φ)
    (dvrPowerSeriesAlgChart dR.parameter dR.irreducible dR.residue_surjective PowerSeries.X) = _
  rw [dvrPowerSeriesAlgChart_X, adicAlgMap_of]

theorem completedDVRPowerSeriesMap_parameter_ne_zero
    (dR : DVRCompletionParameters k R) (dS : DVRCompletionParameters k S)
    (φ : R →ₐ[k] S) [IsLocalHom φ.toRingHom] (hinj : Function.Injective φ) :
    completedDVRPowerSeriesMap dR dS φ PowerSeries.X ≠ 0 := by
  intro hz
  have h := completedDVRPowerSeriesMap_parameter_image dR dS φ
  rw [hz, map_zero] at h
  have hzero : φ dR.parameter = 0 := by
    apply AdicCompletion.of_injective (I := maximalIdeal S) (M := S)
    simpa using h.symm
  have htzero : dR.parameter = 0 := hinj (by simpa using hzero)
  exact dR.irreducible.ne_zero htzero

theorem completedDVRPowerSeriesMap_injective
    (dR : DVRCompletionParameters k R) (dS : DVRCompletionParameters k S)
    (φ : R →ₐ[k] S) [IsLocalHom φ.toRingHom] (hinj : Function.Injective φ) :
    Function.Injective (completedDVRPowerSeriesMap dR dS φ) :=
  power_series_ringHom_injective_of_parameter_ne_zero
    (completedDVRPowerSeriesMap dR dS φ).toRingHom
      (completedDVRPowerSeriesMap_parameter_ne_zero dR dS φ hinj)

/-- The actual fraction-field map induced by the original injective
local DVR map and its constructed completion charts. -/
noncomputable def completedDVRLaurentMap
    (dR : DVRCompletionParameters k R) (dS : DVRCompletionParameters k S)
    (φ : R →ₐ[k] S) [IsLocalHom φ.toRingHom] (hinj : Function.Injective φ) :
    LaurentSeries k →+* LaurentSeries k :=
  IsFractionRing.map (A := PowerSeries k) (B := PowerSeries k)
    (j := (completedDVRPowerSeriesMap dR dS φ).toRingHom)
    (completedDVRPowerSeriesMap_injective dR dS φ hinj)

theorem completedDVRLaurentMap_power_series
    (dR : DVRCompletionParameters k R) (dS : DVRCompletionParameters k S)
    (φ : R →ₐ[k] S) [IsLocalHom φ.toRingHom] (hinj : Function.Injective φ)
    (f : PowerSeries k) :
    completedDVRLaurentMap dR dS φ hinj (f : LaurentSeries k) =
      (completedDVRPowerSeriesMap dR dS φ f : PowerSeries k) := by
  change IsFractionRing.map _ (algebraMap (PowerSeries k) (LaurentSeries k) f) = _
  rw [IsFractionRing.map, IsLocalization.map_eq]
  rfl

theorem completedDVRPowerSeriesMap_parameter_constant_zero
    (dR : DVRCompletionParameters k R) (dS : DVRCompletionParameters k S)
    (φ : R →ₐ[k] S) [IsLocalHom φ.toRingHom] :
    PowerSeries.constantCoeff (completedDVRPowerSeriesMap dR dS φ PowerSeries.X) = 0 := by
  apply (algebraMap k (ResidueField S)).injective
  rw [map_zero]
  rw [← dvrPowerSeriesChart_residue dS.parameter dS.irreducible dS.residue_surjective]
  change AdicCompletion.evalOneₐ (maximalIdeal S)
    (dS.chart (completedDVRPowerSeriesMap dR dS φ PowerSeries.X)) = 0
  rw [completedDVRPowerSeriesMap_parameter_image, AdicCompletion.evalOneₐ_of]
  apply (residue_eq_zero_iff _).mpr
  apply map_nonunit φ.toRingHom
  rw [dR.irreducible.maximalIdeal_eq]
  exact Ideal.mem_span_singleton_self _

end Litt3.QuotientGeometry
