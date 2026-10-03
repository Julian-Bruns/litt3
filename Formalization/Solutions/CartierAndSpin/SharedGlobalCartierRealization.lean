import Definitions.CartierAndSpin.SharedGlobalCartierFixed
import Solutions.CartierAndSpin.SharedGlobalDifferentialRealization

set_option maxHeartbeats 1000000
set_option synthInstance.maxHeartbeats 100000

open CategoryTheory AlgebraicGeometry

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] [IsAlgClosed k] [PerfectField k]
  {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  (s : FiniteEtaleSpan X Y) [IsIntegral s.source]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
  (sY : Y ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sY]
  (hbase : s.right ≫ sY = s.left ≫ sX)
  {p : ℕ} [Fact p.Prime] [CharP k p]

/-- Genuine shared H0 Cartier realizes exactly the actual intrinsic
rational Cartier, with no clump, rank or regularity premise. -/
theorem actual_shared_H0_cartier_rational_realization :
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
    ∀ a : actualSharedGlobalDifferentialSubspace s sX sY hbase,
      (sharedGlobalDifferentialRationalRealization s sX sY hbase
          (actualSharedGlobalCartier (p := p) s sX sY hbase a)).val =
        (actualSmoothCurveRationalCartier (p := p) (s.left ≫ sX)).toAddHom
          (sharedGlobalDifferentialRationalRealization s sX sY hbase a).val := by
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
  intro a
  exact actualSmoothCurveSheafGlobalCartier_rational (p := p) (s.left ≫ sX) a.val

end Litt3.CartierAndSpin
