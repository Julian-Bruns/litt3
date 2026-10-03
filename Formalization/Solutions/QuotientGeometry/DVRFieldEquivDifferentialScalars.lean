import Solutions.QuotientGeometry.OriginalDVRDifferentialScalars

namespace Litt3.QuotientGeometry

variable {k B R₁ R₂ : Type*} [Field k]
  [CommRing B] [IsDomain B] [IsDiscreteValuationRing B] [Algebra k B]
  [CommRing R₁] [IsDomain R₁] [IsDiscreteValuationRing R₁] [Algebra k R₁]
  [CommRing R₂] [IsDomain R₂] [IsDiscreteValuationRing R₂] [Algebra k R₂]

/-- A genuine equivalence over the SAME entire completed downstairs
field forces the exact differential scalar computed from original
functions and actual universal differentials. This comparison allows
chains through several original source points and a Galois fiber. -/
theorem original_dvr_completed_fields_differential_scalars_equal
    [IsAlgClosed k] (p h m : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hm : 0 < m) (hdiv : h ∣ p - 1)
    (hchar : (h : k) ≠ 0) (hmchar : (m : k) ≠ 0)
    (dB : DVRCompletionParameters k B) (d₁ : DVRCompletionParameters k R₁)
    (d₂ : DVRCompletionParameters k R₂)
    (χ₁ : B →ₐ[k] R₁) (χ₂ : B →ₐ[k] R₂)
    [IsLocalHom χ₁.toRingHom] [IsLocalHom χ₂.toRingHom]
    (hi₁ : Function.Injective χ₁) (hi₂ : Function.Injective χ₂)
    (heq : ParameterFieldsEquivalent (completedDVRLaurentMap dB d₁ χ₁ hi₁)
      (completedDVRLaurentMap dB d₂ χ₂ hi₂))
    (g₁ s₁ : R₁) (g₂ s₂ : R₂) (c : k) (hc : c ≠ 0)
    (hg₁ : IsUnit g₁) (hg₂ : IsUnit g₂) (hs₁ : IsUnit s₁) (hs₂ : IsUnit s₂)
    (hpolar₁ : χ₁ dB.parameter * g₁ ^ m = d₁.parameter ^ (p * h))
    (hpolar₂ : χ₂ dB.parameter * g₂ ^ m = d₂.parameter ^ (p * h))
    (hdg₁ : KaehlerDifferential.D k R₁ g₁ =
      (algebraMap k R₁ c * d₁.parameter ^ (p - 2) * s₁) •
        KaehlerDifferential.D k R₁ d₁.parameter)
    (hdg₂ : KaehlerDifferential.D k R₂ g₂ =
      (algebraMap k R₂ c * d₂.parameter ^ (p - 2) * s₂) •
        KaehlerDifferential.D k R₂ d₂.parameter) :
    localDifferentialScalar p h m c (dvrResidueValue d₁ g₁) (dvrResidueValue d₁ s₁) =
      localDifferentialScalar p h m c (dvrResidueValue d₂ g₂) (dvrResidueValue d₂ s₂) := by
  let G₁ := completedDVRStalkEmbedding d₁ g₁
  let G₂ := completedDVRStalkEmbedding d₂ g₂
  let S₁ := completedDVRStalkEmbedding d₁ s₁
  let S₂ := completedDVRStalkEmbedding d₂ s₂
  have hG₁ := completedDVRStalkEmbedding_unit_constant_nonzero d₁ g₁ hg₁
  have hG₂ := completedDVRStalkEmbedding_unit_constant_nonzero d₂ g₂ hg₂
  have hS₁ := completedDVRStalkEmbedding_unit_constant_nonzero d₁ s₁ hs₁
  have hS₂ := completedDVRStalkEmbedding_unit_constant_nonzero d₂ s₂ hs₂
  have hp : 1 < p := (Fact.out : p.Prime).one_lt
  obtain ⟨u₁, hur₁, _⟩ := Litt3.Jacobians.power_series_unit_nth_root h hh hchar (G₁ ^ m)
    (by simpa using pow_ne_zero m hG₁)
  obtain ⟨u₂, hur₂, _⟩ := Litt3.Jacobians.power_series_unit_nth_root h hh hchar (G₂ ^ m)
    (by simpa using pow_ne_zero m hG₂)
  have hD₁ := dvr_differential_identity_expands d₁ g₁ s₁ c (p - 2) hdg₁
  have hD₂ := dvr_differential_identity_expands d₂ g₂ s₂ c (p - 2) hdg₂
  have ho₁ := weak_differential_root_laurent_orders p h m hp hh hm hchar hmchar
    u₁ G₁ S₁ c hc hG₁ hS₁ hur₁ hD₁
  have ho₂ := weak_differential_root_laurent_orders p h m hp hh hm hchar hmchar
    u₂ G₂ S₂ c hc hG₂ hS₂ hur₂ hD₂
  have hβ₁ := dvr_polar_function_identity_expands dB d₁ χ₁ hi₁ g₁ m (p * h) hpolar₁
  have hβ₂ := dvr_polar_function_identity_expands dB d₂ χ₂ hi₂ g₂ m (p * h) hpolar₂
  have hs := (weak_tame_completed_fields_equiv_iff p h hh hdiv
    (completedDVRPowerSeriesMap dB d₁ χ₁) (completedDVRPowerSeriesMap dB d₂ χ₂)
    (completedDVRLaurentMap dB d₁ χ₁ hi₁) (completedDVRLaurentMap dB d₂ χ₂ hi₂)
    (completedDVRLaurentMap_power_series dB d₁ χ₁ hi₁)
    (completedDVRLaurentMap_power_series dB d₂ χ₂ hi₂)
    _ _ (ho₁.2.2.trans hβ₁.symm) (ho₂.2.2.trans hβ₂.symm)
    ho₁.1 ho₂.1 ho₁.2.1 ho₂.2.1).mp heq
  have hs₁ := weak_laurent_power_root_differential_scalar p h m hp hh hm hdiv hchar hmchar
    u₁ G₁ S₁ c hc hG₁ hS₁ hur₁ hD₁
  have hs₂ := weak_laurent_power_root_differential_scalar p h m hp hh hm hdiv hchar hmchar
    u₂ G₂ S₂ c hc hG₂ hS₂ hur₂ hD₂
  have he := hs₁.symm.trans (hs.trans hs₂)
  simpa only [G₁, G₂, S₁, S₂, completedDVRStalkEmbedding_constant_residue] using he

end Litt3.QuotientGeometry
