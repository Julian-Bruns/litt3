import Solutions.CartierAndSpin.FiniteRootPolynomial
import Mathlib.Algebra.CharP.Reduced

namespace Litt3.CartierAndSpin

open Polynomial

variable {K ι : Type*} [Field K] [Fintype ι]

/-- First p−1 power-sum vanishing for an actual p-element family forces
every entry to coincide. The residue field need not be perfect. -/
theorem characteristic_boundary_cohort_entries_equal (p : ℕ) [CharP K p]
    [Fact p.Prime] (u : ι → K) (hcard : Fintype.card ι = p)
    (hpowers : ∀ k, 0 < k → k < p → finitePowerSum u k = 0) :
    ∀ i j, u i = u j := by
  have hp : 0 < p := (Fact.out : p.Prime).pos
  have hesymm : ∀ k, 0 < k → k < p → finiteElementarySymmetric u k = 0 := by
    intro k hk hkp
    have hzero := finiteElementarySymmetric_mul_eq_zero_of_powerSums u k
      (fun l hl hlk => hpowers l hl (lt_of_le_of_lt hlk hkp))
    have hkcast : (k : K) ≠ 0 := by
      rw [Ne, CharP.cast_eq_zero_iff K p]
      exact Nat.not_dvd_of_pos_of_lt hk hkp
    exact (mul_eq_zero.mp hzero).resolve_left hkcast
  have hpoly := finiteRootPolynomial_eq_pow_add_constant u p hp hcard hesymm
  intro i j
  have hi := finiteRootPolynomial_eval_at_member u i
  have hj := finiteRootPolynomial_eval_at_member u j
  rw [hpoly] at hi hj
  simp only [eval_add, eval_pow, eval_X, eval_C] at hi hj
  apply frobenius_inj K p
  change u i ^ p = u j ^ p
  exact add_right_cancel (hi.trans hj.symm)

end Litt3.CartierAndSpin
