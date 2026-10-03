import Solutions.Jacobians.ActualTildeScalarMaps
import Solutions.Jacobians.ActualSheafOpenScalars
import Solutions.Jacobians.OriginalInvertibleFrames

open CategoryTheory Opposite TopologicalSpace AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable {R : Type u} [CommRing R] {M N : ModuleCat.{u} R}

/-- Genuine inverse-up-to-an-original-scalar maps give a true SHEAF isomorphism
on the actual basic open where that scalar is invertible. -/
noncomputable def actualTildeBasicOpenIso (f : M ⟶ N) (g : N ⟶ M) (r : R)
    (hfg : f ≫ g = ModuleCat.ofHom (r • (LinearMap.id : M →ₗ[R] M)))
    (hgf : g ≫ f = ModuleCat.ofHom (r • (LinearMap.id : N →ₗ[R] N))) :
    M.tilde.over (PrimeSpectrum.basicOpen r) ≅ N.tilde.over (PrimeSpectrum.basicOpen r) := by
  let U := PrimeSpectrum.basicOpen r
  let c : ((Spec.structureSheaf R).val.obj (op U))ˣ :=
    (StructureSheaf.isUnit_to_basicOpen_self R r).unit
  have hc : c.val = StructureSheaf.toOpen R U r :=
    (StructureSheaf.isUnit_to_basicOpen_self R r).unit_spec
  let F := actualSheafOverFunctor (R := R) U
  refine
    { hom := F.map (actualTildeMap f)
      inv := F.map (actualTildeMap g) ≫ actualSheafOverScalarEnd M.tilde U c.inv
      hom_inv_id := ?_
      inv_hom_id := ?_ }
  · apply SheafOfModules.hom_ext
    apply PresheafOfModules.hom_ext
    intro X
    apply ModuleCat.hom_ext
    apply LinearMap.ext
    intro s
    change (Spec.structureSheaf R).val.map X.unop.hom.op c.inv •
      (actualTildeMap g).val.app (op X.unop.left)
        ((actualTildeMap f).val.app (op X.unop.left) s) = s
    rw [actualTilde_composite_apply M f g r hfg]
    have hres : StructureSheaf.toOpen R X.unop.left r =
        (Spec.structureSheaf R).val.map X.unop.hom.op c.val := by
      rw [hc]
      rfl
    have hz : (Spec.structureSheaf R).val.map X.unop.hom.op c.inv *
        (Spec.structureSheaf R).val.map X.unop.hom.op c.val = 1 := by
      rw [← ((Spec.structureSheaf R).val.map X.unop.hom.op).hom.map_mul,
        c.inv_val, map_one]
    rw [hres, smul_smul, hz, one_smul]
  · apply SheafOfModules.hom_ext
    apply PresheafOfModules.hom_ext
    intro X
    apply ModuleCat.hom_ext
    apply LinearMap.ext
    intro s
    change (actualTildeMap f).val.app (op X.unop.left)
      ((Spec.structureSheaf R).val.map X.unop.hom.op c.inv •
        (actualTildeMap g).val.app (op X.unop.left) s) = s
    rw [(actualTildeMap f).val.app (op X.unop.left) |>.hom.map_smul]
    rw [actualTilde_composite_apply N g f r hgf]
    have hres : StructureSheaf.toOpen R X.unop.left r =
        (Spec.structureSheaf R).val.map X.unop.hom.op c.val := by
      rw [hc]
      rfl
    have hz : (Spec.structureSheaf R).val.map X.unop.hom.op c.inv *
        (Spec.structureSheaf R).val.map X.unop.hom.op c.val = 1 := by
      rw [← ((Spec.structureSheaf R).val.map X.unop.hom.op).hom.map_mul,
        c.inv_val, map_one]
    rw [hres, smul_smul, hz, one_smul]

end Litt3.Jacobians
