import Solutions.Jacobians.SchemeOpenImageRingMaps
import Solutions.Jacobians.ModuleBaseChangeSemilinearMaps

open CategoryTheory Opposite AlgebraicGeometry TopologicalSpace
open scoped TensorProduct ChangeOfRings

namespace Litt3.Jacobians

universe u
variable {X Y : Scheme.{u}} (f : X ⟶ Y) (hf : IsOpenMap f.base) (M : Y.Modules)

/-- The FULL original section tensor on every actual source open:
the original source-open ring tensored with the ENTIRE original module
on its ACTUAL open image. No claim that these pointwise tensors already
form a SHEAF is assumed. -/
noncomputable def actualSchemeOpenImageTensorSection (V : X.Opens) :
    ModuleCat Γ(X, V) :=
  (ModuleCat.extendScalars ((actualSchemeOpenImageRingMap f hf).app (op V)).hom).obj
    (M.val.obj (op (hf.functor.obj V)))

/-- Original module restriction is genuinely semilinear over the
ACTUAL varying original image-open rings. -/
noncomputable def actualSchemeOpenImageModuleRestriction
    {U V : X.Opens} (i : V ⟶ U) :
    M.val.obj (op (hf.functor.obj U)) →ₛₗ[(Y.presheaf.map (hf.functor.map i).op).hom]
      M.val.obj (op (hf.functor.obj V)) where
  toFun := M.val.map (hf.functor.map i).op
  map_add' := map_add _
  map_smul' := M.val.map_smul (hf.functor.map i).op

/-- The actual open-image tensor restriction is constructed on FULL
tensor products using the genuine commutative square of original scalar
maps and the actual original module restriction. -/
noncomputable def actualSchemeOpenImageTensorRestriction
    {U V : X.Opens} (i : V ⟶ U) :
    actualSchemeOpenImageTensorSection f hf M U ⟶
      (ModuleCat.restrictScalars (X.presheaf.map i.op).hom).obj
        (actualSchemeOpenImageTensorSection f hf M V) :=
  ModuleCat.semilinearMapAddEquiv (X.presheaf.map i.op).hom _ _
    (actualModuleBaseChangeSemilinearMap
      ((actualSchemeOpenImageRingMap f hf).app (op U)).hom
      ((actualSchemeOpenImageRingMap f hf).app (op V)).hom
      (Y.presheaf.map (hf.functor.map i).op).hom (X.presheaf.map i.op).hom
      (by
        have h := congrArg CommRingCat.Hom.hom
          ((actualSchemeOpenImageRingMap f hf).naturality i.op)
        exact h.symm)
      _ _ (actualSchemeOpenImageModuleRestriction f hf M i))

/-- Literal pure-tensor formula for every ORIGINAL restriction. -/
theorem actualSchemeOpenImageTensorRestriction_tmul
    {U V : X.Opens} (i : V ⟶ U) (s : Γ(X, U))
    (m : M.val.obj (op (hf.functor.obj U))) :
    actualSchemeOpenImageTensorRestriction f hf M i
        (s ⊗ₜ[Γ(Y, hf.functor.obj U),((actualSchemeOpenImageRingMap f hf).app (op U)).hom] m) =
      X.presheaf.map i.op s
        ⊗ₜ[Γ(Y, hf.functor.obj V),((actualSchemeOpenImageRingMap f hf).app (op V)).hom]
          M.val.map (hf.functor.map i).op m := rfl

end Litt3.Jacobians
