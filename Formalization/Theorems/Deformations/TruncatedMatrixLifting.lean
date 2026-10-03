import Definitions.Deformations.TruncatedMatrixLifting

namespace Litt3.Deformations.Specifications

variable {k ι : Type*} [CommRing k] [Fintype ι] [DecidableEq ι]

def TruncatedMatrixUnitLifting (N j : ℕ) (bound : j ≤ N) : Prop :=
  TruncatedMatrixUnitsLift (k := k) (ι := ι) N j bound

end Litt3.Deformations.Specifications
