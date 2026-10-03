import Mathlib.GroupTheory.OrderOfElement
import Mathlib.Dynamics.PeriodicPts.Defs
import Mathlib.Tactic

namespace Litt3.CurveArithmetic

open Function

/-- The return map in an action commuting with a periodic map gives the
exact period quotient. This is the orbit-theoretic step behind the affine
Frobenius moduli degree formula. -/
theorem free_action_return_period_quotient
    {G X : Type*} [Group G] [MulAction G X]
    (f : X → X) (a : X) (m : ℕ) (hm : m ≠ 0) (g : G)
    (hfree : ∀ h : G, h • a = a → h = 1)
    (hcommute : ∀ (h : G) (x : X), f (h • x) = h • f x)
    (hreturn : f^[m] a = g • a) (hdivides : m ∣ minimalPeriod f a) :
    minimalPeriod f a / m = orderOf g := by
  have hcommuteIterate : ∀ (n : ℕ) (h : G) (x : X),
      f^[n] (h • x) = h • f^[n] x := by
    intro n
    induction n with
    | zero => simp
    | succ n ih =>
      intro h x
      rw [iterate_succ_apply', ih, hcommute, iterate_succ_apply']
  have hiterate : ∀ n : ℕ, (f^[m])^[n] a = g ^ n • a := by
    intro n
    induction n with
    | zero => simp
    | succ n ih =>
      rw [iterate_succ_apply', ih, hcommuteIterate, hreturn, ← mul_smul, pow_succ]
  have hperiod : minimalPeriod f^[m] a = orderOf g := by
    change minimalPeriod f^[m] a = minimalPeriod (g * ·) (1 : G)
    rw [minimalPeriod_eq_minimalPeriod_iff]
    intro n
    rw [isPeriodicPt_mul_iff_pow_eq_one]
    change (f^[m])^[n] a = a ↔ g ^ n = 1
    rw [hiterate]
    constructor
    · exact hfree _
    · intro h
      rw [h, one_smul]
  rw [minimalPeriod_iterate_eq_div_gcd hm, Nat.gcd_eq_right hdivides] at hperiod
  exact hperiod

end Litt3.CurveArithmetic
