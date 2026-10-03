import Definitions.CartierAndSpin.SchemeDifferentialPoles
import Solutions.SharedTensors.SchemeRegularDifferentials
import Solutions.SharedTensors.SmoothCurveFiniteSupport
import Solutions.SharedTensors.NormalizedSeparatingCoordinates
import Solutions.SharedTensors.SchemeFunctionFieldGeneration
import Solutions.SharedTensors.DivisorSectionOrders
import Solutions.CartierAndSpin.NormalizedDVRBoundary

set_option maxHeartbeats 1000000
set_option synthInstance.maxHeartbeats 100000

open CategoryTheory AlgebraicGeometry

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.QuotientGeometry Litt3.Jacobians
open scoped WithZero

universe u

variable {k : Type u} [Field k] {X : Scheme.{u}} [IsIntegral X]

/-- Actual regular coefficient and function germs give an actual
original stalk representative of f·dg. No differential frame,
valuation bound or regularity conclusion is supplied. -/
theorem actual_regular_coefficient_derivative_mem_local
    (sX : X ⟶ Spec (.of k)) (x : X) :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ f g : X.functionField,
      (∃ a : X.presheaf.stalk x, algebraMap (X.presheaf.stalk x) X.functionField a = f) →
      (∃ b : X.presheaf.stalk x, algebraMap (X.presheaf.stalk x) X.functionField b = g) →
      f • KaehlerDifferential.D k X.functionField g ∈ schemeLocalRegularDifferentials sX x := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := (stalkBaseFieldHom sX x).toAlgebra
  letI : IsScalarTower k (X.presheaf.stalk x) X.functionField :=
    IsScalarTower.of_algebraMap_eq' (stalk_base_field_generic_compatibility sX x).symm
  rintro f g ⟨a, rfl⟩ ⟨b, rfl⟩
  refine ⟨a • KaehlerDifferential.D k (X.presheaf.stalk x) b, ?_⟩
  change KaehlerDifferential.map k k (X.presheaf.stalk x) X.functionField
      (a • KaehlerDifferential.D k (X.presheaf.stalk x) b) = _
  rw [map_smul, KaehlerDifferential.map_D, IsScalarTower.algebraMap_smul]

/-- Every actual rational differential on a quasi-compact smooth
integral curve has finitely many genuine original poles, in ANY
characteristic. Expressing it as f·dg bounds its pole set by two
actual finite principal-divisor supports; no finite pole support is
assumed and no completion replaces the original stalk images. -/
theorem actual_compact_smooth_rational_differential_poles_finite
    [IsAlgClosed k] [CompactSpace X]
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ omega : KaehlerDifferential k X.functionField,
      (schemeDifferentialPoleSet sX omega).Finite := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := actual_smooth_curve_closed_point_dvr_stalks sX
  letI := actual_compact_smooth_curve_finite_principal_support sX
  letI : IsSmooth sX := IsSmoothOfRelativeDimension.isSmooth 1 sX
  intro omega
  obtain ⟨g, e, hg, _, he⟩ := one_variable_normalized_coordinate_exists
    (actual_locally_finite_type_function_field_finitely_generated sX)
    (actual_smooth_function_field_transcendence_degree sX 1)
  let f := e omega
  have hform : omega = f • KaehlerDifferential.D k X.functionField g := by
    apply e.injective
    rw [map_smul, he, smul_eq_mul, mul_one]
  by_cases hf : f = 0
  · have hzero : omega = 0 := by simpa only [hf, zero_smul] using hform
    have hpoles : schemeDifferentialPoleSet sX omega = ∅ := by
      ext x
      simp only [schemeDifferentialPoleSet, Set.mem_setOf_eq, hzero,
        Submodule.zero_mem, not_true_eq_false, Set.mem_empty_iff_false]
    rw [hpoles]
    exact Set.finite_empty
  have hgzero : g ≠ 0 := by
    intro h
    subst g
    exact hg isAlgebraic_zero
  let uf : Additive X.functionFieldˣ := Additive.ofMul (Units.mk0 f hf)
  let ug : Additive X.functionFieldˣ := Additive.ofMul (Units.mk0 g hgzero)
  apply ((FinitePrincipalSupport.finite_support uf).union
    (FinitePrincipalSupport.finite_support ug)).subset
  intro x hpole
  by_contra hout
  have hof : valuationOrder (closedPointValuation X x) uf = 0 := by
    by_contra h
    exact hout (Or.inl h)
  have hog : valuationOrder (closedPointValuation X x) ug = 0 := by
    by_contra h
    exact hout (Or.inr h)
  have hvf : closedPointValuation X x f = 1 := by
    have h := valuation_value_eq_exp_neg_order (closedPointValuation X x) uf
    simpa only [hof, neg_zero, WithZero.exp_zero] using h
  have hvg : closedPointValuation X x g = 1 := by
    have h := valuation_value_eq_exp_neg_order (closedPointValuation X x) ug
    simpa only [hog, neg_zero, WithZero.exp_zero] using h
  have hv := dvr_height_one_valuation_integers (R := X.presheaf.stalk x.val)
    (K := X.functionField)
  obtain ⟨a, ha⟩ := hv.exists_of_le_one (le_of_eq hvf)
  obtain ⟨b, hb⟩ := hv.exists_of_le_one (le_of_eq hvg)
  apply hpole
  rw [hform]
  exact actual_regular_coefficient_derivative_mem_local sX x.val f g ⟨a, ha⟩ ⟨b, hb⟩

end Litt3.CartierAndSpin
