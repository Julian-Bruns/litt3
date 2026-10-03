import Theorems.Deformations.SignedBlockMatrices

namespace Litt3.Deformations

variable {R m n : Type*} [CommRing R] [StarRing R]

/-- An actual signed matrix has the exact signed block form;
both diagonal blocks retain their whole signed symmetry. -/
theorem signed_block_shape (ε : R) (square_one : ε * ε = 1)
    (B : Matrix (m ⊕ n) (m ⊕ n) R) (symmetry : B.conjTranspose = ε • B) :
    Specifications.SignedBlockShape ε B := by
  refine ⟨?_, ?_, ?_⟩
  · ext i j
    cases i with
    | inl i => cases j <;> rfl
    | inr i =>
      cases j with
      | inr j => rfl
      | inl j =>
        change B (Sum.inr i) (Sum.inl j) = ε * star (B (Sum.inl j) (Sum.inr i))
        have h : star (B (Sum.inl j) (Sum.inr i)) = ε * B (Sum.inr i) (Sum.inl j) :=
          congrArg (fun M : Matrix (m ⊕ n) (m ⊕ n) R => M (Sum.inr i) (Sum.inl j)) symmetry
        rw [h, ← mul_assoc, square_one, one_mul]
  · ext i j
    exact congrArg (fun M : Matrix (m ⊕ n) (m ⊕ n) R => M (Sum.inl i) (Sum.inl j)) symmetry
  · ext i j
    exact congrArg (fun M : Matrix (m ⊕ n) (m ⊕ n) R => M (Sum.inr i) (Sum.inr j)) symmetry

end Litt3.Deformations
