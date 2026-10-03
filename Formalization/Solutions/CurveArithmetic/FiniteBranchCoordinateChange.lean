import Solutions.CurveArithmetic.FiniteBranchPolynomial
import Solutions.CurveArithmetic.AffineParameters
import Mathlib.Tactic

namespace Litt3.CurveArithmetic

open scoped Classical

theorem finite_base_polynomial_product
    (K : Type*) [Field K] [Fintype K] :
    (∏ c : K, (Polynomial.X - Polynomial.C c)) =
      (Polynomial.X ^ Fintype.card K - Polynomial.X : Polynomial K) := by
  classical
  have hmonic : (Polynomial.X ^ Fintype.card K - Polynomial.X : Polynomial K).Monic := by
    apply Polynomial.monic_X_pow_sub
    simp only [Polynomial.degree_X]
    exact_mod_cast (Fintype.one_lt_card (α := K))
  have hroots : (Polynomial.X ^ Fintype.card K - Polynomial.X : Polynomial K).roots.card =
      (Polynomial.X ^ Fintype.card K - Polynomial.X : Polynomial K).natDegree := by
    rw [FiniteField.roots_X_pow_card_sub_X, ← Finset.card_def, Finset.card_univ,
      FiniteField.X_pow_card_sub_X_natDegree_eq K Fintype.one_lt_card]
  have h := Polynomial.prod_multiset_X_sub_C_of_monic_of_roots_card_eq hmonic hroots
  rw [FiniteField.roots_X_pow_card_sub_X] at h
  exact h

theorem finite_base_difference_product
    {K L : Type*} [Field K] [Fintype K] [Field L] [Algebra K L] (u : L) :
    (∏ c : K, (u - algebraMap K L c)) = u ^ Fintype.card K - u := by
  have h := congrArg (Polynomial.eval₂RingHom (algebraMap K L) u)
    (finite_base_polynomial_product K)
  simpa only [map_prod, Polynomial.coe_eval₂RingHom, Polynomial.eval₂_sub,
    Polynomial.eval₂_pow, Polynomial.eval₂_X, Polynomial.eval₂_C] using h

theorem finite_base_removed_difference_product
    {K L : Type*} [Field K] [Fintype K] [Field L] [Algebra K L]
    (u : L) (c : K) (hu : u ≠ algebraMap K L c) :
    (∏ s ∈ Finset.univ.erase c, (u - algebraMap K L s)) =
      (u ^ Fintype.card K - u) / (u - algebraMap K L c) := by
  classical
  apply (eq_div_iff (sub_ne_zero.mpr hu)).mpr
  rw [Finset.prod_erase_mul _ _ (Finset.mem_univ c), finite_base_difference_product]

/-- The unmarked reciprocal coordinate change for any finite base
field. It changes the branch point at infinity into the rational point
zero and the omitted rational point c into infinity. -/
theorem finite_branch_reciprocal_equation_identity
    {K L : Type*} [Field K] [Fintype K] [Field L] [Algebra K L]
    (c : K) (t x : L) (ht : t ≠ algebraMap K L c) (hx : x ≠ 0) :
    let u := algebraMap K L c + x⁻¹
    ((u ^ Fintype.card K - u) / (u - algebraMap K L c) * (u - t)) *
      x ^ (Fintype.card K + 1) =
      (t - algebraMap K L c) * (x ^ Fintype.card K - x) *
        (x - (t - algebraMap K L c)⁻¹) := by
  dsimp only
  have hfrob : (algebraMap K L c + x⁻¹) ^ Fintype.card K -
      (algebraMap K L c + x⁻¹) = (x⁻¹) ^ Fintype.card K - x⁻¹ := by
    let frob := FiniteField.frobeniusAlgHom K L
    change frob (algebraMap K L c + x⁻¹) - (algebraMap K L c + x⁻¹) = _
    rw [map_add, frob.commutes]
    change algebraMap K L c + (x⁻¹) ^ Fintype.card K -
      (algebraMap K L c + x⁻¹) = _
    ring
  rw [hfrob, add_sub_cancel_left, div_inv_eq_mul, pow_succ, inv_pow]
  field_simp [hx, sub_ne_zero.mpr ht]
  ring

theorem finite_branch_reciprocal_square_equation
    {K L : Type*} [Field K] [Fintype K] [Field L] [Algebra K L]
    (c : K) (t x V γ : L) (n : ℕ)
    (ht : t ≠ algebraMap K L c) (hx : x ≠ 0)
    (hn : Fintype.card K + 1 = 2 * n)
    (hγ : γ ^ 2 = t - algebraMap K L c)
    (hcurve : V ^ 2 =
      ((algebraMap K L c + x⁻¹) ^ Fintype.card K - (algebraMap K L c + x⁻¹)) /
        ((algebraMap K L c + x⁻¹) - algebraMap K L c) *
          ((algebraMap K L c + x⁻¹) - t)) :
    (V * x ^ n / γ) ^ 2 =
      (x ^ Fintype.card K - x) * (x - (t - algebraMap K L c)⁻¹) := by
  have hγnonzero : γ ≠ 0 := by
    intro hzero
    rw [hzero, zero_pow (by decide)] at hγ
    exact sub_ne_zero.mpr ht hγ.symm
  rw [div_pow, mul_pow, ← pow_mul, Nat.mul_comm n 2, ← hn, hcurve, hγ]
  apply (div_eq_iff (sub_ne_zero.mpr ht)).mpr
  have h := finite_branch_reciprocal_equation_identity c t x ht hx
  exact h.trans (by ring)

end Litt3.CurveArithmetic
