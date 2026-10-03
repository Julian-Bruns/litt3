import Solutions.Jacobians.SchemeOpenImageTensorCategoricalPullbacks

open CategoryTheory CategoryTheory.Functor Opposite AlgebraicGeometry TopologicalSpace

namespace Litt3.Jacobians

universe u
variable {X Y : Scheme.{u}} (f : X ⟶ Y) (hf : IsOpenMap f.base) (M : Y.Modules)

/-- The genuine presheaf pullback comparison identifies the FULL
Hom equivalences, including the actual unit. -/
theorem actualSchemePresheafPullbackOpenImageIso_homEquiv
    (N : PresheafOfModules X.ringCatSheaf.val)
    (g : actualSchemeOpenImageTensorPresheaf f hf M ⟶ N) :
    (PresheafOfModules.pullbackPushforwardAdjunction (actualSchemeRingSheafMap f).val).homEquiv _ _
      ((actualSchemePresheafPullbackOpenImageIso f hf M).hom ≫ g) =
      actualSchemeOpenImageTensorHomEquiv f hf M N g := by
  let e := (PresheafOfModules.pullbackPushforwardAdjunction
    (actualSchemeRingSheafMap f).val).corepresentableBy M.val
  let e' := actualSchemeOpenImageTensorCorepresentableBy f hf M
  change e.homEquiv ((e.uniqueUpToIso e').hom ≫ g) = e'.homEquiv g
  change e.homEquiv (e.homEquiv.symm (e'.homEquiv (𝟙 _)) ≫ g) = e'.homEquiv g
  rw [e.homEquiv_comp, Equiv.apply_symm_apply, ← e'.homEquiv_eq]

/-- The ACTUAL categorical SHEAF pullback comparison followed by
the GENUINE sheafification lift of the explicit tensor cocone is EXACTLY
the true adjoint map from the original pushforward morphism. This proves
compatibility of the comparison with the actual scheme map, rather than
only abstract isomorphism of its source and target objects. -/
theorem actualSchemeModulePullbackOpenImageIso_cocone
    (N : X.Modules)
    (g : M ⟶ (SheafOfModules.pushforward (actualSchemeRingSheafMap f)).obj N) :
    (actualSchemeModulePullbackOpenImageIso f hf M).hom ≫
      (PresheafOfModules.sheafificationHomEquiv (𝟙 X.ringCatSheaf.val)).symm
        (actualSchemeOpenImageTensorCocone f hf M N.val g.val) =
      ((SheafOfModules.pullbackPushforwardAdjunction (actualSchemeRingSheafMap f)).homEquiv _ _).symm g := by
  let a := SheafOfModules.pullbackPushforwardAdjunction (actualSchemeRingSheafMap f)
  let b := SheafOfModules.PullbackConstruction.adjunction (actualSchemeRingSheafMap f)
  let c := PresheafOfModules.sheafificationAdjunction (𝟙 X.ringCatSheaf.val)
  let e := actualSchemePresheafPullbackOpenImageIso f hf M
  let h := actualSchemeOpenImageTensorCocone f hf M N.val g.val
  let l := (PresheafOfModules.sheafificationHomEquiv (𝟙 X.ringCatSheaf.val)).symm h
  apply (a.homEquiv _ _).injective
  rw [Equiv.apply_symm_apply]
  change a.homEquiv _ _ (((a.leftAdjointUniq b).hom.app M ≫
    (PresheafOfModules.sheafification (𝟙 X.ringCatSheaf.val)).map e.hom) ≫ l) = g
  rw [Category.assoc, a.homEquiv_naturality_right,
    Adjunction.homEquiv_leftAdjointUniq_hom_app, ← b.homEquiv_unit]
  apply (SheafOfModules.fullyFaithfulForget Y.ringCatSheaf).map_injective
  change (PresheafOfModules.pullbackPushforwardAdjunction
    (actualSchemeRingSheafMap f).val).homEquiv _ _
      (c.homEquiv _ _ ((PresheafOfModules.sheafification (𝟙 X.ringCatSheaf.val)).map e.hom ≫ l)) = g.val
  rw [c.homEquiv_naturality_left,
    PresheafOfModules.sheafificationAdjunction_homEquiv_apply,
    Equiv.apply_symm_apply]
  rw [actualSchemePresheafPullbackOpenImageIso_homEquiv]
  exact (actualSchemeOpenImageTensorHomEquiv f hf M N.val).apply_symm_apply g.val

end Litt3.Jacobians
