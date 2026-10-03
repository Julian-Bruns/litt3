import Definitions.Deformations.HilbertCoefficients

namespace Litt3.Deformations.Specifications

/-- An exact maximum, stated without any finite list of coefficients. -/
def HeisenbergHilbertMaximum (p : ℕ) : Prop :=
  (∀ n, (heisenbergWidthPolynomial p).coeff n ≤ p ^ 2) ∧
    (heisenbergWidthPolynomial p).coeff (2 * p - 1) = p ^ 2

end Litt3.Deformations.Specifications
