import Solutions.CartierAndSpin.QuadraticSquareClasses
import Mathlib.FieldTheory.IsAlgClosed.Basic
import Mathlib.Data.Set.Finite.Basic

namespace Litt3.CartierAndSpin

variable {k L : Type*} [Field k] [Field L] [Algebra k L] [IsAlgClosed k]

/-- Away from the zero parameter, every nonzero constant factor is a
square from the actual algebraically closed constant field. Thus the
constant-ratio square test is exactly the weight's square test. -/
theorem constant_weighted_square_iff (g : L) (c theta : k) (hne : theta ≠ c) :
    IsSquare (g * (algebraMap k L c - algebraMap k L theta)) ↔ IsSquare g := by
  obtain ⟨root, hroot⟩ := IsAlgClosed.exists_pow_nat_eq (c - theta) (show 0 < 2 by decide)
  have hrootne : root ≠ 0 := by
    intro hz
    have hc : c - theta = 0 := by simpa [hz] using hroot.symm
    exact hne (sub_eq_zero.mp hc).symm
  have hfactor : algebraMap k L c - algebraMap k L theta = (algebraMap k L root) ^ 2 := by
    rw [← map_sub, ← hroot, map_pow]
  rw [hfactor]
  exact isSquare_mul_square_iff g _ (by
    simpa only [map_zero] using (algebraMap k L).injective.ne hrootne)

/-- The exact constant-ratio alternative: the nonzero weighted square
support is empty or the complement of one point, with the original zero
value retained as excluded. No false finiteness conclusion is made. -/
theorem constant_weighted_square_support (g : L) (hg : g ≠ 0) (c : k) :
    {theta : k | IsSquare (g * (algebraMap k L c - algebraMap k L theta)) ∧
      g * (algebraMap k L c - algebraMap k L theta) ≠ 0} =
      {theta : k | theta ≠ c ∧ IsSquare g} := by
  classical
  ext theta
  by_cases hne : theta = c
  · subst theta
    simp
  · have hfactor : algebraMap k L c - algebraMap k L theta ≠ 0 := by
      intro hz
      exact hne ((algebraMap k L).injective (sub_eq_zero.mp hz)).symm
    simp [hne, hg, hfactor, constant_weighted_square_iff g c theta hne]

end Litt3.CartierAndSpin
