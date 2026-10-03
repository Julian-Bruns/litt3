import Definitions.Deformations.GroupAlgebraInvariants
import Mathlib.RingTheory.Jacobson.Radical
import Mathlib.RingTheory.Ideal.Maps

namespace Litt3.Deformations

open scoped MonoidAlgebra

variable {k G : Type*} [CommRing k] [Group G]

/-- The genuine coefficient-sum augmentation, defined by its
actual group-algebra universal property. -/
noncomputable def groupAlgebraAugmentation : k[G] →ₐ[k] k :=
  MonoidAlgebra.lift k G k (1 : G →* k)

noncomputable def groupAlgebraAugmentationIdeal : Ideal k[G] :=
  RingHom.ker (groupAlgebraAugmentation (k := k) (G := G)).toRingHom

end Litt3.Deformations
