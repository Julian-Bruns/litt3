import Solutions.Deformations.WittWeightedCoordinateMap
import Solutions.Deformations.ElementaryWeightCoordinates
import Solutions.Deformations.ElementaryWeightedInitial

set_option maxHeartbeats 1000000

namespace Litt3.Deformations

open scoped BigOperators

variable (p N : ℕ) [Fact p.Prime] [Fact (0 < N)]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

local instance : Nontrivial (TruncatedWittVector p N k) :=
  truncated_witt_nontrivial p N (Fact.out : 0 < N) k

/-- Every actual source Witt weighted class has unique unchanged
original normal residue coordinates, at every rank and precision. -/
theorem elementary_prime_witt_initial_coordinates_exists_unique (r d : ℕ)
    (x : AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p))
    (member : x ∈ elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r d) :
    ∃! c : (Fin r → Fin p) → k,
      WittWeightedBasisInitial p N (elementaryAugmentationBasis p (by have := (Fact.out : p.Prime).two_le; omega) r)
        (p - 1) d (fun alpha => ∑ i, (alpha i).val) x c := by
  exact witt_weighted_basis_initial_exists_unique p N (Fact.out : 0 < N) k
    (elementaryAugmentationBasis p (by have := (Fact.out : p.Prime).two_le; omega) r) (p - 1) d (by have := (Fact.out : p.Prime).two_le; omega)
    (fun alpha => ∑ i, (alpha i).val) x member

/-- The exact original additive associated-weight coordinate map is
constructed from genuine Witt residues and their unique initial lifts. -/
noncomputable def elementaryPrimeWittInitialCoordinates (r d : ℕ) :
    elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r d →+
      ((Fin r → Fin p) → k) :=
  wittWeightedCoordinatesAdd p N (Fact.out : 0 < N) k (elementaryAugmentationBasis p (by have := (Fact.out : p.Prime).two_le; omega) r)
    (p - 1) d (by have := (Fact.out : p.Prime).two_le; omega) (fun alpha => ∑ i, (alpha i).val)

theorem elementary_prime_witt_initial_coordinates_kernel (r d : ℕ)
    (x : elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r d) :
    elementaryPrimeWittInitialCoordinates p N k r d x = 0 ↔
      (x : AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p)) ∈
        elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r (d + 1) :=
  witt_weighted_coordinates_kernel p N (Fact.out : 0 < N) k
    (elementaryAugmentationBasis p (by have := (Fact.out : p.Prime).two_le; omega) r) (p - 1) d (by have := (Fact.out : p.Prime).two_le; omega)
    (fun alpha => ∑ i, (alpha i).val) x

theorem elementary_prime_witt_initial_coordinates_full_range (r d : ℕ)
    (c : (Fin r → Fin p) → k)
    (supported : ∀ alpha, ¬ wittWeightActive (p - 1) d (∑ i, (alpha i).val) N → c alpha = 0) :
    ∃ x : elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r d,
      elementaryPrimeWittInitialCoordinates p N k r d x = c :=
  witt_weighted_coordinates_full_range p N (Fact.out : 0 < N) k
    (elementaryAugmentationBasis p (by have := (Fact.out : p.Prime).two_le; omega) r) (p - 1) d (by have := (Fact.out : p.Prime).two_le; omega)
    (fun alpha => ∑ i, (alpha i).val) c supported

end Litt3.Deformations
