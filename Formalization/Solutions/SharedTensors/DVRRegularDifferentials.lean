import Solutions.SharedTensors.DVRCompletionRegularity
import Solutions.SharedTensors.DVRIntrinsicCartier
import Solutions.SharedTensors.PBasisDerivativeTransport

namespace Litt3.SharedTensors

open Litt3.QuotientGeometry

variable {k R K : Type*} [Field k] [PerfectField k]
  [CommRing R] [IsDomain R] [IsDiscreteValuationRing R] [Algebra k R]
  [Field K] [Algebra R K] [IsFractionRing R K]
  [Algebra k K] [IsScalarTower k R K]
variable {p : ℕ} [Fact p.Prime] [CharP k p] [CharP K p]

noncomputable local instance dvrRegularDifferentialsLaurentModule :
    Module k (LaurentSeries k) := Algebra.toModule

include p

/-- The differential of every original regular function has an original
regular coefficient in the parameter frame. Regularity is concluded in
R itself from the constructed full completion, not assumed for its derivative. -/
theorem actual_dvr_differential_coefficient_regular
    (d : DVRCompletionParameters k R)
    (hfg : IntermediateField.FG (F := k) (E := K) ⊤)
    (htrdeg : Algebra.trdeg k K = 1)
    (eK : KaehlerDifferential k K ≃ₗ[K] K)
    (heK : eK (KaehlerDifferential.D k K (algebraMap R K d.parameter)) = 1)
    (r : R) :
    eK (KaehlerDifferential.D k K (algebraMap R K r)) ∈ (algebraMap R K).range := by
  letI : Algebra K (LaurentSeries k) := dvrFunctionFieldLaurentAlgebra (K := K) d
  have ht : algebraMap K (LaurentSeries k) (algebraMap R K d.parameter) =
      laurentParameter k := by
    change dvrFunctionFieldCompletion d (algebraMap R K d.parameter) = _
    rw [dvrFunctionFieldCompletion_parameter]
    exact HahnSeries.ofPowerSeries_X
  obtain ⟨b0⟩ := one_variable_power_p_basis_exists (p := p) hfg htrdeg
  obtain ⟨bK, hbK⟩ := power_p_basis_change_parameter_exists b0
    (algebraMap R K d.parameter) (laurent_uniformizer_original_not_pth _ ht)
  obtain ⟨bL, hbL⟩ := laurent_power_p_basis_exists (k := k) (p := p)
  have hb : bL.parameter = dvrFunctionFieldCompletion d bK.parameter := by
    rw [hbL, hbK]
    exact ht.symm
  have hK : eK (KaehlerDifferential.D k K bK.parameter) = 1 := by rwa [hbK]
  have hL : Litt3.CartierAndSpin.laurentDerivation k bL.parameter = 1 := by
    rw [hbL]
    exact laurent_derivation_parameter
  have hd := p_basis_derivative_transport (dvrFunctionFieldCompletion d)
    bK bL hb eK hK (Litt3.CartierAndSpin.laurentDerivation k) hL (algebraMap R K r)
  apply (actual_dvr_regular_iff_completed_power_series d _).mpr
  refine ⟨PowerSeries.derivative k (completedDVRStalkEmbedding d r), ?_⟩
  rw [hd, Litt3.CartierAndSpin.laurentDerivation_apply,
    dvrFunctionFieldCompletion_ring, Litt3.CartierAndSpin.laurent_derivative_powerSeries]

/-- The image of the genuine original universal differential module is
exactly the original regular parameter lattice. No freeness or chosen
presentation of Ω(k,R) is assumed. -/
theorem actual_dvr_regular_differential_image_iff
    (d : DVRCompletionParameters k R)
    (hfg : IntermediateField.FG (F := k) (E := K) ⊤)
    (htrdeg : Algebra.trdeg k K = 1)
    (eK : KaehlerDifferential k K ≃ₗ[K] K)
    (heK : eK (KaehlerDifferential.D k K (algebraMap R K d.parameter)) = 1)
    (omega : KaehlerDifferential k K) :
    (∃ omegaR : KaehlerDifferential k R,
      KaehlerDifferential.map k k R K omegaR = omega) ↔
      eK omega ∈ (algebraMap R K).range := by
  let f : KaehlerDifferential k R →ₗ[R] K :=
    (eK.toLinearMap.restrictScalars R).comp (KaehlerDifferential.map k k R K)
  constructor
  · rintro ⟨omegaR, rfl⟩
    have hle : (⊤ : Submodule R (KaehlerDifferential k R)) ≤
        (LinearMap.range (Algebra.linearMap R K)).comap f := by
      rw [← KaehlerDifferential.span_range_derivation, Submodule.span_le]
      rintro _ ⟨r, rfl⟩
      change eK (KaehlerDifferential.map k k R K (KaehlerDifferential.D k R r)) ∈
        LinearMap.range (Algebra.linearMap R K)
      rw [KaehlerDifferential.map_D]
      exact actual_dvr_differential_coefficient_regular d hfg htrdeg eK heK r
    exact hle (Submodule.mem_top)
  · rintro ⟨r, hr⟩
    have hfdt : f (KaehlerDifferential.D k R d.parameter) = 1 := by
      change eK (KaehlerDifferential.map k k R K
        (KaehlerDifferential.D k R d.parameter)) = 1
      rw [KaehlerDifferential.map_D]
      exact heK
    refine ⟨r • KaehlerDifferential.D k R d.parameter, ?_⟩
    apply eK.injective
    change f (r • KaehlerDifferential.D k R d.parameter) = eK omega
    rw [map_smul, hfdt, Algebra.smul_def, mul_one]
    exact hr

end Litt3.SharedTensors
