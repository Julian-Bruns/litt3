import Definitions.Deformations.TruncatedTensorRadical
import Definitions.Deformations.HilbertCoefficients

namespace Litt3.Deformations.Specifications

variable {k : Type*} [Field k]

def TruncatedTensorRadicalWeightedBasis (N M : ℕ) : Prop :=
  jacobsonRadicalSubspace (k := k) (A := TruncatedTensorAlgebra k N M) =
    weightedBasisFiltration (truncatedTensorMonomialBasis k N M) truncatedTensorMonomialWeight 1

def TruncatedTensorRadicalFiltrationWeightedBasis (N M : ℕ) : Prop :=
  ∀ n, jacobsonRadicalFiltration (k := k) (A := TruncatedTensorAlgebra k N M) n =
    weightedBasisFiltration (truncatedTensorMonomialBasis k N M) truncatedTensorMonomialWeight n

def TruncatedTensorRadicalHilbertPolynomial (N M : ℕ) : Prop :=
  ∀ i, Module.finrank k
    (FiltrationLayer (jacobsonRadicalFiltration (k := k) (A := TruncatedTensorAlgebra k N M)) i) =
      (intervalPolynomial N * intervalPolynomial M).coeff i

end Litt3.Deformations.Specifications
