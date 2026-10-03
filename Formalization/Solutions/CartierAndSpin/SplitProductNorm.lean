import Mathlib.RingTheory.Norm.Basic
import Mathlib.Tactic

namespace Litt3.CartierAndSpin

open Finset

variable {R ι : Type*} [CommRing R] [Fintype ι]

/-- The actual determinant norm in a finite product algebra, including
the empty product algebra, is the product of its coordinates. -/
theorem split_product_algebra_norm (value : ι → R) :
    Algebra.norm R value = ∏ i, value i := by
  classical
  rw [Algebra.norm_eq_matrix_det (Pi.basisFun R ι)]
  have hmatrix : Algebra.leftMulMatrix (Pi.basisFun R ι) value =
      Matrix.diagonal value := by
    ext i j
    by_cases h : i = j
    · subst j
      simp [Algebra.leftMulMatrix]
    · simp [Algebra.leftMulMatrix, h]
  rw [hmatrix, Matrix.det_diagonal]

end Litt3.CartierAndSpin
