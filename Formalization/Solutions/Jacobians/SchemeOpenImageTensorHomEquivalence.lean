import Solutions.Jacobians.SchemeOpenImageTensorCocones
import Solutions.Jacobians.SchemeOpenImageTensorAdjunctionUnits
import Solutions.Jacobians.SchemeOpenImageModuleTriangles

open CategoryTheory Opposite AlgebraicGeometry TopologicalSpace
open scoped TensorProduct ChangeOfRings

namespace Litt3.Jacobians

universe u
variable {X Y : Scheme.{u}} (f : X ⟶ Y) (hf : IsOpenMap f.base) (M : Y.Modules)
  (N : PresheafOfModules X.ringCatSheaf.val)

/-- The actual original tensor-unit construction sends a genuine
FULL tensor-presheaf morphism to its true original pushforward morphism. -/
noncomputable def actualSchemeOpenImageTensorToPushforward
    (α : actualSchemeOpenImageTensorPresheaf f hf M ⟶ N) :
    M.val ⟶ (PresheafOfModules.pushforward (actualSchemeRingSheafMap f).val).obj N :=
  actualSchemeOpenImageTensorUnit f hf M ≫
    (PresheafOfModules.pushforward (actualSchemeRingSheafMap f).val).map α

/-- The explicit tensor-presheaf construction satisfies the FULL
original pullback/pushforward Hom equivalence. Both inverse identities
are proved on complete original modules, using the genuine original
open-image unit/counit triangles. -/
noncomputable def actualSchemeOpenImageTensorHomEquiv :
    (actualSchemeOpenImageTensorPresheaf f hf M ⟶ N) ≃
      (M.val ⟶ (PresheafOfModules.pushforward (actualSchemeRingSheafMap f).val).obj N) where
  toFun := actualSchemeOpenImageTensorToPushforward f hf M N
  invFun := actualSchemeOpenImageTensorCocone f hf M N
  left_inv α := by
    apply PresheafOfModules.hom_ext
    intro U
    apply ModuleCat.ExtendScalars.hom_ext
    intro m
    change actualSchemeOpenImageTensorCoconeApp f hf M N
        (actualSchemeOpenImageTensorToPushforward f hf M N α) U.unop
          ((1 : Γ(X, U.unop)) ⊗ₜ[Γ(Y, hf.functor.obj U.unop),_ ] m) =
      α.app U ((1 : Γ(X, U.unop)) ⊗ₜ[Γ(Y, hf.functor.obj U.unop),_ ] m)
    rw [actualSchemeOpenImageTensorCoconeApp_tmul, one_smul]
    change N.map (hf.adjunction.unit.app U.unop).op
        (α.app (op (f ⁻¹ᵁ hf.functor.obj U.unop))
          ((1 : Γ(X, f ⁻¹ᵁ hf.functor.obj U.unop))
            ⊗ₜ[Γ(Y, hf.functor.obj (f ⁻¹ᵁ hf.functor.obj U.unop)),_ ]
              M.val.map (hf.adjunction.counit.app (hf.functor.obj U.unop)).op m)) = _
    have hα := PresheafOfModules.naturality_apply α
      (hf.adjunction.unit.app U.unop).op
        ((1 : Γ(X, f ⁻¹ᵁ hf.functor.obj U.unop))
          ⊗ₜ[Γ(Y, hf.functor.obj (f ⁻¹ᵁ hf.functor.obj U.unop)),_ ]
            M.val.map (hf.adjunction.counit.app (hf.functor.obj U.unop)).op m)
    change α.app U (actualSchemeOpenImageTensorRestriction f hf M
        (hf.adjunction.unit.app U.unop)
          ((1 : Γ(X, f ⁻¹ᵁ hf.functor.obj U.unop))
            ⊗ₜ[Γ(Y, hf.functor.obj (f ⁻¹ᵁ hf.functor.obj U.unop)),_ ]
              M.val.map (hf.adjunction.counit.app (hf.functor.obj U.unop)).op m)) =
      N.map (hf.adjunction.unit.app U.unop).op
        (α.app (op (f ⁻¹ᵁ hf.functor.obj U.unop))
          ((1 : Γ(X, f ⁻¹ᵁ hf.functor.obj U.unop))
            ⊗ₜ[Γ(Y, hf.functor.obj (f ⁻¹ᵁ hf.functor.obj U.unop)),_ ]
              M.val.map (hf.adjunction.counit.app (hf.functor.obj U.unop)).op m)) at hα
    rw [← hα]
    apply congrArg (α.app U)
    exact (actualSchemeOpenImageTensorRestriction_tmul f hf M
      (hf.adjunction.unit.app U.unop) (1 : Γ(X, f ⁻¹ᵁ hf.functor.obj U.unop))
        (show M.val.obj (op (hf.functor.obj (f ⁻¹ᵁ hf.functor.obj U.unop))) from
          M.val.map (hf.adjunction.counit.app (hf.functor.obj U.unop)).op m)).trans
      (by rw [map_one, actualSchemeOpenImageModule_unit_counit]; rfl)
  right_inv g := by
    apply PresheafOfModules.hom_ext
    intro U
    apply ModuleCat.hom_ext
    apply LinearMap.ext
    intro m
    change actualSchemeOpenImageTensorCoconeApp f hf M N g (f ⁻¹ᵁ U.unop)
        ((1 : Γ(X, f ⁻¹ᵁ U.unop))
          ⊗ₜ[Γ(Y, hf.functor.obj (f ⁻¹ᵁ U.unop)),_ ]
            M.val.map (hf.adjunction.counit.app U.unop).op m) = g.app U m
    rw [actualSchemeOpenImageTensorCoconeApp_tmul, one_smul]
    have hg := PresheafOfModules.naturality_apply g (hf.adjunction.counit.app U.unop).op m
    change g.app (op (hf.functor.obj (f ⁻¹ᵁ U.unop)))
        (M.val.map (hf.adjunction.counit.app U.unop).op m) =
      N.map ((Opens.map f.base).map (hf.adjunction.counit.app U.unop)).op (g.app U m) at hg
    rw [hg]
    exact actualSchemeOpenImageModule_counit_unit f hf N U.unop (g.app U m)

end Litt3.Jacobians
