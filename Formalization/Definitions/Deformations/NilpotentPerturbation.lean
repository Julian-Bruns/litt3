import Mathlib.RingTheory.Nilpotent.Basic
import Mathlib.Algebra.Algebra.Basic

namespace Litt3.Deformations

variable {R A : Type*} [CommRing R] [Ring A] [Algebra R A]

def scalarPerturbation (original : A) (parameter : R) (correction : A) : A :=
  original + parameter • correction

end Litt3.Deformations
