import Solutions.CartierAndSpin.ValuationIntegrality
import Mathlib.RingTheory.DiscreteValuationRing.Basic

namespace Litt3.CartierAndSpin

open IsLocalRing

variable {R K ι : Type*} [CommRing R] [IsDomain R] [ValuationRing R]
  [Field K] [Algebra R K] [IsFractionRing R K] [Fintype ι]

/-- An actual valuation ring is the integer ring of its canonical valuation
on the actual fraction field. No separate integer-ring hypothesis is needed. -/
theorem valuationRing_valuation_integers : (ValuationRing.valuation R K).Integers R where
  hom_inj := IsFractionRing.injective R K
  map_le_one a := (ValuationRing.mem_integer_iff R K _).mpr ⟨a, rfl⟩
  exists_of_le_one := fun {x} h => (ValuationRing.mem_integer_iff R K x).mp h

/-- The source weighted power-trace criterion with actual R-membership
inputs and actual R-membership output. DVRs are included by their existing
valuation-ring instance; no rank-one or noetherian hypothesis is needed. -/
theorem valuationRing_weightedPowerTraceIntegrality (p : ℕ) [CharP (ResidueField R) p]
    (a : ι → R) (u : ι → K) (d r : ℕ) (hrp : r < p)
    (hcohorts : MaximalPoleCohortsBounded (ValuationRing.valuation R K) a u d r)
    (hmoments : ∀ j, j < d → ∀ k, 0 < k → k ≤ r →
      ∃ b : R, algebraMap R K b =
        finiteWeightedPowerSum (fun i => algebraMap R K (a i)) u j k) :
    ∀ i, ∃ b : R, algebraMap R K b = u i := by
  apply weightedPowerTraceIntegrality (ValuationRing.valuation R K)
    valuationRing_valuation_integers p a u d r hrp hcohorts
  intro j hj k hk hkr
  obtain ⟨b, hb⟩ := hmoments j hj k hk hkr
  rw [← hb]
  exact valuationRing_valuation_integers.map_le_one b

end Litt3.CartierAndSpin
