import Solutions.SharedTensors.SplitPolynomialPoleBounds
import Mathlib.LinearAlgebra.Lagrange

namespace Litt3.CartierAndSpin

open Polynomial Finset

variable {K Γ ι : Type*} [Field K] [LinearOrderedCommGroupWithZero Γ]

/-- All coefficients of an actual nodal product satisfy the full pole
product bound, even when roots or residues coincide. -/
theorem nodal_coefficient_valuation_bound (v : Valuation K Γ)
    (s : Finset ι) (node : ι → K) (j : ℕ) :
    v ((Lagrange.nodal s node).coeff j) ≤ ∏ i ∈ s, max 1 (v (node i)) := by
  classical
  by_cases hj : j ≤ s.card
  · have hcoeff := (s.val.map node).prod_X_sub_C_coeff (k := j)
      (by simpa only [Multiset.card_map, Finset.card] using hj)
    have hcoeff' : (Lagrange.nodal s node).coeff j =
        (-1) ^ (s.card - j) * (s.val.map node).esymm (s.card - j) := by
      simpa only [Lagrange.nodal, Finset.prod, Multiset.map_map,
        Function.comp_def, Multiset.card_map, Finset.card] using hcoeff
    rw [hcoeff', map_mul, map_pow, v.map_neg, map_one, one_pow, one_mul]
    simpa only [Multiset.map_map, Function.comp_def, Finset.prod] using
      Litt3.SharedTensors.multiset_esymm_valuation_le_total_poles v
        (s.val.map node) (s.card - j)
  · rw [coeff_eq_zero_of_natDegree_lt (by
      rw [Lagrange.natDegree_nodal]; omega), map_zero]
    exact zero_le'

/-- Actual weighted interpolation coefficients have the exact excluded
root pole budget. No injectivity of the nodes is needed for this bound. -/
theorem weighted_interpolation_coefficient_valuation_bound [DecidableEq ι]
    (v : Valuation K Γ) (s : Finset ι) (node weight : ι → K) (content : K)
    (bound : Γ)
    (hbudget : ∀ i ∈ s, v (weight i) * v content *
      (∏ k ∈ s.erase i, max 1 (v (node k))) ≤ bound) (j : ℕ) :
    v ((∑ i ∈ s, C (weight i * content) * Lagrange.nodal (s.erase i) node).coeff j) ≤
      bound := by
  rw [finset_sum_coeff]
  apply v.map_sum_le
  intro i hi
  rw [coeff_C_mul, map_mul, map_mul]
  exact (mul_le_mul' le_rfl
    (nodal_coefficient_valuation_bound v (s.erase i) node j)).trans (hbudget i hi)

/-- Primitive root-content normalization and regular weights force every
weighted interpolation coefficient into the actual valuation ring.
Leading coefficients may vanish in the residue field. -/
theorem regular_weighted_interpolation_coefficient [DecidableEq ι]
    (v : Valuation K Γ) (s : Finset ι) (node weight : ι → K) (content : K)
    (hcontent : v content * (∏ k ∈ s, max 1 (v (node k))) ≤ 1)
    (hweight : ∀ i ∈ s, v (weight i) ≤ 1) (j : ℕ) :
    v ((∑ i ∈ s, C (weight i * content) * Lagrange.nodal (s.erase i) node).coeff j) ≤ 1 := by
  apply weighted_interpolation_coefficient_valuation_bound v s node weight content 1
  intro i hi
  have hremaining : (∏ k ∈ s.erase i, max 1 (v (node k))) ≤
      ∏ k ∈ s, max 1 (v (node k)) := by
    calc
      (∏ k ∈ s.erase i, max 1 (v (node k))) ≤
          (∏ k ∈ s.erase i, max 1 (v (node k))) * max 1 (v (node i)) :=
        le_mul_of_one_le_right' (le_max_left _ _)
      _ = _ := prod_erase_mul _ _ hi
  calc
    v (weight i) * v content * (∏ k ∈ s.erase i, max 1 (v (node k))) ≤
        1 * v content * (∏ k ∈ s.erase i, max 1 (v (node k))) :=
      mul_le_mul' (mul_le_mul' (hweight i hi) le_rfl) le_rfl
    _ = v content * (∏ k ∈ s.erase i, max 1 (v (node k))) := by rw [one_mul]
    _ ≤ v content * (∏ k ∈ s, max 1 (v (node k))) := mul_le_mul' le_rfl hremaining
    _ ≤ 1 := hcontent

end Litt3.CartierAndSpin
