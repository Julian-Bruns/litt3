import Solutions.CartierAndSpin.SharedGlobalDifferentialRealization
import Solutions.CartierAndSpin.ActualSharedDifferentialRank
import Solutions.SharedTensors.SchemeFunctionFieldGeneration

set_option maxHeartbeats 1000000
set_option synthInstance.maxHeartbeats 100000

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

/-- Literal original endpoint field intersection in the original
constants forces the ACTUAL shared H0 intersection to be finite and
of dimension at most one. No properness, clump, genus, H0 finiteness,
shared rational regularity, or characteristic premise is needed. -/
theorem actual_endpoint_constants_shared_H0_finite_and_small
    (hinter : EndpointFieldIntersectionConstants
      (genericBaseFieldHom sX) (genericBaseFieldHom sY)
      (schemeFunctionFieldPullback s.left) (schemeFunctionFieldPullback s.right)) :
    Module.Finite k (actualSharedGlobalDifferentialSubspace s sX sY hbase) ∧
      Module.finrank k (actualSharedGlobalDifferentialSubspace s sX sY hbase) ≤ 1 := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := (genericBaseFieldHom sY).toAlgebra
  letI := (genericBaseFieldHom (s.left ≫ sX)).toAlgebra
  letI := (schemeFunctionFieldPullback s.left).toAlgebra
  letI := (schemeFunctionFieldPullback s.right).toAlgebra
  letI := actualFunctionFieldBaseTower s.left sX (s.left ≫ sX) rfl
  letI := actualFunctionFieldBaseTower s.right sY (s.left ≫ sX) hbase
  letI : IsSmooth sX := IsSmoothOfRelativeDimension.isSmooth 1 sX
  letI : IsSmooth sY := IsSmoothOfRelativeDimension.isSmooth 1 sY
  have hsmall := actual_one_variable_shared_space_finite_and_small
    (E := s.source.functionField)
    (actual_locally_finite_type_function_field_finitely_generated sX)
    (actual_smooth_function_field_transcendence_degree sX 1)
    (actual_locally_finite_type_function_field_finitely_generated sY)
    (actual_smooth_function_field_transcendence_degree sY 1) hinter
  letI := hsmall.1
  let f := sharedGlobalDifferentialRationalRealization s sX sY hbase
  have hinj : Function.Injective f :=
    sharedGlobalDifferentialRationalRealization_injective s sX sY hbase
  exact ⟨Module.Finite.of_injective f hinj,
    (LinearMap.finrank_le_finrank_of_injective hinj).trans hsmall.2⟩

end Litt3.CartierAndSpin
