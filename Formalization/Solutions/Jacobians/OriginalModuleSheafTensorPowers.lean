import Solutions.Jacobians.ActualGlobalModuleTensor

open CategoryTheory AlgebraicGeometry

namespace Litt3.Jacobians

universe u

/-- The ACTUAL iterated global sheafified tensor power on ANY
original scheme, with the original structure module as power zero. -/
noncomputable def actualSchemeModuleTensorPower (X : Scheme.{u}) (M : X.Modules) :
    ℕ → X.Modules
  | 0 => SheafOfModules.unit X.ringCatSheaf
  | n + 1 => actualSchemeModuleTensorSheaf X M (actualSchemeModuleTensorPower X M n)

end Litt3.Jacobians
