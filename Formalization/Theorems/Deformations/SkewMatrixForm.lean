import Definitions.Deformations.SkewMatrixForm

namespace Litt3.Deformations.Specifications

variable {k ι : Type*} [Field k] [Fintype ι] [DecidableEq ι]

def SkewMatrixAlternatingForm (A : Matrix ι ι k) : Prop :=
  (residueMatrixForm A).IsAlt

end Litt3.Deformations.Specifications
