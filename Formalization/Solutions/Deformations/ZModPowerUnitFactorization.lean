import Mathlib.NumberTheory.Padics.PadicVal.Basic
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic

namespace Litt3.Deformations

/-- Every residue modulo a prime power is a literal prime power times
a unit; the exponent is bounded by the modulus exponent. Zero is
represented by the top exponent. -/
theorem zmod_prime_power_unit_factorization (p N : ℕ) [Fact p.Prime]
    (x : ZMod (p ^ N)) :
    ∃ (e : ℕ) (u : (ZMod (p ^ N))ˣ), e ≤ N ∧ x = (p : ZMod (p ^ N)) ^ e * u := by
  have hp := (Fact.out : p.Prime)
  haveI : NeZero (p ^ N) := ⟨pow_ne_zero _ hp.ne_zero⟩
  by_cases zero : x = 0
  · refine ⟨N, 1, le_rfl, ?_⟩
    simp [zero, ← Nat.cast_pow, ZMod.natCast_self]
  · have valueNonzero : x.val ≠ 0 := (ZMod.val_eq_zero x).not.mpr zero
    let e := padicValNat p x.val
    have powerDivides : p ^ e ∣ x.val := pow_padicValNat_dvd
    have quotientCoprime : Nat.Coprime (x.val / p ^ e) p := by
      rw [Nat.coprime_comm, hp.coprime_iff_not_dvd]
      intro divides
      have powerSuccDivides : p ^ (e + 1) ∣ x.val := by
        rw [pow_succ]
        rcases divides with ⟨k, hk⟩
        refine ⟨k, ?_⟩
        calc
          x.val = p ^ e * (x.val / p ^ e) := (Nat.mul_div_cancel' powerDivides).symm
          _ = p ^ e * p * k := by rw [hk, mul_assoc]
      exact pow_succ_padicValNat_not_dvd valueNonzero powerSuccDivides
    have bound : e ≤ N := by
      by_contra larger
      have powerModulusDivides : p ^ N ∣ x.val :=
        (pow_dvd_pow p (by omega : N ≤ e)).trans powerDivides
      have lower := Nat.le_of_dvd (Nat.pos_of_ne_zero valueNonzero) powerModulusDivides
      exact (Nat.not_le_of_lt x.val_lt) lower
    have unitCoprime : Nat.Coprime (x.val / p ^ e) (p ^ N) := quotientCoprime.pow_right N
    refine ⟨e, ZMod.unitOfCoprime _ unitCoprime, bound, ?_⟩
    rw [ZMod.coe_unitOfCoprime, ← Nat.cast_pow, ← Nat.cast_mul,
      Nat.mul_div_cancel' powerDivides, ZMod.natCast_zmod_val]

end Litt3.Deformations
