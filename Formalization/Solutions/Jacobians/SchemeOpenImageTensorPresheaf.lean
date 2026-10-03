import Solutions.Jacobians.SchemeOpenImageTensorSections

open CategoryTheory Opposite AlgebraicGeometry TopologicalSpace
open scoped TensorProduct ChangeOfRings

namespace Litt3.Jacobians

universe u
variable {X Y : Scheme.{u}} (f : X ⟶ Y) (hf : IsOpenMap f.base) (M : Y.Modules)

/-- The ACTUAL full tensor PRESHEAF under any original open scheme
morphism. Identity and composition of all original varying-ring tensor
restrictions are proved. Sheafification remains a separate genuine step. -/
noncomputable def actualSchemeOpenImageTensorPresheaf :
    PresheafOfModules X.ringCatSheaf.val where
  obj V := actualSchemeOpenImageTensorSection f hf M V.unop
  map i := actualSchemeOpenImageTensorRestriction f hf M i.unop
  map_id V := by
    apply ModuleCat.ExtendScalars.hom_ext
    intro m
    change actualSchemeOpenImageTensorRestriction f hf M (𝟙 V.unop)
        ((1 : Γ(X, V.unop)) ⊗ₜ[Γ(Y, hf.functor.obj V.unop),_ ] m) =
      ((1 : Γ(X, V.unop)) ⊗ₜ[Γ(Y, hf.functor.obj V.unop),_ ] m)
    rw [actualSchemeOpenImageTensorRestriction_tmul]
    simp
    congr 1
    have h := CategoryTheory.congr_fun
      (M.val.presheaf.map_id (op (hf.functor.obj V.unop))) m
    simpa only [Functor.map_id, op_id] using h
  map_comp i j := by
    apply ModuleCat.ExtendScalars.hom_ext
    intro m
    change actualSchemeOpenImageTensorRestriction f hf M (i ≫ j).unop
        ((1 : Γ(X, _)) ⊗ₜ[Γ(Y, hf.functor.obj _),_ ] m) =
      actualSchemeOpenImageTensorRestriction f hf M j.unop
        (actualSchemeOpenImageTensorRestriction f hf M i.unop
          ((1 : Γ(X, _)) ⊗ₜ[Γ(Y, hf.functor.obj _),_ ] m))
    rw [actualSchemeOpenImageTensorRestriction_tmul,
      actualSchemeOpenImageTensorRestriction_tmul,
      actualSchemeOpenImageTensorRestriction_tmul]
    simp only [map_one, Functor.map_comp, unop_comp]
    congr 1
    exact CategoryTheory.congr_fun (M.val.presheaf.map_comp
      (hf.functor.map i.unop).op (hf.functor.map j.unop).op) m

/-- Genuine original module sheafification of the full explicit
open-image tensor presheaf. Identification with the categorical pullback
requires a separate adjunction comparison. -/
noncomputable def actualSchemeOpenImageTensorSheaf : X.Modules :=
  (PresheafOfModules.sheafification (𝟙 X.ringCatSheaf.val)).obj
    (actualSchemeOpenImageTensorPresheaf f hf M)

end Litt3.Jacobians
