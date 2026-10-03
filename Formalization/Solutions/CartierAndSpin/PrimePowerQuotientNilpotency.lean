import Mathlib.FieldTheory.KummerPolynomial
import Mathlib.Algebra.CharP.Algebra
import Mathlib.RingTheory.AdjoinRoot
import Mathlib.RingTheory.Nilpotent.Basic

namespace Litt3.CartierAndSpin

open Polynomial

variable {K : Type*} [Field K] {p : ℕ} [Fact p.Prime]

/-- At ANY prime degree, the literal pure-power polynomial is
irreducible exactly when its negative constant has no root in the
ORIGINAL coefficient field. Characteristic need not equal p. -/
theorem actual_prime_power_polynomial_irreducible_iff (c : K) :
    Irreducible ((X : K[X]) ^ p + C c) ↔ ∀ a : K, a ^ p ≠ -c := by
  simpa only [map_neg, sub_neg_eq_add] using
    X_pow_sub_C_irreducible_iff_of_prime (K := K) (Fact.out : p.Prime) (a := -c)

variable [CharP K p]

/-- A genuine ORIGINAL scalar root gives a literal quotient element
whose pth power is zero. No nilpotency conclusion is assumed. -/
theorem actual_prime_power_quotient_root_difference_power_zero
    (c a : K) (ha : a ^ p = -c) :
    (AdjoinRoot.root ((X : K[X]) ^ p + C c) -
      AdjoinRoot.of ((X : K[X]) ^ p + C c) a) ^ p = 0 := by
  letI : CharP (AdjoinRoot ((X : K[X]) ^ p + C c)) p :=
    charP_of_injective_ringHom
      (AdjoinRoot.of.injective_of_degree_ne_zero
        (ne_of_gt (Polynomial.natDegree_pos_iff_degree_pos.mp
          (by simpa only [Polynomial.natDegree_X_pow_add_C] using
            (Fact.out : p.Prime).pos)))) p
  have hrel := AdjoinRoot.eval₂_root ((X : K[X]) ^ p + C c)
  simp only [Polynomial.eval₂_add, Polynomial.eval₂_pow, Polynomial.eval₂_X,
    Polynomial.eval₂_C] at hrel
  rw [sub_pow_char, ← map_pow, ha, map_neg]
  simpa only [sub_neg_eq_add] using hrel

omit [CharP K p] in
/-- EVERY smaller power of the literal root difference is nonzero,
including power zero. This is an actual monic-quotient degree argument,
not a sampled matrix or supplied independent basis. -/
theorem actual_prime_power_quotient_root_difference_power_ne_zero
    (c a : K) (n : ℕ) (hn : n < p) :
    (AdjoinRoot.root ((X : K[X]) ^ p + C c) -
      AdjoinRoot.of ((X : K[X]) ^ p + C c) a) ^ n ≠ 0 := by
  have h := AdjoinRoot.mk_ne_zero_of_natDegree_lt
    (Polynomial.monic_X_pow_add_C c (Fact.out : p.Prime).ne_zero)
    (pow_ne_zero n (Polynomial.X_sub_C_ne_zero a))
    (by simpa only [Polynomial.natDegree_pow, Polynomial.natDegree_X_sub_C,
      Nat.mul_one, Polynomial.natDegree_X_pow_add_C] using hn)
  simpa only [map_pow, map_sub, AdjoinRoot.mk_X, AdjoinRoot.mk_C] using h

/-- The ACTUAL characteristic-p quotient is reduced exactly when the
constant has no original pth root. The excluded branch has an explicit
nonzero nilpotent of exact exponent p. -/
theorem actual_prime_power_quotient_isReduced_iff (c : K) :
    IsReduced (AdjoinRoot ((X : K[X]) ^ p + C c)) ↔ ∀ a : K, a ^ p ≠ -c := by
  constructor
  · intro hred a ha
    letI := hred
    have hzero := IsReduced.pow_eq_zero
      (actual_prime_power_quotient_root_difference_power_zero c a ha)
    have hnonzero := actual_prime_power_quotient_root_difference_power_ne_zero
      c a 1 (Fact.out : p.Prime).one_lt
    simpa only [pow_one, hzero, ne_eq, not_true_eq_false] using hnonzero
  · intro hroot
    have hirr := (actual_prime_power_polynomial_irreducible_iff c).mpr hroot
    letI : IsDomain (AdjoinRoot ((X : K[X]) ^ p + C c)) :=
      AdjoinRoot.isDomain_of_prime hirr.prime
    infer_instance

end Litt3.CartierAndSpin
