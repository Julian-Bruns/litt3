import Solutions.CartierAndSpin.ReciprocalTraceUnits
import Solutions.CartierAndSpin.CharacteristicBoundaryCohort
import Solutions.CartierAndSpin.MaximalSymmetricValue

namespace Litt3.CartierAndSpin

open Finset IsLocalRing Classical

variable {R K Γ ι : Type*} [CommRing R] [IsLocalRing R] [Field K]
  [Algebra R K] [LinearOrderedCommGroupWithZero Γ] [Fintype ι]

/-- At degree 2p, an actual pole forces precisely p equal-order pole
branches and p equal-order zero branches; their values are reciprocal.
The two cohorts exhaust the actual tuple. -/
theorem reciprocal_trace_boundary_pole_zero_partition (v : Valuation K Γ)
    (hv : v.Integers R) (p : ℕ) [CharP (ResidueField R) p] (hp : 0 < p)
    (u : ι → K) (hdegree : Fintype.card ι = 2 * p)
    (hnorm : v (∏ i, u i) = 1)
    (hforward : ∀ k, 0 < k → k < p → v (finitePowerSum u k) ≤ 1)
    (hreciprocal : ∀ k, 0 < k → k < p →
      v (finitePowerSum (fun i => (u i)⁻¹) k) ≤ 1)
    (i : ι) (hipole : 1 < v (u i)) :
    ∃ i₀ j₀,
      1 < v (u i₀) ∧ 1 < v ((u j₀)⁻¹) ∧
      (∀ j, v (u j) ≤ v (u i₀)) ∧
      (∀ j, v ((u j)⁻¹) ≤ v ((u j₀)⁻¹)) ∧
      (univ.filter fun j => v (u j) = v (u i₀)).card = p ∧
      (univ.filter fun j => v ((u j)⁻¹) = v ((u j₀)⁻¹)).card = p ∧
      (∀ j, v (u j) = v (u i₀) ∨ v (u j) = v (u j₀)) ∧
      v (u i₀) * v (u j₀) = 1 := by
  have hproduct_nonzero : (∏ i, u i) ≠ 0 := by
    intro hzero
    simpa [hzero] using hnorm
  have hvalues : ∀ i, u i ≠ 0 :=
    fun i => prod_ne_zero_iff.mp hproduct_nonzero i (mem_univ _)
  obtain ⟨i₀, _, hmax⟩ := univ.exists_max_image (fun i => v (u i)) ⟨i, mem_univ _⟩
  have hmaximum : ∀ j, v (u j) ≤ v (u i₀) := fun j => hmax j (mem_univ _)
  have hpole₀ : 1 < v (u i₀) := lt_of_lt_of_le hipole (hmaximum i)
  obtain ⟨i₁, hzero₁⟩ := unit_norm_and_pole_force_zero v u hnorm i₀ hpole₀
  have hinversepole : 1 < v ((u i₁)⁻¹) := by
    rw [map_inv₀]
    exact (one_lt_inv₀ (v.pos_iff.mpr (hvalues i₁))).mpr hzero₁
  obtain ⟨j₀, _, hmaxinverse⟩ :=
    univ.exists_max_image (fun j => v ((u j)⁻¹)) ⟨i₁, mem_univ _⟩
  have hmaximuminverse : ∀ j, v ((u j)⁻¹) ≤ v ((u j₀)⁻¹) :=
    fun j => hmaxinverse j (mem_univ _)
  have hpoleinverse : 1 < v ((u j₀)⁻¹) :=
    lt_of_lt_of_le hinversepole (hmaximuminverse i₁)
  let poles := univ.filter fun j => v (u j) = v (u i₀)
  let zeros := univ.filter fun j => v ((u j)⁻¹) = v ((u j₀)⁻¹)
  have hpoles : p ≤ poles.card := regularPowerSums_maximal_pole_cohort_card_ge
    v hv p u i₀ hpole₀ hmaximum hforward
  have hzeros : p ≤ zeros.card := regularPowerSums_maximal_pole_cohort_card_ge
    v hv p (fun j => (u j)⁻¹) j₀ hpoleinverse hmaximuminverse hreciprocal
  have hdisjoint : Disjoint poles zeros := by
    apply disjoint_left.mpr
    intro j hjpole hjzero
    have hvalpole : 1 < v (u j) := by
      simpa only [(mem_filter.mp hjpole).2] using hpole₀
    have hvalinverse : 1 < v ((u j)⁻¹) := by
      simpa only [(mem_filter.mp hjzero).2] using hpoleinverse
    rw [map_inv₀] at hvalinverse
    exact lt_asymm hvalpole (one_lt_inv_iff₀.mp hvalinverse).2
  have hcardtotal : poles.card + zeros.card ≤ Fintype.card ι := by
    rw [← card_union_of_disjoint hdisjoint]
    exact (card_le_card (subset_univ _)).trans_eq card_univ
  have hpcard : poles.card = p := by omega
  have hzcard : zeros.card = p := by omega
  have hunion : poles ∪ zeros = univ := by
    apply eq_of_subset_of_card_le (subset_univ _)
    rw [card_univ, card_union_of_disjoint hdisjoint, hpcard, hzcard, hdegree]
    omega
  have hzero_values : ∀ j ∈ zeros, v (u j) = v (u j₀) := by
    intro j hj
    have h := (mem_filter.mp hj).2
    simp only [map_inv₀] at h
    exact inv_injective h
  have hpartition : ∀ j, v (u j) = v (u i₀) ∨ v (u j) = v (u j₀) := by
    intro j
    have hj : j ∈ poles ∪ zeros := hunion ▸ mem_univ j
    rcases mem_union.mp hj with hj | hj
    · exact Or.inl (mem_filter.mp hj).2
    · exact Or.inr (hzero_values j hj)
  have hprod_poles : (∏ j ∈ poles, v (u j)) = v (u i₀) ^ p := by
    rw [prod_eq_pow_card (fun j hj => (mem_filter.mp hj).2), hpcard]
  have hprod_zeros : (∏ j ∈ zeros, v (u j)) = v (u j₀) ^ p := by
    rw [prod_eq_pow_card hzero_values, hzcard]
  have hproduct_values : (v (u i₀) * v (u j₀)) ^ p = 1 := by
    rw [mul_pow, ← hprod_poles, ← hprod_zeros, ← prod_union hdisjoint, hunion]
    simpa only [map_prod] using hnorm
  have hreciprocal_values : v (u i₀) * v (u j₀) = 1 :=
    (pow_eq_one_iff_of_nonneg (zero_le' : (0 : Γ) ≤ v (u i₀) * v (u j₀)) hp.ne').mp
      hproduct_values
  exact ⟨i₀, j₀, hpole₀, hpoleinverse, hmaximum, hmaximuminverse,
    hpcard, hzcard, hpartition, hreciprocal_values⟩

end Litt3.CartierAndSpin
