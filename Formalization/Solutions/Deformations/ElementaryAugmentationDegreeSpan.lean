import Definitions.Deformations.ElementaryAugmentationDegreeSpan
import Mathlib.Algebra.CharP.Lemmas

namespace Litt3.Deformations

open scoped BigOperators

variable {R : Type*} [CommRing R] [Nontrivial R]

/-- An actual zero scalar q removes all positive scalar-power monomials,
leaving exactly the original degree span. This also covers prime powers
in smaller characteristic, and needs neither a field nor primality. -/
theorem elementary_normal_weight_zero_scalar_degree (q : ℕ) (positive : 0 < q)
    (scalarZero : (q : R) = 0) (r d : ℕ) :
    elementaryNormalWeightFiltration R q positive r d =
      elementaryAugmentationDegreeSpan R q positive r d := by
  classical
  apply le_antisymm
  · apply Submodule.span_le.mpr
    rintro x ⟨j, alpha, high, rfl⟩
    by_cases zero : j = 0
    · subst j
      simp only [Nat.mul_zero, zero_add, pow_zero, one_smul] at high ⊢
      exact Submodule.subset_span ⟨alpha, high, rfl⟩
    · simp only [scalarZero, zero_pow zero, zero_smul]
      exact Submodule.zero_mem _
  · apply Submodule.span_le.mpr
    rintro x ⟨alpha, high, rfl⟩
    apply Submodule.subset_span
    exact ⟨0, alpha, by simpa using high, by simp⟩

theorem elementary_normal_weight_characteristic_degree (q : ℕ) (positive : 0 < q)
    [CharP R q] (r d : ℕ) :
    elementaryNormalWeightFiltration R q positive r d =
      elementaryAugmentationDegreeSpan R q positive r d :=
  elementary_normal_weight_zero_scalar_degree q positive (CharP.cast_eq_zero R q) r d

end Litt3.Deformations
