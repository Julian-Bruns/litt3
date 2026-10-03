import Mathlib.Algebra.Polynomial.Derivative
import Mathlib.Algebra.Polynomial.AlgebraMap
import Mathlib.Tactic.NoncommRing

namespace Litt3.CartierAndSpin

open Polynomial

variable {A : Type*} [Ring A]

/-- The literal Weyl relation gives the full symbolic power
commutator, over EVERY ring and in every characteristic. -/
theorem weyl_power_commutator_succ
    (T M : A) (hweyl : T * M - M * T = 1) (n : ℕ) :
    T ^ (n + 1) * M - M * T ^ (n + 1) = (n + 1) • T ^ n := by
  induction n with
  | zero => simpa only [Nat.zero_add, pow_one, pow_zero, one_nsmul] using hweyl
  | succ n ih =>
    calc
      _ = T * (T ^ (n + 1) * M - M * T ^ (n + 1)) +
          (T * M - M * T) * T ^ (n + 1) := by
        rw [pow_succ' T (n + 1)]
        noncomm_ring
      _ = T * ((n + 1) • T ^ n) + 1 * T ^ (n + 1) := by rw [ih, hweyl]
      _ = _ := by
        have hmul : T * ((n + 1) • T ^ n) = (n + 1) • (T * T ^ n) :=
          map_nsmul (AddMonoidHom.mulLeft T) (n + 1) (T ^ n)
        rw [hmul, ← pow_succ', one_mul]
        simp only [add_nsmul, one_nsmul]

variable {R : Type*} [CommRing R] [Algebra R A]

/-- Actual polynomial evaluation differentiates under the literal
Weyl commutator. The coefficients are the true central algebra image;
no matrix, separability, finite dimension or prime is assumed. -/
theorem weyl_polynomial_commutator
    (T M : A) (hweyl : T * M - M * T = 1) (F : R[X]) :
    (aeval T F) * M - M * (aeval T F) = aeval T F.derivative := by
  induction F using Polynomial.induction_on' with
  | add F G hF hG =>
    calc
      _ = ((aeval T F) * M - M * (aeval T F)) +
          ((aeval T G) * M - M * (aeval T G)) := by
        rw [map_add]
        noncomm_ring
      _ = _ := by rw [hF, hG, Polynomial.derivative_add, map_add]
  | monomial n c =>
    cases n with
    | zero =>
      simp only [Polynomial.monomial_zero_left, Polynomial.derivative_C,
        Polynomial.aeval_C, map_zero]
      exact sub_eq_zero.mpr (Algebra.commutes c M)
    | succ n =>
      rw [Polynomial.derivative_monomial_succ, Polynomial.aeval_monomial,
        Polynomial.aeval_monomial]
      calc
        _ = algebraMap R A c * (T ^ (n + 1) * M - M * T ^ (n + 1)) := by
          rw [mul_sub, ← mul_assoc M (algebraMap R A c) (T ^ (n + 1)),
            ← Algebra.commutes c M]
          simp only [mul_assoc]
        _ = _ := by
          rw [weyl_power_commutator_succ T M hweyl n]
          simp only [map_mul, map_add, map_natCast, map_one, nsmul_eq_mul,
            Nat.cast_add, Nat.cast_one, mul_assoc]

end Litt3.CartierAndSpin
