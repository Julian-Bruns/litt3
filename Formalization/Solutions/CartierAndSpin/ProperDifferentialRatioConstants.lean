import Definitions.CartierAndSpin.SchemeDifferentialZeros
import Solutions.CartierAndSpin.PrimitiveDifferentialRatios
import Solutions.CartierAndSpin.SmoothStalkDifferentialCoordinates
import Solutions.SharedTensors.SmoothCurvePointStrata
import Solutions.SharedTensors.ProperSchemeGlobalConstants
import Solutions.SharedTensors.SchemeFunctionFieldGeneration
import Solutions.SharedTensors.SchemeRegularDifferentials
import Solutions.SharedTensors.OneVariableKaehler

set_option maxHeartbeats 1000000
set_option synthInstance.maxHeartbeats 100000

open CategoryTheory AlgebraicGeometry

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
  [UniversallyClosed sX]

/-- A genuine nowhere-zero regular one-form on an original smooth
universally closed curve spans ALL original global regular one-forms.
Local primitive-module division gives an actual everywhere regular
rational ratio, and proper constants make it a literal base constant.
No canonical-degree, genus or line-bundle-trivialization theorem is used. -/
theorem actual_nowhere_zero_regular_differential_spans_global :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ omega nu : KaehlerDifferential k X.functionField,
      omega ≠ 0 → omega ∈ schemeGlobalRegularDifferentials sX →
      nu ∈ schemeGlobalRegularDifferentials sX →
      schemeDifferentialZeroSet sX omega = ∅ →
      ∃ c : k, nu = c • omega := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI : IsSmooth sX := IsSmoothOfRelativeDimension.isSmooth 1 sX
  intro omega nu homega hregomega hregnu hzero
  obtain ⟨e⟩ := one_variable_kaehler_coordinate_exists
    (actual_locally_finite_type_function_field_finitely_generated sX)
    (actual_smooth_function_field_transcendence_degree sX 1)
  have heomega : e omega ≠ 0 := by
    intro h
    apply homega
    exact e.injective (h.trans (map_zero e).symm)
  let f := e nu / e omega
  have hform : nu = f • omega := by
    apply e.injective
    rw [map_smul, smul_eq_mul]
    exact (div_mul_cancel₀ (e nu) heomega).symm
  have hclosed : ∀ x : ClosedPoint X, ∃ r : X.presheaf.stalk x.val,
      algebraMap (X.presheaf.stalk x.val) X.functionField r = f := by
    intro x
    letI := (stalkBaseFieldHom sX x.val).toAlgebra
    letI : IsScalarTower k (X.presheaf.stalk x.val) X.functionField :=
      IsScalarTower.of_algebraMap_eq' (stalk_base_field_generic_compatibility sX x.val).symm
    have hprimitive : ¬ differentialZeroLattice (R := X.presheaf.stalk x.val) omega := by
      have hnot : x ∉ schemeDifferentialZeroSet sX omega := by simp only [hzero, Set.mem_empty_iff_false, not_false_eq_true]
      exact hnot
    have hw := (mem_schemeGlobalRegularDifferentials_iff sX omega).mp hregomega x
    have hv := (mem_schemeGlobalRegularDifferentials_iff sX nu).mp hregnu x
    obtain ⟨r, hr⟩ := actual_primitive_regular_differential_ratio
      (actualSmoothCurveStalkDifferentialCoordinate sX x.val) omega nu hw hv hprimitive
    refine ⟨r, ?_⟩
    have he := congrArg e hr
    rw [map_smul, smul_eq_mul] at he
    exact (eq_div_iff heomega).mpr he
  obtain ⟨c, hc⟩ := actual_universally_closed_regular_rational_function_constant sX f
    ((actual_smooth_curve_closed_regular_iff_everywhere sX f).mp hclosed)
  refine ⟨c, ?_⟩
  rw [hform]
  change f • omega = algebraMap k X.functionField c • omega
  change algebraMap k X.functionField c = f at hc
  rw [hc]

/-- Two actual independent regular one-forms force EVERY nonzero
regular one-form to have a genuine original closed-point zero.
Independence is explicit; no unformalized genus conversion is presumed. -/
theorem actual_independent_regular_differential_forces_zero :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ omega nu : KaehlerDifferential k X.functionField,
      omega ≠ 0 → omega ∈ schemeGlobalRegularDifferentials sX →
      nu ∈ schemeGlobalRegularDifferentials sX →
      (∀ c : k, nu ≠ c • omega) →
      (schemeDifferentialZeroSet sX omega).Nonempty := by
  letI := (genericBaseFieldHom sX).toAlgebra
  intro omega nu homega hregomega hregnu hindependent
  by_contra h
  have hzero : schemeDifferentialZeroSet sX omega = ∅ := Set.not_nonempty_iff_eq_empty.mp h
  obtain ⟨c, hc⟩ := actual_nowhere_zero_regular_differential_spans_global
    sX omega nu homega hregomega hregnu hzero
  exact hindependent c hc

end Litt3.CartierAndSpin
