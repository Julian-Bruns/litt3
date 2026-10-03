import Definitions.Deformations.ToricHypersurfaceAlgebra
import Mathlib.Tactic

namespace Litt3.Deformations

theorem toric_hypersurface_normalize_axis (s : ℕ) (a : ToricHypersurfaceData)
    (axis : a.x = 0 ∨ a.y = 0) :
    toricHypersurfaceNormalize s (toricHypersurfaceExponent a) = a := by
  rcases a with ⟨x,y,z⟩
  rcases axis with h | h <;> simp_all [toricHypersurfaceNormalize,
    toricHypersurfaceExponent]

theorem toric_hypersurface_normalize_relation (s : ℕ) (a : Fin 3 →₀ ℕ) :
    toricHypersurfaceNormalize s (a + Finsupp.single 0 1 + Finsupp.single 1 1) =
      toricHypersurfaceNormalize s (a + Finsupp.single 2 s) := by
  ext <;> simp [toricHypersurfaceNormalize, min_add_add_right, Nat.mul_add] <;> omega

/-- A surviving normalized monomial forces every ORIGINAL exponent
below its literal power cutoff. -/
theorem toric_hypersurface_surviving_original_bounds (Q R s : ℕ) (positive : 0 < s)
    (a : Fin 3 →₀ ℕ)
    (survives : toricHypersurfaceSurvives Q R s (toricHypersurfaceNormalize s a)) :
    a 0 < Q ∧ a 1 < Q ∧ a 2 < R := by
  rcases survives with ⟨_, hx, hy, hz, hzx, hzy⟩
  simp only [toricHypersurfaceNormalize] at hx hy hz hzx hzy
  have hz' : a 2 < R := by omega
  by_cases h : a 0 ≤ a 1
  · rw [Nat.min_eq_left h] at hzy
    have bound : s * a 0 < s * (Q - (a 1 - a 0)) := by omega
    have small := (Nat.mul_lt_mul_left positive).mp bound
    exact ⟨by omega, by omega, hz'⟩
  · have h' : a 1 ≤ a 0 := by omega
    rw [Nat.min_eq_right h'] at hzx
    have bound : s * a 1 < s * (Q - (a 0 - a 1)) := by omega
    have small := (Nat.mul_lt_mul_left positive).mp bound
    exact ⟨by omega, by omega, hz'⟩

end Litt3.Deformations
