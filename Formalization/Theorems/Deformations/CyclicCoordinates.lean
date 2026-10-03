import Definitions.Deformations.CyclicCoordinates

namespace Litt3.Deformations.Specifications

variable {R : Type*} [CommRing R] [Invertible (2 : R)]

/-- The new skew coordinate generates exactly the same principal
ideal and every power as the original cyclic augmentation coordinate. -/
def CyclicCoordinateIdealsAgree (generator : Rˣ) : Prop :=
  ∀ n,
    Ideal.span ({cyclicSkewCoordinate generator ^ n} : Set R) =
      Ideal.span ({cyclicAugmentationCoordinate generator ^ n} : Set R)

end Litt3.Deformations.Specifications
