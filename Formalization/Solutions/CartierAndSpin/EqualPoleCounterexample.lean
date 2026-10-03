import Solutions.CartierAndSpin.ValuationLeadingMoments

namespace Litt3.CartierAndSpin

open Finset IsLocalRing

variable {K Γ : Type*} [Field K] [LinearOrderedCommGroupWithZero Γ]

/-- A cohort of exactly p equal entries is invisible to every weighted power
trace in characteristic p, without any restriction on the moment exponents. -/
theorem characteristic_equal_cohort_weighted_moments_zero (p : ℕ) [CharP K p]
    (a u : K) (j k : ℕ) :
    finiteWeightedPowerSum (fun _ : Fin p => a) (fun _ => u) j k = 0 := by
  simp [finiteWeightedPowerSum, sum_const, nsmul_eq_mul]

/-- Actual sharpness example for every integer valuation ring whose fraction
field has characteristic p and has an actual pole t. All moment values
descend to zero in R while each tuple entry fails to descend to R. -/
theorem equal_pole_cohort_integrality_counterexample
    {R : Type*} [CommRing R] [IsLocalRing R] [Algebra R K]
    (v : Valuation K Γ) (hv : v.Integers R) (p : ℕ) [CharP K p] (hp : 0 < p)
    (a : R) (t : K) (ht : 1 < v t) :
    (∀ j k, ∃ b : R, algebraMap R K b =
      finiteWeightedPowerSum (fun _ : Fin p => algebraMap R K a) (fun _ => t) j k) ∧
    (∃ i : Fin p, ¬∃ b : R, algebraMap R K b = (fun _ : Fin p => t) i) := by
  constructor
  · intro j k
    exact ⟨0, by simp [characteristic_equal_cohort_weighted_moments_zero]⟩
  · refine ⟨⟨0, hp⟩, ?_⟩
    intro h
    obtain ⟨b, hb⟩ := h
    have hle := hv.map_le_one b
    rw [hb] at hle
    exact ht.not_ge hle

end Litt3.CartierAndSpin
