import Definitions.Deformations.MinimalComplex

namespace Litt3.Deformations.Specifications

variable {k ι : Type*} [CommRing k] [Fintype ι] [DecidableEq ι]

def MinimalHomotopyEquivalenceComponentsInvertible (N : ℕ) (positive : 0 < N)
    (A B : Matrix ι ι (TruncatedCoefficientRing k N)) : Prop :=
  ∀ w : MinimalTwoTermHomotopyEquivalence N positive A B,
    IsUnit w.f₀ ∧ IsUnit w.f₁

end Litt3.Deformations.Specifications
