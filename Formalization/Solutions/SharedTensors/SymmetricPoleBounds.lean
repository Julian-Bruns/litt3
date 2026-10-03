import Solutions.CartierAndSpin.MaximalSymmetricValue
import Mathlib.Algebra.Order.BigOperators.Group.Finset

namespace Litt3.SharedTensors

open Litt3.CartierAndSpin Finset

variable {K Γ ι : Type*} [Field K] [LinearOrderedCommGroupWithZero Γ] [Fintype ι]

/-- Every elementary coefficient has poles bounded by the sum of the
individual pole orders. Repetitions and zero roots are retained, and the
bound is independent of the chosen coefficient index. -/
theorem elementarySymmetric_valuation_le_total_poles
    (v : Valuation K Γ) (u : ι → K) (j : ℕ) :
    v (finiteElementarySymmetric u j) ≤ ∏ i, max 1 (v (u i)) := by
  classical
  rw [finiteElementarySymmetric_eq_finset_sum]
  apply v.map_sum_le
  intro s _
  rw [map_prod]
  calc
    ∏ i ∈ s, v (u i) ≤ ∏ i ∈ s, max 1 (v (u i)) :=
      Finset.prod_le_prod' (fun i _ => le_max_right _ _)
    _ ≤ ∏ i, max 1 (v (u i)) :=
      Finset.prod_le_prod_of_subset_of_one_le' (subset_univ s)
        (fun i _ _ => le_max_left _ _)

end Litt3.SharedTensors
