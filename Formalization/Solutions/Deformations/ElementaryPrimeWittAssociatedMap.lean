import Solutions.Deformations.ElementaryPrimeWittInitialCoordinates
import Solutions.Deformations.WeightedInitialPolynomialMap
import Solutions.Deformations.HomogeneousInitialCoordinates

set_option maxHeartbeats 1000000

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (p N : ℕ) [Fact p.Prime] [Fact (0 < N)]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

local instance : Nontrivial (TruncatedWittVector p N k) :=
  truncated_witt_nontrivial p N (Fact.out : 0 < N) k

theorem elementary_prime_witt_initial_coordinates_supported (r d : ℕ)
    (x : elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r d) :
    ∀ alpha, ¬ wittWeightActive (p - 1) d (∑ i, (alpha i).val) N →
      elementaryPrimeWittInitialCoordinates p N k r d x alpha = 0 :=
  (witt_weighted_coordinates_initial p N (Fact.out : 0 < N) k
    (elementaryAugmentationBasis p (by have := (Fact.out : p.Prime).two_le; omega) r) (p - 1) d (by have := (Fact.out : p.Prime).two_le; omega)
    (fun alpha => ∑ i, (alpha i).val) x).1

/-- Actual additive map from the genuine Witt weighted module to the
literal source parameter algebra at exactly the same precision. -/
noncomputable def elementaryPrimeWittAssociatedMap (r d : ℕ) :
    elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r d →+
      weightedRootProduct (TruncatedCoefficientRing k N) p (truncatedParameter k N) r :=
  (weightedRootTruncation k p N (Fact.out : 0 < N) r).toAddMonoidHom.comp
    ((weightedInitialPolynomialLinear k p (by have := (Fact.out : p.Prime).two_le; omega) r d).toAddMonoidHom.comp
      (elementaryPrimeWittInitialCoordinates p N k r d))

/-- The actual map kills exactly the actual next source weight,
proving faithful identification of genuine associated-weight classes. -/
theorem elementary_prime_witt_associated_map_kernel (r d : ℕ)
    (x : elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r d) :
    elementaryPrimeWittAssociatedMap p N k r d x = 0 ↔
      (x : AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p)) ∈
        elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r (d + 1) := by
  change weightedRootTruncation k p N (Fact.out : 0 < N) r
    (weightedInitialPolynomial k p (by have := (Fact.out : p.Prime).two_le; omega) r d (elementaryPrimeWittInitialCoordinates p N k r d x)) = 0 ↔ _
  rw [weighted_initial_polynomial_truncation_zero k p (by have := (Fact.out : p.Prime).two_le; omega) N (Fact.out : 0 < N) r d _
    (elementary_prime_witt_initial_coordinates_supported p N k r d x)]
  exact elementary_prime_witt_initial_coordinates_kernel p N k r d x

/-- Its range is the entire actual homogeneous parameter class at the
source precision, with both directions supplied by constructed lifts. -/
theorem elementary_prime_witt_associated_map_full_range (r d : ℕ)
    (z : weightedRootProduct (TruncatedCoefficientRing k N) p (truncatedParameter k N) r) :
    (∃ x : elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r d,
      elementaryPrimeWittAssociatedMap p N k r d x = z) ↔
    ∃ Z : weightedRootProduct (Polynomial k) p Polynomial.X r,
      Z ∈ weightedRootHomogeneousComponent k p (by have := (Fact.out : p.Prime).two_le; omega) r d ∧
      weightedRootTruncation k p N (Fact.out : 0 < N) r Z = z := by
  constructor
  · rintro ⟨x, image⟩
    refine ⟨weightedInitialPolynomial k p (by have := (Fact.out : p.Prime).two_le; omega) r d
      (elementaryPrimeWittInitialCoordinates p N k r d x), ?_, image⟩
    exact weighted_initial_polynomial_homogeneous k p (by have := (Fact.out : p.Prime).two_le; omega) N r d _
      (elementary_prime_witt_initial_coordinates_supported p N k r d x)
  · rintro ⟨Z, homogeneous, image⟩
    obtain ⟨x, coordinates⟩ := elementary_prime_witt_initial_coordinates_full_range p N k r d
      (homogeneousInitialCoordinates k p (by have := (Fact.out : p.Prime).two_le; omega) N r d Z)
      (homogeneous_initial_coordinates_supported k p (by have := (Fact.out : p.Prime).two_le; omega) N r d Z)
    refine ⟨x, ?_⟩
    change weightedRootTruncation k p N (Fact.out : 0 < N) r
      (weightedInitialPolynomial k p (by have := (Fact.out : p.Prime).two_le; omega) r d (elementaryPrimeWittInitialCoordinates p N k r d x)) = z
    rw [coordinates, homogeneous_initial_coordinates_truncation k p (by have := (Fact.out : p.Prime).two_le; omega) N (Fact.out : 0 < N)
      r d Z homogeneous, image]

end Litt3.Deformations
