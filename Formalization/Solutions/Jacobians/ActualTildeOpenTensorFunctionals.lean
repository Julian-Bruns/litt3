import Solutions.Jacobians.ActualTildeOpenBaseChangeMaps

open CategoryTheory Opposite TopologicalSpace AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable {R : Type u} [CommRing R] (M : ModuleCat.{u} R)

noncomputable def actualTildeOpenOriginalCoefficientMap (g : Module.Dual R M)
    (U : Opens (PrimeSpectrum R)) :
    M ⟶ (ModuleCat.restrictScalars (StructureSheaf.toOpen R U).hom).obj
      (ModuleCat.of ((Spec.structureSheaf R).val.obj (op U))
        ((Spec.structureSheaf R).val.obj (op U))) :=
  ModuleCat.ofHom (Y := (ModuleCat.restrictScalars (StructureSheaf.toOpen R U).hom).obj
      (ModuleCat.of ((Spec.structureSheaf R).val.obj (op U))
        ((Spec.structureSheaf R).val.obj (op U))))
    { toFun := fun m => StructureSheaf.toOpen R U (g m)
      map_add' := fun m n => by rw [g.map_add, map_add]
      map_smul' := fun r m => by
        change StructureSheaf.toOpen R U (g (r • m)) =
          StructureSheaf.toOpen R U r * StructureSheaf.toOpen R U (g m)
        rw [g.map_smul, smul_eq_mul, map_mul] }

/-- An original functional extends to the ACTUAL coefficient tensor module
through the true scalar-extension adjunction. -/
noncomputable def actualTildeOpenTensorFunctional (g : Module.Dual R M)
    (U : Opens (PrimeSpectrum R)) :
    (ModuleCat.extendScalars (StructureSheaf.toOpen R U).hom).obj M ⟶
      ModuleCat.of ((Spec.structureSheaf R).val.obj (op U))
        ((Spec.structureSheaf R).val.obj (op U)) :=
  ((ModuleCat.extendRestrictScalarsAdj (StructureSheaf.toOpen R U).hom).homEquiv
    M _).symm (actualTildeOpenOriginalCoefficientMap M g U)

theorem actualTildeOpenTensorFunctional_original (g : Module.Dual R M)
    (U : Opens (PrimeSpectrum R)) (m : M) :
    actualTildeOpenTensorFunctional M g U (actualTildeOpenExtendedOriginal M U m) =
      StructureSheaf.toOpen R U (g m) := by
  exact congrArg (fun f => f m)
    (((ModuleCat.extendRestrictScalarsAdj (StructureSheaf.toOpen R U).hom).homEquiv
      M _).apply_symm_apply (actualTildeOpenOriginalCoefficientMap M g U))

/-- The scalar tensor's genuine coefficient functional is EXACTLY the
actual associated-sheaf functional after the actual base-change map. -/
theorem actualTildeOpenTensorFunctional_compatibility (g : Module.Dual R M)
    (U : Opens (PrimeSpectrum R)) :
    actualTildeOpenBaseChangeMap M U ≫ ModuleCat.ofHom
      (R := (Spec.structureSheaf R).val.obj (op U))
      (X := M.tilde.val.obj (op U))
      (Y := ModuleCat.of ((Spec.structureSheaf R).val.obj (op U))
        ((Spec.structureSheaf R).val.obj (op U)))
      (actualTildeOpenFunctional M g U) =
      actualTildeOpenTensorFunctional M g U := by
  apply ((ModuleCat.extendRestrictScalarsAdj (StructureSheaf.toOpen R U).hom).homEquiv M _).injective
  apply ModuleCat.hom_ext
  apply LinearMap.ext
  intro m
  change actualTildeOpenFunctional M g U
    (actualTildeOpenBaseChangeMap M U (actualTildeOpenExtendedOriginal M U m)) =
      actualTildeOpenTensorFunctional M g U (actualTildeOpenExtendedOriginal M U m)
  rw [actualTildeOpenBaseChangeMap_original, actualTildeOpenFunctional_original,
    actualTildeOpenTensorFunctional_original]

end Litt3.Jacobians
