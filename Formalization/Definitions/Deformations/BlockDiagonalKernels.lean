import Mathlib.LinearAlgebra.Matrix.ToLinearEquiv
import Mathlib.Data.Matrix.Block
import Mathlib.LinearAlgebra.Prod
import Mathlib.LinearAlgebra.Pi

namespace Litt3.Deformations

variable {R m n : Type*} [CommRing R]

def blockDiagonalMatrix (A : Matrix m m R) (B : Matrix n n R) : Matrix (m ⊕ n) (m ⊕ n) R :=
  Matrix.fromBlocks A 0 0 B

end Litt3.Deformations
