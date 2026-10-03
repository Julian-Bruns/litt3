import Solutions.Jacobians.DedekindPrincipalIdeals
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.Order.Monoid.Unbundled.Pow

open scoped nonZeroDivisors Classical
open IsDedekindDomain

namespace Litt3.Jacobians

variable (R K : Type*) [CommRing R] [IsDedekindDomain R]
  [Field K] [Algebra R K] [IsFractionRing R K]

/-- An actual nonzero fractional ideal is contained in the original ring
precisely when every actual prime-ideal count is nonnegative. -/
theorem dedekind_fractional_ideal_le_one_iff
    (I : (FractionalIdeal R⁰ K)ˣ) :
    I.val ≤ 1 ↔ ∀ v : HeightOneSpectrum R, 0 ≤ FractionalIdeal.count K v I.val := by
  constructor
  · intro h v
    simpa only [FractionalIdeal.count_one] using
      FractionalIdeal.count_mono K v I.ne_zero h
  · intro h
    let D := dedekindIdealDivisorMap R K (Additive.ofMul I)
    have hfactor : D.prod (fun v n => (v.asIdeal : FractionalIdeal R⁰ K) ^ n) = I.val := by
      rw [← dedekindDivisorIdealMap_value]
      exact congrArg (fun J => J.toMul.val) (dedekindDivisorIdealMap_idealDivisor R K _)
    rw [← hfactor, Finsupp.prod]
    apply Finset.prod_le_one'
    intro v hv
    have hn : 0 ≤ D v := h v
    have he : D v = (D v).toNat := (Int.toNat_of_nonneg hn).symm
    rw [he, zpow_natCast]
    induction (D v).toNat with
    | zero => simp
    | succ n ih =>
      rw [pow_succ]
      exact (mul_le_mul' ih FractionalIdeal.coeIdeal_le_one).trans (by simp)

/-- Literal fractional-ideal inclusion is exactly the reverse comparison of
the original integer prime-ideal counts, with no valuation-bound premise. -/
theorem dedekind_fractional_ideal_le_iff_counts
    (I J : (FractionalIdeal R⁰ K)ˣ) :
    I.val ≤ J.val ↔ ∀ v : HeightOneSpectrum R,
      FractionalIdeal.count K v J.val ≤ FractionalIdeal.count K v I.val := by
  constructor
  · intro h v
    exact FractionalIdeal.count_mono K v I.ne_zero h
  · intro h
    have hquot : (I * J⁻¹).val ≤ 1 := by
      apply (dedekind_fractional_ideal_le_one_iff R K (I * J⁻¹)).mpr
      intro v
      change 0 ≤ FractionalIdeal.count K v (I.val * J⁻¹.val)
      rw [FractionalIdeal.count_mul K v I.ne_zero J⁻¹.ne_zero]
      have hinv : FractionalIdeal.count K v J⁻¹.val = -FractionalIdeal.count K v J.val := by
        have he := FractionalIdeal.count_mul K v J.ne_zero J⁻¹.ne_zero
        have hunit : J.val * J⁻¹.val = 1 := by
          simpa only [Units.val_mul, Units.val_one] using
            congrArg Units.val (mul_inv_cancel J)
        rw [hunit, FractionalIdeal.count_one] at he
        omega
      rw [hinv]
      exact sub_nonneg.mpr (h v)
    have hm := mul_le_mul_right hquot J.val
    have hcancel : J.val * (I * J⁻¹).val = I.val := by
      simpa only [Units.val_mul] using
        congrArg Units.val (by simp [mul_comm] : J * (I * J⁻¹) = I)
    simpa only [hcancel, mul_one] using hm

/-- Membership in the literal divisor ideal is the genuine normalized
adic order bound at EVERY actual height-one point. -/
theorem dedekind_divisor_ideal_mem_iff_orders
    (D : Divisor (HeightOneSpectrum R)) (f : Kˣ) :
    f.val ∈ (dedekindDivisorIdealMap R K D).toMul.val ↔
      ∀ v, D v ≤ principalDivisorMap (dedekindValuationDivisorSystem R K)
        (Additive.ofMul f) v := by
  rw [← FractionalIdeal.spanSingleton_le_iff_mem]
  rw [← coe_toPrincipalIdeal]
  rw [dedekind_fractional_ideal_le_iff_counts R K]
  apply forall_congr'
  intro v
  have hD := congrArg (fun E => E v) (dedekindIdealDivisorMap_divisorIdeal R K D)
  have hf := congrArg (fun E => E v) (dedekindIdealDivisorMap_principal R K (Additive.ofMul f))
  change FractionalIdeal.count K v (dedekindDivisorIdealMap R K D).toMul.val = D v at hD
  change FractionalIdeal.count K v (toPrincipalIdeal R K f).val =
    principalDivisorMap (dedekindValuationDivisorSystem R K) (Additive.ofMul f) v at hf
  rw [hD, hf]

end Litt3.Jacobians
