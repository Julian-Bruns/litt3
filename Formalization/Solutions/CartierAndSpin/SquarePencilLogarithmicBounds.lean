import Solutions.CartierAndSpin.WeightedSquarePencils
import Mathlib.Data.Nat.Log

namespace Litt3.CartierAndSpin

open Polynomial

/-- The exact 2-adic exponent is bounded by the binary logarithm of any
actual degree upper bound. This is a divisibility proof, not a numeric
approximation to a logarithm. -/
theorem two_factorization_le_degree_log (N d : ℕ) (hN : N ≠ 0) (hd : N ≤ d) :
    N.factorization 2 ≤ Nat.log 2 d := by
  apply Nat.le_log_of_pow_le (by decide)
  have hdvd : 2 ^ N.factorization 2 ∣ N :=
    (Nat.prime_two.pow_dvd_iff_le_factorization hN).mpr le_rfl
  exact (Nat.le_of_dvd (Nat.pos_of_ne_zero hN) hdvd).trans hd

variable {k T L : Type*} [Field k] [Field T] [Field L]
  [Algebra k[X] T] [IsFractionRing k[X] T] [Algebra T L] [FiniteDimensional T L]

/-- The source-only A_d pencil bound follows from an actual degree
upper bound, retaining the full original weighted square-class test. -/
theorem weighted_square_pencil_support_log_bound
    (g : L) (hg : g ≠ 0) (htwo : (2 : T) ≠ 0)
    (d : ℕ) (hdegree : Module.finrank T L ≤ d) :
    let support : Set k := {theta | IsSquare
      (g * algebraMap T L (algebraMap k[X] T (X - C theta)))}
    support.Finite ∧ support.ncard ≤ 1 + Nat.log 2 d := by
  have h := weighted_square_pencil_support_finite (k := k) (T := T) g hg htwo
  refine ⟨h.1, h.2.trans ?_⟩
  exact Nat.add_le_add_left
    (two_factorization_le_degree_log _ d Module.finrank_pos.ne' hdegree) 1

end Litt3.CartierAndSpin
