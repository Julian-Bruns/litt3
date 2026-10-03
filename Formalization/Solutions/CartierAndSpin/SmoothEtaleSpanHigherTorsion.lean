import Solutions.CartierAndSpin.ActualHigherUnitTorsion
import Solutions.CartierAndSpin.SmoothEtaleSpanPowerCriterion

open CategoryTheory AlgebraicGeometry

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  (s : FiniteEtaleSpan X Y) [IsIntegral s.source]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
  (sY : Y ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sY]
  (hbase : s.right ≫ sY = s.left ≫ sX)
  {p : ℕ} [Fact p.Prime] [CharP k p]

include hbase

/-- At every finite height, the ORIGINAL multiplicative quotient of
both genuine finite etale maps from the SAME smooth source has a
finite cyclic p^n-kernel of size at most p^n. No supplied Cartier,
function-field presentation, shared rank, ambient finite group or
simultaneous closure is an input. -/
theorem actual_smooth_etale_span_all_primary_heights_finite_cyclic
    (hintersection : EndpointFieldIntersectionConstants
      (genericBaseFieldHom sX) (genericBaseFieldHom sY)
      (schemeFunctionFieldPullback s.left) (schemeFunctionFieldPullback s.right))
    (n : ℕ) :
    Finite (powerTorsionSubgroup s.unitRelationQuotient (p ^ n)) ∧
      IsAddCyclic (powerTorsionSubgroup s.unitRelationQuotient (p ^ n)) ∧
      Nat.card (powerTorsionSubgroup s.unitRelationQuotient (p ^ n)) ≤ p ^ n := by
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
  exact actual_unit_quotient_all_primary_heights_finite_cyclic
    (actual_locally_finite_type_function_field_finitely_generated sX)
    (actual_smooth_function_field_transcendence_degree sX 1)
    (actual_locally_finite_type_function_field_finitely_generated sY)
    (actual_smooth_function_field_transcendence_degree sY 1)
    (actual_locally_finite_type_function_field_finitely_generated (s.left ≫ sX))
    (actual_smooth_function_field_transcendence_degree (s.left ≫ sX) 1)
    hintersection n

end Litt3.CartierAndSpin
