import Mathlib.RingTheory.AdicCompletion.Basic
import Mathlib.Tactic

namespace Litt3.Deformations

variable {A : Type*} [CommRing A]

/-- Actual prime-power ideal congruences are literal integral
divisibility, including coefficient torsion. -/
theorem prime_power_smodEq_iff (p n : ℕ) (x y : A) :
    x ≡ y [SMOD ((Ideal.span {(p : A)}) ^ n)] ↔
      ∃ z : A, x - y = (p : A) ^ n * z := by
  rw [SModEq.sub_mem, Ideal.span_singleton_pow, Ideal.mem_span_singleton]
  rfl

end Litt3.Deformations
