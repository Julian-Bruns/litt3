import Definitions.Deformations.CyclicBlockProfile

namespace Litt3.Deformations

variable {k : Type*} [Field k]

def CyclicDecompositionsHaveSameMultiplicities (s t : ℕ)
    (degree multiplicity : Fin s → ℕ) (degree' multiplicity' : Fin t → ℕ) : Prop :=
  ∀ a, 0 < a → cyclicMultiplicityAt degree multiplicity a =
    cyclicMultiplicityAt degree' multiplicity' a

end Litt3.Deformations
