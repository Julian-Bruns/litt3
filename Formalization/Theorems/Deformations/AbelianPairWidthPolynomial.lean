import Definitions.Deformations.HilbertCoefficients

namespace Litt3.Deformations.Specifications

def AbelianPairAdjacentHilbertMaximum (q : ℕ) : Prop :=
  (∀ n, (intervalPolynomial q ^ 2).coeff n + (intervalPolynomial q ^ 2).coeff (n + 1) ≤ 2 * q - 1) ∧
    (intervalPolynomial q ^ 2).coeff (q - 1) +
      (intervalPolynomial q ^ 2).coeff (q - 1 + 1) = 2 * q - 1

end Litt3.Deformations.Specifications
