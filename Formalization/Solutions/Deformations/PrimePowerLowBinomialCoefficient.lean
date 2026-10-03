import Solutions.Deformations.PrimePowerPreviousBinomialRow
import Mathlib.RingTheory.Coprime.Lemmas

namespace Litt3.Deformations

variable {R : Type*} [CommRing R]

/-- Every small denominator is an actual unit over any coefficient
ring killed by the stated p-power, including nonreduced coefficient rings. -/
theorem small_denominator_unit (p N j : ℕ) (prime : p.Prime)
    (positive : 0 < j) (bound : j < p) (nilpotent : (p : R) ^ N = 0) :
    IsUnit (j : R) := by
  have coprime := (Nat.coprime_of_lt_prime positive.ne' bound prime).symm.pow_right N
  have cast : IsCoprime (j : R) ((p : R) ^ N) := by
    simpa only [Nat.cast_pow] using (coprime.cast (R := R))
  rw [nilpotent, isCoprime_zero_right] at cast
  exact cast

/-- The exact low cyclic binomial coefficient over the actual
p-power coefficient ring. The denominator condition is actual unit
invertibility; no coefficient-field or semilinearity assumption is used. -/
theorem prime_power_low_binomial_coefficient (p a j : ℕ) [Fact p.Prime]
    (positive : 0 < j) (bound : j ≤ p ^ a)
    (nilpotent : (p : R) ^ (a + 1) = 0) (unit : IsUnit (j : R)) :
    (((p ^ a).choose j : ℕ) : R) =
      (p : R) ^ a * ((-1) ^ (j - 1) * Ring.inverse (j : R)) := by
  have row := prime_power_previous_binomial_row (R := ZMod p) p a (j - 1) (by omega)
  have rowzero : (((((p ^ a - 1).choose (j - 1) : ℕ) : ℤ) -
      (-1 : ℤ) ^ (j - 1) : ℤ) : ZMod p) = 0 := by
    push_cast
    rw [row]
    exact sub_self _
  obtain ⟨t, equation⟩ := (ZMod.intCast_zmod_eq_zero_iff_dvd _ p).mp rowzero
  have residual : (((p ^ a - 1).choose (j - 1) : ℕ) : R) - (-1) ^ (j - 1) =
      (p : R) * (t : R) := by
    have cast := congrArg (fun n : ℤ => (n : R)) equation
    simpa only [Int.cast_sub, Int.cast_natCast, Int.cast_pow, Int.cast_neg, Int.cast_one,
      Int.cast_mul] using cast
  have scaled : (p : R) ^ a * (((p ^ a - 1).choose (j - 1) : ℕ) : R) =
      (p : R) ^ a * (-1) ^ (j - 1) := by
    have difference := congrArg (fun r : R => (p : R) ^ a * r) residual
    dsimp only at difference
    have zero : (p : R) ^ a * (p * (t : R)) = 0 := by
      rw [← mul_assoc, ← pow_succ, nilpotent, zero_mul]
    rw [mul_sub, zero] at difference
    exact sub_eq_zero.mp difference
  have recurrence := Nat.add_one_mul_choose_eq (p ^ a - 1) (j - 1)
  rw [Nat.sub_add_cancel (Nat.succ_le_of_lt (pow_pos (Fact.out : p.Prime).pos a)),
    Nat.sub_add_cancel positive] at recurrence
  have cast := congrArg (fun n : ℕ => (n : R)) recurrence
  simp only [Nat.cast_mul, Nat.cast_pow] at cast
  have multiplied : (((p ^ a).choose j : ℕ) : R) * (j : R) =
      (p : R) ^ a * (-1) ^ (j - 1) := cast.symm.trans scaled
  calc
    (((p ^ a).choose j : ℕ) : R) =
        (((p ^ a).choose j : ℕ) : R) * (j : R) * Ring.inverse (j : R) :=
      (Ring.mul_inverse_cancel_right _ _ unit).symm
    _ = (p : R) ^ a * (-1) ^ (j - 1) * Ring.inverse (j : R) := by rw [multiplied]
    _ = (p : R) ^ a * ((-1) ^ (j - 1) * Ring.inverse (j : R)) := mul_assoc _ _ _

end Litt3.Deformations
