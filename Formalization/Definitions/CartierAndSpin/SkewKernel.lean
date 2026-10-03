import Mathlib.LinearAlgebra.LinearIndependent.Lemmas
import Mathlib.Data.Fin.VecNotation
import Mathlib.Data.Matrix.Mul

namespace Litt3.CartierAndSpin

variable {K V : Type*} [CommRing K] [AddCommGroup V] [Module K V]

/-- The skew rank-two operator arising from a rank-one scalar graph. -/
def rankTwoSkew (e u : V) (a b : V →ₗ[K] K) : V →ₗ[K] V :=
  a.smulRight e - b.smulRight u

/-- A general three-dimensional alternating matrix. -/
def alternatingThreeMatrix (a b c : K) : Matrix (Fin 3) (Fin 3) K :=
  ![![0, a, b], ![-a, 0, c], ![-b, -c, 0]]

/-- Its signed cofactor kernel vector. -/
def alternatingThreeKernelVector (a b c : K) : Fin 3 → K := ![c, -b, a]

end Litt3.CartierAndSpin
