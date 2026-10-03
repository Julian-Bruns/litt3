import Mathlib.Algebra.Group.Subgroup.Ker
import Mathlib.Algebra.Group.Torsion

namespace Litt3.SharedTensors

variable {A B : Type*} [AddGroup A] [AddGroup B]

/-- A kernel with torsion-free target contains every integral root of its elements. -/
def KernelRootsSaturated (f : A →+ B) : Prop :=
  ∀ (n : ℕ), n ≠ 0 → ∀ a : A,
    (∃ x : A, n • x = a) ∧ a ∈ f.ker ↔
      ∃ x : f.ker, n • (x : A) = a

end Litt3.SharedTensors
