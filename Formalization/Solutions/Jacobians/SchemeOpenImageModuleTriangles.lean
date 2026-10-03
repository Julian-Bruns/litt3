import Solutions.Jacobians.SchemeOpenImageTensorSections

open CategoryTheory Opposite AlgebraicGeometry TopologicalSpace

namespace Litt3.Jacobians

universe u
variable {X Y : Scheme.{u}} (f : X ⟶ Y) (hf : IsOpenMap f.base)

/-- Actual whole original module sections satisfy the open-image
unit/counit triangle. The entire original module, not generic values, is
transported under genuine original restrictions. -/
theorem actualSchemeOpenImageModule_unit_counit (M : Y.Modules) (V : X.Opens)
    (m : M.val.obj (op (hf.functor.obj V))) :
    M.val.map (hf.functor.map (hf.adjunction.unit.app V)).op
        (M.val.map (hf.adjunction.counit.app (hf.functor.obj V)).op m) = m := by
  have hcomp := CategoryTheory.congr_fun (M.val.presheaf.map_comp
    (hf.adjunction.counit.app (hf.functor.obj V)).op
    (hf.functor.map (hf.adjunction.unit.app V)).op) m
  have h : (hf.adjunction.counit.app (hf.functor.obj V)).op ≫
      (hf.functor.map (hf.adjunction.unit.app V)).op =
        𝟙 (op (hf.functor.obj V)) := Subsingleton.elim _ _
  rw [h] at hcomp
  exact hcomp.symm.trans
    (CategoryTheory.congr_fun (M.val.presheaf.map_id (op (hf.functor.obj V))) m)

/-- The other actual original-section triangle holds for ANY
original module PRESHEAF; no sheaf or finite-type property is needed. -/
theorem actualSchemeOpenImageModule_counit_unit
    (N : PresheafOfModules X.ringCatSheaf.val) (U : Y.Opens)
    (n : N.obj (op (f ⁻¹ᵁ U))) :
    N.map (hf.adjunction.unit.app (f ⁻¹ᵁ U)).op
        (N.map ((Opens.map f.base).map (hf.adjunction.counit.app U)).op n) = n := by
  have hcomp := CategoryTheory.congr_fun (N.presheaf.map_comp
    ((Opens.map f.base).map (hf.adjunction.counit.app U)).op
    (hf.adjunction.unit.app (f ⁻¹ᵁ U)).op) n
  have h : ((Opens.map f.base).map (hf.adjunction.counit.app U)).op ≫
      (hf.adjunction.unit.app (f ⁻¹ᵁ U)).op =
        𝟙 (op (f ⁻¹ᵁ U)) := Subsingleton.elim _ _
  rw [h] at hcomp
  exact hcomp.symm.trans
    (CategoryTheory.congr_fun (N.presheaf.map_id (op (f ⁻¹ᵁ U))) n)

end Litt3.Jacobians
