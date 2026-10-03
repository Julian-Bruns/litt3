import Definitions.Deformations.TruncatedMatrixLifting
import Definitions.Deformations.HermitianLeadingExtraction

namespace Litt3.Deformations

variable {k ι : Type*} [CommRing k] [Fintype ι] [DecidableEq ι]

/-- Every actual short congruence lifts to an actual invertible
congruence of the full parameter-multiplied operator. -/
def TruncatedCongruenceLifts (N e : ℕ)
    (A D : Matrix ι ι (TruncatedCoefficientRing k N)) : Prop :=
  ∀ S : Matrix ι ι (TruncatedCoefficientRing k (N - e)), IsUnit S →
    truncatedHermitianTranspose k (N - e) S *
        truncatedMatrixRestriction k N (N - e) (Nat.sub_le _ _) A * S =
      truncatedMatrixRestriction k N (N - e) (Nat.sub_le _ _) D →
    ∃ P : Matrix ι ι (TruncatedCoefficientRing k N), IsUnit P ∧
      truncatedMatrixRestriction k N (N - e) (Nat.sub_le _ _) P = S ∧
      truncatedHermitianTranspose k N P * (truncatedParameter k N ^ e • A) * P =
        truncatedParameter k N ^ e • D

end Litt3.Deformations
