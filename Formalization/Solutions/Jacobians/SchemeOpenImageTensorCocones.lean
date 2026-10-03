import Solutions.Jacobians.SchemeOpenImageTensorPresheaf

open CategoryTheory Opposite AlgebraicGeometry TopologicalSpace
open scoped TensorProduct ChangeOfRings

namespace Litt3.Jacobians

universe u
variable {X Y : Scheme.{u}} (f : X ⟶ Y) (hf : IsOpenMap f.base) (M : Y.Modules)
  (N : PresheafOfModules X.ringCatSheaf.val)
  (g : M.val ⟶ (PresheafOfModules.pushforward (actualSchemeRingSheafMap f).val).obj N)

/-- Actual image-open sections of a pushforward morphism give a
genuine original scalar-linear map into the FULL source-open module, by
the original restriction from the inverse image of the image. -/
noncomputable def actualSchemeOpenImageTensorCoconeSection (V : X.Opens) :
    M.val.obj (op (hf.functor.obj V)) ⟶
      (ModuleCat.restrictScalars
        ((actualSchemeOpenImageRingMap f hf).app (op V)).hom).obj (N.obj (op V)) :=
  ModuleCat.ofHom
    (X := M.val.obj (op (hf.functor.obj V)))
    (Y := (ModuleCat.restrictScalars
      ((actualSchemeOpenImageRingMap f hf).app (op V)).hom).obj (N.obj (op V)))
    { toFun := fun m => N.map (hf.adjunction.unit.app V).op
        (g.app (op (hf.functor.obj V)) m)
      map_add' := fun a b => by rw [map_add, map_add]
      map_smul' := fun r m => by
        have h := (g.app (op (hf.functor.obj V))).hom.map_smul r m
        change g.app (op (hf.functor.obj V)) (r • m) =
          f.app (hf.functor.obj V) r •
            (show N.obj (op (f ⁻¹ᵁ hf.functor.obj V)) from
              g.app (op (hf.functor.obj V)) m) at h
        rw [h, N.map_smul]
        rfl }

/-- The actual tensor universal property extends every original
pushforward morphism to a FULL source-open tensor-module morphism. -/
noncomputable def actualSchemeOpenImageTensorCoconeApp (V : X.Opens) :
    actualSchemeOpenImageTensorSection f hf M V ⟶ N.obj (op V) :=
  ((ModuleCat.extendRestrictScalarsAdj
    ((actualSchemeOpenImageRingMap f hf).app (op V)).hom).homEquiv _ _).symm
      (actualSchemeOpenImageTensorCoconeSection f hf M N g V)

/-- Literal universal-map formula on all original pure tensors. -/
theorem actualSchemeOpenImageTensorCoconeApp_tmul (V : X.Opens)
    (s : Γ(X, V)) (m : M.val.obj (op (hf.functor.obj V))) :
    actualSchemeOpenImageTensorCoconeApp f hf M N g V
        (s ⊗ₜ[Γ(Y, hf.functor.obj V),((actualSchemeOpenImageRingMap f hf).app (op V)).hom] m) =
      s • N.map (hf.adjunction.unit.app V).op (g.app (op (hf.functor.obj V)) m) := rfl

/-- The tensor universal maps are natural on EVERY original open,
including empty opens. Compatibility is proved from the actual original
pushforward morphism and original restriction squares. -/
noncomputable def actualSchemeOpenImageTensorCocone :
    actualSchemeOpenImageTensorPresheaf f hf M ⟶ N where
  app V := actualSchemeOpenImageTensorCoconeApp f hf M N g V.unop
  naturality {U V} i := by
    apply ModuleCat.ExtendScalars.hom_ext
    intro m
    change actualSchemeOpenImageTensorCoconeApp f hf M N g V.unop
        (actualSchemeOpenImageTensorRestriction f hf M i.unop
          ((1 : Γ(X, U.unop)) ⊗ₜ[Γ(Y, hf.functor.obj U.unop),_ ] m)) =
      N.map i (actualSchemeOpenImageTensorCoconeApp f hf M N g U.unop
        ((1 : Γ(X, U.unop)) ⊗ₜ[Γ(Y, hf.functor.obj U.unop),_ ] m))
    rw [actualSchemeOpenImageTensorRestriction_tmul,
      actualSchemeOpenImageTensorCoconeApp_tmul,
      actualSchemeOpenImageTensorCoconeApp_tmul, map_one, one_smul, one_smul]
    have hg := PresheafOfModules.naturality_apply g (hf.functor.map i.unop).op m
    change g.app (op (hf.functor.obj V.unop)) (M.val.map (hf.functor.map i.unop).op m) =
      N.map ((Opens.map f.base).map (hf.functor.map i.unop)).op
        (g.app (op (hf.functor.obj U.unop)) m) at hg
    rw [hg]
    have hleft := CategoryTheory.congr_fun (N.presheaf.map_comp
      ((Opens.map f.base).map (hf.functor.map i.unop)).op
      (hf.adjunction.unit.app V.unop).op) (g.app (op (hf.functor.obj U.unop)) m)
    have hright := CategoryTheory.congr_fun (N.presheaf.map_comp
      (hf.adjunction.unit.app U.unop).op i) (g.app (op (hf.functor.obj U.unop)) m)
    exact hleft.symm.trans ((congrArg (fun j => N.presheaf.map j
      (g.app (op (hf.functor.obj U.unop)) m)) (Subsingleton.elim _ _)).trans hright)

end Litt3.Jacobians
