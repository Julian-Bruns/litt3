import Definitions.CartierAndSpin.LinearMoments

namespace Litt3.CartierAndSpin.Specifications

variable {K A : Type*} [CommRing K] [CommRing A] [Algebra K A]

def FunctionalTraceZeroMomentTranslationInvariant (linear : A →ₗ[K] K)
    (weight value : A) : Prop :=
  functionalMoment linear weight value 0 = 0 →
  functionalMoment linear weight value 1 = 0 →
  ∀ b : K,
    functionalMoment linear weight (value + algebraMap K A b) 2 =
      functionalMoment linear weight value 2 ∧
    functionalMomentDiscriminant linear weight (value + algebraMap K A b) =
      functionalMomentDiscriminant linear weight value

end Litt3.CartierAndSpin.Specifications
