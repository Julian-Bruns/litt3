import Solutions.Jacobians.ActualTildeFiniteProjectiveOpenSections
import Mathlib.RingTheory.PicardGroup

open CategoryTheory Opposite TopologicalSpace AlgebraicGeometry
open scoped TensorProduct

namespace Litt3.Jacobians

universe u
variable {R : Type u} [CommRing R] (M : ModuleCat.{u} R) [Module.Invertible R M]

theorem actualTildeOpenExtendedModule_invertible (U : Opens (PrimeSpectrum R)) :
    Module.Invertible ((Spec.structureSheaf R).val.obj (op U))
      ((ModuleCat.extendScalars (StructureSheaf.toOpen R U).hom).obj M) := by
  letI := (StructureSheaf.toOpen R U).hom.toAlgebra
  change Module.Invertible ((Spec.structureSheaf R).val.obj (op U))
    (((Spec.structureSheaf R).val.obj (op U)) ⊗[R] M)
  infer_instance

/-- For an associated original invertible module on Spec R, its ACTUAL
sections on ANY open are an actual invertible module over the true O(U).
This is derived from coefficient extension, without affineness of the open. -/
noncomputable instance actualTildeOpenSections_invertible
    (U : Opens (PrimeSpectrum R)) :
    Module.Invertible ((Spec.structureSheaf R).val.obj (op U)) (M.tilde.val.obj (op U)) := by
  letI := actualTildeOpenExtendedModule_invertible M U
  exact Module.Invertible.congr (actualTildeFiniteProjectiveOpenSectionsIso M U).toLinearEquiv

end Litt3.Jacobians
