import Solutions.CartierAndSpin.WeightedCohorts

namespace Litt3.CartierAndSpin

open Finset Classical

variable {K ι : Type*} [Field K] [Fintype ι]

/-- Zero scalar values contribute nothing to positive power moments. -/
theorem finiteWeightedPowerSum_restrict_nonzero (a u : ι → K) (j k : ℕ)
    (hk : 0 < k) :
    finiteWeightedPowerSum a u j k =
      ∑ i : {i // u i ≠ 0}, a i ^ j * u i ^ k := by
  classical
  unfold finiteWeightedPowerSum
  rw [← Fintype.sum_subtype_add_sum_subtype (fun i => u i ≠ 0)
    (fun i => a i ^ j * u i ^ k)]
  have hzero : (∑ i : {i // ¬u i ≠ 0}, a i ^ j * u i ^ k) = 0 := by
    apply sum_eq_zero
    intro i _
    have hi : u i = 0 := not_ne_iff.mp i.property
    simp [hi, hk.ne']
  rw [hzero, add_zero]

/-- Exact finite-cohort version that allows zero entries and uses the cohort
bound only on the support of the actual scalar family. -/
theorem finiteWeightedPowerSums_force_zero_of_cohort_assignment {d r s : ℕ}
    (p : ℕ) [CharP K p] (a u : ι → K) (c : Fin s → K)
    (label : {i // u i ≠ 0} → Fin s) (hc : Function.Injective c)
    (hclasses : ∀ i : {i // u i ≠ 0}, a i = c (label i))
    (hclasses_le : s ≤ d)
    (hsizes : ∀ g, Fintype.card {i : {i // u i ≠ 0} // label i = g} ≤ r)
    (hrp : r < p)
    (hmoments : ∀ j, j < d → ∀ k, 0 < k → k ≤ r →
      finiteWeightedPowerSum a u j k = 0) : ∀ i, u i = 0 := by
  classical
  have hempty : IsEmpty {i // u i ≠ 0} :=
    characteristic_weighted_cohort_moments_force_empty p c label
      (fun i => u i) hc (fun i => i.property) hsizes hrp (by
        intro j k hk hkr
        have hmoment := hmoments j.val (lt_of_lt_of_le j.isLt hclasses_le) k hk hkr
        rw [finiteWeightedPowerSum_restrict_nonzero a u j.val k hk] at hmoment
        simpa only [cohortWeightedMoment, ← hclasses] using hmoment)
  intro i
  by_contra hi
  exact hempty.false ⟨i, hi⟩

/-- Intrinsic form: the hypotheses count the actual distinct weights and
actual same-weight entries on the nonzero support. No cohort labeling is an
input, and no restriction is imposed on zero entries. -/
theorem finiteWeightedPowerSums_force_zero_of_support_counts {d r : ℕ}
    (p : ℕ) [CharP K p] (a u : ι → K)
    (hclasses : ((univ.filter fun i => u i ≠ 0).image a).card ≤ d)
    (hsizes : ∀ c : K, (univ.filter fun i => u i ≠ 0 ∧ a i = c).card ≤ r)
    (hrp : r < p)
    (hmoments : ∀ j, j < d → ∀ k, 0 < k → k ≤ r →
      finiteWeightedPowerSum a u j k = 0) : ∀ i, u i = 0 := by
  classical
  let classes := (univ.filter fun i => u i ≠ 0).image a
  let e : classes ≃ Fin classes.card :=
    (Fintype.equivFin classes).trans (finCongr (Fintype.card_coe classes))
  let c : Fin classes.card → K := fun g => (e.symm g).val
  let label : {i // u i ≠ 0} → Fin classes.card := fun i =>
    e ⟨a i, mem_image.mpr ⟨i, mem_filter.mpr ⟨mem_univ _, i.property⟩, rfl⟩⟩
  have hdistinct : Function.Injective c := Subtype.val_injective.comp e.symm.injective
  have hlabel : ∀ i : {i // u i ≠ 0}, a i = c (label i) := by
    intro i
    simp [c, label]
  apply finiteWeightedPowerSums_force_zero_of_cohort_assignment p a u c label
    hdistinct hlabel hclasses ?_ hrp hmoments
  intro g
  let f : {i : {i // u i ≠ 0} // label i = g} → {i // u i ≠ 0 ∧ a i = c g} :=
    fun i => ⟨i.val.val, i.val.property, by rw [hlabel i.val, i.property]⟩
  have hf : Function.Injective f := by
    intro i j hij
    apply Subtype.ext
    apply Subtype.ext
    exact congrArg (fun i => i.val) hij
  have hcard := Fintype.card_le_of_injective f hf
  rw [Fintype.card_subtype (fun i : ι => u i ≠ 0 ∧ a i = c g)] at hcard
  exact le_trans hcard (hsizes (c g))

end Litt3.CartierAndSpin
