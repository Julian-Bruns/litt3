import Solutions.Jacobians.SchemeOpenImageRingMaps

open CategoryTheory Opposite AlgebraicGeometry TopologicalSpace

namespace Litt3.Jacobians

universe u
variable {X Y : Scheme.{u}} (f : X ⟶ Y) (hf : IsOpenMap f.base)

/-- The true original open-image scalar map, after restricting
from an actual target open to the image of its inverse image, is EXACTLY
the original scheme-open ring map. All maps are whole original sections. -/
theorem actualSchemeOpenImageRingMap_counit (U : Y.Opens) :
    Y.presheaf.map (hf.adjunction.counit.app U).op ≫
        (actualSchemeOpenImageRingMap f hf).app (op (f ⁻¹ᵁ U)) = f.app U := by
  dsimp only [actualSchemeOpenImageRingMap]
  have hnat := f.c.naturality (hf.adjunction.counit.app U).op
  change Y.presheaf.map (hf.adjunction.counit.app U).op ≫
      f.app (hf.functor.obj (f ⁻¹ᵁ U)) =
    f.app U ≫ X.presheaf.map ((Opens.map f.base).map (hf.adjunction.counit.app U)).op at hnat
  rw [← Category.assoc, hnat, Category.assoc]
  change f.app U ≫
    (X.presheaf.map ((Opens.map f.base).map (hf.adjunction.counit.app U)).op ≫
      X.presheaf.map (hf.adjunction.unit.app (f ⁻¹ᵁ U)).op) = f.app U
  rw [← X.presheaf.map_comp]
  have h : ((Opens.map f.base).map (hf.adjunction.counit.app U)).op ≫
      (hf.adjunction.unit.app (f ⁻¹ᵁ U)).op = 𝟙 (op (f ⁻¹ᵁ U)) := Subsingleton.elim _ _
  rw [h, X.presheaf.map_id, Category.comp_id]

/-- Literal element form of the genuine original-ring triangle. -/
theorem actualSchemeOpenImageRingMap_counit_apply (U : Y.Opens) (r : Γ(Y, U)) :
    (actualSchemeOpenImageRingMap f hf).app (op (f ⁻¹ᵁ U))
        (Y.presheaf.map (hf.adjunction.counit.app U).op r) = f.app U r :=
  CategoryTheory.congr_fun (actualSchemeOpenImageRingMap_counit f hf U) r

end Litt3.Jacobians
