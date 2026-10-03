import Definitions.Deformations.TruncatedBasisLift

namespace Litt3.Deformations.Specifications

open Module

variable {k V m n : Type*} [CommRing k] [AddCommGroup V] [Module k V]
variable [Fintype m] [DecidableEq m] [Fintype n] [DecidableEq n]

def TruncatedBasisMatricesInverse (N : ℕ) (b : Basis m k V) (c : Basis n k V) : Prop :=
  MatrixInversePair (truncatedBasisMatrix N b c) (truncatedBasisMatrix N c b)

end Litt3.Deformations.Specifications
