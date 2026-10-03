import Solutions.CartierAndSpin.WeightedSquarePencils
import Mathlib.FieldTheory.Perfect
import Mathlib.Algebra.CharP.Lemmas

namespace Litt3.CartierAndSpin

open Polynomial

variable {K : Type*} [Field K]

/-- An arbitrary fixed weight survives odd-power square-class
cancellation, even when the weight itself is nonsquare. -/
theorem weighted_odd_power_square_iff (g a : K) (n : ℕ) (hn : Odd n) (ha : a ≠ 0) :
    IsSquare (g * a ^ n) ↔ IsSquare (g * a) := by
  obtain ⟨m, hm⟩ := hn
  have hn' : n = 2 * m + 1 := by omega
  have heq : g * a ^ n = (g * a) * (a ^ m) ^ 2 := by
    rw [hn', pow_add, pow_one, Nat.mul_comm 2 m, pow_mul]
    ring
  rw [heq]
  exact isSquare_mul_square_iff (g * a) (a ^ m) (pow_ne_zero _ ha)

variable {k T L : Type*} [Field k] [Field T] [Field L]
  [Algebra k[X] T] [IsFractionRing k[X] T] [Algebra T L]

theorem weighted_odd_power_pencil_support_finite [FiniteDimensional T L]
    (g : L) (hg : g ≠ 0) (htwo : (2 : T) ≠ 0) (n : ℕ) (hn : Odd n) :
    let support : Set k := {theta | IsSquare
      (g * (algebraMap T L (algebraMap k[X] T (X - C theta))) ^ n)}
    support.Finite ∧ support.ncard ≤ 1 + (Module.finrank T L).factorization 2 := by
  have heq : {theta : k | IsSquare
      (g * (algebraMap T L (algebraMap k[X] T (X - C theta))) ^ n)} =
      {theta : k | IsSquare
      (g * algebraMap T L (algebraMap k[X] T (X - C theta)))} := by
    ext theta
    apply weighted_odd_power_square_iff g _ n hn
    have hpoly := (IsFractionRing.injective k[X] T).ne (Polynomial.X_sub_C_ne_zero theta)
    have hT : algebraMap k[X] T (X - C theta) ≠ 0 := by
      simpa only [map_zero] using hpoly
    simpa only [map_zero] using (algebraMap T L).injective.ne hT
  dsimp only
  rw [heq]
  exact weighted_square_pencil_support_finite g hg htwo

end Litt3.CartierAndSpin
