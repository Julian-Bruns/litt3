import Definitions.Deformations.GroupAlgebraQuotients
import Definitions.Deformations.TruncatedTensorRadical
import Definitions.Deformations.HilbertCoefficients

namespace Litt3.Deformations.Specifications

open scoped MonoidAlgebra

variable {k : Type*} [Field k]

def ActualAbelianPairRadicalHilbertPolynomial (p a b : ℕ) : Prop :=
  ∀ i, Module.finrank k (FiltrationLayer (jacobsonRadicalFiltration (k := k)
    (A := k[Multiplicative (ZMod (p ^ a)) × Multiplicative (ZMod (p ^ b))])) i) =
      (intervalPolynomial (p ^ a) * intervalPolynomial (p ^ b)).coeff i

end Litt3.Deformations.Specifications
