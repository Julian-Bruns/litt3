import Mathlib.Analysis.InnerProductSpace.Basic
import Mathlib.Analysis.InnerProductSpace.PiL2

namespace Litt3.Jacobians.Targets

/-- An almost-fixed relation on a finite divisor orbit forces both
permutations to fix its coefficients. Reducing an Abel class relation
to this coefficient identity is a separate geometric theorem. -/
def FinitePermutationAlmostFixed : Prop :=
  ∀ (ι : Type) [Fintype ι] (σ τ : Equiv.Perm ι) (coefficient : ι → ℝ),
    (∀ i, coefficient (σ i) + coefficient (τ i) = 2 * coefficient i) →
    (∀ i, coefficient (σ i) = coefficient i) ∧
    (∀ i, coefficient (τ i) = coefficient i)

end Litt3.Jacobians.Targets
