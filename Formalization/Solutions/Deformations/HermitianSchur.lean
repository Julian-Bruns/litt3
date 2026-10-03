import Theorems.Deformations.HermitianSchur

namespace Litt3.Deformations

open Matrix

variable {R m n : Type*} [Ring R] [StarRing R]
variable [Fintype m] [DecidableEq m] [Fintype n] [DecidableEq n]

/-- The change of basis is invertible before any quotient or
residue-field passage. -/
def hermitianSchurEliminatorInvertible (C : Matrix m m R) (D : Matrix m n R)
    [Invertible C] : Invertible (hermitianSchurEliminator C D) where
  invOf := fromBlocks 1 (⅟C * D) 0 1
  invOf_mul_self := by
    simp only [hermitianSchurEliminator, fromBlocks_multiply, Matrix.one_mul,
      Matrix.mul_one, Matrix.mul_zero, Matrix.zero_mul, add_zero, zero_add,
      neg_add_cancel, fromBlocks_one]
  mul_invOf_self := by
    simp only [hermitianSchurEliminator, fromBlocks_multiply, Matrix.one_mul,
      Matrix.mul_one, Matrix.mul_zero, Matrix.zero_mul, add_zero, zero_add,
      add_neg_cancel, fromBlocks_one]

theorem hermitian_inverseOf (C : Matrix m m R) [Invertible C] (hermitian : Cᴴ = C) :
    (⅟C)ᴴ = ⅟C := by
  have hleft : (⅟C)ᴴ * C = 1 := by
    calc
      _ = (⅟C)ᴴ * Cᴴ := congrArg (fun B => (⅟C)ᴴ * B) hermitian.symm
      _ = (C * ⅟C)ᴴ := by rw [conjTranspose_mul]
      _ = 1 := by rw [mul_invOf_self, conjTranspose_one]
  exact (invOf_eq_left_inv hleft).symm

theorem skew_hermitian_inverseOf (C : Matrix m m R) [Invertible C]
    (skew : Cᴴ = -C) : (⅟C)ᴴ = -⅟C := by
  have hstar : (⅟C)ᴴ * (-C) = 1 := by
    rw [← skew, ← conjTranspose_mul, mul_invOf_self, conjTranspose_one]
  have hleft : (-(⅟C)ᴴ) * C = 1 := by
    simpa only [Matrix.neg_mul, Matrix.mul_neg] using hstar
  have h := congrArg (fun x : Matrix m m R => -x) (invOf_eq_left_inv hleft)
  simpa only [neg_neg] using h.symm

/-- Exact Hermitian congruence splitting over any star ring; it
does not require a field, commutativity, or a nonsingular remainder. -/
theorem hermitian_schur_congruence (C : Matrix m m R) (D : Matrix m n R)
    (F : Matrix n n R) [Invertible C] (hermitian : Cᴴ = C) :
    Specifications.HermitianSchurCongruence C D F := by
  unfold Specifications.HermitianSchurCongruence hermitianSchurEliminator
  simp [fromBlocks_conjTranspose, fromBlocks_multiply, conjTranspose_mul,
    hermitian_inverseOf C hermitian, Matrix.mul_assoc,
    Matrix.mul_invOf_cancel_left, sub_eq_add_neg, add_comm]

/-- Exact odd-valuation congruence splitting; the plus sign in
the remainder is forced by skew symmetry of the divided leading block. -/
theorem skew_hermitian_schur_congruence (C : Matrix m m R) (D : Matrix m n R)
    (F : Matrix n n R) [Invertible C] (skew : Cᴴ = -C) :
    Specifications.SkewHermitianSchurCongruence C D F := by
  unfold Specifications.SkewHermitianSchurCongruence hermitianSchurEliminator
  simp [fromBlocks_conjTranspose, fromBlocks_multiply, conjTranspose_mul,
    skew_hermitian_inverseOf C skew, Matrix.mul_assoc,
    Matrix.mul_invOf_cancel_left, add_comm]

omit [Fintype n] [DecidableEq n] in
theorem hermitian_schur_remainder (C : Matrix m m R) (D : Matrix m n R)
    (F : Matrix n n R) [Invertible C] (hC : Cᴴ = C) (hF : Fᴴ = F) :
    (F - Dᴴ * ⅟C * D)ᴴ = F - Dᴴ * ⅟C * D := by
  simp [conjTranspose_mul, hermitian_inverseOf C hC, hF, Matrix.mul_assoc]

omit [Fintype n] [DecidableEq n] in
theorem skew_hermitian_schur_remainder (C : Matrix m m R) (D : Matrix m n R)
    (F : Matrix n n R) [Invertible C] (hC : Cᴴ = -C) (hF : Fᴴ = -F) :
    (F + Dᴴ * ⅟C * D)ᴴ = -(F + Dᴴ * ⅟C * D) := by
  simp [conjTranspose_mul, skew_hermitian_inverseOf C hC, hF, Matrix.mul_assoc, add_comm]

end Litt3.Deformations
