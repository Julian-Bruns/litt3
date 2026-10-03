import Definitions.Deformations.TruncatedCoefficientRing
import Definitions.Deformations.GroupAlgebraProducts
import Definitions.Deformations.WeightedBasisFiltration

namespace Litt3.Deformations

open scoped TensorProduct

variable (k : Type*) [CommRing k] [Nontrivial k]

/-- Genuine parameter powers form a basis over any coefficient ring. -/
noncomputable def truncatedMonomialBasis (N : ℕ) :
    Module.Basis (Fin N) k (TruncatedCoefficientRing k N) :=
  (AdjoinRoot.powerBasis' (Polynomial.monic_X_pow N :
    ((Polynomial.X : Polynomial k) ^ N).Monic)).basis.reindex
      (finCongr (Polynomial.natDegree_X_pow N))

abbrev TruncatedTensorAlgebra (N M : ℕ) :=
  TruncatedCoefficientRing k N ⊗[k] TruncatedCoefficientRing k M

noncomputable def truncatedTensorMonomialBasis (N M : ℕ) :
    Module.Basis (Fin N × Fin M) k (TruncatedTensorAlgebra k N M) :=
  (truncatedMonomialBasis k N).tensorProduct (truncatedMonomialBasis k M)

instance truncatedTensorModuleFinite (N M : ℕ) :
    Module.Finite k (TruncatedTensorAlgebra k N M) :=
  Module.Finite.of_basis (truncatedTensorMonomialBasis k N M)

def truncatedTensorMonomialWeight {N M : ℕ} (ij : Fin N × Fin M) : ℕ :=
  ij.1.val + ij.2.val

end Litt3.Deformations
