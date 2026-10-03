import Definitions.CartierAndSpin.CohortPowerSums
import Mathlib.Algebra.Polynomial.Eval.Defs
import Mathlib.RingTheory.LocalRing.ResidueField.Basic

namespace Litt3.CartierAndSpin.Specifications

open Polynomial

variable {R K ι : Type*} [CommRing R] [Field K] [Algebra R K] [Fintype ι]

/-- Actual regular weighted higher powers are equivalent to actual descent
of the quotient values. First powers are intentionally absent from the
input: the model supplies their regularity by monic division over R. -/
def IntegralCriticalMomentCriterion (w : ι → R) (U D : R[X]) (d r : ℕ) : Prop :=
  (∀ j, j < d → ∀ k, 2 ≤ k → k ≤ r →
    finiteWeightedPowerSum (fun i => algebraMap R K (w i))
      (fun i => U.eval₂ (algebraMap R K) (algebraMap R K (w i)) /
        D.eval₂ (algebraMap R K) (algebraMap R K (w i))) j k ∈
      (algebraMap R K).range) ↔
  ∀ i, U.eval₂ (algebraMap R K) (algebraMap R K (w i)) /
    D.eval₂ (algebraMap R K) (algebraMap R K (w i)) ∈ (algebraMap R K).range

end Litt3.CartierAndSpin.Specifications
