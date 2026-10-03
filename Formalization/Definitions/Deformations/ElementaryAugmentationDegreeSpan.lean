import Definitions.Deformations.ElementaryNormalWeights
import Solutions.Deformations.ActualAdditiveGroupAugmentation
import Mathlib.RingTheory.Ideal.Operations

namespace Litt3.Deformations

open scoped BigOperators

variable (R : Type*) [CommRing R] [Nontrivial R]

/-- Actual original normal monomials of total augmentation degree at
least d, viewed inside the literal original elementary group algebra. -/
noncomputable def elementaryAugmentationDegreeSpan (q : ℕ) (positive : 0 < q)
    (r d : ℕ) : Submodule R (AddMonoidAlgebra R (Fin r → ZMod q)) :=
  Submodule.span R ((elementaryAugmentationBasis (R := R) q positive r) ''
    {alpha : Fin r → Fin q | d ≤ ∑ i, (alpha i).val})

/-- The actual coefficient-sum augmentation ideal. -/
noncomputable def elementaryOriginalAugmentationIdeal (q r : ℕ) :
    Ideal (AddMonoidAlgebra R (Fin r → ZMod q)) :=
  RingHom.ker (additiveGroupAlgebraAugmentation (R := R) (G := Fin r → ZMod q)).toRingHom

end Litt3.Deformations
