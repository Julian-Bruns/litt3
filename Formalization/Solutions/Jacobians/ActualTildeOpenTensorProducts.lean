import Solutions.Jacobians.ActualTildeFiniteProjectiveOpenSections
import Mathlib.LinearAlgebra.TensorProduct.Tower
import Mathlib.LinearAlgebra.TensorProduct.Finiteness
import Mathlib.RingTheory.TensorProduct.Finite

open CategoryTheory Opposite TopologicalSpace AlgebraicGeometry
open TensorProduct
open scoped TensorProduct

namespace Litt3.Jacobians

universe u
variable {R : Type u} [CommRing R] (M N : ModuleCat.{u} R)
  [Module.Finite R M] [Module.Projective R M]
  [Module.Finite R N] [Module.Projective R N]

/-- The actual tensor of associated-sheaf section modules on EVERY original
open is the actual section module of the original tensor. This is derived
from true coefficient extension and its actual tensor-distribution theorem. -/
noncomputable def actualTildeOpenTensorProductEquiv (U : Opens (PrimeSpectrum R)) :
    (M.tilde.val.obj (op U) ⊗[(Spec.structureSheaf R).val.obj (op U)]
      N.tilde.val.obj (op U)) ≃ₗ[(Spec.structureSheaf R).val.obj (op U)]
        (ModuleCat.of R (M ⊗[R] N)).tilde.val.obj (op U) := by
  let A := (Spec.structureSheaf R).val.obj (op U)
  letI := (StructureSheaf.toOpen R U).hom.toAlgebra
  let eM : A ⊗[R] M ≃ₗ[A] M.tilde.val.obj (op U) :=
    (actualTildeFiniteProjectiveOpenSectionsIso M U).toLinearEquiv
  let eN : A ⊗[R] N ≃ₗ[A] N.tilde.val.obj (op U) :=
    (actualTildeFiniteProjectiveOpenSectionsIso N U).toLinearEquiv
  let eMN : A ⊗[R] (M ⊗[R] N) ≃ₗ[A]
      (ModuleCat.of R (M ⊗[R] N)).tilde.val.obj (op U) :=
    (actualTildeFiniteProjectiveOpenSectionsIso (ModuleCat.of R (M ⊗[R] N)) U).toLinearEquiv
  exact TensorProduct.congr eM.symm eN.symm ≪≫ₗ
    (AlgebraTensorModule.distribBaseChange R A M N).symm ≪≫ₗ eMN

end Litt3.Jacobians
