import Solutions.QuotientGeometry.CompletedDVRMaps
import Definitions.QuotientGeometry.ParameterFieldComparison
import Mathlib.RingTheory.LaurentSeries

namespace Litt3.QuotientGeometry

variable {k B R₁ R₂ S : Type*} [Field k]
  [CommRing B] [IsDomain B] [IsDiscreteValuationRing B] [Algebra k B]
  [CommRing R₁] [IsDomain R₁] [IsDiscreteValuationRing R₁] [Algebra k R₁]
  [CommRing R₂] [IsDomain R₂] [IsDiscreteValuationRing R₂] [Algebra k R₂]
  [CommRing S] [IsDomain S] [IsDiscreteValuationRing S] [Algebra k S]

local instance {U V W : Type*} [CommRing U] [CommRing V] [CommRing W]
    [Algebra k U] [Algebra k V] [Algebra k W]
    (φ : U →ₐ[k] V) (ψ : V →ₐ[k] W)
    [IsLocalHom φ.toRingHom] [IsLocalHom ψ.toRingHom] :
    IsLocalHom (ψ.comp φ).toRingHom :=
  RingHom.isLocalHom_comp ψ.toRingHom φ.toRingHom

/-- The genuine same-source square of local stalk maps survives actual
completion and the constructed power-series charts on every whole series. -/
theorem same_source_dvr_completed_square
    (dB : DVRCompletionParameters k B) (d₁ : DVRCompletionParameters k R₁)
    (d₂ : DVRCompletionParameters k R₂) (dS : DVRCompletionParameters k S)
    (χ₁ : B →ₐ[k] R₁) (χ₂ : B →ₐ[k] R₂)
    (φ₁ : R₁ →ₐ[k] S) (φ₂ : R₂ →ₐ[k] S)
    [IsLocalHom χ₁.toRingHom] [IsLocalHom χ₂.toRingHom]
    [IsLocalHom φ₁.toRingHom] [IsLocalHom φ₂.toRingHom]
    (hbase : φ₁.comp χ₁ = φ₂.comp χ₂) :
    (completedDVRPowerSeriesMap d₁ dS φ₁).comp (completedDVRPowerSeriesMap dB d₁ χ₁) =
      (completedDVRPowerSeriesMap d₂ dS φ₂).comp (completedDVRPowerSeriesMap dB d₂ χ₂) := by
  rw [completedDVRPowerSeriesMap_comp, completedDVRPowerSeriesMap_comp]
  congr 1

theorem same_source_unramified_dvr_completed_equivalence
    (dB : DVRCompletionParameters k B) (d₁ : DVRCompletionParameters k R₁)
    (d₂ : DVRCompletionParameters k R₂) (dS : DVRCompletionParameters k S)
    (χ₁ : B →ₐ[k] R₁) (χ₂ : B →ₐ[k] R₂)
    (φ₁ : R₁ →ₐ[k] S) (φ₂ : R₂ →ₐ[k] S)
    [IsLocalHom χ₁.toRingHom] [IsLocalHom χ₂.toRingHom]
    [IsLocalHom φ₁.toRingHom] [IsLocalHom φ₂.toRingHom]
    (hu₁ : φ₁.toRingHom.FormallyUnramified) (hf₁ : φ₁.toRingHom.EssFiniteType)
    (hu₂ : φ₂.toRingHom.FormallyUnramified) (hf₂ : φ₂.toRingHom.EssFiniteType)
    (hbase : φ₁.comp χ₁ = φ₂.comp χ₂) :
    ∃ e : PowerSeries k ≃ₐ[k] PowerSeries k,
      ∀ f : PowerSeries k,
        e (completedDVRPowerSeriesMap dB d₁ χ₁ f) =
          completedDVRPowerSeriesMap dB d₂ χ₂ f := by
  let e₁ := unramifiedCompletedDVRPowerSeriesEquiv d₁ dS φ₁ hu₁ hf₁
  let e₂ := unramifiedCompletedDVRPowerSeriesEquiv d₂ dS φ₂ hu₂ hf₂
  refine ⟨e₁.trans e₂.symm, ?_⟩
  intro f
  apply e₂.injective
  change e₂ (e₂.symm (e₁ (completedDVRPowerSeriesMap dB d₁ χ₁ f))) =
    e₂ (completedDVRPowerSeriesMap dB d₂ χ₂ f)
  rw [e₂.apply_symm_apply]
  have h := AlgHom.congr_fun
    (same_source_dvr_completed_square dB d₁ d₂ dS χ₁ χ₂ φ₁ φ₂ hbase) f
  simpa only [← unramifiedCompletedDVRPowerSeriesEquiv_toAlgHom,
    AlgHom.comp_apply, AlgEquiv.toAlgHom_eq_coe, AlgEquiv.coe_algHom, e₁, e₂] using h

/-- Two actual unramified local DVR maps into the SAME source construct
an endpoint Laurent-field isomorphism over the entire original base map.
The original stalk square, not a supplied completed-field identification,
is the input. -/
theorem same_source_unramified_dvr_fields_equivalent
    (dB : DVRCompletionParameters k B) (d₁ : DVRCompletionParameters k R₁)
    (d₂ : DVRCompletionParameters k R₂) (dS : DVRCompletionParameters k S)
    (χ₁ : B →ₐ[k] R₁) (χ₂ : B →ₐ[k] R₂)
    (φ₁ : R₁ →ₐ[k] S) (φ₂ : R₂ →ₐ[k] S)
    [IsLocalHom χ₁.toRingHom] [IsLocalHom χ₂.toRingHom]
    [IsLocalHom φ₁.toRingHom] [IsLocalHom φ₂.toRingHom]
    (hu₁ : φ₁.toRingHom.FormallyUnramified) (hf₁ : φ₁.toRingHom.EssFiniteType)
    (hu₂ : φ₂.toRingHom.FormallyUnramified) (hf₂ : φ₂.toRingHom.EssFiniteType)
    (hbase : φ₁.comp χ₁ = φ₂.comp χ₂)
    (Ψ₁ Ψ₂ : LaurentSeries k →+* LaurentSeries k)
    (hΨ₁ : ∀ f : PowerSeries k, Ψ₁ (f : LaurentSeries k) =
      (completedDVRPowerSeriesMap dB d₁ χ₁ f : PowerSeries k))
    (hΨ₂ : ∀ f : PowerSeries k, Ψ₂ (f : LaurentSeries k) =
      (completedDVRPowerSeriesMap dB d₂ χ₂ f : PowerSeries k)) :
    ParameterFieldsEquivalent Ψ₁ Ψ₂ := by
  obtain ⟨e, he⟩ := same_source_unramified_dvr_completed_equivalence
    dB d₁ d₂ dS χ₁ χ₂ φ₁ φ₂ hu₁ hf₁ hu₂ hf₂ hbase
  letI : SMul k (LaurentSeries k) := (inferInstance : Algebra k (LaurentSeries k)).toSMul
  haveI : IsScalarTower k (PowerSeries k) (LaurentSeries k) :=
    IsScalarTower.of_algebraMap_eq' (R := k) (S := PowerSeries k) (A := LaurentSeries k) rfl
  let E : LaurentSeries k ≃ₐ[k] LaurentSeries k := IsFractionRing.algEquivOfAlgEquiv e
  have hE : E.toRingHom.comp Ψ₁ = Ψ₂ := by
    apply IsFractionRing.ringHom_ext (A := PowerSeries k)
    intro f
    change E (Ψ₁ (f : LaurentSeries k)) = Ψ₂ (f : LaurentSeries k)
    rw [hΨ₁, hΨ₂]
    change E (algebraMap (PowerSeries k) (LaurentSeries k) _) = _
    rw [IsFractionRing.algEquivOfAlgEquiv_algebraMap, he]
    rfl
  exact ⟨E.toRingEquiv, fun r => RingHom.congr_fun hE r⟩

end Litt3.QuotientGeometry
