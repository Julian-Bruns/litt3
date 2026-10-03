import Theorems.Deformations.SkewMatrixForm

namespace Litt3.Deformations

variable {k ι : Type*} [Field k] [Fintype ι] [DecidableEq ι]

/-- Skew symmetry gives an actual alternating form when two is
nonzero, without discarding any radical or choosing a minor. -/
theorem skew_matrix_alternating_form (two_ne_zero : (2 : k) ≠ 0)
    (A : Matrix ι ι k) (skew : A.transpose = -A) :
    Specifications.SkewMatrixAlternatingForm A := by
  intro x
  have hneg : residueMatrixForm A x x = -residueMatrixForm A x x := by
    calc
      _ = ∑ i, ∑ j, x i * A i j * x j := Matrix.toBilin'_apply A x x
      _ = ∑ i, ∑ j, x j * A j i * x i := Finset.sum_comm
      _ = ∑ i, ∑ j, -(x i * A i j * x j) := by
        apply Finset.sum_congr rfl
        intro i hi
        apply Finset.sum_congr rfl
        intro j hj
        have h : A j i = -A i j := congrArg (fun M : Matrix ι ι k => M i j) skew
        rw [h]
        ring
      _ = -(∑ i, ∑ j, x i * A i j * x j) := by
        simp only [Finset.sum_neg_distrib]
      _ = _ := by rw [residueMatrixForm, Matrix.toBilin'_apply]
  have hz : (2 : k) * residueMatrixForm A x x = 0 := by
    simpa only [two_mul] using eq_neg_iff_add_eq_zero.mp hneg
  exact (mul_eq_zero.mp hz).resolve_left two_ne_zero

end Litt3.Deformations
