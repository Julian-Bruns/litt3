import Definitions.Jacobians.ValuationDivisors

namespace Litt3.Jacobians

def rationalUnitPullback {K L : Type*} [Field K] [Field L] (φ : K →+* L) :
    Additive Kˣ →+ Additive Lˣ := (Units.map φ.toMonoidHom).toAdditive

end Litt3.Jacobians
