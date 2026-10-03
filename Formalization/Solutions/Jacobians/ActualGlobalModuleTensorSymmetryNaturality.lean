import Solutions.Jacobians.ActualGlobalModuleTensorMorphisms
import Solutions.Jacobians.ActualGlobalModuleTensorSymmetry

open CategoryTheory AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u})

/-- Actual presheaf factor swapping is natural for BOTH genuine
original module-SHEAF arguments, with literal tensor action on sections. -/
theorem actualSchemeModuleTensorPresheafSwap_naturality
    {M M' N N' : X.Modules} (f : M ⟶ M') (g : N ⟶ N') :
    PresheafOfModules.Monoidal.tensorHom (R := X.presheaf) f.val g.val ≫
      (actualSchemeModuleTensorPresheafSwapIso X M' N').hom =
    (actualSchemeModuleTensorPresheafSwapIso X M N).hom ≫
      PresheafOfModules.Monoidal.tensorHom (R := X.presheaf) g.val f.val := by
  apply PresheafOfModules.hom_ext
  intro U
  apply ModuleCat.MonoidalCategory.tensor_ext
  intro a b
  rfl

/-- The genuine GLOBAL tensor commutator is natural on the ENTIRE
actual sheaf category over ANY original scheme. -/
theorem actualSchemeModuleTensorSwap_naturality
    {M M' N N' : X.Modules} (f : M ⟶ M') (g : N ⟶ N') :
    actualSchemeModuleTensorHom X f g ≫ (actualSchemeModuleTensorSwapIso X M' N').hom =
      (actualSchemeModuleTensorSwapIso X M N).hom ≫ actualSchemeModuleTensorHom X g f := by
  change (PresheafOfModules.sheafification (𝟙 X.ringCatSheaf.val)).map
      (PresheafOfModules.Monoidal.tensorHom (R := X.presheaf) f.val g.val) ≫
    (PresheafOfModules.sheafification (𝟙 X.ringCatSheaf.val)).map
      (actualSchemeModuleTensorPresheafSwapIso X M' N').hom =
    (PresheafOfModules.sheafification (𝟙 X.ringCatSheaf.val)).map
      (actualSchemeModuleTensorPresheafSwapIso X M N).hom ≫
    (PresheafOfModules.sheafification (𝟙 X.ringCatSheaf.val)).map
      (PresheafOfModules.Monoidal.tensorHom (R := X.presheaf) g.val f.val)
  rw [← CategoryTheory.Functor.map_comp, ← CategoryTheory.Functor.map_comp,
    actualSchemeModuleTensorPresheafSwap_naturality]

end Litt3.Jacobians
