import Solutions.CartierAndSpin.ActualUnitTorsionCartierLinear
import Solutions.SharedTensors.SchemeFunctionFieldGeneration
import Solutions.SharedTensors.SchemeFieldTowers
import Definitions.SharedTensors.SchemeUnitQuotients

open CategoryTheory AlgebraicGeometry

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] [PerfectField k]
  {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  (s : FiniteEtaleSpan X Y) [IsIntegral s.source]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
  (sY : Y ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sY]
  (hbase : s.right ≫ sY = s.left ≫ sX)
  {p : ℕ} [Fact p.Prime] [CharP k p]

/-- The exact characteristic-primary isomorphism on an ACTUAL smooth
two-leg finite etale span, retaining both original generic-stalk maps
from the SAME source. Every finite-generation, transcendence-degree,
separability, source-smoothness and scalar-tower fact is derived from the
original morphisms. Properness and genus restrictions are unnecessary. -/
noncomputable def actual_smooth_etale_span_unit_torsion_cartier_equiv
    (hintersection : EndpointFieldIntersectionConstants
      (genericBaseFieldHom sX) (genericBaseFieldHom sY)
      (schemeFunctionFieldPullback s.left) (schemeFunctionFieldPullback s.right))
    (CE : letI := (genericBaseFieldHom (s.left ≫ sX)).toAlgebra
      RationalCartierOperator k s.source.functionField p) :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := (genericBaseFieldHom sY).toAlgebra
    letI := (genericBaseFieldHom (s.left ≫ sX)).toAlgebra
    letI := (schemeFunctionFieldPullback s.left).toAlgebra
    letI := (schemeFunctionFieldPullback s.right).toAlgebra
    letI := actualFunctionFieldBaseTower s.left sX (s.left ≫ sX) rfl
    letI := actualFunctionFieldBaseTower s.right sY (s.left ≫ sX) hbase
    powerTorsionSubgroup s.unitRelationQuotient p ≃ₗ[ZMod p]
      sharedIntrinsicCartierFixedForms k X.functionField Y.functionField
        s.source.functionField CE := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := (genericBaseFieldHom sY).toAlgebra
  letI := (genericBaseFieldHom (s.left ≫ sX)).toAlgebra
  letI := (schemeFunctionFieldPullback s.left).toAlgebra
  letI := (schemeFunctionFieldPullback s.right).toAlgebra
  letI := actualFunctionFieldBaseTower s.left sX (s.left ≫ sX) rfl
  letI := actualFunctionFieldBaseTower s.right sY (s.left ≫ sX) hbase
  letI : IsSmoothOfRelativeDimension 1 (s.left ≫ sX) := by
    have h : IsSmoothOfRelativeDimension (0 + 1) (s.left ≫ sX) := inferInstance
    exact h
  letI : IsSmooth sX := IsSmoothOfRelativeDimension.isSmooth 1 sX
  letI : IsSmooth sY := IsSmoothOfRelativeDimension.isSmooth 1 sY
  letI : IsSmooth (s.left ≫ sX) :=
    IsSmoothOfRelativeDimension.isSmooth 1 (s.left ≫ sX)
  letI : Algebra.IsSeparable X.functionField s.source.functionField :=
    (actual_unramified_function_field_finite_separable s.left).2
  letI : Algebra.IsSeparable Y.functionField s.source.functionField :=
    (actual_unramified_function_field_finite_separable s.right).2
  exact actual_unit_quotient_p_torsion_cartier_linear_equiv
    (actual_locally_finite_type_function_field_finitely_generated sX)
    (actual_smooth_function_field_transcendence_degree sX 1)
    (actual_locally_finite_type_function_field_finitely_generated sY)
    (actual_smooth_function_field_transcendence_degree sY 1)
    (actual_locally_finite_type_function_field_finitely_generated (s.left ≫ sX))
    (actual_smooth_function_field_transcendence_degree (s.left ≫ sX) 1)
    hintersection CE

end Litt3.CartierAndSpin
