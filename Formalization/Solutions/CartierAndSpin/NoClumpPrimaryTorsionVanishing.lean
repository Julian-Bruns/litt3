import Solutions.CartierAndSpin.NoClumpSharedDifferentialVanishing
import Solutions.CartierAndSpin.NoClumpConstantIntersection
import Solutions.CartierAndSpin.ActualHigherUnitTorsion
import Solutions.CartierAndSpin.SmoothEtaleSpanUnitTorsion

set_option maxHeartbeats 1000000
set_option synthInstance.maxHeartbeats 100000

open CategoryTheory AlgebraicGeometry

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  (s : FiniteEtaleSpan X Y) [IsIntegral s.source]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] [IsProper sX]
  (sY : Y ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sY] [IsProper sY]
  (hbase : s.right ≫ sY = s.left ≫ sX)
  {p : ℕ} [Fact p.Prime] [CharP k p]

include sY hbase

/-- For the ORIGINAL two-leg smooth proper finite etale span, literal
no-clump and genuine H0 rank at least two on ONE endpoint eliminate
the ENTIRE actual characteristic-primary multiplicative quotient.
Constant intersection, shared rational vanishing, Cartier existence and
kernel, logarithmic converse and higher torsion are all proved rather
than supplied. No finite-primary or bounded-height premise is needed. -/
theorem actual_no_clump_entire_unit_quotient_primary_zero
    (hno : IsEmpty s.fiberClump)
    (hdimension : 2 ≤ Module.rank k (schemeDifferentialGlobalSections sX)) :
    AddCommGroup.primaryComponent s.unitRelationQuotient p = ⊥ := by
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
  have hinter := actual_no_clump_endpoint_function_field_intersection_constants
    s sX sY hbase hno
  have hz := actual_no_clump_shared_rational_differentials_eq_bot
    s sX sY hbase hno hdimension
  exact actual_unit_quotient_all_primary_torsion_zero
    (actual_locally_finite_type_function_field_finitely_generated sX)
    (actual_smooth_function_field_transcendence_degree sX 1)
    (actual_locally_finite_type_function_field_finitely_generated sY)
    (actual_smooth_function_field_transcendence_degree sY 1)
    (actual_locally_finite_type_function_field_finitely_generated (s.left ≫ sX))
    (actual_smooth_function_field_transcendence_degree (s.left ≫ sX) 1)
    hinter hz

end Litt3.CartierAndSpin
