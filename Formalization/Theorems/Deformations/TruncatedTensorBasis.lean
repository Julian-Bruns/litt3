import Definitions.Deformations.TruncatedTensorBasis

namespace Litt3.Deformations.Specifications

variable {k : Type*} [CommRing k] [Nontrivial k]

def TruncatedTensorMonomialFormula (N M : ℕ) : Prop :=
  ∀ ij : Fin N × Fin M, truncatedTensorMonomialBasis k N M ij =
    ((Algebra.TensorProduct.includeLeft : TruncatedCoefficientRing k N →ₐ[k]
      TruncatedTensorAlgebra k N M) (truncatedParameter k N)) ^ ij.1.val *
      ((Algebra.TensorProduct.includeRight : TruncatedCoefficientRing k M →ₐ[k]
        TruncatedTensorAlgebra k N M) (truncatedParameter k M)) ^ ij.2.val

end Litt3.Deformations.Specifications
