import Mathlib.LinearAlgebra.Matrix.BilinearForm
import Mathlib.LinearAlgebra.BilinearForm.Orthogonal

namespace Litt3.Deformations

variable {R ι : Type*} [CommRing R] [Fintype ι] [DecidableEq ι]

def HasSignedTranspose (ε : R) (A : Matrix ι ι R) : Prop := A.transpose = ε • A

end Litt3.Deformations
