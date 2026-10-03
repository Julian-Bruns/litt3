import Definitions.Jacobians.RationalLinearPlaces

namespace Litt3.Jacobians

noncomputable def rationalPrincipalDegree
    (K : Type*) [Field K] : Additive (RatFunc K)ˣ →+ ℤ :=
  divisorDegree.comp (principalDivisorMap (rationalProjectiveValuationDivisorSystem K))

end Litt3.Jacobians
