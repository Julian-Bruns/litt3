import Definitions.Jacobians.RationalProductFormula

namespace Litt3.Jacobians

def RationalDegreeZeroDivisorsPrincipal : Prop :=
  ∀ (K : Type*) [Field K] [IsAlgClosed K] (D : Divisor (RationalProjectivePlaces K)),
    divisorDegree D = 0 ↔ ∃ f : Additive (RatFunc K)ˣ,
      principalDivisorMap (rationalProjectiveValuationDivisorSystem K) f = D

end Litt3.Jacobians
