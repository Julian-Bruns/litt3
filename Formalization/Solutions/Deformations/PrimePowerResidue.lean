import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic

namespace Litt3.Deformations

/-- The literal coefficient residue map between the prime-power integer
ring and its prime residue field. -/
def primePowerResidue (p N : ℕ) (positive : 0 < N) : ZMod (p ^ N) →+* ZMod p :=
  ZMod.castHom (dvd_pow_self p (Nat.ne_of_gt positive)) (ZMod p)

theorem prime_power_residue_surjective (p N : ℕ) (positive : 0 < N) :
    Function.Surjective (primePowerResidue p N positive) :=
  ZMod.castHom_surjective _

theorem prime_power_residue_kernel (p N : ℕ) [Fact p.Prime] (positive : 0 < N)
    (x : ZMod (p ^ N)) (zero : primePowerResidue p N positive x = 0) :
    ∃ z : ZMod (p ^ N), (p : ZMod (p ^ N)) * z = x := by
  haveI : NeZero (p ^ N) := ⟨pow_ne_zero _ (Fact.out : p.Prime).ne_zero⟩
  have residue : (x.val : ZMod p) = 0 := by
    simpa only [primePowerResidue, ZMod.castHom_apply, ZMod.cast_eq_val] using zero
  obtain ⟨z, relation⟩ := (ZMod.natCast_eq_zero_iff x.val p).mp residue
  refine ⟨z, ?_⟩
  rw [← Nat.cast_mul, ← relation, ZMod.natCast_zmod_val]

end Litt3.Deformations
