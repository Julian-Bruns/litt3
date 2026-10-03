import Solutions.Jacobians.ActualTildeOpenTensorProducts

open CategoryTheory Opposite TopologicalSpace AlgebraicGeometry TensorProduct
open scoped TensorProduct

namespace Litt3.Jacobians

universe u
variable {R : Type u} [CommRing R] (M N : ModuleCat.{u} R)
  [Module.Finite R M] [Module.Projective R M]
  [Module.Finite R N] [Module.Projective R N]

theorem actualTildeFiniteProjectiveOpenSectionsIso_symm_original
    (U : Opens (PrimeSpectrum R)) (m : M) :
    (actualTildeFiniteProjectiveOpenSectionsIso M U).inv
      (ModuleCat.Tilde.toOpen M U m) = actualTildeOpenExtendedOriginal M U m := by
  apply (actualTildeFiniteProjectiveOpenSectionsIso M U).toLinearEquiv.injective
  exact (actualTildeFiniteProjectiveOpenSectionsIso M U).toLinearEquiv.apply_symm_apply _ |>.trans
    (actualTildeOpenBaseChangeMap_original M U m).symm

/-- Actual tensor section comparison agrees with the original module tensor
on actual original sections, fixing its geometric multiplication convention. -/
theorem actualTildeOpenTensorProductEquiv_original
    (U : Opens (PrimeSpectrum R)) (m : M) (n : N) :
    actualTildeOpenTensorProductEquiv M N U
      ((show M.tilde.val.obj (op U) from ModuleCat.Tilde.toOpen M U m) ⊗ₜ
        (show N.tilde.val.obj (op U) from ModuleCat.Tilde.toOpen N U n)) =
      ModuleCat.Tilde.toOpen (ModuleCat.of R (M ⊗[R] N)) U (m ⊗ₜ[R] n) := by
  let A := (Spec.structureSheaf R).val.obj (op U)
  letI := (StructureSheaf.toOpen R U).hom.toAlgebra
  let eM := (actualTildeFiniteProjectiveOpenSectionsIso M U).toLinearEquiv
  let eN := (actualTildeFiniteProjectiveOpenSectionsIso N U).toLinearEquiv
  let eMN := (actualTildeFiniteProjectiveOpenSectionsIso (ModuleCat.of R (M ⊗[R] N)) U).toLinearEquiv
  have hm : eM.symm (ModuleCat.Tilde.toOpen M U m) = (1 : A) ⊗ₜ[R] m :=
    actualTildeFiniteProjectiveOpenSectionsIso_symm_original M U m
  have hn : eN.symm (ModuleCat.Tilde.toOpen N U n) = (1 : A) ⊗ₜ[R] n :=
    actualTildeFiniteProjectiveOpenSectionsIso_symm_original N U n
  change eMN ((AlgebraTensorModule.distribBaseChange R A M N).symm
    (TensorProduct.congr eM.symm eN.symm
      ((show M.tilde.val.obj (op U) from ModuleCat.Tilde.toOpen M U m) ⊗ₜ
        (show N.tilde.val.obj (op U) from ModuleCat.Tilde.toOpen N U n)))) = _
  rw [TensorProduct.congr_tmul, hm, hn]
  have hd : (AlgebraTensorModule.distribBaseChange R A M N).symm
      (((1 : A) ⊗ₜ[R] m) ⊗ₜ[A] ((1 : A) ⊗ₜ[R] n)) =
        (1 : A) ⊗ₜ[R] (m ⊗ₜ[R] n) := by
    simp [AlgebraTensorModule.distribBaseChange, AlgebraTensorModule.cancelBaseChange]
  rw [hd]
  exact actualTildeOpenBaseChangeMap_original (ModuleCat.of R (M ⊗[R] N)) U (m ⊗ₜ n)

end Litt3.Jacobians
