import Definitions.CartierAndSpin.LinearMoments

namespace Litt3.CartierAndSpin

variable {K A : Type*} [CommRing K] [CommRing A] [Algebra K A]

/-- The source's literal characteristic-five quartic moment invariant. -/
def functionalMomentFiveInvariant (linear : A →ₗ[K] K) (weight value : A) : K :=
  functionalMoment linear weight value 2 * functionalMoment linear weight value 4 +
    functionalMoment linear weight value 3 ^ 2

end Litt3.CartierAndSpin
