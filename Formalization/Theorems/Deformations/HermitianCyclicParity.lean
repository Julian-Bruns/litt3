import Definitions.Deformations.HermitianCyclicParity

namespace Litt3.Deformations.Specifications

def HermitianCyclicParity (N s : ℕ) (degree multiplicity : Fin s → ℕ) : Prop :=
  OddNonfreeCyclicMultiplicitiesEven N s degree multiplicity

end Litt3.Deformations.Specifications
