import Solutions.Deformations.WittWeightedInitialResidue
import Solutions.Deformations.ElementaryPrimeWittInitialCoordinates

namespace Litt3.Deformations

open scoped BigOperators

variable (p N : ℕ) [Fact p.Prime] [Fact (0 < N)]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

local instance : Nontrivial (TruncatedWittVector p N k) :=
  truncated_witt_nontrivial p N (Fact.out : 0 < N) k

theorem elementary_prime_witt_initial_own_degree (r d : ℕ)
    (x : elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r d)
    (alpha : Fin r → Fin p) (degree : (∑ i, (alpha i).val) = d) :
    elementaryPrimeWittInitialCoordinates p N k r d x alpha =
      truncatedWittResidue p N (Fact.out : 0 < N) k
        ((elementaryAugmentationBasis p (by have := (Fact.out : p.Prime).two_le; omega) r).repr x.val alpha) := by
  have initial := witt_weighted_coordinates_initial p N (Fact.out : 0 < N) k
    (elementaryAugmentationBasis p (by have := (Fact.out : p.Prime).two_le; omega) r) (p - 1) d (by have := (Fact.out : p.Prime).two_le; omega)
    (fun beta => ∑ i, (beta i).val) x
  have coordinate := (witt_weighted_basis_initial_iff p N k
    (elementaryAugmentationBasis p (by have := (Fact.out : p.Prime).two_le; omega) r) (p - 1) d (by have := (Fact.out : p.Prime).two_le; omega)
    (fun beta => ∑ i, (beta i).val) x.val _).mp initial alpha
  rw [degree] at coordinate
  exact witt_weighted_initial_zero_exponent p N (Fact.out : 0 < N) k (p - 1) d (by have := (Fact.out : p.Prime).two_le; omega) _ _ coordinate

end Litt3.Deformations
