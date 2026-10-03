import Definitions.Deformations.SignedMatrixForm

namespace Litt3.Deformations.Specifications

variable {R ι : Type*} [CommRing R] [Fintype ι] [DecidableEq ι]

def SignedMatrixFormReflexive (A : Matrix ι ι R) : Prop :=
  (Matrix.toBilin' A).IsRefl

end Litt3.Deformations.Specifications
