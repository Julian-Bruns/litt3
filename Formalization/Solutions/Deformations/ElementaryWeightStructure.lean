import Solutions.Deformations.ElementaryNormalWeights
import Solutions.Deformations.BasisWeightedFiltration

namespace Litt3.Deformations

variable {R : Type*} [CommRing R] [Nontrivial R]

theorem elementary_normal_weight_antitone (q : ℕ) (positive : 0 < q) (r : ℕ) :
    Antitone (elementaryNormalWeightFiltration R q positive r) :=
  basis_weighted_power_filtration_antitone (elementaryAugmentationBasis q positive r)
    (q : R) (q - 1) (fun alpha => ∑ i, (alpha i).val)

theorem elementary_normal_weight_initial (q : ℕ) (positive : 0 < q) (r : ℕ) :
    elementaryNormalWeightFiltration R q positive r 0 = ⊤ :=
  basis_weighted_power_filtration_initial (elementaryAugmentationBasis q positive r)
    (q : R) (q - 1) (fun alpha => ∑ i, (alpha i).val)

theorem elementary_five_normal_weight_mul (r d e : ℕ)
    (x y : AddMonoidAlgebra R (Fin r → ZMod 5))
    (left : x ∈ elementaryNormalWeightFiltration R 5 (by omega) r d)
    (right : y ∈ elementaryNormalWeightFiltration R 5 (by omega) r e) :
    x * y ∈ elementaryNormalWeightFiltration R 5 (by omega) r (d + e) := by
  rw [elementary_five_normal_weights_eq] at left right ⊢
  exact weighted_generator_filtration_multiplicative _ _ _ _ _ _ _ left right

end Litt3.Deformations
