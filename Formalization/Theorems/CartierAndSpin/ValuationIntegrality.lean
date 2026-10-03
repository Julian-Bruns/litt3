import Definitions.CartierAndSpin.ValuationIntegrality

namespace Litt3.CartierAndSpin.Specifications

variable {R K Γ ι : Type*} [CommRing R] [IsLocalRing R] [Field K]
  [Algebra R K] [LinearOrderedCommGroupWithZero Γ] [Fintype ι]

/-- The weighted trace integrality clause over an actual valuation ring.
The conclusion is actual descent of every entry to R. -/
def WeightedPowerTraceIntegrality (v : Valuation K Γ) (a : ι → R)
    (u : ι → K) (d r : ℕ) : Prop :=
  MaximalPoleCohortsBounded v a u d r →
    (∀ j, j < d → ∀ k, 0 < k → k ≤ r →
      v (finiteWeightedPowerSum (fun i => algebraMap R K (a i)) u j k) ≤ 1) →
    ∀ i, ∃ b : R, algebraMap R K b = u i

end Litt3.CartierAndSpin.Specifications
