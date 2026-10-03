import Solutions.Jacobians.ActualTildeProjectiveGlobalSections
import Mathlib.RingTheory.PicardGroup

open CategoryTheory Opposite TopologicalSpace AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable {R : Type u} [CommRing R] {M N : ModuleCat.{u} R}

/-- An actual O_Spec-module SHEAF morphism acts on actual original global R-modules. -/
noncomputable def actualTildeGlobalSheafMap (h : M.tilde ⟶ N.tilde) :
    M.tildeInModuleCat.obj (op ⊤) →ₗ[R] N.tildeInModuleCat.obj (op ⊤) where
  toFun := h.val.app (op ⊤)
  map_add' := (h.val.app (op ⊤)).hom.map_add
  map_smul' r s := by
    exact (h.val.app (op ⊤)).hom.map_smul (StructureSheaf.toOpen R ⊤ r)
      (show M.tilde.val.obj (op ⊤) from s)

noncomputable def actualTildeIsoGlobalSections (e : M.tilde ≅ N.tilde) :
    M.tildeInModuleCat.obj (op ⊤) ≃ₗ[R] N.tildeInModuleCat.obj (op ⊤) :=
  let eΓ := ((SheafOfModules.evaluation (Spec (.of R)).ringCatSheaf (op ⊤)).mapIso e).toLinearEquiv
  LinearEquiv.ofLinear (actualTildeGlobalSheafMap e.hom) (actualTildeGlobalSheafMap e.inv)
    (LinearMap.ext fun s => eΓ.apply_symm_apply s)
    (LinearMap.ext fun s => eΓ.symm_apply_apply s)

/-- A genuine associated-sheaf isomorphism recovers a true original module isomorphism.
Global section recovery is DERIVED from finite projectivity, not supplied. -/
noncomputable def actualTildeIsoOriginalModules
    [Module.Finite R M] [Module.Projective R M]
    [Module.Finite R N] [Module.Projective R N] (e : M.tilde ≅ N.tilde) : M ≃ₗ[R] N :=
  actualTildeProjectiveGlobalSectionsEquiv M ≪≫ₗ actualTildeIsoGlobalSections e ≪≫ₗ
    (actualTildeProjectiveGlobalSectionsEquiv N).symm

theorem actual_invertible_modules_picard_eq_iff_tilde_iso
    [Module.Invertible R M] [Module.Invertible R N] :
    CommRing.Pic.mk R M = CommRing.Pic.mk R N ↔ Nonempty (M.tilde ≅ N.tilde) := by
  rw [CommRing.Pic.mk_eq_mk_iff]
  constructor
  · rintro ⟨e⟩
    let eCat : M ≅ N := (ModuleCat.ofSelfIso M).symm ≪≫ e.toModuleIso ≪≫ ModuleCat.ofSelfIso N
    exact ⟨(actualTildeFunctor R).mapIso eCat⟩
  · rintro ⟨e⟩
    exact ⟨actualTildeIsoOriginalModules e⟩

/-- True affine ring Picard vanishing iff the ACTUAL associated sheaf is the
ACTUAL structure-sheaf module; no scheme Picard-group definition is substituted. -/
theorem actual_invertible_module_picard_zero_iff_sheaf_trivial
    [Module.Invertible R M] :
    CommRing.Pic.mk R M = 1 ↔
      Nonempty (M.tilde ≅ SheafOfModules.unit (Spec (.of R)).ringCatSheaf) := by
  rw [← CommRing.Pic.mk_self (R := R)]
  change CommRing.Pic.mk R M = CommRing.Pic.mk R (ModuleCat.of R R) ↔ _
  rw [actual_invertible_modules_picard_eq_iff_tilde_iso (N := ModuleCat.of R R)]
  constructor
  · rintro ⟨e⟩
    exact ⟨e ≪≫ actualTildeUnitIso R⟩
  · rintro ⟨e⟩
    exact ⟨e ≪≫ (actualTildeUnitIso R).symm⟩

end Litt3.Jacobians
