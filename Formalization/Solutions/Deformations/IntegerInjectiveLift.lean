import Mathlib.LinearAlgebra.Matrix.Charpoly.Coeff
import Mathlib.LinearAlgebra.Matrix.ToLin
import Mathlib.LinearAlgebra.Matrix.Adjugate
import Mathlib.Algebra.Polynomial.Roots
import Mathlib.Data.ZMod.Basic

namespace Litt3.Deformations

open Matrix Polynomial

/-- A nonzero determinant gives injectivity over every integral domain,
without a field or an invertibility assumption. -/
theorem matrix_mulVec_injective_of_det_ne_zero {R I : Type*}
    [CommRing R] [IsDomain R] [Fintype I] [DecidableEq I]
    (B : Matrix I I R) (determinant : B.det ≠ 0) :
    Function.Injective B.mulVecLin := by
  intro x y equal
  have equal' := congrArg (fun v => B.adjugate *ᵥ v) equal
  change B.adjugate *ᵥ (B *ᵥ x) = B.adjugate *ᵥ (B *ᵥ y) at equal'
  rw [mulVec_mulVec, mulVec_mulVec, adjugate_mul, smul_mulVec, smul_mulVec,
    one_mulVec, one_mulVec] at equal'
  ext i
  have coordinate := congrFun equal' i
  exact mul_left_cancel₀ determinant coordinate

/-- Any integral matrix can be shifted by a multiple of a nonzero
integer modulus to make its determinant nonzero. The argument uses
the finite root set of the monic characteristic polynomial. -/
theorem integer_matrix_exists_regular_shift {I : Type*}
    [Fintype I] [DecidableEq I] (B : Matrix I I ℤ)
    (modulus : ℤ) (nonzero : modulus ≠ 0) :
    ∃ k : ℤ, (B + Matrix.scalar I (modulus * k)).det ≠ 0 := by
  classical
  by_contra noShift
  have allShifts : ∀ k : ℤ, (B + Matrix.scalar I (modulus * k)).det = 0 := by
    simpa only [not_exists, not_not] using noShift
  have rootsFinite := Polynomial.finite_setOf_isRoot (-B).charpoly_monic.ne_zero
  have rootsInfinite : Set.Infinite (Set.range (fun k : ℤ => modulus * k)) :=
    Set.infinite_range_of_injective (fun _ _ equal => mul_left_cancel₀ nonzero equal)
  apply rootsInfinite
  apply rootsFinite.subset
  rintro t ⟨k, rfl⟩
  change (-B).charpoly.eval (modulus * k) = 0
  rw [Matrix.eval_charpoly]
  simpa only [sub_neg_eq_add, add_comm] using allShifts k

/-- Every square matrix over a nonzero integer residue ring has a
literal integral lift whose associated integral linear map is
injective. No search or bounded determinant computation is used. -/
theorem zmod_matrix_injective_integer_lift {I : Type*}
    [Fintype I] [DecidableEq I] (n : ℕ) [NeZero n]
    (A : Matrix I I (ZMod n)) :
    ∃ B : Matrix I I ℤ,
      B.map (Int.castRingHom (ZMod n)) = A ∧ Function.Injective B.mulVecLin := by
  classical
  let lift : Matrix I I ℤ := fun i j => (A i j).val
  obtain ⟨k, regular⟩ := integer_matrix_exists_regular_shift lift (n : ℤ)
    (by exact_mod_cast NeZero.ne n)
  refine ⟨lift + Matrix.scalar I ((n : ℤ) * k), ?_,
    matrix_mulVec_injective_of_det_ne_zero _ regular⟩
  ext i j
  change (((A i j).val : ℤ) + (if i = j then (n : ℤ) * k else 0) : ℤ) =
    (A i j : ZMod n)
  by_cases equal : i = j
  · subst j
    simp
  · simp [equal]

end Litt3.Deformations
