import Mathlib.RingTheory.PowerSeries.Trunc
import Mathlib.Algebra.Polynomial.Expand

namespace Litt3.SharedTensors

open PowerSeries Polynomial

variable {R : Type*} [CommRing R] {p : ℕ} [Fact p.Prime] [CharP R p]

/-- Frobenius on the entire power-series ring, proved from a sufficient
finite truncation for each coefficient. There is no truncation hypothesis
on the input series. -/
theorem power_series_frobenius_coeff (f : PowerSeries R) (n : ℕ) :
    PowerSeries.coeff n (f ^ p) =
      if p ∣ n then (PowerSeries.coeff (n / p) f) ^ p else 0 := by
  have hp : 0 < p := (Fact.out : p.Prime).pos
  have htr := congrArg (fun q : R[X] => q.coeff n)
    (PowerSeries.trunc_trunc_pow f (n + 1) p)
  simp only [PowerSeries.coeff_trunc, Nat.lt_succ_self, if_true] at htr
  rw [← htr, ← Polynomial.coe_pow, Polynomial.coeff_coe]
  rw [← Polynomial.expand_char, Polynomial.coeff_map,
    Polynomial.coeff_expand hp]
  split_ifs with h
  · rw [frobenius_def, PowerSeries.coeff_trunc,
      if_pos (lt_of_le_of_lt (Nat.div_le_self n p) (Nat.lt_succ_self n))]
  · simp

end Litt3.SharedTensors
