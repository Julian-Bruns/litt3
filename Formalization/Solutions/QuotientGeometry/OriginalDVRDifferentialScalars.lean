import Solutions.QuotientGeometry.DVRPolarFunctionExpansion
import Solutions.QuotientGeometry.DVRResidueValues
import Solutions.QuotientGeometry.SameSourceDVRWeakScalars

namespace Litt3.QuotientGeometry

variable {k B R₁ R₂ S : Type*} [Field k]
  [CommRing B] [IsDomain B] [IsDiscreteValuationRing B] [Algebra k B]
  [CommRing R₁] [IsDomain R₁] [IsDiscreteValuationRing R₁] [Algebra k R₁]
  [CommRing R₂] [IsDomain R₂] [IsDiscreteValuationRing R₂] [Algebra k R₂]
  [CommRing S] [IsDomain S] [IsDiscreteValuationRing S] [Algebra k S]

/-- Two actual unramified maps into the same original DVR force equality
of the exact local invariant evaluated in the original residue fields.
Only identities in the original rings and their actual universal
differential modules are supplied. The whole completed charts, fraction
maps, Laurent expansions, differential expansions and comparison are
constructed from those original data. -/
theorem original_same_source_dvr_differential_scalars_equal
    [IsAlgClosed k] (p h m : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hm : 0 < m) (hdiv : h ∣ p - 1)
    (hchar : (h : k) ≠ 0) (hmchar : (m : k) ≠ 0)
    (dB : DVRCompletionParameters k B) (d₁ : DVRCompletionParameters k R₁)
    (d₂ : DVRCompletionParameters k R₂) (dS : DVRCompletionParameters k S)
    (χ₁ : B →ₐ[k] R₁) (χ₂ : B →ₐ[k] R₂)
    (φ₁ : R₁ →ₐ[k] S) (φ₂ : R₂ →ₐ[k] S)
    [IsLocalHom χ₁.toRingHom] [IsLocalHom χ₂.toRingHom]
    [IsLocalHom φ₁.toRingHom] [IsLocalHom φ₂.toRingHom]
    (hi₁ : Function.Injective χ₁) (hi₂ : Function.Injective χ₂)
    (hu₁ : φ₁.toRingHom.FormallyUnramified) (hf₁ : φ₁.toRingHom.EssFiniteType)
    (hu₂ : φ₂.toRingHom.FormallyUnramified) (hf₂ : φ₂.toRingHom.EssFiniteType)
    (hbase : φ₁.comp χ₁ = φ₂.comp χ₂)
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
  have he := same_source_unramified_dvr_differential_scalars_equal p h m
    hh hm hdiv hchar hmchar dB d₁ d₂ dS χ₁ χ₂ φ₁ φ₂ hi₁ hi₂ hu₁ hf₁ hu₂ hf₂ hbase
    (completedDVRStalkEmbedding d₁ g₁) (completedDVRStalkEmbedding d₂ g₂)
    (completedDVRStalkEmbedding d₁ s₁) (completedDVRStalkEmbedding d₂ s₂) c hc
    (completedDVRStalkEmbedding_unit_constant_nonzero d₁ g₁ hg₁)
    (completedDVRStalkEmbedding_unit_constant_nonzero d₂ g₂ hg₂)
    (completedDVRStalkEmbedding_unit_constant_nonzero d₁ s₁ hs₁)
    (completedDVRStalkEmbedding_unit_constant_nonzero d₂ s₂ hs₂)
    (dvr_polar_function_identity_expands dB d₁ χ₁ hi₁ g₁ m (p * h) hpolar₁)
    (dvr_polar_function_identity_expands dB d₂ χ₂ hi₂ g₂ m (p * h) hpolar₂)
    (dvr_differential_identity_expands d₁ g₁ s₁ c (p - 2) hdg₁)
    (dvr_differential_identity_expands d₂ g₂ s₂ c (p - 2) hdg₂)
  simpa only [completedDVRStalkEmbedding_constant_residue] using he

end Litt3.QuotientGeometry
