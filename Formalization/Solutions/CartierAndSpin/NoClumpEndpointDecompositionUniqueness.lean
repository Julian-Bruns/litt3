import Solutions.CartierAndSpin.NoClumpSharedDifferentialVanishing
import Solutions.CartierAndSpin.ActualEndpointDecompositionTorsor

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

/-- Under actual no-clump and ONE endpoint's genuine H0 rank at least
two, any two ORIGINAL endpoint differential decompositions agree.
Existence of a decomposition is not asserted. This uses the true
universal maps from BOTH original endpoints to the SAME source. -/
theorem actual_no_clump_endpoint_differential_decomposition_unique
    (hno : IsEmpty s.fiberClump)
    (hdimension : 2 ≤ Module.rank k (schemeDifferentialGlobalSections sX)) :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := (genericBaseFieldHom sY).toAlgebra
    letI := (genericBaseFieldHom (s.left ≫ sX)).toAlgebra
    letI := (schemeFunctionFieldPullback s.left).toAlgebra
    letI := (schemeFunctionFieldPullback s.right).toAlgebra
    letI := actualFunctionFieldBaseTower s.left sX (s.left ≫ sX) rfl
    letI := actualFunctionFieldBaseTower s.right sY (s.left ≫ sX) hbase
    ∀ (alpha alpha' : KaehlerDifferential k X.functionField)
      (beta beta' : KaehlerDifferential k Y.functionField),
      KaehlerDifferential.map k k Y.functionField s.source.functionField beta -
          KaehlerDifferential.map k k X.functionField s.source.functionField alpha =
        KaehlerDifferential.map k k Y.functionField s.source.functionField beta' -
          KaehlerDifferential.map k k X.functionField s.source.functionField alpha' →
      alpha = alpha' ∧ beta = beta' := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := (genericBaseFieldHom sY).toAlgebra
  letI := (genericBaseFieldHom (s.left ≫ sX)).toAlgebra
  letI := (schemeFunctionFieldPullback s.left).toAlgebra
  letI := (schemeFunctionFieldPullback s.right).toAlgebra
  letI := actualFunctionFieldBaseTower s.left sX (s.left ≫ sX) rfl
  letI := actualFunctionFieldBaseTower s.right sY (s.left ≫ sX) hbase
  letI : IsSmooth sX := IsSmoothOfRelativeDimension.isSmooth 1 sX
  letI : IsSmooth sY := IsSmoothOfRelativeDimension.isSmooth 1 sY
  letI : Algebra.IsSeparable X.functionField s.source.functionField :=
    (actual_unramified_function_field_finite_separable s.left).2
  letI : Algebra.IsSeparable Y.functionField s.source.functionField :=
    (actual_unramified_function_field_finite_separable s.right).2
  obtain ⟨eF⟩ := one_variable_kaehler_coordinate_exists
    (actual_locally_finite_type_function_field_finitely_generated sX)
    (actual_smooth_function_field_transcendence_degree sX 1)
  obtain ⟨eG⟩ := one_variable_kaehler_coordinate_exists
    (actual_locally_finite_type_function_field_finitely_generated sY)
    (actual_smooth_function_field_transcendence_degree sY 1)
  exact actual_endpoint_decomposition_unique_of_shared_zero eF eG
    (actual_no_clump_shared_rational_differentials_eq_bot s sX sY hbase hno hdimension)

end Litt3.CartierAndSpin
