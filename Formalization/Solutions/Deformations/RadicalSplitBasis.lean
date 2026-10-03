import Theorems.Deformations.RadicalSplitBasis
import Solutions.Deformations.RadicalComplements

namespace Litt3.Deformations

open Module

variable {k V : Type*} [Field k] [AddCommGroup V] [Module k V] [FiniteDimensional k V]

@[simp] theorem radical_split_basis_inl (B : LinearMap.BilinForm k V)
    (U : Submodule k V) (complement : IsCompl U (BilinearRadical B))
    (i : Fin (Module.finrank k U)) :
    radicalSplitBasis B U complement (Sum.inl i) = (Module.finBasis k U i : V) := by
  change (((Module.finBasis k U).prod (Module.finBasis k (BilinearRadical B)))
      (Sum.inl i)).1.val +
    (((Module.finBasis k U).prod (Module.finBasis k (BilinearRadical B)))
      (Sum.inl i)).2.val = _
  rw [Basis.prod_apply_inl_fst, Basis.prod_apply_inl_snd]
  simp only [Submodule.coe_zero, add_zero]

@[simp] theorem radical_split_basis_inr (B : LinearMap.BilinForm k V)
    (U : Submodule k V) (complement : IsCompl U (BilinearRadical B))
    (i : Fin (Module.finrank k (BilinearRadical B))) :
    radicalSplitBasis B U complement (Sum.inr i) =
      (Module.finBasis k (BilinearRadical B) i : V) := by
  change (((Module.finBasis k U).prod (Module.finBasis k (BilinearRadical B)))
      (Sum.inr i)).1.val +
    (((Module.finBasis k U).prod (Module.finBasis k (BilinearRadical B)))
      (Sum.inr i)).2.val = _
  rw [Basis.prod_apply_inr_fst, Basis.prod_apply_inr_snd]
  simp only [Submodule.coe_zero, zero_add]

/-- The actual whole matrix in the actual split basis has one
nonsingular leading block and the complete zero radical block. -/
theorem radical_split_matrix (B : LinearMap.BilinForm k V) (reflexive : B.IsRefl)
    (U : Submodule k V) (complement : IsCompl U (BilinearRadical B)) :
    _root_.BilinForm.toMatrix (radicalSplitBasis B U complement) B =
      Matrix.fromBlocks (_root_.BilinForm.toMatrix (Module.finBasis k U) (B.restrict U)) 0 0 0 := by
  ext i j
  cases i with
  | inl i =>
    cases j with
    | inl j =>
      simp only [_root_.BilinForm.toMatrix_apply, radical_split_basis_inl,
        Matrix.fromBlocks_apply₁₁]
      rfl
    | inr j =>
      simp only [_root_.BilinForm.toMatrix_apply, radical_split_basis_inl,
        radical_split_basis_inr, Matrix.fromBlocks_apply₁₂, Matrix.zero_apply]
      apply reflexive
      have h := LinearMap.mem_ker.mp (Module.finBasis k (BilinearRadical B) j).property
      exact congrArg (fun f : V →ₗ[k] k => f (Module.finBasis k U i)) h
  | inr i =>
    cases j with
    | inl j =>
      simp only [_root_.BilinForm.toMatrix_apply, radical_split_basis_inl,
        radical_split_basis_inr, Matrix.fromBlocks_apply₂₁, Matrix.zero_apply]
      have h := LinearMap.mem_ker.mp (Module.finBasis k (BilinearRadical B) i).property
      exact congrArg (fun f : V →ₗ[k] k => f (Module.finBasis k U j)) h
    | inr j =>
      simp only [_root_.BilinForm.toMatrix_apply, radical_split_basis_inr,
        Matrix.fromBlocks_apply₂₂, Matrix.zero_apply]
      have h := LinearMap.mem_ker.mp (Module.finBasis k (BilinearRadical B) i).property
      exact congrArg (fun f : V →ₗ[k] k => f (Module.finBasis k (BilinearRadical B) j)) h

theorem reflexive_radical_matrix_split (B : LinearMap.BilinForm k V)
    (reflexive : B.IsRefl) : Specifications.ReflexiveRadicalMatrixSplit B := by
  obtain ⟨U, complement, nondegenerate⟩ := reflexive_radical_complement B reflexive
  refine ⟨U, complement, ?_, radical_split_matrix B reflexive U complement⟩
  rw [Matrix.isUnit_iff_isUnit_det, isUnit_iff_ne_zero]
  exact (LinearMap.BilinForm.nondegenerate_iff_det_ne_zero (Module.finBasis k U)).mp nondegenerate

end Litt3.Deformations
