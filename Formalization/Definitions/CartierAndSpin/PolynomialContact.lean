import Mathlib.Algebra.Polynomial.Basic

namespace Litt3.CartierAndSpin

open Polynomial

variable {R : Type*} [CommRing R]

/-- Cross multiplication retains all zero-denominator boundaries. -/
noncomputable def polynomialCrossDifference (f T g U : R[X]) : R[X] := f * U - g * T

/-- Vanishing of a polynomial section of `O(N)` to order at least `e` at
infinity, expressed in its actual coefficient frame. -/
def polynomialSectionVanishesAtInfinity (H : R[X]) (N e : ℕ) : Prop :=
  ∀ i : ℕ, N < i + e → H.coeff i = 0

end Litt3.CartierAndSpin
