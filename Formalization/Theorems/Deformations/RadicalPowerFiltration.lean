import Definitions.Deformations.RadicalPowerFiltration
import Theorems.Deformations.MatrixFiltrationWidth

namespace Litt3.Deformations.Specifications

variable {k A ι : Type*} [Field k] [Ring A] [Algebra k A] [Fintype ι]

def ActualRadicalMatrixWidth (lag : ℕ) (M : Matrix ι ι A) : Prop :=
  MatrixFiltrationWidth (jacobsonRadicalFiltration (k := k) (A := A)) lag M

end Litt3.Deformations.Specifications
