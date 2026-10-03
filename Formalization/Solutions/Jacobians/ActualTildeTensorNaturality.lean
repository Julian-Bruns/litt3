import Solutions.Jacobians.ActualTildeOpenTensorProductOriginals
import Solutions.Jacobians.ActualTildeOriginalOpenSpanning
import Mathlib.Algebra.Category.ModuleCat.Presheaf.Monoidal

open CategoryTheory Opposite TopologicalSpace AlgebraicGeometry TensorProduct
open scoped TensorProduct

namespace Litt3.Jacobians

universe u
variable {R : Type u} [CommRing R] (M N : ModuleCat.{u} R)
  [Module.Finite R M] [Module.Projective R M]
  [Module.Finite R N] [Module.Projective R N]

/-- The actual all-open tensor comparison commutes with every genuine
restriction map of the original affine structure sheaf. -/
theorem actualTildeOpenTensorProductEquiv_naturality
    {X Y : (Opens (PrimeSpectrum R))ᵒᵖ} (i : X ⟶ Y) :
    (PresheafOfModules.Monoidal.tensorObj (R := (Spec.structureSheaf R).val)
      M.tilde.val N.tilde.val).map i ≫
        (ModuleCat.restrictScalars ((Spec.structureSheaf R).val.map i).hom).map
          (actualTildeOpenTensorProductEquiv M N Y.unop).toModuleIso.hom =
      (actualTildeOpenTensorProductEquiv M N X.unop).toModuleIso.hom ≫
        (ModuleCat.of R (M ⊗[R] N)).tilde.val.map i := by
  apply ModuleCat.hom_ext
  apply TensorProduct.curry_injective
  apply LinearMap.ext_on_range (actualTildeOriginalOpenSections_span_top M X.unop)
  intro m
  apply LinearMap.ext_on_range (actualTildeOriginalOpenSections_span_top N X.unop)
  intro n
  change actualTildeOpenTensorProductEquiv M N Y.unop
      ((show M.tilde.val.obj Y from ModuleCat.Tilde.toOpen M Y.unop m) ⊗ₜ
        (show N.tilde.val.obj Y from ModuleCat.Tilde.toOpen N Y.unop n)) =
    (ModuleCat.of R (M ⊗[R] N)).tilde.val.map i
      (actualTildeOpenTensorProductEquiv M N X.unop
        ((show M.tilde.val.obj X from ModuleCat.Tilde.toOpen M X.unop m) ⊗ₜ
          (show N.tilde.val.obj X from ModuleCat.Tilde.toOpen N X.unop n)))
  rw [actualTildeOpenTensorProductEquiv_original, actualTildeOpenTensorProductEquiv_original]
  rfl

/-- A genuine isomorphism of module PRESHEAVES, with the actual tensor on
every open and the actual restriction maps, rather than isolated Γ isomorphisms. -/
noncomputable def actualTildeTensorPresheafIso :
    PresheafOfModules.Monoidal.tensorObj (R := (Spec.structureSheaf R).val)
      M.tilde.val N.tilde.val ≅ (ModuleCat.of R (M ⊗[R] N)).tilde.val :=
  PresheafOfModules.isoMk
    (fun X => (actualTildeOpenTensorProductEquiv M N X.unop).toModuleIso)
    (fun _ _ i => actualTildeOpenTensorProductEquiv_naturality M N i)

end Litt3.Jacobians
