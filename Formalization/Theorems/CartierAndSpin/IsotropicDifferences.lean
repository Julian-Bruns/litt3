import Definitions.CartierAndSpin.IsotropicDifferences

namespace Litt3.CartierAndSpin.Specifications

variable {K : Type*} [Field K]

/-- The full affine-line conclusion for arbitrary sets, including the empty
set and singleton, over an arbitrary field of characteristic different from 2. -/
def CoupledDifferencesLieInAffineLine (A : Set (Fin 3 → K)) : Prop :=
  (2 : K) ≠ 0 → (∀ r ∈ A, ∀ s ∈ A, coupledDifferenceQuadratic (r - s) = 0) →
    ∃ base direction : Fin 3 → K,
      ∀ r ∈ A, r - base ∈ Submodule.span K ({direction} : Set (Fin 3 → K))

end Litt3.CartierAndSpin.Specifications
