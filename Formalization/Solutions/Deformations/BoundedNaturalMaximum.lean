import Theorems.Deformations.BoundedNaturalMaximum
import Lean.Elab.Tactic.Omega

namespace Litt3.Deformations

theorem bounded_natural_maximum_upper {ι : Type*} (f : ι → ℕ)
    (bounded : ∃ n, ∀ i, f i ≤ n) : ∀ i, f i ≤ boundedNaturalMaximum f bounded := by
  classical
  exact Nat.find_spec bounded

theorem bounded_natural_maximum_le {ι : Type*} (f : ι → ℕ)
    (bounded : ∃ n, ∀ i, f i ≤ n) (n : ℕ) (upper : ∀ i, f i ≤ n) :
    boundedNaturalMaximum f bounded ≤ n := by
  classical
  exact Nat.find_min' bounded upper

/-- Every bounded natural family indexed by any nonempty
type has an actual attained maximum. No enumeration is used. -/
theorem bounded_natural_maximum_attained {ι : Type*} [Nonempty ι] (f : ι → ℕ)
    (bounded : ∃ n, ∀ i, f i ≤ n) :
    Specifications.AttainedNaturalMaximum f (boundedNaturalMaximum f bounded) := by
  classical
  refine ⟨bounded_natural_maximum_upper f bounded, ?_⟩
  by_cases hz : boundedNaturalMaximum f bounded = 0
  · refine ⟨Classical.choice (inferInstance : Nonempty ι), ?_⟩
    have h := bounded_natural_maximum_upper f bounded
      (Classical.choice (inferInstance : Nonempty ι))
    omega
  · have hpositive : 0 < boundedNaturalMaximum f bounded := by omega
    have hlt : boundedNaturalMaximum f bounded - 1 < boundedNaturalMaximum f bounded := by omega
    have hnot : ¬ ∀ i, f i ≤ boundedNaturalMaximum f bounded - 1 :=
      Nat.find_min bounded hlt
    obtain ⟨i, hi⟩ := not_forall.mp hnot
    refine ⟨i, ?_⟩
    have upper := bounded_natural_maximum_upper f bounded i
    omega

end Litt3.Deformations
