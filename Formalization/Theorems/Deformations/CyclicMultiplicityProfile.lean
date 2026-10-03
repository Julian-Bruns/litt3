import Definitions.Deformations.CyclicMultiplicityProfile

namespace Litt3.Deformations.Specifications

variable {ι κ : Type*} [Fintype ι] [Fintype κ]

def CyclicMultiplicityProfileUnique (degree multiplicity : ι → ℕ)
    (degree' multiplicity' : κ → ℕ) : Prop :=
  (∀ a, cyclicDimensionProfile degree multiplicity a =
    cyclicDimensionProfile degree' multiplicity' a) →
  ∀ a, 0 < a → cyclicMultiplicityAt degree multiplicity a =
    cyclicMultiplicityAt degree' multiplicity' a

end Litt3.Deformations.Specifications
