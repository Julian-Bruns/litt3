import Solutions.Jacobians.ActualGlobalModuleTensor

open CategoryTheory MonoidalCategory AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u})

noncomputable local instance : MonoidalCategory (PresheafOfModules X.ringCatSheaf.val) :=
  PresheafOfModules.monoidalCategory (R := X.presheaf)

/-- Genuine original sheaf isomorphisms induce an isomorphism of
the actual GLOBAL sheafified tensor, on an arbitrary original scheme. -/
noncomputable def actualSchemeModuleTensorIso
    {M M' N N' : X.Modules} (e : M ≅ M') (f : N ≅ N') :
    actualSchemeModuleTensorSheaf X M N ≅ actualSchemeModuleTensorSheaf X M' N' :=
  (PresheafOfModules.sheafification (𝟙 X.ringCatSheaf.val)).mapIso
    (((SheafOfModules.forget X.ringCatSheaf).mapIso e) ⊗ᵢ
      ((SheafOfModules.forget X.ringCatSheaf).mapIso f))

/-- Tensoring with any ACTUAL globally trivial original line
SHEAF recovers the original module SHEAF; no affine/global-section
tensor identification or given section generator is assumed. -/
noncomputable def actualSchemeModuleTensorTrivialRightIso
    (M N : X.Modules) (e : N ≅ SheafOfModules.unit X.ringCatSheaf) :
    actualSchemeModuleTensorSheaf X M N ≅ M :=
  actualSchemeModuleTensorIso X (Iso.refl M) e ≪≫
    actualSchemeModuleTensorRightUnitIso X M

noncomputable def actualSchemeModuleTensorTrivialLeftIso
    (M N : X.Modules) (e : M ≅ SheafOfModules.unit X.ringCatSheaf) :
    actualSchemeModuleTensorSheaf X M N ≅ N :=
  actualSchemeModuleTensorIso X e (Iso.refl N) ≪≫
    actualSchemeModuleTensorLeftUnitIso X N

end Litt3.Jacobians
