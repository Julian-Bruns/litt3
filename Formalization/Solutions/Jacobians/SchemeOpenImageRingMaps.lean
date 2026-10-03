import Solutions.Jacobians.ActualSchemeModulePullbacks
import Mathlib.AlgebraicGeometry.Morphisms.UniversallyOpen

open CategoryTheory CategoryTheory.Functor Opposite AlgebraicGeometry TopologicalSpace

namespace Litt3.Jacobians

universe u
variable {X Y : Scheme.{u}} (f : X ⟶ Y) (hf : IsOpenMap f.base)

/-- Under an ACTUAL open scheme morphism, the scalar map on EVERY
original source open uses its ACTUAL open image, the ACTUAL scheme-ring
pullback and the original restriction to that source open. -/
noncomputable def actualSchemeOpenImageRingMap :
    hf.functor.op ⋙ Y.presheaf ⟶ X.presheaf where
  app V := f.app (hf.functor.obj V.unop) ≫
    X.presheaf.map (hf.adjunction.unit.app V.unop).op
  naturality {U V} i := by
    change Y.presheaf.map (hf.functor.map i.unop).op ≫
        (f.app (hf.functor.obj V.unop) ≫ X.presheaf.map (hf.adjunction.unit.app V.unop).op) =
      (f.app (hf.functor.obj U.unop) ≫ X.presheaf.map (hf.adjunction.unit.app U.unop).op) ≫
        X.presheaf.map i
    rw [← Category.assoc, f.c.naturality (hf.functor.map i.unop).op, Category.assoc,
      Category.assoc]
    change f.app (hf.functor.obj U.unop) ≫
        (X.presheaf.map ((Opens.map f.base).map (hf.functor.map i.unop)).op ≫
          X.presheaf.map (hf.adjunction.unit.app V.unop).op) =
      f.app (hf.functor.obj U.unop) ≫
        (X.presheaf.map (hf.adjunction.unit.app U.unop).op ≫ X.presheaf.map i)
    rw [← X.presheaf.map_comp, ← X.presheaf.map_comp]
    congr 2

/-- The actual open-image scalar map has the literal original
scheme pullback/restriction formula, including empty opens. -/
theorem actualSchemeOpenImageRingMap_apply (V : X.Opens)
    (a : Γ(Y, hf.functor.obj V)) :
    (actualSchemeOpenImageRingMap f hf).app (op V) a =
      X.presheaf.map (hf.adjunction.unit.app V).op
        (f.app (hf.functor.obj V) a) := rfl

/-- Full original open-image scalar maps commute with every actual
original restriction square; no stalk or generic-field replacement is used. -/
theorem actualSchemeOpenImageRingMap_naturality
    {U V : X.Opens} (i : V ⟶ U) (a : Γ(Y, hf.functor.obj U)) :
    (actualSchemeOpenImageRingMap f hf).app (op V)
        (Y.presheaf.map (hf.functor.map i).op a) =
      X.presheaf.map i.op ((actualSchemeOpenImageRingMap f hf).app (op U) a) :=
  CategoryTheory.congr_fun ((actualSchemeOpenImageRingMap f hf).naturality i.op) a

/-- Every genuine universally open scheme morphism supplies the
ACTUAL open-image chart maps without an additional topological premise. -/
noncomputable def actualUniversallyOpenSchemeImageRingMap
    [UniversallyOpen f] : f.isOpenMap.functor.op ⋙ Y.presheaf ⟶ X.presheaf :=
  actualSchemeOpenImageRingMap f f.isOpenMap

end Litt3.Jacobians
