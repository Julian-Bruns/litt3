import Solutions.Jacobians.ActualTildeOpenTensorFunctionals

open CategoryTheory Opposite TopologicalSpace AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable {R : Type u} [CommRing R] (M : ModuleCat.{u} R)

theorem actualTildeOpenExtendedOriginal_smul (U : Opens (PrimeSpectrum R))
    (r : R) (m : M) :
    actualTildeOpenExtendedOriginal M U (r • m) = StructureSheaf.toOpen R U r •
      actualTildeOpenExtendedOriginal M U m :=
  ((ModuleCat.extendRestrictScalarsAdj (StructureSheaf.toOpen R U).hom).unit.app M).hom.map_smul r m

/-- Original finite dual reconstruction holds on the ENTIRE actual
coefficient-extended tensor module; no pure-tensor or finite-support premise. -/
theorem actual_tilde_open_extended_module_reconstruction
    {ι : Type*} [Fintype ι] (m : ι → M) (g : ι → Module.Dual R M)
    (h : ∀ a : M, ∑ i, g i a • m i = a)
    (U : Opens (PrimeSpectrum R))
    (a : (ModuleCat.extendScalars (StructureSheaf.toOpen R U).hom).obj M) :
    ∑ i, actualTildeOpenTensorFunctional M (g i) U a •
      actualTildeOpenExtendedOriginal M U (m i) = a := by
  let E := (ModuleCat.extendScalars (StructureSheaf.toOpen R U).hom).obj M
  let H : E ⟶ E := ModuleCat.ofHom
    (∑ i, (LinearMap.toSpanSingleton ((Spec.structureSheaf R).val.obj (op U)) E
      (actualTildeOpenExtendedOriginal M U (m i))).comp
        (actualTildeOpenTensorFunctional M (g i) U).hom)
  have hHapply (b : E) : H b = ∑ i, actualTildeOpenTensorFunctional M (g i) U b •
      actualTildeOpenExtendedOriginal M U (m i) := by
    change (∑ i, (LinearMap.toSpanSingleton ((Spec.structureSheaf R).val.obj (op U)) E
      (actualTildeOpenExtendedOriginal M U (m i))).comp
        (actualTildeOpenTensorFunctional M (g i) U).hom) b = _
    simp only [LinearMap.sum_apply, LinearMap.comp_apply, LinearMap.toSpanSingleton_apply]
  have hH : H = 𝟙 E := by
    apply ((ModuleCat.extendRestrictScalarsAdj (StructureSheaf.toOpen R U).hom).homEquiv M E).injective
    apply ModuleCat.hom_ext
    apply LinearMap.ext
    intro b
    change H (actualTildeOpenExtendedOriginal M U b) = actualTildeOpenExtendedOriginal M U b
    rw [hHapply]
    calc
      _ = ∑ i, StructureSheaf.toOpen R U (g i b) •
          actualTildeOpenExtendedOriginal M U (m i) := by
        apply Finset.sum_congr rfl
        intro i hi
        exact congrArg (fun c => c • actualTildeOpenExtendedOriginal M U (m i))
          (actualTildeOpenTensorFunctional_original M (g i) U b)
      _ = ∑ i, actualTildeOpenExtendedOriginal M U (g i b • m i) := by
        apply Finset.sum_congr rfl
        intro i hi
        exact (actualTildeOpenExtendedOriginal_smul M U (g i b) (m i)).symm
      _ = actualTildeOpenExtendedOriginal M U b := by
        change ∑ i, ((ModuleCat.extendRestrictScalarsAdj (StructureSheaf.toOpen R U).hom).unit.app M)
          (g i b • m i) =
            ((ModuleCat.extendRestrictScalarsAdj (StructureSheaf.toOpen R U).hom).unit.app M) b
        rw [← map_sum, h]
  have he := CategoryTheory.congr_fun hH a
  change H a = a at he
  rw [hHapply] at he
  exact he

end Litt3.Jacobians
