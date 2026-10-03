import Solutions.Deformations.BasisWeightedPowers
import Solutions.Deformations.ElementaryNormalWeights

namespace Litt3.Deformations

open scoped BigOperators

variable {R : Type*} [CommRing R] [Nontrivial R]

/-- Exact normal-coordinate divisibility for the original elementary
filtration, over any mixed-characteristic coefficient ring. -/
theorem elementary_normal_weight_coordinate_iff (q : ℕ) (positive : 0 < q)
    (nontrivial : 1 < q) (r d : ℕ)
    (x : AddMonoidAlgebra R (Fin r → ZMod q)) :
    x ∈ elementaryNormalWeightFiltration R q positive r d ↔
      ∀ alpha : Fin r → Fin q,
        (q : R) ^ basisWeightExponent (q - 1) d (∑ i, (alpha i).val) ∣
          (elementaryAugmentationBasis q positive r).repr x alpha := by
  change x ∈ basisWeightedPowerFiltration (elementaryAugmentationBasis q positive r)
    (q : R) (q - 1) (fun alpha => ∑ i, (alpha i).val) d ↔ _
  exact basis_weighted_power_mem_iff _ _ _ (by omega) _ _ _

end Litt3.Deformations
