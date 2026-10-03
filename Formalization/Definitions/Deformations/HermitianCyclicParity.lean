import Definitions.Deformations.HermitianCyclicKernel
import Definitions.Deformations.CyclicDecompositionUniqueness

namespace Litt3.Deformations

def OddNonfreeCyclicMultiplicitiesEven (N s : ℕ) (degree multiplicity : Fin s → ℕ) : Prop :=
  ∀ a, Odd a → a < N → Even (cyclicMultiplicityAt degree multiplicity a)

end Litt3.Deformations
