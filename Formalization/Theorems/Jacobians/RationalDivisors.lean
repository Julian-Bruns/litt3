import Definitions.Jacobians.RationalInfinityValuation

namespace Litt3.Jacobians.Targets

/-- The principal divisor at the actual infinity valuation has its usual
order for every rational function over every field. -/
def RationalPrincipalDivisorInfinityOrder : Prop :=
  ∀ (K : Type) [Field K] (r : (RatFunc K)ˣ),
    principalDivisorMap (rationalProjectiveValuationDivisorSystem K) (Additive.ofMul r) none =
      ((r.val.denom.natDegree : ℤ) - (r.val.num.natDegree : ℤ))

end Litt3.Jacobians.Targets
