import Solutions.QuotientGeometry.CompletedDVRParameterIdentification

namespace Litt3.QuotientGeometry

/-- The ENTIRE original completed fraction-field map is the canonical
Laurent substitution by the FULL expansion of its original parameter
image. This identifies the original map before any normalization. -/
theorem completedDVRLaurentMap_eq_actual_parameter_substitution
    {k R S : Type*} [Field k]
    [CommRing R] [IsDomain R] [IsDiscreteValuationRing R] [Algebra k R]
    [CommRing S] [IsDomain S] [IsDiscreteValuationRing S] [Algebra k S]
    (dR : DVRCompletionParameters k R) (dS : DVRCompletionParameters k S)
    (φ : R →ₐ[k] S) [IsLocalHom φ.toRingHom] (hinj : Function.Injective φ)
    (hi : Function.Injective (PowerSeries.subst
      (completedDVRStalkEmbedding dS (φ dR.parameter)) : PowerSeries k → PowerSeries k)) :
    completedDVRLaurentMap dR dS φ hinj =
      parameterLaurentMap (completedDVRStalkEmbedding dS (φ dR.parameter))
        (completedDVRPowerSeriesMap_original_parameter_image_constant_zero dR dS φ) hi := by
  exact laurent_field_map_eq_parameter_substitution _
    (completedDVRPowerSeriesMap_original_parameter_image_constant_zero dR dS φ) hi
    (completedDVRPowerSeriesMap dR dS φ)
    (completedDVRPowerSeriesMap_parameter_expansion dR dS φ)
    (completedDVRLaurentMap dR dS φ hinj)
    (completedDVRLaurentMap_power_series dR dS φ hinj)

end Litt3.QuotientGeometry
