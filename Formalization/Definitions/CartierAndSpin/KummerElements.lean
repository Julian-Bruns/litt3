import Mathlib.Algebra.Algebra.Basic

namespace Litt3.CartierAndSpin

variable {K L : Type*} [CommRing K] [CommRing L] [Algebra K L]

def kummerElement (t : L) (a b c d : K) : L :=
  algebraMap K L a + b • t + c • t ^ 2 + d • t ^ 3

end Litt3.CartierAndSpin
