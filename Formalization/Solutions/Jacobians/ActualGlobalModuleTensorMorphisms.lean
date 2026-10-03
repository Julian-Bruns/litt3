import Solutions.Jacobians.ActualGlobalModuleTensor

open CategoryTheory MonoidalCategory AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u})

noncomputable local instance : MonoidalCategory (PresheafOfModules X.ringCatSheaf.val) :=
  PresheafOfModules.monoidalCategory (R := X.presheaf)

/-- Genuine original module-SHEAF morphisms act on the actual
GLOBAL tensor SHEAF through the honest tensor PRESHEAF and true
module sheafification, on ANY original scheme. -/
noncomputable def actualSchemeModuleTensorHom
    {M M' N N' : X.Modules} (f : M ⟶ M') (g : N ⟶ N') :
    actualSchemeModuleTensorSheaf X M N ⟶ actualSchemeModuleTensorSheaf X M' N' :=
  (PresheafOfModules.sheafification (𝟙 X.ringCatSheaf.val)).map
    (PresheafOfModules.Monoidal.tensorHom (R := X.presheaf) f.val g.val)

theorem actualSchemeModuleTensorHom_id (M N : X.Modules) :
    actualSchemeModuleTensorHom X (𝟙 M) (𝟙 N) =
      𝟙 (actualSchemeModuleTensorSheaf X M N) := by
  change (PresheafOfModules.sheafification (𝟙 X.ringCatSheaf.val)).map
    (𝟙 M.val ⊗ₘ 𝟙 N.val) = _
  rw [MonoidalCategory.id_tensorHom_id]
  exact (PresheafOfModules.sheafification (𝟙 X.ringCatSheaf.val)).map_id _

theorem actualSchemeModuleTensorHom_comp
    {M₁ M₂ M₃ N₁ N₂ N₃ : X.Modules}
    (f₁ : M₁ ⟶ M₂) (f₂ : M₂ ⟶ M₃) (g₁ : N₁ ⟶ N₂) (g₂ : N₂ ⟶ N₃) :
    actualSchemeModuleTensorHom X f₁ g₁ ≫ actualSchemeModuleTensorHom X f₂ g₂ =
      actualSchemeModuleTensorHom X (f₁ ≫ f₂) (g₁ ≫ g₂) := by
  change (PresheafOfModules.sheafification (𝟙 X.ringCatSheaf.val)).map (f₁.val ⊗ₘ g₁.val) ≫
    (PresheafOfModules.sheafification (𝟙 X.ringCatSheaf.val)).map (f₂.val ⊗ₘ g₂.val) =
    (PresheafOfModules.sheafification (𝟙 X.ringCatSheaf.val)).map
      ((f₁.val ≫ f₂.val) ⊗ₘ (g₁.val ≫ g₂.val))
  rw [← CategoryTheory.Functor.map_comp, MonoidalCategory.tensorHom_comp_tensorHom]

/-- Left tensor by a genuine original SHEAF is an honest functor
on the actual original module-SHEAF category. -/
noncomputable def actualSchemeModuleLeftTensorFunctor (M : X.Modules) :
    X.Modules ⥤ X.Modules where
  obj N := actualSchemeModuleTensorSheaf X M N
  map f := actualSchemeModuleTensorHom X (𝟙 M) f
  map_id N := actualSchemeModuleTensorHom_id X M N
  map_comp f g := by
    simpa only [Category.id_comp] using
      (actualSchemeModuleTensorHom_comp X (𝟙 M) (𝟙 M) f g).symm

noncomputable def actualSchemeModuleRightTensorFunctor (N : X.Modules) :
    X.Modules ⥤ X.Modules where
  obj M := actualSchemeModuleTensorSheaf X M N
  map f := actualSchemeModuleTensorHom X f (𝟙 N)
  map_id M := actualSchemeModuleTensorHom_id X M N
  map_comp f g := by
    simpa only [Category.id_comp] using
      (actualSchemeModuleTensorHom_comp X f g (𝟙 N) (𝟙 N)).symm

end Litt3.Jacobians
