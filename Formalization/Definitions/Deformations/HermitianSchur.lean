import Mathlib.LinearAlgebra.Matrix.SchurComplement
import Mathlib.LinearAlgebra.Matrix.Hermitian

namespace Litt3.Deformations

open Matrix

variable {R m n : Type*} [Ring R] [StarRing R]
variable [Fintype m] [DecidableEq m] [Fintype n] [DecidableEq n]

/-- The actual invertible congruence used to split a leading block. -/
def hermitianSchurEliminator (C : Matrix m m R) (D : Matrix m n R) [Invertible C] :
    Matrix (m ⊕ n) (m ⊕ n) R :=
  fromBlocks 1 (-(⅟C * D)) 0 1

end Litt3.Deformations
