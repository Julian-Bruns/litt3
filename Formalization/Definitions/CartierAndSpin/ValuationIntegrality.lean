import Definitions.CartierAndSpin.CohortPowerSums
import Mathlib.RingTheory.Valuation.ValuationRing
import Mathlib.RingTheory.LocalRing.ResidueField.Basic

namespace Litt3.CartierAndSpin

open Finset IsLocalRing Classical

variable {R K Γ ι : Type*} [CommRing R] [IsLocalRing R] [Field K]
  [Algebra R K] [LinearOrderedCommGroupWithZero Γ] [Fintype ι]

/-- The intrinsic hypothesis counts only the maximal poles, conditional on
there being a pole. Counts use actual residue classes in the actual residue
field; no pole restriction is made on any other cohort. -/
def MaximalPoleCohortsBounded (v : Valuation K Γ) (a : ι → R) (u : ι → K)
    (d r : ℕ) : Prop :=
  ∀ i₀, 1 < v (u i₀) → (∀ i, v (u i) ≤ v (u i₀)) →
    ((univ.filter fun i => v (u i) = v (u i₀)).image (fun i => residue R (a i))).card ≤ d ∧
      ∀ c : ResidueField R,
        (univ.filter fun i => v (u i) = v (u i₀) ∧ residue R (a i) = c).card ≤ r

end Litt3.CartierAndSpin
