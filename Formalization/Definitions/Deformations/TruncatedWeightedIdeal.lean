import Definitions.Deformations.TruncatedMonomialAlgebra
import Definitions.Deformations.WeightedMonomialIdeal

namespace Litt3.Deformations

variable (R I : Type*) [CommRing R] [Fintype I]

/-- The image of the literal original weighted monomial ideal in the
actual quotient by the original unequal variable powers. -/
noncomputable def truncatedWeightedIdeal (q w : I → ℕ) (d : ℕ) :
    Ideal (TruncatedMonomialAlgebra R I q) :=
  (weightedMonomialIdeal I R w d).map (Ideal.Quotient.mk (truncatedMonomialIdeal R I q))

end Litt3.Deformations
