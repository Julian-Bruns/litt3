import Definitions.Deformations.TruncatedMonomialAlgebra
import Definitions.Deformations.SplitQuadraticAlgebra

namespace Litt3.Deformations.Specifications

variable (K I : Type*) [Field K] [Fintype I]

/-- Literal relative quadratic truncation: this claims the length of
the actual polynomial quotient after splitting, with no formal change
of coordinates or geometric truncation-identification assumed. -/
def SplitQuadraticTruncationLength (q : I → ℕ) (Q : ℕ) : Prop :=
  ∀ g : TruncatedMonomialAlgebra K I q,
    g ∈ truncatedMonomialAugmentationIdeal K I q ^ 2 →
    Module.finrank K
      (Polynomial (TruncatedMonomialAlgebra K I q) ⧸
        Ideal.span ({splitQuadraticPolynomial g, Polynomial.X ^ Q} :
          Set (Polynomial (TruncatedMonomialAlgebra K I q)))) = 2 * ∏ i, q i

end Litt3.Deformations.Specifications
