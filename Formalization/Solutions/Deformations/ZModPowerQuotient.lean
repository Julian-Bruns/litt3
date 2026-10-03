import Definitions.Deformations.FiniteShiftCokernel
import Mathlib.Data.ZMod.QuotientGroup

namespace Litt3.Deformations

/-- The actual coefficient scalar-power submodule is exactly the
kernel of the actual quotient map between the two integer rings. -/
theorem zmod_power_quotient_kernel (p N e : ℕ) (positive : 0 < p) (bound : e ≤ N) :
    (coefficientScalarRange (K := ZMod (p ^ N)) ((p : ZMod (p ^ N)) ^ e)).toAddSubgroup =
      (ZMod.castHom (pow_dvd_pow p bound) (ZMod (p ^ e))).toAddMonoidHom.ker := by
  letI : NeZero (p ^ N) := ⟨Nat.ne_of_gt (pow_pos positive _)⟩
  ext x
  change (∃ y : ZMod (p ^ N), (p : ZMod (p ^ N)) ^ e * y = x) ↔
    ZMod.castHom (pow_dvd_pow p bound) (ZMod (p ^ e)) x = 0
  constructor
  · rintro ⟨y, rfl⟩
    rw [map_mul, map_pow, map_natCast, ← Nat.cast_pow]
    have zero : ((p ^ e : ℕ) : ZMod (p ^ e)) = 0 := CharP.cast_eq_zero _ _
    rw [zero, zero_mul]
  · intro zero
    have divisible : p ^ e ∣ x.val := by
      apply (ZMod.natCast_eq_zero_iff _ _).mp
      simpa only [ZMod.castHom_apply, ZMod.cast_eq_val] using zero
    obtain ⟨y, same⟩ := divisible
    refine ⟨(y : ZMod (p ^ N)), ?_⟩
    rw [← Nat.cast_pow, ← Nat.cast_mul, ← same, ZMod.natCast_zmod_val]

/-- Every actual scalar-power coefficient quotient is the literal
smaller integer quotient, including power zero and the full modulus. -/
noncomputable def zmodPowerQuotientAddEquiv (p N e : ℕ) (positive : 0 < p) (bound : e ≤ N) :
    (ZMod (p ^ N) ⧸ coefficientScalarRange (K := ZMod (p ^ N)) ((p : ZMod (p ^ N)) ^ e)) ≃+
      ZMod (p ^ e) :=
  (QuotientAddGroup.quotientAddEquivOfEq (zmod_power_quotient_kernel p N e positive bound)).trans
    (QuotientAddGroup.quotientKerEquivOfSurjective _ (ZMod.castHom_surjective (pow_dvd_pow p bound)))

theorem zmod_power_quotient_card (p N e : ℕ) (positive : 0 < p) (bound : e ≤ N) :
    Nat.card (ZMod (p ^ N) ⧸ coefficientScalarRange (K := ZMod (p ^ N)) ((p : ZMod (p ^ N)) ^ e)) =
      p ^ e := by
  rw [Nat.card_congr (zmodPowerQuotientAddEquiv p N e positive bound).toEquiv, Nat.card_zmod]

end Litt3.Deformations
