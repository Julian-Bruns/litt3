import Mathlib.Algebra.AddTorsor.Basic
import Mathlib.Algebra.Group.Hom.Basic
import Mathlib.Logic.Equiv.Defs

namespace Litt3.Deformations

variable {K O A : Type*} [AddCommGroup K] [AddCommGroup O] [AddTorsor K A]

/-- The complete affine obstruction on the actual point torsor. -/
def IsAffineObstruction (R : K →+ O) (c : A → O) : Prop :=
  ∀ (x : K) (a : A), c (x +ᵥ a) = R x + c a

section Triangular

variable {P P' K O : Type*} [AddCommGroup O]

/-- Append one arbitrary-tail block to an already solved prefix.
The tail need not be additive, linear, polynomial, or pointed. -/
def triangularStep (earlierEquiv : P ≃ P') (diagonal : K ≃ O)
    (tail : P → O) : P × K ≃ P' × O where
  toFun x := (earlierEquiv x.1, diagonal x.2 + tail x.1)
  invFun y := (earlierEquiv.symm y.1,
    diagonal.symm (y.2 - tail (earlierEquiv.symm y.1)))
  left_inv x := by
    rcases x with ⟨p, k⟩
    simp
  right_inv y := by
    rcases y with ⟨p, o⟩
    simp

end Triangular

section DelayedStabilization

variable {L : ℕ → Type*} (truncate : ∀ n, L (n + 1) → L n)

/-- Stabilize two provisional digits by retaining their double
truncation. -/
def stabilizedLevel (provisional : ∀ n, L (n + 2)) (n : ℕ) : L n :=
  truncate n (truncate (n + 1) (provisional n))

end DelayedStabilization

end Litt3.Deformations
