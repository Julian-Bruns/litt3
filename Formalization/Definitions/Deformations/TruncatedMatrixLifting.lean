import Definitions.Deformations.TruncatedSymmetry

namespace Litt3.Deformations

variable {k ι : Type*} [CommRing k] [Fintype ι] [DecidableEq ι]

/-- Every actual invertible matrix at a shorter length lifts to
an actual invertible matrix at the larger length. -/
def TruncatedMatrixUnitsLift (N j : ℕ) (bound : j ≤ N) : Prop :=
  ∀ S : Matrix ι ι (TruncatedCoefficientRing k j), IsUnit S →
    ∃ P : Matrix ι ι (TruncatedCoefficientRing k N), IsUnit P ∧
      (truncatedRestriction k N j bound).toRingHom.mapMatrix P = S

end Litt3.Deformations
