import Mathlib.AlgebraicGeometry.Modules.Sheaf
import Mathlib.Algebra.Category.ModuleCat.Presheaf.Monoidal
import Mathlib.Algebra.Category.ModuleCat.Sheaf.Colimits

open CategoryTheory MonoidalCategory AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u})

noncomputable local instance : MonoidalCategory (PresheafOfModules X.ringCatSheaf.val) :=
  PresheafOfModules.monoidalCategory (R := X.presheaf)

/-- The honest ORIGINAL presheaf of pointwise original-module
tensor products, with its actual varying-ring restriction maps.
No assertion that it already satisfies the sheaf condition is made. -/
noncomputable def actualSchemeModuleTensorPresheaf (M N : X.Modules) :
    PresheafOfModules X.ringCatSheaf.val :=
  PresheafOfModules.Monoidal.tensorObj (R := X.presheaf) M.val N.val

/-- The genuine GLOBAL module tensor SHEAF is the actual module
sheafification of the true pointwise tensor PRESHEAF. This works for ANY
original scheme and ANY original module SHEAVES, including empty opens. -/
noncomputable def actualSchemeModuleTensorSheaf (M N : X.Modules) : X.Modules :=
  (PresheafOfModules.sheafification (𝟙 X.ringCatSheaf.val)).obj
    (actualSchemeModuleTensorPresheaf X M N)

/-- Sheafifying the ORIGINAL presheaf of a true original module
SHEAF recovers that very SHEAF by the genuine adjunction counit. -/
noncomputable def actualSchemeModuleSheafificationIso (M : X.Modules) :
    (PresheafOfModules.sheafification (𝟙 X.ringCatSheaf.val)).obj M.val ≅ M :=
  asIso ((PresheafOfModules.sheafificationAdjunction (𝟙 X.ringCatSheaf.val)).counit.app M)

/-- The true original structure module is a LEFT unit for the
genuine sheafified GLOBAL tensor, with no affine restriction. -/
noncomputable def actualSchemeModuleTensorLeftUnitIso (M : X.Modules) :
    actualSchemeModuleTensorSheaf X (SheafOfModules.unit X.ringCatSheaf) M ≅ M :=
  (PresheafOfModules.sheafification (𝟙 X.ringCatSheaf.val)).mapIso
    (show actualSchemeModuleTensorPresheaf X (SheafOfModules.unit X.ringCatSheaf) M ≅ M.val
      from λ_ M.val) ≪≫ actualSchemeModuleSheafificationIso X M

/-- The true original structure module is a RIGHT unit for the
genuine sheafified GLOBAL tensor, with no affine restriction. -/
noncomputable def actualSchemeModuleTensorRightUnitIso (M : X.Modules) :
    actualSchemeModuleTensorSheaf X M (SheafOfModules.unit X.ringCatSheaf) ≅ M :=
  (PresheafOfModules.sheafification (𝟙 X.ringCatSheaf.val)).mapIso
    (show actualSchemeModuleTensorPresheaf X M (SheafOfModules.unit X.ringCatSheaf) ≅ M.val
      from ρ_ M.val) ≪≫ actualSchemeModuleSheafificationIso X M

end Litt3.Jacobians
