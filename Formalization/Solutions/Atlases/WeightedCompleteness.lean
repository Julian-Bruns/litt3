import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Tactic

namespace Litt3.Atlases

variable {ι : Type*} [Fintype ι]

/-- Positive actual weights make equality with the full total an exact
completeness certificate. Independent lower bounds are simultaneously exact. -/
theorem weighted_lower_bounds_complete (s : Finset ι) (w b : ι → ℕ)
    (positive : ∀ i, 0 < w i) (lower : ∀ i ∈ s, b i ≤ w i)
    (total : ∑ i ∈ s, b i = ∑ i, w i) :
    s = Finset.univ ∧ ∀ i, b i = w i := by
  classical
  have hle : ∑ i ∈ s, b i ≤ ∑ i ∈ s, w i := Finset.sum_le_sum lower
  have hs : s = Finset.univ := by
    apply Finset.eq_univ_of_forall
    intro i
    by_contra hi
    have hlt := Finset.sum_lt_sum_of_subset (Finset.subset_univ s)
      (Finset.mem_univ i) hi (positive i) (fun j _ _ => Nat.zero_le (w j))
    omega
  refine ⟨hs, ?_⟩
  rw [hs] at lower total
  intro i
  have hi := lower i (Finset.mem_univ i)
  apply le_antisymm hi
  by_contra hnot
  have hlt : b i < w i := by omega
  have hsum := Finset.sum_lt_sum lower ⟨i, Finset.mem_univ i, hlt⟩
  omega

theorem weighted_exact_lengths_complete_iff (s : Finset ι) (w : ι → ℕ)
    (positive : ∀ i, 0 < w i) :
    (∑ i ∈ s, w i = ∑ i, w i) ↔ s = Finset.univ := by
  constructor
  · intro total
    exact (weighted_lower_bounds_complete s w w positive (fun _ _ => le_rfl) total).1
  · intro hs
    rw [hs]

end Litt3.Atlases
