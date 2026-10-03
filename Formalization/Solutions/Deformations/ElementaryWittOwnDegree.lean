import Solutions.Deformations.WittWeightedInitialResidue
import Solutions.Deformations.ElementaryWittInitialCoordinates

namespace Litt3.Deformations

open scoped BigOperators

variable (N : ℕ) [Fact (0 < N)]
variable (k : Type*) [Field k] [Fact (Nat.Prime 5)] [CharP k 5] [PerfectRing k 5]

local instance : Nontrivial (TruncatedWittVector 5 N k) :=
  truncated_witt_nontrivial 5 N (Fact.out : 0 < N) k

theorem elementary_witt_initial_own_degree (r d : ℕ)
    (x : elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d)
    (alpha : Fin r → Fin 5) (degree : (∑ i, (alpha i).val) = d) :
    elementaryWittInitialCoordinates N k r d x alpha =
      truncatedWittResidue 5 N (Fact.out : 0 < N) k
        ((elementaryAugmentationBasis 5 (by omega) r).repr x.val alpha) := by
  have initial := witt_weighted_coordinates_initial 5 N (Fact.out : 0 < N) k
    (elementaryAugmentationBasis 5 (by omega) r) 4 d (by omega)
    (fun beta => ∑ i, (beta i).val) x
  have coordinate := (witt_weighted_basis_initial_iff 5 N k
    (elementaryAugmentationBasis 5 (by omega) r) 4 d (by omega)
    (fun beta => ∑ i, (beta i).val) x.val _).mp initial alpha
  rw [degree] at coordinate
  exact witt_weighted_initial_zero_exponent 5 N (Fact.out : 0 < N) k 4 d (by omega) _ _ coordinate

end Litt3.Deformations
