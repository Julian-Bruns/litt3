import Solutions.Jacobians.SchemeOpenImageTensorPresheaf
import Solutions.Jacobians.SchemeOpenImageRingTriangles

open CategoryTheory Opposite AlgebraicGeometry TopologicalSpace
open scoped TensorProduct ChangeOfRings

namespace Litt3.Jacobians

universe u
variable {X Y : Scheme.{u}} (f : X ⟶ Y) (hf : IsOpenMap f.base) (M : Y.Modules)

/-- The actual whole-section unit map into the explicit image-open
tensor presheaf, using the genuine original counit restriction and the
actual original ring triangle. -/
noncomputable def actualSchemeOpenImageTensorUnitApp (U : Y.Opens) :
    M.val.obj (op U) ⟶
      ((PresheafOfModules.pushforward (actualSchemeRingSheafMap f).val).obj
        (actualSchemeOpenImageTensorPresheaf f hf M)).obj (op U) :=
  ModuleCat.ofHom
    (X := M.val.obj (op U))
    (Y := ((PresheafOfModules.pushforward (actualSchemeRingSheafMap f).val).obj
      (actualSchemeOpenImageTensorPresheaf f hf M)).obj (op U))
    { toFun := fun m =>
        (1 : Γ(X, f ⁻¹ᵁ U))
          ⊗ₜ[Γ(Y, hf.functor.obj (f ⁻¹ᵁ U)),
            ((actualSchemeOpenImageRingMap f hf).app (op (f ⁻¹ᵁ U))).hom]
            M.val.map (hf.adjunction.counit.app U).op m
      map_add' := fun a b => by rw [map_add, TensorProduct.tmul_add]
      map_smul' := fun r m => by
        let β := ((actualSchemeOpenImageRingMap f hf).app (op (f ⁻¹ᵁ U))).hom
        letI : Module Γ(Y, hf.functor.obj (f ⁻¹ᵁ U)) Γ(X, f ⁻¹ᵁ U) :=
          Module.compHom Γ(X, f ⁻¹ᵁ U) β
        let r' : Γ(Y, hf.functor.obj (f ⁻¹ᵁ U)) :=
          Y.presheaf.map (hf.adjunction.counit.app U).op r
        let m' : M.val.obj (op (hf.functor.obj (f ⁻¹ᵁ U))) :=
          M.val.map (hf.adjunction.counit.app U).op m
        rw [M.val.map_smul]
        change (1 : Γ(X, f ⁻¹ᵁ U)) ⊗ₜ[Γ(Y, hf.functor.obj (f ⁻¹ᵁ U)),β] (r' • m') =
          (f.app U r * 1) ⊗ₜ[Γ(Y, hf.functor.obj (f ⁻¹ᵁ U)),β] m'
        rw [TensorProduct.tmul_smul]
        change (β r' * 1) ⊗ₜ[Γ(Y, hf.functor.obj (f ⁻¹ᵁ U)),β] m' =
          (f.app U r * 1) ⊗ₜ[Γ(Y, hf.functor.obj (f ⁻¹ᵁ U)),β] m'
        have h := actualSchemeOpenImageRingMap_counit_apply f hf U r
        change β r' = f.app U r at h
        rw [h] }

/-- The genuine whole original tensor unit is natural under ALL
original open restrictions, proved from the actual original counit square. -/
noncomputable def actualSchemeOpenImageTensorUnit :
    M.val ⟶ (PresheafOfModules.pushforward (actualSchemeRingSheafMap f).val).obj
      (actualSchemeOpenImageTensorPresheaf f hf M) where
  app U := actualSchemeOpenImageTensorUnitApp f hf M U.unop
  naturality {U V} i := by
    apply ModuleCat.hom_ext
    apply LinearMap.ext
    intro m
    change actualSchemeOpenImageTensorUnitApp f hf M V.unop (M.val.map i m) =
      actualSchemeOpenImageTensorRestriction f hf M ((Opens.map f.base).map i.unop)
        (actualSchemeOpenImageTensorUnitApp f hf M U.unop m)
    change
      (1 : Γ(X, f ⁻¹ᵁ V.unop)) ⊗ₜ[Γ(Y, hf.functor.obj (f ⁻¹ᵁ V.unop)),_ ]
        M.val.map (hf.adjunction.counit.app V.unop).op (M.val.map i m) =
      actualSchemeOpenImageTensorRestriction f hf M ((Opens.map f.base).map i.unop)
        ((1 : Γ(X, f ⁻¹ᵁ U.unop)) ⊗ₜ[Γ(Y, hf.functor.obj (f ⁻¹ᵁ U.unop)),_ ]
          M.val.map (hf.adjunction.counit.app U.unop).op m)
    rw [actualSchemeOpenImageTensorRestriction_tmul, map_one]
    congr 1
    have hleft := CategoryTheory.congr_fun (M.val.presheaf.map_comp
      i (hf.adjunction.counit.app V.unop).op) m
    have hright := CategoryTheory.congr_fun (M.val.presheaf.map_comp
      (hf.adjunction.counit.app U.unop).op
      (hf.functor.map ((Opens.map f.base).map i.unop)).op) m
    exact hleft.symm.trans ((congrArg (fun j => M.val.presheaf.map j m)
      (Subsingleton.elim _ _)).trans hright)

end Litt3.Jacobians
