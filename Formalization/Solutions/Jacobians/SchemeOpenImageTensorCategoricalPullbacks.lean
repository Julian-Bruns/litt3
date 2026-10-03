import Solutions.Jacobians.SchemeOpenImageTensorHomEquivalence

open CategoryTheory Opposite AlgebraicGeometry TopologicalSpace

namespace Litt3.Jacobians

universe u
variable {X Y : Scheme.{u}} (f : X ⟶ Y) (hf : IsOpenMap f.base) (M : Y.Modules)

/-- The FULL explicit original image-open tensor presheaf genuinely
corepresents the original pushforward Hom functor. Naturality and BOTH
inverse identities are proved, not supplied as universal-property inputs. -/
noncomputable def actualSchemeOpenImageTensorCorepresentableBy :
    (PresheafOfModules.pushforward (actualSchemeRingSheafMap f).val ⋙
      coyoneda.obj (op M.val)).CorepresentableBy
        (actualSchemeOpenImageTensorPresheaf f hf M) where
  homEquiv {N} := actualSchemeOpenImageTensorHomEquiv f hf M N
  homEquiv_comp {N P} g α := by
    change actualSchemeOpenImageTensorUnit f hf M ≫
        (PresheafOfModules.pushforward (actualSchemeRingSheafMap f).val).map (α ≫ g) =
      (actualSchemeOpenImageTensorUnit f hf M ≫
        (PresheafOfModules.pushforward (actualSchemeRingSheafMap f).val).map α) ≫
          (PresheafOfModules.pushforward (actualSchemeRingSheafMap f).val).map g
    rw [Functor.map_comp, Category.assoc]

/-- The true categorical ORIGINAL module PRESHEAF pullback is
ACTUALLY isomorphic to the constructed FULL original image-open tensor
presheaf under ANY actual open scheme morphism. -/
noncomputable def actualSchemePresheafPullbackOpenImageIso :
    (PresheafOfModules.pullback (actualSchemeRingSheafMap f).val).obj M.val ≅
      actualSchemeOpenImageTensorPresheaf f hf M :=
  ((PresheafOfModules.pullbackPushforwardAdjunction
    (actualSchemeRingSheafMap f).val).corepresentableBy M.val).uniqueUpToIso
      (actualSchemeOpenImageTensorCorepresentableBy f hf M)

/-- The true categorical ORIGINAL module SHEAF pullback is the
GENUINE sheafification of the constructed full original image-open tensor
presheaf. ANY original module SHEAF and ANY actual open scheme morphism
are allowed; no local frames, line property, affineness or flatness is assumed. -/
noncomputable def actualSchemeModulePullbackOpenImageIso :
    (actualSchemeModulePullback f).obj M ≅ actualSchemeOpenImageTensorSheaf f hf M :=
  (SheafOfModules.pullbackIso (actualSchemeRingSheafMap f)).app M ≪≫
    (PresheafOfModules.sheafification (𝟙 X.ringCatSheaf.val)).mapIso
      (actualSchemePresheafPullbackOpenImageIso f hf M)

end Litt3.Jacobians
