import Solutions.QuotientGeometry.OriginalDVRDifferentialScalars
import Solutions.QuotientGeometry.DVRBaseEquivCompletions

namespace Litt3.QuotientGeometry

variable {k B R₁ R₂ : Type*} [Field k]
  [CommRing B] [IsDomain B] [IsDiscreteValuationRing B] [Algebra k B]
  [CommRing R₁] [IsDomain R₁] [IsDiscreteValuationRing R₁] [Algebra k R₁]
  [CommRing R₂] [IsDomain R₂] [IsDiscreteValuationRing R₂] [Algebra k R₂]

/-- A genuine equivalence of the original DVRs over the whole downstairs
local ring forces equality of the invariant evaluated in their actual
residue fields. The hypotheses concern original functions and actual
universal differentials; completed expansions are constructed. -/
theorem original_dvr_base_equiv_differential_scalars_equal
    [IsAlgClosed k] (p h m : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hm : 0 < m) (hdiv : h ∣ p - 1)
    (hchar : (h : k) ≠ 0) (hmchar : (m : k) ≠ 0)
    (dB : DVRCompletionParameters k B) (d₁ : DVRCompletionParameters k R₁)
    (d₂ : DVRCompletionParameters k R₂)
    (χ₁ : B →ₐ[k] R₁) (χ₂ : B →ₐ[k] R₂)
    [IsLocalHom χ₁.toRingHom] [IsLocalHom χ₂.toRingHom]
    (hi₁ : Function.Injective χ₁) (hi₂ : Function.Injective χ₂)
    (e : R₁ ≃ₐ[k] R₂) (he : e.toAlgHom.comp χ₁ = χ₂)
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
  let φ₁ := e.toAlgHom
  let φ₂ := AlgHom.id k R₂
  letI : IsLocalHom φ₁.toRingHom :=
    ⟨fun r hr => (MulEquiv.isUnit_map e).mp hr⟩
  letI : IsLocalHom φ₂.toRingHom := inferInstanceAs (IsLocalHom (RingHom.id R₂))
  have hbase : φ₁.comp χ₁ = φ₂.comp χ₂ := by
    simpa only [φ₁, φ₂, AlgHom.id_comp] using he
  exact original_same_source_dvr_differential_scalars_equal p h m hh hm hdiv hchar hmchar
    dB d₁ d₂ d₂ χ₁ χ₂ φ₁ φ₂ hi₁ hi₂
    (actual_algEquiv_formallyUnramified e)
    (RingHom.FiniteType.of_surjective _ e.surjective).essFiniteType
    (actual_algEquiv_formallyUnramified (AlgEquiv.refl : R₂ ≃ₐ[k] R₂))
    (RingHom.FiniteType.of_surjective _ Function.surjective_id).essFiniteType hbase
    g₁ s₁ g₂ s₂ c hc hg₁ hg₂ hs₁ hs₂ hpolar₁ hpolar₂ hdg₁ hdg₂

end Litt3.QuotientGeometry
