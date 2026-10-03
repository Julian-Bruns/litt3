import Solutions.Deformations.ElementaryPrimeWittFrobeniusWeight
import Solutions.Deformations.ElementaryPrimeWittInitialCoordinates
import Solutions.Deformations.WittInitialCoefficientMap

set_option maxHeartbeats 1000000

namespace Litt3.Deformations

open scoped BigOperators

variable (p N : ℕ) [Fact p.Prime] [Fact (0 < N)]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

local instance : Nontrivial (TruncatedWittVector p N k) :=
  truncated_witt_nontrivial p N (Fact.out : 0 < N) k

/-- The actual source Witt Frobenius induces precisely coefficient
Frobenius on every unchanged original weighted normal coordinate. -/
theorem elementary_prime_witt_frobenius_initial_coordinates (r d : ℕ)
    (x : elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r d) :
    elementaryPrimeWittInitialCoordinates p N k r d (elementaryPrimeWittFrobeniusWeight p N k r d x) =
      fun alpha => (_root_.frobeniusEquiv k p) (elementaryPrimeWittInitialCoordinates p N k r d x alpha) := by
  let B := elementaryAugmentationBasis (R := TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r
  let f := (_root_.frobeniusEquiv k p).toRingHom
  let c := fun alpha => (_root_.frobeniusEquiv k p) (elementaryPrimeWittInitialCoordinates p N k r d x alpha)
  have initial := witt_weighted_coordinates_initial p N (Fact.out : 0 < N) k B (p - 1) d (by have := (Fact.out : p.Prime).two_le; omega)
    (fun alpha => ∑ i, (alpha i).val) x
  have transformed : WittWeightedBasisInitial p N B (p - 1) d (fun alpha => ∑ i, (alpha i).val)
      (elementaryWittFrobenius p N r k x) c := by
    rw [witt_weighted_basis_initial_iff p N k B (p - 1) d (by have := (Fact.out : p.Prime).two_le; omega)]
    intro alpha
    have coefficient := witt_weighted_coefficient_initial_map p N f (p - 1) d
      (∑ i, (alpha i).val) (B.repr x alpha) (elementaryPrimeWittInitialCoordinates p N k r d x alpha)
      ((witt_weighted_basis_initial_iff p N k B (p - 1) d (by have := (Fact.out : p.Prime).two_le; omega)
        (fun alpha => ∑ i, (alpha i).val) x _).mp initial alpha)
    have normal := group_coefficient_map_normal_coordinate (truncatedWittMap p N f)
      p (by have := (Fact.out : p.Prime).two_le; omega) r x alpha
    rw [← normal] at coefficient
    exact coefficient
  exact ((Classical.choose_spec (witt_weighted_basis_initial_exists_unique p N (Fact.out : 0 < N) k
    B (p - 1) d (by have := (Fact.out : p.Prime).two_le; omega) (fun alpha => ∑ i, (alpha i).val)
    (elementaryPrimeWittFrobeniusWeight p N k r d x) (elementaryPrimeWittFrobeniusWeight p N k r d x).property)).2 c transformed).symm

end Litt3.Deformations
