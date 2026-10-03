import Solutions.SharedTensors.DVRRegularDifferentials
import Solutions.QuotientGeometry.SmoothStalkDifferentialInjectivity
import Mathlib.RingTheory.Ideal.Operations

namespace Litt3.QuotientGeometry

open Litt3.SharedTensors

variable {k R K : Type*} [Field k] [PerfectField k]
  [CommRing R] [IsDomain R] [IsDiscreteValuationRing R] [Algebra k R]
  [Field K] [Algebra R K] [IsFractionRing R K]
  [Algebra k K] [IsScalarTower k R K]
variable {p : ℕ} [Fact p.Prime] [CharP k p] [CharP K p]

include p

/-- A genuine original DVR uniformizer supplies a normalized coordinate
on fraction-field differentials. Its separating property is derived from
its FULL Laurent completion image, without assuming algebraicity of the
completion. -/
theorem original_dvr_parameter_field_coordinate_exists
    (d : DVRCompletionParameters k R)
    (hfg : IntermediateField.FG (F := k) (E := K) ⊤)
    (htrdeg : Algebra.trdeg k K = 1) :
    ∃ eK : KaehlerDifferential k K ≃ₗ[K] K,
      eK (KaehlerDifferential.D k K (algebraMap R K d.parameter)) = 1 := by
  letI : Algebra K (LaurentSeries k) := dvrFunctionFieldLaurentAlgebra (K := K) d
  have ht : algebraMap K (LaurentSeries k) (algebraMap R K d.parameter) =
      laurentParameter k := by
    change dvrFunctionFieldCompletion d (algebraMap R K d.parameter) = _
    rw [dvrFunctionFieldCompletion_parameter]
    exact HahnSeries.ofPowerSeries_X
  obtain ⟨b0⟩ := one_variable_power_p_basis_exists (p := p) hfg htrdeg
  obtain ⟨bK, hbK⟩ := power_p_basis_change_parameter_exists b0
    (algebraMap R K d.parameter) (laurent_uniformizer_original_not_pth _ ht)
  obtain ⟨eK, heK⟩ := p_basis_perfect_base_kaehler_coordinate_exists (k := k) bK
  exact ⟨eK, by rwa [hbK] at heK⟩

/-- A true original uniformizer generates the entire original differential
module, once its genuine fraction-localization map is injective. The exact
regular lattice in the fraction field is derived through full completion.
No parameter frame or presentation of the original module is supplied. -/
theorem original_dvr_parameter_differential_bijective
    (d : DVRCompletionParameters k R)
    (hfg : IntermediateField.FG (F := k) (E := K) ⊤)
    (htrdeg : Algebra.trdeg k K = 1)
    (eK : KaehlerDifferential k K ≃ₗ[K] K)
    (heK : eK (KaehlerDifferential.D k K (algebraMap R K d.parameter)) = 1)
    (hinj : Function.Injective (KaehlerDifferential.map k k R K)) :
    Function.Bijective
      (LinearMap.toSpanSingleton R (KaehlerDifferential k R)
        (KaehlerDifferential.D k R d.parameter)) := by
  let f : KaehlerDifferential k R →ₗ[R] K :=
    (eK.toLinearMap.restrictScalars R).comp (KaehlerDifferential.map k k R K)
  have hdt : f (KaehlerDifferential.D k R d.parameter) = 1 := by
    change eK (KaehlerDifferential.map k k R K
      (KaehlerDifferential.D k R d.parameter)) = 1
    rw [KaehlerDifferential.map_D]
    exact heK
  have hf : Function.Injective f := eK.injective.comp hinj
  constructor
  · intro a b hab
    apply (IsFractionRing.injective R K)
    have h := congrArg f hab
    simpa only [LinearMap.toSpanSingleton_apply, map_smul, hdt,
      Algebra.smul_def, mul_one] using h
  · intro omega
    have hreg := (actual_dvr_regular_differential_image_iff
      (p := p) d hfg htrdeg eK heK
      (KaehlerDifferential.map k k R K omega)).mp ⟨omega, rfl⟩
    obtain ⟨r, hr⟩ := hreg
    refine ⟨r, hf ?_⟩
    change f (r • KaehlerDifferential.D k R d.parameter) = f omega
    rw [map_smul, hdt, Algebra.smul_def, mul_one]
    exact hr

/-- The literal original universal differential module is identified with
the original DVR in its actual uniformizer frame. -/
noncomputable def originalDVRParameterDifferentialEquiv
    (d : DVRCompletionParameters k R)
    (hfg : IntermediateField.FG (F := k) (E := K) ⊤)
    (htrdeg : Algebra.trdeg k K = 1)
    (eK : KaehlerDifferential k K ≃ₗ[K] K)
    (heK : eK (KaehlerDifferential.D k K (algebraMap R K d.parameter)) = 1)
    (hinj : Function.Injective (KaehlerDifferential.map k k R K)) :
    R ≃ₗ[R] KaehlerDifferential k R :=
  LinearEquiv.ofBijective
    (LinearMap.toSpanSingleton R (KaehlerDifferential k R)
      (KaehlerDifferential.D k R d.parameter))
    (original_dvr_parameter_differential_bijective (p := p) d hfg htrdeg eK heK hinj)

theorem originalDVRParameterDifferentialEquiv_apply
    (d : DVRCompletionParameters k R)
    (hfg : IntermediateField.FG (F := k) (E := K) ⊤)
    (htrdeg : Algebra.trdeg k K = 1)
    (eK : KaehlerDifferential k K ≃ₗ[K] K)
    (heK : eK (KaehlerDifferential.D k K (algebraMap R K d.parameter)) = 1)
    (hinj : Function.Injective (KaehlerDifferential.map k k R K)) (r : R) :
    originalDVRParameterDifferentialEquiv (p := p) d hfg htrdeg eK heK hinj r =
      r • KaehlerDifferential.D k R d.parameter := rfl

/-- Nonvanishing in the ACTUAL residue fiber forces a unit coefficient
in the original uniformizer differential frame. -/
theorem original_dvr_nonvanishing_differential_unit_slope
    (d : DVRCompletionParameters k R)
    (hfg : IntermediateField.FG (F := k) (E := K) ⊤)
    (htrdeg : Algebra.trdeg k K = 1)
    (eK : KaehlerDifferential k K ≃ₗ[K] K)
    (heK : eK (KaehlerDifferential.D k K (algebraMap R K d.parameter)) = 1)
    (hinj : Function.Injective (KaehlerDifferential.map k k R K))
    (omega : KaehlerDifferential k R)
    (hnonzero : omega ∉ IsLocalRing.maximalIdeal R •
      (⊤ : Submodule R (KaehlerDifferential k R))) :
    ∃ S : R, IsUnit S ∧ omega = S • KaehlerDifferential.D k R d.parameter := by
  let e := originalDVRParameterDifferentialEquiv (p := p) d hfg htrdeg eK heK hinj
  let S := e.symm omega
  have hS : omega = S • KaehlerDifferential.D k R d.parameter := by
    change omega = e S
    exact (e.apply_symm_apply omega).symm
  refine ⟨S, ?_, hS⟩
  apply IsLocalRing.notMem_maximalIdeal.mp
  intro hmem
  apply hnonzero
  rw [hS]
  exact Submodule.smul_mem_smul hmem Submodule.mem_top

end Litt3.QuotientGeometry
