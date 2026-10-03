import Solutions.Jacobians.ActualTildeOpenBaseChange
import Mathlib.LinearAlgebra.Dual.Defs

open CategoryTheory Opposite TopologicalSpace AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable {R : Type u} [CommRing R] (M : ModuleCat.{u} R)

/-- The genuine original vector in the actual coefficient-extended module. -/
noncomputable def actualTildeOpenExtendedOriginal (U : Opens (PrimeSpectrum R)) (m : M) :
    (ModuleCat.extendScalars (StructureSheaf.toOpen R U).hom).obj M :=
  (ModuleCat.extendRestrictScalarsAdj (StructureSheaf.toOpen R U).hom).unit.app M m

theorem actualTildeOpenBaseChangeMap_original (U : Opens (PrimeSpectrum R)) (m : M) :
    actualTildeOpenBaseChangeMap M U (actualTildeOpenExtendedOriginal M U m) =
      ModuleCat.Tilde.toOpen M U m := by
  have h := congrArg (fun f => f m)
    (((ModuleCat.extendRestrictScalarsAdj (StructureSheaf.toOpen R U).hom).homEquiv
      M (M.tilde.val.obj (op U))).apply_symm_apply (actualTildeOpenOriginalMap M U))
  exact h

/-- An original functional extends to a true O(U)-linear functional on all
actual associated-sheaf sections, preserving the genuine original coefficient. -/
noncomputable def actualTildeOpenFunctional (g : Module.Dual R M)
    (U : Opens (PrimeSpectrum R)) :
    M.tilde.val.obj (op U) →ₗ[(Spec.structureSheaf R).val.obj (op U)]
      (Spec.structureSheaf R).val.obj (op U) :=
  (actualTildeRingSectionMap R (op U)).comp
    (actualTildeSectionMap (ModuleCat.ofHom g) (op U))

theorem actualTildeOpenFunctional_original (g : Module.Dual R M)
    (U : Opens (PrimeSpectrum R)) (m : M) :
    actualTildeOpenFunctional M g U (ModuleCat.Tilde.toOpen M U m) =
      StructureSheaf.toOpen R U (g m) := by
  apply Subtype.ext
  funext x
  change actualLocalizedModuleFunctional M x.1 g
    (LocalizedModule.mkLinearMap x.1.asIdeal.primeCompl M m) = _
  exact actualLocalizedModuleFunctional_original M x.1 g m

/-- Original finite dual reconstruction holds for EVERY section on EVERY
actual open, with genuine O(U) coefficients, without affineness of U. -/
theorem actual_tilde_open_section_reconstruction
    {ι : Type*} [Fintype ι] (m : ι → M) (g : ι → Module.Dual R M)
    (h : ∀ a : M, ∑ i, g i a • m i = a)
    (U : Opens (PrimeSpectrum R)) (s : M.tilde.val.obj (op U)) :
    ∑ i, actualTildeOpenFunctional M (g i) U s •
      (show M.tilde.val.obj (op U) from ModuleCat.Tilde.toOpen M U (m i)) = s := by
  apply Subtype.ext
  funext x
  change (∑ i, actualTildeOpenFunctional M (g i) U s •
    (show ModuleCat.Tilde.sectionsSubmodule M (op U) from
      ModuleCat.Tilde.toOpen M U (m i))).val x = s.val x
  simp only [Submodule.coe_sum, Finset.sum_apply, Submodule.coe_smul]
  change ∑ i, actualLocalizedModuleFunctional M x.1 (g i) (s.val x) •
    LocalizedModule.mkLinearMap x.1.asIdeal.primeCompl M (m i) = s.val x
  exact actual_localized_module_reconstruction M m g h x.1 (s.val x)

end Litt3.Jacobians
