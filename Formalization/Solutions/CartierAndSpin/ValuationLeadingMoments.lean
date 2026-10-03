import Solutions.CartierAndSpin.SupportWeightedCohorts
import Mathlib.RingTheory.Valuation.ValuationRing
import Mathlib.RingTheory.LocalRing.ResidueField.Basic
import Mathlib.Tactic

namespace Litt3.CartierAndSpin

open Finset IsLocalRing

variable {R K Γ ι : Type*} [CommRing R] [IsLocalRing R] [Field K]
  [Algebra R K] [LinearOrderedCommGroupWithZero Γ] [Fintype ι]

/-- Weighted power sums commute with any ring homomorphism. -/
theorem finiteWeightedPowerSum_map {A B : Type*} [CommRing A] [CommRing B]
    (f : A →+* B) (a u : ι → A) (j k : ℕ) :
    f (finiteWeightedPowerSum a u j k) =
      finiteWeightedPowerSum (fun i => f (a i)) (fun i => f (u i)) j k := by
  simp [finiteWeightedPowerSum]

theorem finiteWeightedPowerSum_div_right (a u : ι → K) (t : K) (j k : ℕ) :
    finiteWeightedPowerSum a (fun i => u i / t) j k =
      finiteWeightedPowerSum a u j k / t ^ k := by
  simp only [finiteWeightedPowerSum, div_pow, ← mul_div_assoc, sum_div]

/-- Scaling by an actual pole kills the residue of each regular weighted
moment. This uses arbitrary valuations and an actual ring of integers, with
no uniformizer expansion, rank-one assumption or characteristic restriction. -/
theorem regular_moment_scaled_residue_zero (v : Valuation K Γ)
    (hv : v.Integers R) (a b : ι → R) (u : ι → K) (t : K)
    (ht : 1 < v t) (hscaled : ∀ i, algebraMap R K (b i) = u i / t)
    (j k : ℕ) (hk : 0 < k)
    (hregular : v (finiteWeightedPowerSum (fun i => algebraMap R K (a i)) u j k) ≤ 1) :
    finiteWeightedPowerSum (fun i => residue R (a i))
      (fun i => residue R (b i)) j k = 0 := by
  let s := finiteWeightedPowerSum a b j k
  have hmaps : algebraMap R K s =
      finiteWeightedPowerSum (fun i => algebraMap R K (a i)) u j k / t ^ k := by
    rw [finiteWeightedPowerSum_map]
    simp only [hscaled]
    exact finiteWeightedPowerSum_div_right _ _ _ _ _
  have hval : v (algebraMap R K s) < 1 := by
    rw [hmaps, v.map_div, map_pow]
    apply (div_lt_one₀ (pow_pos (zero_lt_one.trans ht) k)).mpr
    exact lt_of_le_of_lt hregular (one_lt_pow₀ ht hk.ne')
  have hresidue : residue R s = 0 := by
    by_contra hnonzero
    have hunit : IsUnit s := (residue_ne_zero_iff_isUnit s).mp hnonzero
    have hone : v (algebraMap R K s) = 1 := hv.one_of_isUnit hunit
    exact hval.ne hone
  simpa only [s, finiteWeightedPowerSum_map] using hresidue

/-- The nonzero leading-coefficient support is exactly the maximal-valuation
cohort when the actual scaled representatives lie in the integer ring. -/
theorem scaled_residue_nonzero_iff_maximal_value (v : Valuation K Γ)
    (hv : v.Integers R) (b : R) (u t : K) (ht : v t ≠ 0)
    (hscaled : algebraMap R K b = u / t) :
    residue R b ≠ 0 ↔ v u = v t := by
  rw [residue_ne_zero_iff_isUnit, hv.isUnit_iff_valuation_eq_one, hscaled, v.map_div]
  exact div_eq_one_iff_eq ht

end Litt3.CartierAndSpin
