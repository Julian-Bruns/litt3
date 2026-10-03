import Solutions.QuotientGeometry.SameSourceDVRCompletions
import Solutions.QuotientGeometry.DVRCompletedFractionMaps
import Solutions.QuotientGeometry.CommonSourceDifferentialComparison

namespace Litt3.QuotientGeometry

variable {k B R₁ R₂ S : Type*} [Field k]
  [CommRing B] [IsDomain B] [IsDiscreteValuationRing B] [Algebra k B]
  [CommRing R₁] [IsDomain R₁] [IsDiscreteValuationRing R₁] [Algebra k R₁]
  [CommRing R₂] [IsDomain R₂] [IsDiscreteValuationRing R₂] [Algebra k R₂]
  [CommRing S] [IsDomain S] [IsDiscreteValuationRing S] [Algebra k S]

theorem same_source_unramified_dvr_laurent_fields_equivalent
    (dB : DVRCompletionParameters k B) (d₁ : DVRCompletionParameters k R₁)
    (d₂ : DVRCompletionParameters k R₂) (dS : DVRCompletionParameters k S)
    (χ₁ : B →ₐ[k] R₁) (χ₂ : B →ₐ[k] R₂)
    (φ₁ : R₁ →ₐ[k] S) (φ₂ : R₂ →ₐ[k] S)
    [IsLocalHom χ₁.toRingHom] [IsLocalHom χ₂.toRingHom]
    [IsLocalHom φ₁.toRingHom] [IsLocalHom φ₂.toRingHom]
    (hi₁ : Function.Injective χ₁) (hi₂ : Function.Injective χ₂)
    (hu₁ : φ₁.toRingHom.FormallyUnramified) (hf₁ : φ₁.toRingHom.EssFiniteType)
    (hu₂ : φ₂.toRingHom.FormallyUnramified) (hf₂ : φ₂.toRingHom.EssFiniteType)
    (hbase : φ₁.comp χ₁ = φ₂.comp χ₂) :
    ParameterFieldsEquivalent (completedDVRLaurentMap dB d₁ χ₁ hi₁)
      (completedDVRLaurentMap dB d₂ χ₂ hi₂) :=
  same_source_unramified_dvr_fields_equivalent dB d₁ d₂ dS χ₁ χ₂ φ₁ φ₂
    hu₁ hf₁ hu₂ hf₂ hbase _ _
    (completedDVRLaurentMap_power_series dB d₁ χ₁ hi₁)
    (completedDVRLaurentMap_power_series dB d₂ χ₂ hi₂)

/-- Scalar equality follows from the original same-source DVR diagram.
All whole completed-ring and Laurent maps and their comparison are
constructed from those actual maps. -/
theorem same_source_unramified_dvr_weak_scalars_equal
    [IsAlgClosed k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hdiv : h ∣ p - 1)
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
    (ψ₁ ψ₂ : LaurentSeries k)
    (hr₁ : ψ₁ ^ h = completedDVRLaurentMap dB d₁ χ₁ hi₁ (HahnSeries.single (-1) 1))
    (hr₂ : ψ₂ ^ h = completedDVRLaurentMap dB d₂ χ₂ hi₂ (HahnSeries.single (-1) 1))
    (ho₁ : ψ₁.order = -(p : ℤ)) (ho₂ : ψ₂.order = -(p : ℤ))
    (hd₁ : (LaurentSeries.derivative k ψ₁).order = -2)
    (hd₂ : (LaurentSeries.derivative k ψ₂).order = -2) :
    weakPoleScalar p ψ₁ = weakPoleScalar p ψ₂ :=
  (weak_tame_completed_fields_equiv_iff p h hh hdiv
    (completedDVRPowerSeriesMap dB d₁ χ₁) (completedDVRPowerSeriesMap dB d₂ χ₂)
    (completedDVRLaurentMap dB d₁ χ₁ hi₁) (completedDVRLaurentMap dB d₂ χ₂ hi₂)
    (completedDVRLaurentMap_power_series dB d₁ χ₁ hi₁)
    (completedDVRLaurentMap_power_series dB d₂ χ₂ hi₂)
    ψ₁ ψ₂ hr₁ hr₂ ho₁ ho₂ hd₁ hd₂).mp
    (same_source_unramified_dvr_laurent_fields_equivalent dB d₁ d₂ dS χ₁ χ₂ φ₁ φ₂
      hi₁ hi₂ hu₁ hf₁ hu₂ hf₂ hbase)

/-- The exact differential invariant is forced by two genuine local DVR
maps into the SAME source. Neither completion charts, field maps, roots,
weak pole orders nor scalar equality are supplied. -/
theorem same_source_unramified_dvr_differential_scalars_equal
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
    (g₁ g₂ σ₁ σ₂ : PowerSeries k) (c : k) (hc : c ≠ 0)
    (hg₁ : PowerSeries.constantCoeff g₁ ≠ 0) (hg₂ : PowerSeries.constantCoeff g₂ ≠ 0)
    (hσ₁ : PowerSeries.constantCoeff σ₁ ≠ 0) (hσ₂ : PowerSeries.constantCoeff σ₂ ≠ 0)
    (hβ₁ : completedDVRLaurentMap dB d₁ χ₁ hi₁ (HahnSeries.single (-1) 1) =
      HahnSeries.single (-((p * h : ℕ) : ℤ)) 1 * (g₁ : LaurentSeries k) ^ m)
    (hβ₂ : completedDVRLaurentMap dB d₂ χ₂ hi₂ (HahnSeries.single (-1) 1) =
      HahnSeries.single (-((p * h : ℕ) : ℤ)) 1 * (g₂ : LaurentSeries k) ^ m)
    (hdg₁ : PowerSeries.derivative k g₁ = PowerSeries.C c * PowerSeries.X ^ (p - 2) * σ₁)
    (hdg₂ : PowerSeries.derivative k g₂ = PowerSeries.C c * PowerSeries.X ^ (p - 2) * σ₂) :
    localDifferentialScalar p h m c (PowerSeries.constantCoeff g₁) (PowerSeries.constantCoeff σ₁) =
      localDifferentialScalar p h m c (PowerSeries.constantCoeff g₂) (PowerSeries.constantCoeff σ₂) := by
  have hp : 1 < p := (Fact.out : p.Prime).one_lt
  obtain ⟨u₁, hur₁, _⟩ := Litt3.Jacobians.power_series_unit_nth_root h hh hchar (g₁ ^ m)
    (by simpa using pow_ne_zero m hg₁)
  obtain ⟨u₂, hur₂, _⟩ := Litt3.Jacobians.power_series_unit_nth_root h hh hchar (g₂ ^ m)
    (by simpa using pow_ne_zero m hg₂)
  let ψ₁ : LaurentSeries k := HahnSeries.single (-(p : ℤ)) 1 * (u₁ : LaurentSeries k)
  let ψ₂ : LaurentSeries k := HahnSeries.single (-(p : ℤ)) 1 * (u₂ : LaurentSeries k)
  have ho₁ := weak_differential_root_laurent_orders p h m hp hh hm hchar hmchar
    u₁ g₁ σ₁ c hc hg₁ hσ₁ hur₁ hdg₁
  have ho₂ := weak_differential_root_laurent_orders p h m hp hh hm hchar hmchar
    u₂ g₂ σ₂ c hc hg₂ hσ₂ hur₂ hdg₂
  have hs := same_source_unramified_dvr_weak_scalars_equal p h hh hdiv
    dB d₁ d₂ dS χ₁ χ₂ φ₁ φ₂ hi₁ hi₂ hu₁ hf₁ hu₂ hf₂ hbase ψ₁ ψ₂
    (ho₁.2.2.trans hβ₁.symm) (ho₂.2.2.trans hβ₂.symm)
    ho₁.1 ho₂.1 ho₁.2.1 ho₂.2.1
  have hs₁ := weak_laurent_power_root_differential_scalar p h m hp hh hm hdiv hchar hmchar
    u₁ g₁ σ₁ c hc hg₁ hσ₁ hur₁ hdg₁
  have hs₂ := weak_laurent_power_root_differential_scalar p h m hp hh hm hdiv hchar hmchar
    u₂ g₂ σ₂ c hc hg₂ hσ₂ hur₂ hdg₂
  exact hs₁.symm.trans (hs.trans hs₂)

end Litt3.QuotientGeometry
