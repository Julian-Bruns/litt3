import Mathlib.FieldTheory.KummerPolynomial
import Mathlib.FieldTheory.Minpoly.Field
import Mathlib.Algebra.CharP.Reduced
import Mathlib.Tactic

namespace Litt3.CartierAndSpin

open Polynomial

variable {K L : Type*} [Field K] [Field L] [Algebra K L]

/-- The Frobenius factor X^p+f is irreducible whenever f is not a p-th
power, over an arbitrary field of prime characteristic. -/
theorem inseparable_factor_irreducible (p : ℕ) [CharP K p] (hp : p.Prime)
    (f : K) (hnot : ∀ a : K, a ^ p ≠ f) :
    Irreducible (X ^ p + C f) := by
  letI : Fact p.Prime := ⟨hp⟩
  have hneg : ∀ a : K, a ^ p ≠ -f := by
    intro a ha
    have hpow : (-a) ^ p = -(a ^ p) := map_neg (frobenius K p) a
    apply hnot (-a)
    rw [hpow, ha, neg_neg]
  simpa only [map_neg, sub_neg_eq_add] using
    (X_pow_sub_C_irreducible_of_prime hp hneg)

/-- Any actual p-th root of -f has the full degree-p minimal polynomial;
no p-basis, perfect constants, or function-field hypotheses are supplied. -/
theorem inseparable_root_minpoly (p : ℕ) [CharP K p] (hp : p.Prime)
    (f : K) (hnot : ∀ a : K, a ^ p ≠ f) (c : L)
    (hc : c ^ p = -algebraMap K L f) :
    minpoly K c = X ^ p + C f := by
  symm
  apply minpoly.eq_of_irreducible_of_monic
    (inseparable_factor_irreducible p hp f hnot)
  · simp only [map_add, map_pow, aeval_X, aeval_C, hc, neg_add_cancel]
  · exact monic_X_pow_add_C f hp.ne_zero

/-- A polynomial taking a constant value at the actual degree-p root has
a constant Frobenius remainder. This is literal polynomial divisibility. -/
theorem polynomial_constant_inseparable_remainder (p : ℕ) [CharP K p]
    (hp : p.Prime) (f : K) (hnot : ∀ a : K, a ^ p ≠ f)
    (c : L) (hc : c ^ p = -algebraMap K L f) (F : K[X]) (tau : K)
    (hvalue : aeval c F = algebraMap K L tau) :
    ∃ H : K[X], F = (X ^ p + C f) * H + C tau := by
  have hdvd : minpoly K c ∣ F - C tau := minpoly.dvd K c (by
    rw [map_sub, aeval_C, hvalue, sub_self])
  rw [inseparable_root_minpoly p hp f hnot c hc] at hdvd
  obtain ⟨H, hH⟩ := hdvd
  exact ⟨H, by rw [← hH, sub_add_cancel]⟩

/-- The quotient polynomial and constant in a Frobenius-remainder
presentation are unique. -/
theorem inseparable_remainder_presentation_unique (p : ℕ) [CharP K p]
    (hp : p.Prime) (f : K) (c : L) (hc : c ^ p = -algebraMap K L f)
    (F H₁ H₂ : K[X]) (tau₁ tau₂ : K)
    (h₁ : F = (X ^ p + C f) * H₁ + C tau₁)
    (h₂ : F = (X ^ p + C f) * H₂ + C tau₂) :
    H₁ = H₂ ∧ tau₁ = tau₂ := by
  have hzero : aeval c (X ^ p + C f) = 0 := by
    simp only [map_add, map_pow, aeval_X, aeval_C, hc, neg_add_cancel]
  have heq := congrArg (aeval c) (h₁.symm.trans h₂)
  simp only [map_add, map_mul, aeval_C, hzero, zero_mul, zero_add] at heq
  have htau : tau₁ = tau₂ := (algebraMap K L).injective heq
  refine ⟨?_, htau⟩
  have hmul : (X ^ p + C f) * H₁ = (X ^ p + C f) * H₂ := by
    apply add_right_cancel (b := C tau₁)
    rw [← h₁, htau, ← h₂]
  exact mul_left_cancel₀ (monic_X_pow_add_C f hp.ne_zero).ne_zero hmul

end Litt3.CartierAndSpin
