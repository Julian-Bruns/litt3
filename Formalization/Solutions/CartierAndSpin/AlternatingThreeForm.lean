import Solutions.CartierAndSpin.AlternatingThreeRank
import Mathlib.LinearAlgebra.Matrix.BilinearForm

namespace Litt3.CartierAndSpin

open Module LinearMap
open LinearMap (BilinForm)

variable {K V ι : Type*} [Field K] [AddCommGroup V] [Module K V]

theorem bilinear_matrix_mulVec_basis_apply [Fintype ι] [DecidableEq ι]
    (C : BilinForm K V) (basis : Basis ι K V) (x : V) (i : ι) :
    ((BilinForm.toMatrix basis C).mulVec (basis.equivFun x)) i = C (basis i) x := by
  change (∑ j, (BilinForm.toMatrix basis C) i j * basis.repr x j) = C (basis i) x
  calc
    _ = C (basis i) (∑ j, (basis.repr x j) • basis j) := by
      simp only [map_sum, map_smul, smul_eq_mul, BilinForm.toMatrix_apply]
      apply Finset.sum_congr rfl
      intro j _
      ring
    _ = C (basis i) x := by rw [basis.sum_repr x]

theorem alternating_form_matrix_kernel_iff [Fintype ι] [DecidableEq ι]
    (C : BilinForm K V) (hC : C.IsAlt) (basis : Basis ι K V) (x : V) :
    (BilinForm.toMatrix basis C).mulVec (basis.equivFun x) = 0 ↔ C x = 0 := by
  constructor
  · intro h
    apply basis.ext
    intro i
    have hi := congrFun h i
    rw [bilinear_matrix_mulVec_basis_apply] at hi
    have hj := hC.neg_eq x (basis i)
    rw [hi] at hj
    exact neg_eq_zero.mp hj
  · intro h
    ext i
    rw [bilinear_matrix_mulVec_basis_apply]
    have hi := LinearMap.congr_fun h (basis i)
    change C x (basis i) = 0 at hi
    change C (basis i) x = 0
    rw [← hC.neg_eq, hi, neg_zero]

theorem alternating_three_form_matrix (C : BilinForm K V) (hC : C.IsAlt)
    (basis : Basis (Fin 3) K V) :
    BilinForm.toMatrix basis C =
      alternatingThreeMatrix (C (basis 0) (basis 1)) (C (basis 0) (basis 2))
        (C (basis 1) (basis 2)) := by
  ext i j
  rw [BilinForm.toMatrix_apply]
  fin_cases i <;> fin_cases j
  · exact hC.self_eq_zero (basis 0)
  · rfl
  · rfl
  · exact (hC.neg_eq (basis 0) (basis 1)).symm
  · exact hC.self_eq_zero (basis 1)
  · rfl
  · exact (hC.neg_eq (basis 0) (basis 2)).symm
  · exact (hC.neg_eq (basis 1) (basis 2)).symm
  · exact hC.self_eq_zero (basis 2)

theorem alternating_three_form_finrank_kernel [FiniteDimensional K V]
    (C : BilinForm K V) (hC : C.IsAlt) (hne : C ≠ 0) (hdim : finrank K V = 3) :
    finrank K (LinearMap.ker C) = 1 := by
  let basis := finBasisOfFinrankEq K V hdim
  let a := C (basis 0) (basis 1)
  let b := C (basis 0) (basis 2)
  let c := C (basis 1) (basis 2)
  have hm := alternating_three_form_matrix C hC basis
  have habc : a ≠ 0 ∨ b ≠ 0 ∨ c ≠ 0 := by
    by_contra h
    push_neg at h
    apply hne
    apply (BilinForm.toMatrix basis).injective
    rw [hm]
    ext i j
    fin_cases i <;> fin_cases j <;>
      change (alternatingThreeMatrix a b c) _ _ = 0 <;>
      simp only [alternatingThreeMatrix, h.1, h.2.1, h.2.2, neg_zero] <;> rfl
  have hker : LinearMap.ker C =
      (LinearMap.ker (alternatingThreeMatrix a b c).mulVecLin).map
        (basis.equivFun.symm : (Fin 3 → K) →ₗ[K] V) := by
    ext x
    rw [Submodule.mem_map_equiv]
    change C x = 0 ↔ (alternatingThreeMatrix a b c).mulVec (basis.equivFun x) = 0
    rw [← hm]
    exact (alternating_form_matrix_kernel_iff C hC basis x).symm
  rw [hker, LinearEquiv.finrank_map_eq, alternatingThreeMatrix_finrank_kernel a b c habc]

end Litt3.CartierAndSpin
