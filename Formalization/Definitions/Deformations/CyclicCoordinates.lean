import Mathlib.Algebra.CharP.Lemmas
import Mathlib.RingTheory.Nilpotent.Basic
import Mathlib.RingTheory.Ideal.Span

namespace Litt3.Deformations

variable {R : Type*} [CommRing R]

/-- The original cyclic augmentation coordinate. -/
def cyclicAugmentationCoordinate (generator : Rˣ) : R :=
  (generator : R) - 1

variable [Invertible (2 : R)]

/-- The involution-odd coordinate used by the Hermitian block proof. -/
def cyclicSkewCoordinate (generator : Rˣ) : R :=
  ⅟ (2 : R) * ((generator : R) - (generator⁻¹ : Rˣ))

/-- The exact unit relating the two coordinates; no truncated
coefficient search or formal inverse is needed. -/
def cyclicCoordinateFactor (generator : Rˣ) : R :=
  ⅟ (2 : R) * (generator⁻¹ : Rˣ) * ((generator : R) + 1)

end Litt3.Deformations
