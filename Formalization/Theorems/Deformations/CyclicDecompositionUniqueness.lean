import Definitions.Deformations.CyclicDecompositionUniqueness

namespace Litt3.Deformations.Specifications

def CyclicDecompositionUnique (s t : ℕ)
    (degree multiplicity : Fin s → ℕ) (degree' multiplicity' : Fin t → ℕ) : Prop :=
  CyclicDecompositionsHaveSameMultiplicities s t degree multiplicity degree' multiplicity'

end Litt3.Deformations.Specifications
