import Mathlib.RingTheory.Polynomial.Resultant.Basic

namespace Litt3.CartierAndSpin.Specifications

open Polynomial

variable {R : Type*} [CommRing R]

/-- Translation of a numerator by a constant multiple of its critical
denominator preserves a resultant with fixed formal degrees. -/
def CriticalResultantTranslationInvariant (D U : R[X]) (m n : ℕ) : Prop :=
  D.natDegree ≤ m → m ≤ n → ∀ z : R,
    Polynomial.resultant D (U - Polynomial.C z * D) m n =
      Polynomial.resultant D U m n

/-- A polynomial critical-square identity transforms without discriminant
inversion or any condition on root multiplicities. -/
def CriticalSquareTranslation (F Q D U V : R) : Prop :=
  U ^ 2 - F * Q = D * V → ∀ z : R,
    (U - z * D) ^ 2 - F * Q = D * (V - 2 * z * U + z ^ 2 * D)

end Litt3.CartierAndSpin.Specifications
