import Mathlib.RingTheory.Idempotents
import Mathlib.Algebra.Module.Submodule.Basic

namespace Litt3.Atlases

variable {k A : Type*} [CommRing k] [CommRing A] [Algebra k A]

/-- The actual part eA, as the fixed space of multiplication by e. -/
def idempotentPart (e : A) : Submodule k A where
  carrier := {x | e * x = x}
  zero_mem' := mul_zero e
  add_mem' := by
    intro x y hx hy
    change e * x = x at hx
    change e * y = y at hy
    change e * (x + y) = x + y
    rw [mul_add, hx, hy]
  smul_mem' := by
    intro r x hx
    change e * x = x at hx
    change e * (r • x) = r • x
    rw [Algebra.mul_smul_comm, hx]

/-- A nonzero idempotent that has no proper nonzero idempotent part. -/
def IsPrimitiveIdempotent (e : A) : Prop :=
  IsIdempotentElem e ∧ e ≠ 0 ∧
    ∀ f : A, IsIdempotentElem f → e * f = f → f = 0 ∨ f = e

end Litt3.Atlases
