import Definitions.Deformations.TruncatedCongruenceLifting
import Definitions.Deformations.TruncatedMatrixDivisibility
import Definitions.Deformations.HermitianSchur

namespace Litt3.Deformations

variable {k m n : Type*} [CommRing k]
variable [Fintype m] [DecidableEq m] [Fintype n] [DecidableEq n]

/-- An actual invertible full congruence removes a genuine
unit block at valuation e and leaves a genuine higher-valuation
complete remainder. -/
def HasTruncatedSchurStep (N e : ℕ)
    (A : Matrix (m ⊕ n) (m ⊕ n) (TruncatedCoefficientRing k N)) : Prop :=
  ∃ P : Matrix (m ⊕ n) (m ⊕ n) (TruncatedCoefficientRing k N), IsUnit P ∧
    ∃ C : Matrix m m (TruncatedCoefficientRing k N), IsUnit C ∧
      ∃ F : Matrix n n (TruncatedCoefficientRing k N),
        truncatedHermitianTranspose k N P * (truncatedParameter k N ^ e • A) * P =
          Matrix.fromBlocks (truncatedParameter k N ^ e • C) 0 0
            (truncatedParameter k N ^ (e + 1) • F)

end Litt3.Deformations
