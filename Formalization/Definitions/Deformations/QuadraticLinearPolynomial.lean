import Definitions.Deformations.SplitQuadraticAlgebra

namespace Litt3.Deformations

variable {A : Type*} [CommRing A]

/-- The literal monic quadratic with unchanged original linear and
constant coefficients. -/
noncomputable def quadraticLinearPolynomial (a b : A) : Polynomial A :=
  Polynomial.X ^ 2 + Polynomial.C a * Polynomial.X + Polynomial.C b

end Litt3.Deformations
