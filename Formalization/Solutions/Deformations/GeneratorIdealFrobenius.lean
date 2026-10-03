import Mathlib.Algebra.CharP.Lemmas
import Mathlib.RingTheory.Ideal.Maps

namespace Litt3.Deformations

variable {A I : Type*} [CommSemiring A]
variable (p : ℕ) [ExpChar A p]

/-- Actual Frobenius annihilates the entire original generator ideal
when it annihilates every original generator. The index set can be
infinite, and no coefficient-field linearity is needed. -/
theorem generator_ideal_frobenius_pow_zero (E : I → A) (n : ℕ)
    (nilpotent : ∀ i, E i ^ (p ^ n) = 0) (x : A)
    (member : x ∈ Ideal.span (Set.range E)) : x ^ (p ^ n) = 0 := by
  have inclusion : Ideal.span (Set.range E) ≤ RingHom.ker (iterateFrobenius A p n) := by
    apply Ideal.span_le.mpr
    rintro y ⟨i, rfl⟩
    exact nilpotent i
  exact inclusion member

end Litt3.Deformations
