import Definitions.Deformations.NilpotentPerturbation

namespace Litt3.Deformations.Specifications

variable {R A : Type*} [CommRing R] [Ring A] [Algebra R A]

def UnitSurvivesNilpotentScalar (original : A) (parameter : R) : Prop :=
  ∀ correction, IsUnit (scalarPerturbation original parameter correction)

end Litt3.Deformations.Specifications
