import Definitions.CartierAndSpin.CohortPowerSums

namespace Litt3.CartierAndSpin.Specifications

variable {K ι : Type*} [CommRing K] [Fintype ι]

/-- The precise Newton obstruction: a nonempty finite family of nonzero
scalars cannot have all its first m power sums zero when m is nonzero. -/
def NewtonCohortObstruction (u : ι → K) : Prop :=
  (∀ i, u i ≠ 0) → (Fintype.card ι : K) ≠ 0 →
    (∀ k, 0 < k → k ≤ Fintype.card ι → finitePowerSum u k = 0) → False

end Litt3.CartierAndSpin.Specifications
