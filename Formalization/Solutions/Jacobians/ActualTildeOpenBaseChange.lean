import Solutions.Jacobians.ActualLocalizedModuleReconstruction
import Mathlib.Algebra.Category.ModuleCat.ChangeOfRings

open CategoryTheory Opposite TopologicalSpace AlgebraicGeometry
open scoped TensorProduct

namespace Litt3.Jacobians

universe u
variable {R : Type u} [CommRing R] (M : ModuleCat.{u} R)

/-- The original module maps to its ACTUAL associated-sheaf sections on any
actual open, via the true coefficient restriction R→O(U). -/
noncomputable def actualTildeOpenOriginalMap (U : Opens (PrimeSpectrum R)) :
    M ⟶ (ModuleCat.restrictScalars (StructureSheaf.toOpen R U).hom).obj
      (M.tilde.val.obj (op U)) :=
  ModuleCat.ofHom
    (Y := (ModuleCat.restrictScalars (StructureSheaf.toOpen R U).hom).obj
      (M.tilde.val.obj (op U)))
    { toFun := ModuleCat.Tilde.toOpen M U
      map_add' := (ModuleCat.Tilde.toOpen M U).hom.map_add
      map_smul' := fun r m => by
        apply Subtype.ext
        funext x
        change LocalizedModule.mkLinearMap x.1.asIdeal.primeCompl M (r • m) =
          algebraMap R (Localization.AtPrime x.1.asIdeal) r •
            LocalizedModule.mkLinearMap x.1.asIdeal.primeCompl M m
        rw [algebraMap_smul]
        exact (LocalizedModule.mkLinearMap x.1.asIdeal.primeCompl M).map_smul r m }

/-- The actual extension-of-scalars map O(U)⊗_R M→Γ(U,tilde M), built using
Mathlib's genuine extend/restrict scalars adjunction. -/
noncomputable def actualTildeOpenBaseChangeMap (U : Opens (PrimeSpectrum R)) :
    (ModuleCat.extendScalars (StructureSheaf.toOpen R U).hom).obj M ⟶
      M.tilde.val.obj (op U) :=
  ((ModuleCat.extendRestrictScalarsAdj (StructureSheaf.toOpen R U).hom).homEquiv
    M (M.tilde.val.obj (op U))).symm (actualTildeOpenOriginalMap M U)

end Litt3.Jacobians
