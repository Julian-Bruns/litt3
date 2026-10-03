import Solutions.CartierAndSpin.SharedGlobalCartierRealization
import Definitions.CartierAndSpin.PrimeTorsionModules

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

/-- Canonical prime-linear rational realization of the literal
Cartier-fixed subgroup of BOTH true endpoint H0 images. The target is
the actual rational fixed intersection, and no regularity is presumed. -/
noncomputable def actualSharedH0FixedRationalMap :
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
    actualSharedGlobalCartierFixed (p := p) s sX sY hbase →ₗ[ZMod p]
      sharedIntrinsicCartierFixedForms k X.functionField Y.functionField
        s.source.functionField (actualSmoothCurveRationalCartier (p := p) (s.left ≫ sX)) := by
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
  let f : actualSharedGlobalCartierFixed (p := p) s sX sY hbase →+
      sharedIntrinsicCartierFixedForms k X.functionField Y.functionField
        s.source.functionField (actualSmoothCurveRationalCartier (p := p) (s.left ≫ sX)) := {
    toFun := fun a => ⟨(sharedGlobalDifferentialRationalRealization s sX sY hbase a.val).val, by
      constructor
      · exact (sharedGlobalDifferentialRationalRealization s sX sY hbase a.val).property
      · apply (mem_intrinsicCartierFixedSubgroup _ _).mpr
        have ha : actualSharedGlobalCartier (p := p) s sX sY hbase a.val = a.val :=
          sub_eq_zero.mp a.property
        rw [← actual_shared_H0_cartier_rational_realization, ha]⟩
    map_zero' := by apply Subtype.ext; exact map_zero _
    map_add' := by intro a b; apply Subtype.ext; exact map_add _ _ _ }
  exact { f with map_smul' := fun c a => ZMod.map_smul f c a }

end Litt3.CartierAndSpin
