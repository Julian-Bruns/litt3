import Solutions.QuotientGeometry.OriginalDVRDifferentialFrame
import Solutions.SharedTensors.SmoothCurveCompletions
import Solutions.SharedTensors.SchemeFunctionFieldGeneration

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

open Litt3.SharedTensors

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
  {p : ℕ} [Fact p.Prime] [CharP k p]

include p

/-- Every actual uniformizer of the original closed smooth curve stalk
gives a frame of the ENTIRE original differential module. Generic field
generation, transcendence degree, separating parameter, original DVR and
full differential localization injectivity are all derived. -/
theorem actual_smooth_curve_original_parameter_differential_frame (x : ClosedPoint X) :
    letI := (stalkBaseFieldHom sX x.val).toAlgebra
    letI := actual_smooth_curve_closed_point_dvr sX x
    ∀ d : DVRCompletionParameters k (X.presheaf.stalk x.val),
      ∃ e : X.presheaf.stalk x.val ≃ₗ[X.presheaf.stalk x.val]
          KaehlerDifferential k (X.presheaf.stalk x.val),
        ∀ r, e r = r • KaehlerDifferential.D k (X.presheaf.stalk x.val) d.parameter := by
  letI := (stalkBaseFieldHom sX x.val).toAlgebra
  letI := actual_smooth_curve_closed_point_dvr sX x
  letI := (genericBaseFieldHom sX).toAlgebra
  letI : IsScalarTower k (X.presheaf.stalk x.val) X.functionField :=
    IsScalarTower.of_algebraMap_eq' (stalk_base_field_generic_compatibility sX x.val).symm
  letI : CharP X.functionField p :=
    charP_of_injective_algebraMap (algebraMap k X.functionField).injective p
  letI : IsSmooth sX := IsSmoothOfRelativeDimension.isSmooth 1 sX
  intro d
  have hfg := actual_locally_finite_type_function_field_finitely_generated sX
  have htrdeg := actual_smooth_function_field_transcendence_degree sX 1
  obtain ⟨eK, heK⟩ := original_dvr_parameter_field_coordinate_exists
    (p := p) (K := X.functionField) d hfg htrdeg
  have hinj := actual_smooth_stalk_differential_map_injective sX 1 x.val
  refine ⟨originalDVRParameterDifferentialEquiv
    (p := p) d hfg htrdeg eK heK hinj, ?_⟩
  intro r
  rfl

/-- Nonvanishing of an original regular differential in the ACTUAL
closed-point residue fiber gives an actual original unit slope relative
to ANY original uniformizer. No slope, local differential basis or
completed differential realization is an assumption. -/
theorem actual_smooth_curve_original_nonvanishing_unit_slope (x : ClosedPoint X) :
    letI := (stalkBaseFieldHom sX x.val).toAlgebra
    letI := actual_smooth_curve_closed_point_dvr sX x
    ∀ (d : DVRCompletionParameters k (X.presheaf.stalk x.val))
      (omega : KaehlerDifferential k (X.presheaf.stalk x.val)),
      omega ∉ IsLocalRing.maximalIdeal (X.presheaf.stalk x.val) •
        (⊤ : Submodule (X.presheaf.stalk x.val)
          (KaehlerDifferential k (X.presheaf.stalk x.val))) →
      ∃ S : X.presheaf.stalk x.val, IsUnit S ∧
        omega = S • KaehlerDifferential.D k (X.presheaf.stalk x.val) d.parameter := by
  letI := (stalkBaseFieldHom sX x.val).toAlgebra
  letI := actual_smooth_curve_closed_point_dvr sX x
  intro d omega hnonzero
  obtain ⟨e, he⟩ := actual_smooth_curve_original_parameter_differential_frame
    (p := p) sX x d
  let S := e.symm omega
  have hS : omega = S • KaehlerDifferential.D k (X.presheaf.stalk x.val) d.parameter := by
    rw [← he S]
    exact (e.apply_symm_apply omega).symm
  refine ⟨S, IsLocalRing.notMem_maximalIdeal.mp ?_, hS⟩
  intro hmem
  apply hnonzero
  rw [hS]
  exact Submodule.smul_mem_smul hmem Submodule.mem_top

end Litt3.QuotientGeometry
