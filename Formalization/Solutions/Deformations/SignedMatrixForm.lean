import Theorems.Deformations.SignedMatrixForm
import Mathlib.Tactic.Ring

namespace Litt3.Deformations

variable {R ι : Type*} [CommRing R] [Fintype ι] [DecidableEq ι]

/-- The actual signed transpose gives the exact signed
interchange formula of the actual bilinear form. -/
theorem signed_matrix_form_interchange (ε : R) (A : Matrix ι ι R)
    (signed : HasSignedTranspose ε A) (x y : ι → R) :
    Matrix.toBilin' A y x = ε * Matrix.toBilin' A x y := by
  calc
    _ = ∑ i, ∑ j, y i * A i j * x j := Matrix.toBilin'_apply A y x
    _ = ∑ i, ∑ j, y j * A j i * x i := Finset.sum_comm
    _ = ∑ i, ∑ j, ε * (x i * A i j * y j) := by
      apply Finset.sum_congr rfl
      intro i hi
      apply Finset.sum_congr rfl
      intro j hj
      have h : A j i = ε * A i j := congrArg (fun M : Matrix ι ι R => M i j) signed
      rw [h]
      ring
    _ = ε * (∑ i, ∑ j, x i * A i j * y j) := by simp only [Finset.mul_sum]
    _ = _ := by rw [Matrix.toBilin'_apply]

/-- Signed symmetry implies actual reflexivity over every
commutative coefficient ring; ε need not be a unit. -/
theorem signed_matrix_form_reflexive (ε : R) (A : Matrix ι ι R)
    (signed : HasSignedTranspose ε A) : Specifications.SignedMatrixFormReflexive A := by
  intro x y h
  rw [signed_matrix_form_interchange ε A signed x y, h, mul_zero]

end Litt3.Deformations
