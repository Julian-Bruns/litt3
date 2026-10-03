import Solutions.CartierAndSpin.ActualConstantIntersectionPowerCriterion
import Solutions.CartierAndSpin.SmoothEtaleSpanUnitTorsion

open CategoryTheory AlgebraicGeometry

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.QuotientGeometry Litt3.Jacobians

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  (s : FiniteEtaleSpan X Y) [IsIntegral s.source]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
  (sY : Y ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sY]
  (hbase : s.right ≫ sY = s.left ≫ sX)
  {p : ℕ} [Fact p.Prime] [CharP k p]

/-- Exact quotient p-power/decomposition criterion on BOTH original
finite etale maps from the SAME smooth source. All field finiteness,
transcendence-degree, separability and shared-rank facts are derived
from the actual span and literal constant intersection. -/
theorem actual_smooth_etale_span_power_iff_additive_decomposition
    (hintersection : EndpointFieldIntersectionConstants
      (genericBaseFieldHom sX) (genericBaseFieldHom sY)
      (schemeFunctionFieldPullback s.left) (schemeFunctionFieldPullback s.right))
    (a : Additive s.source.functionFieldˣ) :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := (genericBaseFieldHom sY).toAlgebra
    letI := (genericBaseFieldHom (s.left ≫ sX)).toAlgebra
    letI := (schemeFunctionFieldPullback s.left).toAlgebra
    letI := (schemeFunctionFieldPullback s.right).toAlgebra
    letI := actualFunctionFieldBaseTower s.left sX (s.left ≫ sX) rfl
    letI := actualFunctionFieldBaseTower s.right sY (s.left ≫ sX) hbase
    (∃ q : s.unitRelationQuotient,
      p • q = QuotientAddGroup.mk' (unitRelationMap
        (schemeFunctionFieldPullback s.left) (schemeFunctionFieldPullback s.right)).range a) ↔
    ∃ alpha : KaehlerDifferential k X.functionField,
      ∃ beta : KaehlerDifferential k Y.functionField,
      rationalLogarithmicDifferential k s.source.functionField a =
        actualRationalDifferentialPullback k Y.functionField s.source.functionField beta -
          actualRationalDifferentialPullback k X.functionField s.source.functionField alpha := by
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
  exact actual_constant_intersection_power_iff_additive_decomposition
    (actual_locally_finite_type_function_field_finitely_generated sX)
    (actual_smooth_function_field_transcendence_degree sX 1)
    (actual_locally_finite_type_function_field_finitely_generated sY)
    (actual_smooth_function_field_transcendence_degree sY 1)
    (actual_locally_finite_type_function_field_finitely_generated (s.left ≫ sX))
    (actual_smooth_function_field_transcendence_degree (s.left ≫ sX) 1)
    hintersection a

end Litt3.CartierAndSpin
