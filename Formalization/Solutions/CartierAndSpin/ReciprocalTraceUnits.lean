import Solutions.CartierAndSpin.ValuationMaximalCohorts

namespace Litt3.CartierAndSpin

open Finset IsLocalRing Classical

variable {R K Γ ι : Type*} [CommRing R] [IsLocalRing R] [Field K]
  [Algebra R K] [LinearOrderedCommGroupWithZero Γ] [Fintype ι]

/-- Actual regular forward and reciprocal power traces with a unit norm
force a unit tuple below degree 2p. This holds over arbitrary valuation
rings, not only discrete valuation rings. -/
theorem reciprocal_power_traces_force_units_below_twice_characteristic
    (v : Valuation K Γ) (hv : v.Integers R) (p : ℕ) [CharP (ResidueField R) p]
    (u : ι → K) (hdegree : Fintype.card ι < 2 * p)
    (hnorm : v (∏ i, u i) = 1)
    (hforward : ∀ k, 0 < k → k < p → v (finitePowerSum u k) ≤ 1)
    (hreciprocal : ∀ k, 0 < k → k < p →
      v (finitePowerSum (fun i => (u i)⁻¹) k) ≤ 1) :
    ∀ i, ∃ b : R, IsUnit b ∧ algebraMap R K b = u i := by
  have hproduct_nonzero : (∏ i, u i) ≠ 0 := by
    intro hzero
    simpa [hzero] using hnorm
  have hvalues_nonzero : ∀ i, u i ≠ 0 :=
    fun i => prod_ne_zero_iff.mp hproduct_nonzero i (mem_univ _)
  have hno_poles : ∀ i, v (u i) ≤ 1 := by
    intro i
    by_contra hpole
    have hipole : 1 < v (u i) := lt_of_not_ge hpole
    obtain ⟨i₀, _, hmax⟩ := univ.exists_max_image (fun i => v (u i)) ⟨i, mem_univ _⟩
    have hmaximum : ∀ j, v (u j) ≤ v (u i₀) := fun j => hmax j (mem_univ _)
    have hpole₀ : 1 < v (u i₀) := lt_of_lt_of_le hipole (hmaximum i)
    obtain ⟨i₁, hzero₁⟩ := unit_norm_and_pole_force_zero v u hnorm i₀ hpole₀
    have hinversepole : 1 < v ((u i₁)⁻¹) := by
      rw [map_inv₀]
      exact (one_lt_inv₀ (v.pos_iff.mpr (hvalues_nonzero i₁))).mpr hzero₁
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
      exact (card_le_card (subset_univ _)).trans_eq (card_univ)
    omega
  have hprod : (∏ i, v (u i)) = 1 := by simpa only [map_prod] using hnorm
  have hunit_values : ∀ i, v (u i) = 1 :=
    fun i => (prod_eq_one_iff_of_le_one' (fun i _ => hno_poles i)).mp hprod i (mem_univ _)
  intro i
  obtain ⟨b, hb⟩ := hv.exists_of_le_one (hno_poles i)
  refine ⟨b, hv.isUnit_of_one' ?_, hb⟩
  rw [hb]
  exact hunit_values i

end Litt3.CartierAndSpin
