import Theorems.Deformations.CyclicMultiplicityProfile
import Mathlib.Tactic.Ring
import Lean.Elab.Tactic.Omega

namespace Litt3.Deformations

theorem minimum_second_difference (a j : ℕ) (positive : 0 < a) :
    min (a - 1) j + min (a + 1) j + (if j = a then 1 else 0) = 2 * min a j := by
  split_ifs <;> omega

variable {ι κ : Type*} [Fintype ι] [Fintype κ]

/-- The exact multiplicity at each positive degree is the
second difference of its intrinsic power-kernel profile. -/
theorem cyclic_multiplicity_profile_identity (degree multiplicity : ι → ℕ)
    (a : ℕ) (positive : 0 < a) :
    cyclicDimensionProfile degree multiplicity (a - 1) +
      cyclicDimensionProfile degree multiplicity (a + 1) +
      cyclicMultiplicityAt degree multiplicity a =
        2 * cyclicDimensionProfile degree multiplicity a := by
  unfold cyclicDimensionProfile cyclicMultiplicityAt
  rw [← Finset.sum_add_distrib, ← Finset.sum_add_distrib, Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro i _
  calc
    _ = multiplicity i * (min (a - 1) (degree i) + min (a + 1) (degree i) +
        (if degree i = a then 1 else 0)) := by split_ifs <;> ring
    _ = _ := by rw [minimum_second_difference a (degree i) positive]; ring

/-- Complete cyclic multiplicity uniqueness follows from
the actual power-kernel profile, uniformly in finite index
types and all positive lengths. -/
theorem cyclic_multiplicity_profile_unique (degree multiplicity : ι → ℕ)
    (degree' multiplicity' : κ → ℕ) :
    Specifications.CyclicMultiplicityProfileUnique degree multiplicity degree' multiplicity' := by
  intro equalProfile a positive
  have h := cyclic_multiplicity_profile_identity degree multiplicity a positive
  have h' := cyclic_multiplicity_profile_identity degree' multiplicity' a positive
  rw [equalProfile (a - 1), equalProfile (a + 1), equalProfile a] at h
  omega

end Litt3.Deformations
