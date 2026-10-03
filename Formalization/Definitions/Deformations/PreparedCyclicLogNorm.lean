import Mathlib.Algebra.Polynomial.AlgebraMap
import Mathlib.Algebra.GroupWithZero.Units.Basic

namespace Litt3.Deformations

open Polynomial

variable {R B : Type*} [CommRing R] [Ring B] [Algebra R B]

/-- The literal full integral norm polynomial evaluated at the actual
augmentation operator, before any characteristic-p reduction. -/
def integralCyclicNormValue (p a : ℕ) (x : B) : B :=
  ∑ j ∈ Finset.Icc 1 (p ^ a), (((p ^ a).choose j : ℕ) : R) • x ^ (j - 1)

noncomputable def truncatedLogPolynomial (h : ℕ) : R[X] :=
  ∑ i ∈ Finset.range h, C ((-1) ^ i * Ring.inverse ((i + 1 : ℕ) : R)) * X ^ i

/-- The exact truncated logarithmic unit, with actual unit inverses
in the original integral coefficient ring. -/
noncomputable def truncatedLogValue (h : ℕ) (x : B) : B :=
  ∑ i ∈ Finset.range h, ((-1 : R) ^ i * Ring.inverse ((i + 1 : ℕ) : R)) • x ^ i

end Litt3.Deformations
