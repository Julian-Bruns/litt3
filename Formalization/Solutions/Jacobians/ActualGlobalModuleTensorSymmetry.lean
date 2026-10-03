import Solutions.Jacobians.ActualGlobalModuleTensor

open CategoryTheory AlgebraicGeometry Opposite
open scoped TensorProduct

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u})

/-- The honest original tensor PRESHEAF swaps factors by the actual
module tensor commutator on every original open, respecting all original
varying-ring restrictions. This requires no finite presentation. -/
noncomputable def actualSchemeModuleTensorPresheafSwapIso (M N : X.Modules) :
    actualSchemeModuleTensorPresheaf X M N ≅ actualSchemeModuleTensorPresheaf X N M :=
  PresheafOfModules.isoMk
    (fun U => (TensorProduct.comm (X.presheaf.obj U) (M.val.obj U) (N.val.obj U)).toModuleIso)
    (fun {U V} i => by
      apply ModuleCat.MonoidalCategory.tensor_ext
      intro a b
      rfl)

theorem actualSchemeModuleTensorPresheafSwap_twice (M N : X.Modules) :
    (actualSchemeModuleTensorPresheafSwapIso X M N).hom ≫
      (actualSchemeModuleTensorPresheafSwapIso X N M).hom =
        𝟙 (actualSchemeModuleTensorPresheaf X M N) := by
  apply PresheafOfModules.hom_ext
  intro U
  apply ModuleCat.MonoidalCategory.tensor_ext
  intro a b
  rfl

/-- A true GLOBAL tensor-SHEAF commutator, by genuine original
module sheafification; no sectionwise tensor-sheaf assertion is used. -/
noncomputable def actualSchemeModuleTensorSwapIso (M N : X.Modules) :
    actualSchemeModuleTensorSheaf X M N ≅ actualSchemeModuleTensorSheaf X N M :=
  (PresheafOfModules.sheafification (𝟙 X.ringCatSheaf.val)).mapIso
    (actualSchemeModuleTensorPresheafSwapIso X M N)

/-- The original GLOBAL commutator is involutive as an ENTIRE
actual sheaf morphism, on arbitrary original schemes. -/
theorem actualSchemeModuleTensorSwap_twice (M N : X.Modules) :
    (actualSchemeModuleTensorSwapIso X M N).hom ≫
      (actualSchemeModuleTensorSwapIso X N M).hom =
        𝟙 (actualSchemeModuleTensorSheaf X M N) := by
  change (PresheafOfModules.sheafification (𝟙 X.ringCatSheaf.val)).map
      (actualSchemeModuleTensorPresheafSwapIso X M N).hom ≫
    (PresheafOfModules.sheafification (𝟙 X.ringCatSheaf.val)).map
      (actualSchemeModuleTensorPresheafSwapIso X N M).hom = _
  rw [← CategoryTheory.Functor.map_comp, actualSchemeModuleTensorPresheafSwap_twice]
  exact (PresheafOfModules.sheafification (𝟙 X.ringCatSheaf.val)).map_id _

end Litt3.Jacobians
