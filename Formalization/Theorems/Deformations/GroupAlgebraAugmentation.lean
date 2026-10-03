import Definitions.Deformations.GroupAlgebraAugmentation

namespace Litt3.Deformations.Specifications

open scoped MonoidAlgebra

variable {k G : Type*} [CommRing k] [Group G]

def PGroupAugmentationRadical : Prop :=
  groupAlgebraAugmentationIdeal (k := k) (G := G) = Ring.jacobson k[G]

end Litt3.Deformations.Specifications
