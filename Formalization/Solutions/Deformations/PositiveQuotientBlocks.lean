import Definitions.Deformations.PositiveQuotientBlocks

namespace Litt3.Deformations

open Polynomial

variable {k ι : Type*} [CommRing k]

/-- The actual zero-length quotient has only its zero element. -/
theorem truncated_zero_length_eq_zero (v : TruncatedCoefficientRing k 0) : v = 0 := by
  induction v using AdjoinRoot.induction_on ((X : k[X]) ^ 0) with
  | ih P =>
    exact AdjoinRoot.mk_eq_zero.mpr (by simp)

/-- Removing zero summands is a genuine linear equivalence of the
actual full quotient products. No positive summand is discarded. -/
noncomputable def positiveQuotientBlocksEquiv (length : ι → ℕ) :
    (∀ i, TruncatedCoefficientRing k (length i)) ≃ₗ[k]
      (∀ i : {i // 0 < length i}, TruncatedCoefficientRing k (length i.1)) where
  __ := positiveBlockRestriction (k := k) length
  invFun := positiveBlockExtension (k := k) length
  left_inv v := by
    funext i
    by_cases h : 0 < length i
    · simp [positiveBlockExtension, positiveBlockRestriction, h]
    · have zero : length i = 0 := Nat.eq_zero_of_not_pos h
      have trivial : ∀ x : TruncatedCoefficientRing k (length i), x = 0 := by
        rw [zero]
        exact truncated_zero_length_eq_zero
      simpa [positiveBlockExtension, positiveBlockRestriction, h] using (trivial (v i)).symm
  right_inv v := by
    funext i
    simp [positiveBlockExtension, positiveBlockRestriction, i.2]

@[simp] theorem positive_quotient_blocks_equiv_apply (length : ι → ℕ)
    (v : ∀ i, TruncatedCoefficientRing k (length i)) (i : {i // 0 < length i}) :
    positiveQuotientBlocksEquiv length v i = v i.1 := rfl

end Litt3.Deformations
