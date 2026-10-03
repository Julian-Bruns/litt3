import Definitions.Jacobians.RationalProductFormula

namespace Litt3.Jacobians

def RationalProductFormula : Prop :=
  ∀ (K : Type*) [Field K] [IsAlgClosed K] (f : Additive (RatFunc K)ˣ),
    rationalPrincipalDegree K f = 0

end Litt3.Jacobians
