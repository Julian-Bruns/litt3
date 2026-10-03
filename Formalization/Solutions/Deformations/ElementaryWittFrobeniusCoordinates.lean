import Solutions.Deformations.ElementaryWittFrobeniusWeight
import Solutions.Deformations.WittInitialCoefficientMap

set_option maxHeartbeats 1000000

namespace Litt3.Deformations

open scoped BigOperators

variable (N : ℕ) [Fact (0 < N)]
variable (k : Type*) [Field k] [Fact (Nat.Prime 5)] [CharP k 5] [PerfectRing k 5]

local instance : Nontrivial (TruncatedWittVector 5 N k) :=
  truncated_witt_nontrivial 5 N (Fact.out : 0 < N) k

/-- The actual source Witt Frobenius induces precisely coefficient
Frobenius on every unchanged original weighted normal coordinate. -/
theorem elementary_witt_frobenius_initial_coordinates (r d : ℕ)
    (x : elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d) :
    elementaryWittInitialCoordinates N k r d (elementaryWittFrobeniusWeight N k r d x) =
      fun alpha => (_root_.frobeniusEquiv k 5) (elementaryWittInitialCoordinates N k r d x alpha) := by
  let B := elementaryAugmentationBasis (R := TruncatedWittVector 5 N k) 5 (by omega) r
  let f := (_root_.frobeniusEquiv k 5).toRingHom
  let c := fun alpha => (_root_.frobeniusEquiv k 5) (elementaryWittInitialCoordinates N k r d x alpha)
  have initial := witt_weighted_coordinates_initial 5 N (Fact.out : 0 < N) k B 4 d (by omega)
    (fun alpha => ∑ i, (alpha i).val) x
  have transformed : WittWeightedBasisInitial 5 N B 4 d (fun alpha => ∑ i, (alpha i).val)
      (elementaryWittFrobenius 5 N r k x) c := by
    rw [witt_weighted_basis_initial_iff 5 N k B 4 d (by omega)]
    intro alpha
    have coefficient := witt_weighted_coefficient_initial_map 5 N f 4 d
      (∑ i, (alpha i).val) (B.repr x alpha) (elementaryWittInitialCoordinates N k r d x alpha)
      ((witt_weighted_basis_initial_iff 5 N k B 4 d (by omega)
        (fun alpha => ∑ i, (alpha i).val) x _).mp initial alpha)
    have normal := group_coefficient_map_normal_coordinate (truncatedWittMap 5 N f)
      5 (by omega) r x alpha
    rw [← normal] at coefficient
    exact coefficient
  exact ((Classical.choose_spec (witt_weighted_basis_initial_exists_unique 5 N (Fact.out : 0 < N) k
    B 4 d (by omega) (fun alpha => ∑ i, (alpha i).val)
    (elementaryWittFrobeniusWeight N k r d x) (elementaryWittFrobeniusWeight N k r d x).property)).2 c transformed).symm

end Litt3.Deformations
