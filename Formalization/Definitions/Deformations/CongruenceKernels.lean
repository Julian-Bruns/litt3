import Mathlib.LinearAlgebra.Matrix.ToLinearEquiv
import Mathlib.LinearAlgebra.Matrix.ConjTranspose

namespace Litt3.Deformations

variable {R ι : Type*} [CommRing R] [StarRing R] [Fintype ι] [DecidableEq ι]

def hermitianCongruence (A P : Matrix ι ι R) : Matrix ι ι R := P.conjTranspose * A * P

end Litt3.Deformations
