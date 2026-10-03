import Definitions.Deformations.TruncatedMonomialAlgebra
import Mathlib.Algebra.MvPolynomial.Equiv

namespace Litt3.Deformations

variable (R : Type*) [CommRing R] (d : ℕ)

/-- The actual original polynomial, with the selected first coordinate
regrouped and only the unchanged lower coefficients reduced. -/
noncomputable def selectedTruncatedCoefficientPolynomial (q : Fin d → ℕ)
    (P : MvPolynomial (Fin (d + 1)) R) :
    Polynomial (TruncatedMonomialAlgebra R (Fin d) q) :=
  Polynomial.map (Ideal.Quotient.mk (truncatedMonomialIdeal R (Fin d) q))
    (MvPolynomial.finSuccEquiv R d P)

end Litt3.Deformations
