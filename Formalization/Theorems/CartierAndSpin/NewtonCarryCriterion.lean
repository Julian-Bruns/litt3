import Theorems.CartierAndSpin.ReciprocalTraceBoundary

namespace Litt3.CartierAndSpin.Specifications

variable {R K ι : Type*} [CommRing R] [Field K] [Algebra R K] [Fintype ι]

/-- The exact source list of characteristic carries and additional traces
through N=n−p, with actual membership under the embedded ring map. -/
def NewtonCarryConditions (u : ι → K) (p : ℕ) : Prop :=
  (∀ k, 0 < k → k ≤ Fintype.card ι - p → p ∣ k →
    finiteElementarySymmetric u k ∈ (algebraMap R K).range) ∧
  (∀ k, p ≤ k → k ≤ Fintype.card ι - p → ¬p ∣ k →
    finitePowerSum u k ∈ (algebraMap R K).range)

end Litt3.CartierAndSpin.Specifications
