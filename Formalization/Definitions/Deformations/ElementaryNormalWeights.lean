import Solutions.Deformations.ElementaryAugmentationBasis
import Definitions.Deformations.WeightedNormalReduction

namespace Litt3.Deformations

/-- Weight defined directly on the actual fixed-generator augmentation
basis, with coefficient precision weighted by q-1. -/
noncomputable def elementaryNormalWeightFiltration (R : Type*) [CommRing R] [Nontrivial R]
    (q : ℕ) (positive : 0 < q) (r d : ℕ) :
    Submodule R (AddMonoidAlgebra R (Fin r → ZMod q)) :=
  Submodule.span R {x | ∃ j : ℕ, ∃ alpha : Fin r → Fin q,
    d ≤ (q - 1) * j + ∑ i, (alpha i).val ∧
      x = (q : R) ^ j • elementaryAugmentationBasis q positive r alpha}

end Litt3.Deformations
