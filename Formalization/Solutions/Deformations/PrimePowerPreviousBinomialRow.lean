import Solutions.Deformations.CyclicNormPower
import Mathlib.Algebra.Polynomial.Coeff
import Mathlib.Tactic

namespace Litt3.Deformations

open Polynomial

variable {R : Type*} [CommRing R]

/-- The entire preceding p-power binomial row has its exact alternating
coefficient in characteristic p. This is uniform in the full group range. -/
theorem prime_power_previous_binomial_row (p a j : ℕ) [Fact p.Prime] [CharP R p]
    (bound : j < p ^ a) : (((p ^ a - 1).choose j : ℕ) : R) = (-1) ^ j := by
  have positive : 0 < p ^ a := pow_pos (Fact.out : p.Prime).pos a
  induction j with
  | zero => simp
  | succ j induction =>
    have identity : ((X : R[X]) + 1) ^ (p ^ a) = X ^ (p ^ a) + 1 := by
      rw [add_pow_char_pow, one_pow]
    have coefficient := congrArg (fun P : R[X] => P.coeff (j + 1)) identity
    have zero : (((p ^ a).choose (j + 1) : ℕ) : R) = 0 := by
      simpa only [Polynomial.coeff_X_add_one_pow, Polynomial.coeff_add,
        Polynomial.coeff_X_pow, Polynomial.coeff_one, if_neg (by omega : j + 1 ≠ p ^ a),
        if_neg (by omega : j + 1 ≠ 0), zero_add] using coefficient
    have recurrence := Nat.choose_succ_succ (p ^ a - 1) j
    simp only [Nat.succ_eq_add_one] at recurrence
    rw [Nat.sub_add_cancel (by omega : 1 ≤ p ^ a)] at recurrence
    have cast := congrArg (fun n : ℕ => (n : R)) recurrence
    simp only [Nat.cast_add] at cast
    rw [zero] at cast
    have next : (((p ^ a - 1).choose (j + 1) : ℕ) : R) =
        -(((p ^ a - 1).choose j : ℕ) : R) := by linear_combination -cast
    rw [next, induction (by omega), pow_succ]
    ring

end Litt3.Deformations
