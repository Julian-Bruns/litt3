import Solutions.Jacobians.ActualGlobalModuleTensor
import Mathlib.CategoryTheory.Sites.Localization

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u})

/-- A TRUE site-locally bijective map from an original module
PRESHEAF to an actual original module SHEAF becomes an ISOMORPHISM
by the genuine module sheafification universal property. -/
theorem actualSchemeModuleSheafificationLift_isIso
    (M : PresheafOfModules.{u} X.ringCatSheaf.val) (N : X.Modules) (f : M ⟶ N.val)
    [PresheafOfModules.IsLocallyInjective (Opens.grothendieckTopology X) f]
    [PresheafOfModules.IsLocallySurjective (Opens.grothendieckTopology X) f] :
    IsIso ((PresheafOfModules.sheafificationHomEquiv (𝟙 X.ringCatSheaf.val)).symm f) := by
  haveI : IsIso ((PresheafOfModules.sheafification (𝟙 X.ringCatSheaf.val)).map f) := by
    haveI : IsIso ((SheafOfModules.toSheaf X.ringCatSheaf).map
        ((PresheafOfModules.sheafification (𝟙 X.ringCatSheaf.val)).map f)) := by
      change IsIso ((presheafToSheaf (Opens.grothendieckTopology X) AddCommGrpCat).map
        ((PresheafOfModules.toPresheaf X.ringCatSheaf.val).map f))
      exact ((Opens.grothendieckTopology X).W_iff _).mp
        ((Opens.grothendieckTopology X).W_of_isLocallyBijective _)
    exact isIso_of_reflects_iso _ (SheafOfModules.toSheaf X.ringCatSheaf)
  have he : (PresheafOfModules.sheafificationAdjunction
      (𝟙 X.ringCatSheaf.val)).homEquiv M N =
        PresheafOfModules.sheafificationHomEquiv (𝟙 X.ringCatSheaf.val) := by
    apply Equiv.ext
    intro g
    exact PresheafOfModules.sheafificationAdjunction_homEquiv_apply
      (𝟙 X.ringCatSheaf.val) g
  rw [← he]
  change IsIso ((PresheafOfModules.sheafification (𝟙 X.ringCatSheaf.val)).map f ≫
    (PresheafOfModules.sheafificationAdjunction (𝟙 X.ringCatSheaf.val)).counit.app N)
  infer_instance

noncomputable def actualSchemeModuleLocallyBijectiveSheafificationIso
    (M : PresheafOfModules.{u} X.ringCatSheaf.val) (N : X.Modules) (f : M ⟶ N.val)
    [PresheafOfModules.IsLocallyInjective (Opens.grothendieckTopology X) f]
    [PresheafOfModules.IsLocallySurjective (Opens.grothendieckTopology X) f] :
    (PresheafOfModules.sheafification (𝟙 X.ringCatSheaf.val)).obj M ≅ N := by
  letI := actualSchemeModuleSheafificationLift_isIso X M N f
  exact asIso ((PresheafOfModules.sheafificationHomEquiv (𝟙 X.ringCatSheaf.val)).symm f)

end Litt3.Jacobians
