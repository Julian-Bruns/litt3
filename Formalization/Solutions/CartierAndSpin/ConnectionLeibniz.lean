import Mathlib.RingTheory.Derivation.Basic
import Mathlib.Data.Nat.Choose.Dvd
import Mathlib.Algebra.CharP.Basic
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Logic.Function.Iterate
import Mathlib.Tactic.Ring

namespace Litt3.CartierAndSpin

open Finset

variable {R A : Type*} [CommRing R] [CommRing A] [Algebra R A]

/-- The actual scalar first-order connection over a commutative ring. -/
noncomputable def scalarDerivationConnection (D : Derivation R A A) (f : A) :
    A →ₗ[R] A := D.toLinearMap - LinearMap.mulLeft R f

theorem scalar_connection_leibniz (D : Derivation R A A) (f a x : A) :
    scalarDerivationConnection D f (a * x) =
      D a * x + a * scalarDerivationConnection D f x := by
  change D (a * x) - f * (a * x) = D a * x + a * (D x - f * x)
  rw [D.leibniz]
  simp only [smul_eq_mul]
  ring

/-- The exact binomial Leibniz formula for arbitrary connection iterates.
This is a symbolic identity, uniform in n and over every commutative ring. -/
theorem scalar_connection_iterate_leibniz
    (D : Derivation R A A) (f a x : A) (n : ℕ) :
    (scalarDerivationConnection D f)^[n] (a * x) =
      ∑ k ∈ range (n + 1), n.choose k •
        (D^[n - k] a * (scalarDerivationConnection D f)^[k] x) := by
  induction n with
  | zero => simp
  | succ n IH =>
    let L := scalarDerivationConnection D f
    change L^[n + 1] (a * x) = _
    calc
      L^[n + 1] (a * x) =
          L (∑ k ∈ range (n + 1), n.choose k • (D^[n - k] a * L^[k] x)) := by
        rw [Function.iterate_succ_apply', IH]
      _ = (∑ k ∈ range (n + 1), n.choose k • (D^[n - k + 1] a * L^[k] x)) +
          ∑ k ∈ range (n + 1), n.choose k • (D^[n - k] a * L^[k + 1] x) := by
        dsimp only [L]
        simp only [map_sum, map_nsmul, scalar_connection_leibniz,
          Function.iterate_succ_apply', smul_add, sum_add_distrib]
      _ = (∑ k ∈ range (n + 1), n.choose (k + 1) •
            (D^[n - k] a * L^[k + 1] x)) +
          1 • (D^[n + 1] a * L^[0] x) +
          ∑ k ∈ range (n + 1), n.choose k • (D^[n - k] a * L^[k + 1] x) := by
        congr 1
        refine (sum_range_succ' _ _).trans (congr_arg₂ (· + ·) ?_ ?_)
        · rw [sum_range_succ, Nat.choose_succ_self, zero_smul, add_zero]
          refine sum_congr rfl fun k hk => ?_
          rw [mem_range] at hk
          have hexp : n - (k + 1) + 1 = n - k := by omega
          rw [hexp]
        · rw [Nat.choose_zero_right, tsub_zero]
      _ = ((∑ k ∈ range (n + 1), n.choose k • (D^[n - k] a * L^[k + 1] x)) +
            ∑ k ∈ range (n + 1), n.choose (k + 1) •
              (D^[n - k] a * L^[k + 1] x)) +
          1 • (D^[n + 1] a * L^[0] x) := by
        rw [add_comm, add_assoc]
      _ = (∑ k ∈ range (n + 1), (n + 1).choose (k + 1) •
            (D^[n + 1 - (k + 1)] a * L^[k + 1] x)) +
          1 • (D^[n + 1] a * L^[0] x) := by
        simp_rw [Nat.choose_succ_succ, Nat.succ_sub_succ, add_smul, sum_add_distrib]
      _ = ∑ k ∈ range (n + 1 + 1), (n + 1).choose k •
          (D^[n + 1 - k] a * L^[k] x) := by
        rw [sum_range_succ' _ (n + 1), Nat.choose_zero_right, tsub_zero]

/-- In characteristic p, the pth power of the actual connection is
A-linear whenever the pth derivative vanishes. No curvature identity or
connection solution is assumed. -/
theorem scalar_connection_prime_iterate_mul
    {p : ℕ} [Fact p.Prime] [CharP A p]
    (D : Derivation R A A) (f : A) (hD : ∀ a : A, D^[p] a = 0) (a x : A) :
    (scalarDerivationConnection D f)^[p] (a * x) =
      a * (scalarDerivationConnection D f)^[p] x := by
  rw [scalar_connection_iterate_leibniz, sum_eq_single p]
  · simp
  · intro k hk hkp
    have hklt : k < p := by have := mem_range.mp hk; omega
    by_cases hkzero : k = 0
    · subst k
      simp [hD]
    · have hchoose : ((p.choose k : ℕ) : A) = 0 :=
        (CharP.cast_eq_zero_iff A p _).mpr
          ((Fact.out : p.Prime).dvd_choose_self hkzero hklt)
      rw [nsmul_eq_mul, hchoose, zero_mul]
  · simp

theorem scalar_connection_prime_iterate_scalar
    {p : ℕ} [Fact p.Prime] [CharP A p]
    (D : Derivation R A A) (f : A) (hD : ∀ a : A, D^[p] a = 0) (a : A) :
    (scalarDerivationConnection D f)^[p] a =
      a * (scalarDerivationConnection D f)^[p] 1 := by
  simpa only [mul_one] using scalar_connection_prime_iterate_mul D f hD a 1

end Litt3.CartierAndSpin
