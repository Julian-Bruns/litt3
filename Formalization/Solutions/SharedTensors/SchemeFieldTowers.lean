import Solutions.SharedTensors.SchemeGenericExtensions
import Solutions.QuotientGeometry.FunctionFieldRecovery
import Solutions.QuotientGeometry.SchemeBaseFields
import Definitions.SharedTensors.SchemeDegrees

open CategoryTheory AlgebraicGeometry

namespace Litt3.SharedTensors

open Litt3.QuotientGeometry
universe u

/-- The actual commuting structure-map triangle supplies the actual
constant-field tower on the actual generic fields. -/
theorem actualFunctionFieldBaseTower
    {k : Type u} [Field k] {Z X : Scheme.{u}} [IsIntegral Z] [IsIntegral X]
    (f : Z ⟶ X) [Surjective f]
    (sX : X ⟶ Spec (.of k)) (sZ : Z ⟶ Spec (.of k)) (hbase : f ≫ sX = sZ) :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := (genericBaseFieldHom sZ).toAlgebra
    letI := (schemeFunctionFieldPullback f).toAlgebra
    IsScalarTower k X.functionField Z.functionField := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := (genericBaseFieldHom sZ).toAlgebra
  letI := (schemeFunctionFieldPullback f).toAlgebra
  apply IsScalarTower.of_algebraMap_eq
  intro c
  exact (DFunLike.congr_fun
    ((generic_field_map_over_iff_constants sZ sX _).mp
      (actual_scheme_function_field_map_over_base sZ sX f hbase)) c).symm

theorem actual_unramified_generic_degree_positive
    {Z X : Scheme.{u}} [IsIntegral Z] [IsIntegral X]
    (f : Z ⟶ X) [Surjective f] [LocallyOfFiniteType f]
    [AlgebraicGeometry.FormallyUnramified f] : 0 < schemeGenericDegree f := by
  letI := (schemeFunctionFieldPullback f).toAlgebra
  letI : Module.Finite X.functionField Z.functionField :=
    (actual_unramified_function_field_finite_separable f).1
  exact Module.finrank_pos

end Litt3.SharedTensors
