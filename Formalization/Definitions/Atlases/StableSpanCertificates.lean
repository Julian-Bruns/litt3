import Mathlib.Algebra.Algebra.Subalgebra.Lattice
import Mathlib.LinearAlgebra.Dimension.OrzechProperty

namespace Litt3.Atlases

variable {K A : Type*} [CommSemiring K] [Semiring A] [Algebra K A]

/-- Actual left multiplication operators preserving a specified
submodule form a subalgebra, even when the ambient algebra is noncommutative. -/
def leftMultiplierStabilizer (S : Submodule K A) : Subalgebra K A where
  carrier := {a | ∀ x ∈ S, a * x ∈ S}
  zero_mem' := by intro x _; simp
  one_mem' := by intro x hx; simpa using hx
  add_mem' := by intro a b ha hb x hx; simpa only [add_mul] using S.add_mem (ha x hx) (hb x hx)
  mul_mem' := by intro a b ha hb x hx; simpa only [mul_assoc] using ha (b * x) (hb x hx)
  algebraMap_mem' := by
    intro c x hx
    simpa only [Algebra.smul_def] using S.smul_mem c hx

end Litt3.Atlases
