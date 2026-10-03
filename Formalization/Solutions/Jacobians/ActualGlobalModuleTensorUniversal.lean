import Solutions.Jacobians.ActualGlobalModuleTensor

open CategoryTheory AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u})

/-- The genuine universal property of the GLOBAL tensor SHEAF:
maps into any actual module SHEAF are precisely maps from the true
sectionwise tensor PRESHEAF. No section-surjectivity is postulated. -/
noncomputable def actualSchemeModuleTensorHomEquiv (M N P : X.Modules) :
    (actualSchemeModuleTensorSheaf X M N ⟶ P) ≃
      (actualSchemeModuleTensorPresheaf X M N ⟶ P.val) :=
  PresheafOfModules.sheafificationHomEquiv (𝟙 X.ringCatSheaf.val)

/-- A genuine natural bilinear operation on original open sections
extends UNIQUELY to the entire actual GLOBAL tensor SHEAF. -/
theorem actualSchemeModuleTensor_unique_lift (M N P : X.Modules)
    (h : actualSchemeModuleTensorPresheaf X M N ⟶ P.val) :
    ∃! f : actualSchemeModuleTensorSheaf X M N ⟶ P,
      actualSchemeModuleTensorHomEquiv X M N P f = h := by
  let e := actualSchemeModuleTensorHomEquiv X M N P
  refine ⟨e.symm h, e.apply_symm_apply h, ?_⟩
  intro f hf
  exact e.injective (hf.trans (e.apply_symm_apply h).symm)

end Litt3.Jacobians
