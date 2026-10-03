import Solutions.Deformations.FiniteFieldNormalCoordinates

namespace Litt3.Deformations

open scoped BigOperators

variable {J K : Type*} [Fintype J] [Field K]

/-- Actual invertible diagonal scaling of every original coefficient. -/
noncomputable def diagonalPowerCoordinates (c : K) (nonzero : c ≠ 0) (w : J → ℕ) :
    (J → K) ≃ₗ[K] (J → K) where
  toFun x j := c ^ w j * x j
  invFun x j := c⁻¹ ^ w j * x j
  left_inv x := by
    ext j
    change c⁻¹ ^ w j * (c ^ w j * x j) = x j
    rw [← mul_assoc, ← mul_pow, inv_mul_cancel₀ nonzero, one_pow, one_mul]
  right_inv x := by
    ext j
    change c ^ w j * (c⁻¹ ^ w j * x j) = x j
    rw [← mul_assoc, ← mul_pow, mul_inv_cancel₀ nonzero, one_pow, one_mul]
  map_add' _ _ := by ext j; simp [mul_add]
  map_smul' a x := by ext j; change c ^ w j * (a * x j) = a * (c ^ w j * x j); ring

variable (F K : Type*) [Field F] [Fintype F] [DecidableEq F] [Field K]
variable {I : Type*} [Fintype I] [DecidableEq I]

/-- Actual finite-field normal evaluation with every original coordinate
scaled by the same nonzero field element. -/
noncomputable def scaledFiniteFieldNormalCoordinates (φ : F →+* K) (c : K) (nonzero : c ≠ 0) :
    ((I → Fin (Fintype.card F - 1 + 1)) → K) ≃ₗ[K] ((I → F) → K) :=
  (diagonalPowerCoordinates c nonzero (fun alpha => ∑ i, (alpha i).val)).trans
    (finiteFieldNormalFunctionCoordinates F K φ)

theorem scaled_finite_field_normal_coordinates_apply (φ : F →+* K) (c : K) (nonzero : c ≠ 0)
    (b : (I → Fin (Fintype.card F - 1 + 1)) → K) (a : I → F) :
    scaledFiniteFieldNormalCoordinates (I := I) F K φ c nonzero b a =
      ∑ alpha : I → Fin (Fintype.card F - 1 + 1), b alpha *
        (∏ i, (c * φ (a i)) ^ (alpha i).val) := by
  rw [scaledFiniteFieldNormalCoordinates, LinearEquiv.trans_apply,
    finite_field_normal_function_coordinates_apply]
  apply Finset.sum_congr rfl
  intro alpha _
  change (c ^ (∑ i, (alpha i).val) * b alpha) *
    (∏ i, φ (a i) ^ (alpha i).val) = _
  simp_rw [mul_pow]
  rw [Finset.prod_mul_distrib, ← Finset.prod_pow_eq_pow_sum]
  ring

end Litt3.Deformations
