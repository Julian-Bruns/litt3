import Solutions.Deformations.WittWeightedCoordinateMap
import Solutions.Deformations.ElementaryWeightCoordinates
import Solutions.Deformations.ElementaryWeightedInitial

set_option maxHeartbeats 1000000

namespace Litt3.Deformations

open scoped BigOperators

variable (N : ℕ) [Fact (0 < N)]
variable (k : Type*) [Field k] [Fact (Nat.Prime 5)] [CharP k 5] [PerfectRing k 5]

local instance : Nontrivial (TruncatedWittVector 5 N k) :=
  truncated_witt_nontrivial 5 N (Fact.out : 0 < N) k

/-- Every actual source Witt weighted class has unique unchanged
original normal residue coordinates, at every rank and precision. -/
theorem elementary_witt_initial_coordinates_exists_unique (r d : ℕ)
    (x : AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5))
    (member : x ∈ elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d) :
    ∃! c : (Fin r → Fin 5) → k,
      WittWeightedBasisInitial 5 N (elementaryAugmentationBasis 5 (by omega) r)
        4 d (fun alpha => ∑ i, (alpha i).val) x c := by
  exact witt_weighted_basis_initial_exists_unique 5 N (Fact.out : 0 < N) k
    (elementaryAugmentationBasis 5 (by omega) r) 4 d (by omega)
    (fun alpha => ∑ i, (alpha i).val) x member

/-- The exact original additive associated-weight coordinate map is
constructed from genuine Witt residues and their unique initial lifts. -/
noncomputable def elementaryWittInitialCoordinates (r d : ℕ) :
    elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d →+
      ((Fin r → Fin 5) → k) :=
  wittWeightedCoordinatesAdd 5 N (Fact.out : 0 < N) k (elementaryAugmentationBasis 5 (by omega) r)
    4 d (by omega) (fun alpha => ∑ i, (alpha i).val)

theorem elementary_witt_initial_coordinates_kernel (r d : ℕ)
    (x : elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d) :
    elementaryWittInitialCoordinates N k r d x = 0 ↔
      (x : AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5)) ∈
        elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r (d + 1) :=
  witt_weighted_coordinates_kernel 5 N (Fact.out : 0 < N) k
    (elementaryAugmentationBasis 5 (by omega) r) 4 d (by omega)
    (fun alpha => ∑ i, (alpha i).val) x

theorem elementary_witt_initial_coordinates_full_range (r d : ℕ)
    (c : (Fin r → Fin 5) → k)
    (supported : ∀ alpha, ¬ wittWeightActive 4 d (∑ i, (alpha i).val) N → c alpha = 0) :
    ∃ x : elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d,
      elementaryWittInitialCoordinates N k r d x = c :=
  witt_weighted_coordinates_full_range 5 N (Fact.out : 0 < N) k
    (elementaryAugmentationBasis 5 (by omega) r) 4 d (by omega)
    (fun alpha => ∑ i, (alpha i).val) c supported

end Litt3.Deformations
