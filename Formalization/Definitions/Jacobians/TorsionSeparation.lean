import Mathlib.Algebra.Group.Hom.Defs
import Mathlib.Data.Set.Basic

namespace Litt3.Jacobians

/-- A subset has disjoint translates by nonzero two-torsion exactly when
two of its points cannot differ by nonzero two-torsion. No variety or
Frobenius is hidden in this definition. -/
def TwoTorsionSeparated {A : Type*} [AddCommGroup A] (W : Set A) : Prop :=
  ∀ a ∈ W, ∀ b ∈ W, 2 • (b - a) = 0 → b = a

/-- An endomorphism preserves a subset. This is the geometric point-level
input supplied by a Frobenius-stable closed subvariety. -/
def PreservesSubset {A : Type*} [AddCommGroup A]
    (M : A →+ A) (W : Set A) : Prop := ∀ a ∈ W, M a ∈ W

end Litt3.Jacobians
