import Solutions.CartierAndSpin.CohortPowerSums
import Mathlib.LinearAlgebra.Vandermonde
import Mathlib.Tactic

namespace Litt3.CartierAndSpin

open Finset

variable {K ι : Type*} [Field K] [Fintype ι]

/-- Actual regrouping of weighted scalar moments into residue cohorts. -/
theorem cohortWeightedMoment_eq_fiber_sum {d : ℕ} (c : Fin d → K)
    (label : ι → Fin d) (u : ι → K) (j k : ℕ) :
    cohortWeightedMoment c label u j k =
      ∑ g, finitePowerSum (fun i : {i // label i = g} => u i) k * c g ^ j := by
  classical
  unfold cohortWeightedMoment
  rw [← Fintype.sum_fiberwise label (fun i => c (label i) ^ j * u i ^ k)]
  apply sum_congr rfl
  intro g _
  unfold finitePowerSum
  rw [sum_mul]
  apply sum_congr rfl
  intro i _
  rw [i.property, mul_comm]

/-- Distinct residues and all weights below the number of residue classes
separate the actual power sum of each cohort. -/
theorem weighted_moments_separate_cohort_powerSum {d : ℕ} (c : Fin d → K)
    (label : ι → Fin d) (u : ι → K) (k : ℕ) (hc : Function.Injective c)
    (hmoments : ∀ j : Fin d, cohortWeightedMoment c label u j.val k = 0) :
    ∀ g, finitePowerSum (fun i : {i // label i = g} => u i) k = 0 := by
  classical
  have hzero := Matrix.eq_zero_of_forall_pow_sum_mul_pow_eq_zero hc
    (v := fun g => finitePowerSum (fun i : {i // label i = g} => u i) k)
    (fun j => by simpa [cohortWeightedMoment_eq_fiber_sum] using hmoments j)
  exact fun g => congrFun hzero g

/-- The characteristic-free cohort obstruction uses only that integers
through r are nonzero in the field. It applies in characteristic zero too. -/
theorem weighted_cohort_moments_force_empty {d r : ℕ} (c : Fin d → K)
    (label : ι → Fin d) (u : ι → K) (hc : Function.Injective c)
    (hvalues : ∀ i, u i ≠ 0)
    (hsizes : ∀ g, Fintype.card {i // label i = g} ≤ r)
    (hchar : ∀ m, 0 < m → m ≤ r → (m : K) ≠ 0)
    (hmoments : ∀ j : Fin d, ∀ k, 0 < k → k ≤ r →
      cohortWeightedMoment c label u j.val k = 0) : IsEmpty ι := by
  classical
  constructor
  intro i
  let g := label i
  let fiber := {i // label i = g}
  have hpositive : 0 < Fintype.card fiber :=
    Fintype.card_pos_iff.mpr ⟨⟨i, rfl⟩⟩
  apply newtonCohortObstruction (fun i : fiber => u i)
    (fun i => hvalues i) (hchar _ hpositive (hsizes g))
  intro k hk hkle
  exact weighted_moments_separate_cohort_powerSum c label u k hc
    (fun j => hmoments j k hk (le_trans hkle (hsizes g))) g

/-- In residue characteristic p, fewer than p entries in each residue cohort
make simultaneous low weighted power-sum vanishing impossible for a nonempty
family of nonzero leading coefficients. -/
theorem characteristic_weighted_cohort_moments_force_empty {d r : ℕ}
    (p : ℕ) [CharP K p] (c : Fin d → K) (label : ι → Fin d) (u : ι → K)
    (hc : Function.Injective c) (hvalues : ∀ i, u i ≠ 0)
    (hsizes : ∀ g, Fintype.card {i // label i = g} ≤ r) (hrp : r < p)
    (hmoments : ∀ j : Fin d, ∀ k, 0 < k → k ≤ r →
      cohortWeightedMoment c label u j.val k = 0) : IsEmpty ι := by
  apply weighted_cohort_moments_force_empty c label u hc hvalues hsizes ?_ hmoments
  intro m hm hmr
  rw [Ne, CharP.cast_eq_zero_iff K p]
  exact Nat.not_dvd_of_pos_of_lt hm (lt_of_le_of_lt hmr hrp)

end Litt3.CartierAndSpin
