import Mathlib.Data.Matrix.Basic
import Mathlib.Data.Fin.VecNotation

namespace Litt3.CartierAndSpin

variable {K : Type*} [CommRing K]

def kummerTracePairingMatrix (m : K) : Matrix (Fin 3) (Fin 3) K :=
  ![![0, 0, m], ![0, m, 0], ![m, 0, 0]]

def kummerCompressionMatrix (m a b c d : K) : Matrix (Fin 3) (Fin 3) K :=
  ![![a, m*d, m*c], ![b, a, m*d], ![c, b, a]]

def kummerBoundaryMatrix (m b c d : K) : Matrix (Fin 3) (Fin 3) K :=
  m • ![![b*d, b*c, b*b], ![c*d, c*c, c*b], ![d*d, d*c, d*b]]

def kummerSkewKernelCoordinates (M : Matrix (Fin 3) (Fin 3) K) : Fin 3 → K :=
  ![M 1 2 - M 0 1, M 0 0 - M 2 2, M 2 1 - M 1 0]

end Litt3.CartierAndSpin
