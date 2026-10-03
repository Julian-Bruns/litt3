import Mathlib.RingTheory.AdjoinRoot
import Mathlib.RingTheory.Ideal.Operations

namespace Litt3.Deformations

variable {A : Type*} [CommRing A]

/-- The literal relative quadratic equation, over the unchanged base
coefficient algebra. No formal coordinate change is presumed. -/
noncomputable def splitQuadraticPolynomial (g : A) : Polynomial A := Polynomial.X ^ 2 + Polynomial.C g

/-- The actual quotient by the literal relative quadratic equation. -/
abbrev SplitQuadraticAlgebra (g : A) := AdjoinRoot (splitQuadraticPolynomial g)

end Litt3.Deformations
