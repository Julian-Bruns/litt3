import Solutions.CartierAndSpin.FiniteRootPolynomial
import Mathlib.RingTheory.Valuation.Basic
import Mathlib.Algebra.Order.BigOperators.Ring.Finset

namespace Litt3.CartierAndSpin

open Finset Classical

variable {K Γ ι : Type*} [Field K] [LinearOrderedCommGroupWithZero Γ] [Fintype ι]

theorem finiteElementarySymmetric_eq_finset_sum (u : ι → K) (k : ℕ) :
    finiteElementarySymmetric u k =
      ∑ s ∈ powersetCard k univ, ∏ i ∈ s, u i := by
  classical
  simp [finiteElementarySymmetric, MvPolynomial.esymm]

/-- The product of all maximal-valued entries is the unique dominant term
of the elementary symmetric function of that cohort size. This is a general
valuation identity, with no residue characteristic or degree restriction. -/
theorem maximal_cohort_elementarySymmetric_value (v : Valuation K Γ) (u : ι → K)
    (i₀ : ι) (hvalues : ∀ i, u i ≠ 0) (hmax : ∀ i, v (u i) ≤ v (u i₀)) :
    v (finiteElementarySymmetric u
      (univ.filter fun i => v (u i) = v (u i₀)).card) =
      v (u i₀) ^ (univ.filter fun i => v (u i) = v (u i₀)).card := by
  let cohort := univ.filter fun i => v (u i) = v (u i₀)
  have hvalue : v (∏ i ∈ cohort, u i) = v (u i₀) ^ cohort.card := by
    rw [map_prod]
    exact prod_eq_pow_card (fun i hi => (mem_filter.mp hi).2)
  rw [finiteElementarySymmetric_eq_finset_sum]
  change v (∑ s ∈ powersetCard cohort.card univ, ∏ i ∈ s, u i) =
    v (u i₀) ^ cohort.card
  rw [v.map_sum_eq_of_lt (j := cohort) (mem_powersetCard.mpr ⟨subset_univ _, rfl⟩) ?_]
  · exact hvalue
  · intro s hs
    obtain ⟨hs, hne⟩ := mem_sdiff.mp hs
    have hcard : s.card = cohort.card := (mem_powersetCard.mp hs).2
    have hnot_subset : ¬s ⊆ cohort := by
      intro hsub
      exact hne (by simpa only [mem_singleton] using eq_of_subset_of_card_le hsub hcard.ge)
    obtain ⟨i, hi, hico⟩ := not_subset.mp hnot_subset
    have hstrict : v (u i) < v (u i₀) := by
      apply lt_of_le_of_ne (hmax i)
      intro heq
      exact hico (mem_filter.mpr ⟨mem_univ _, heq⟩)
    rw [hvalue, map_prod]
    have hprodlt := Finset.prod_lt_prod (s := s) (g := fun _ => v (u i₀))
      (fun j _ => v.pos_iff.mpr (hvalues j)) (fun j _ => hmax j) ⟨i, hi, hstrict⟩
    simpa only [prod_const, hcard] using hprodlt

theorem maximal_pole_cohort_symmetric_coefficient_nonregular (v : Valuation K Γ)
    (u : ι → K) (i₀ : ι) (hvalues : ∀ i, u i ≠ 0)
    (hmax : ∀ i, v (u i) ≤ v (u i₀)) (hpole : 1 < v (u i₀)) :
    1 < v (finiteElementarySymmetric u
      (univ.filter fun i => v (u i) = v (u i₀)).card) := by
  rw [maximal_cohort_elementarySymmetric_value v u i₀ hvalues hmax]
  apply one_lt_pow₀ hpole
  exact card_ne_zero.mpr ⟨i₀, mem_filter.mpr ⟨mem_univ _, rfl⟩⟩

end Litt3.CartierAndSpin
