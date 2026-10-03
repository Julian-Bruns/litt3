import Definitions.Deformations.CyclicGroupAlgebra

namespace Litt3.Deformations.Specifications

variable {k : Type*} [CommRing k]

def CyclicAugmentationPresentationBijective (p a : ℕ) [Fact p.Prime] [CharP k p] : Prop :=
  Function.Bijective (cyclicAugmentationPresentation k p a)

end Litt3.Deformations.Specifications
