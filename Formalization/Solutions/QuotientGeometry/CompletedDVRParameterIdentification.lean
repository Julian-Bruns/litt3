import Solutions.QuotientGeometry.DVRResidueValues
import Solutions.QuotientGeometry.ParameterFieldMapUniqueness
import Solutions.QuotientGeometry.DVRCompletedFractionMaps

namespace Litt3.QuotientGeometry

open IsLocalRing

variable {k R S : Type*} [Field k]
  [CommRing R] [IsDomain R] [IsDiscreteValuationRing R] [Algebra k R]
  [CommRing S] [IsDomain S] [IsDiscreteValuationRing S] [Algebra k S]

/-- The constructed WHOLE completed ring map sends its original parameter
to the actual expansion of the original image, before normalization. -/
theorem completedDVRPowerSeriesMap_parameter_expansion
    (dR : DVRCompletionParameters k R) (dS : DVRCompletionParameters k S)
    (φ : R →ₐ[k] S) [IsLocalHom φ.toRingHom] :
    completedDVRPowerSeriesMap dR dS φ PowerSeries.X =
      completedDVRStalkEmbedding dS (φ dR.parameter) := by
  have h := completedDVRPowerSeriesMap_stalk dR dS φ dR.parameter
  change completedDVRPowerSeriesMap dR dS φ
    (completedDVRStalkEmbedding dR dR.parameter) = _ at h
  rwa [completedDVRStalkEmbedding_parameter] at h

/-- Localness of the ORIGINAL map forces zero constant coefficient of
the actual original parameter image in its constructed full expansion. -/
theorem completedDVRPowerSeriesMap_original_parameter_image_constant_zero
    (dR : DVRCompletionParameters k R) (dS : DVRCompletionParameters k S)
    (φ : R →ₐ[k] S) [IsLocalHom φ.toRingHom] :
    PowerSeries.constantCoeff (completedDVRStalkEmbedding dS (φ dR.parameter)) = 0 := by
  rw [completedDVRStalkEmbedding_constant_residue]
  apply (algebraMap k (ResidueField S)).injective
  rw [dvrResidueValue_residue, map_zero]
  apply (residue_eq_zero_iff _).mpr
  apply map_nonunit φ.toRingHom
  exact dR.irreducible.not_isUnit

/-- The actual original completed map is genuine substitution on EVERY
series by the actual original parameter image. Continuity and a model
identification are not hypotheses. -/
theorem completedDVRPowerSeriesMap_eq_actual_substitution
    (dR : DVRCompletionParameters k R) (dS : DVRCompletionParameters k S)
    (φ : R →ₐ[k] S) [IsLocalHom φ.toRingHom] :
    completedDVRPowerSeriesMap dR dS φ = PowerSeries.substAlgHom
      (PowerSeries.HasSubst.of_constantCoeff_zero'
        (completedDVRPowerSeriesMap_original_parameter_image_constant_zero dR dS φ)) := by
  exact power_series_algHom_eq_substitution _
    (completedDVRPowerSeriesMap_original_parameter_image_constant_zero dR dS φ)
    (completedDVRPowerSeriesMap dR dS φ)
    (completedDVRPowerSeriesMap_parameter_expansion dR dS φ)

end Litt3.QuotientGeometry
