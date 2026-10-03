import Solutions.Deformations.ElementaryPrimeWittAssociatedMap
import Solutions.Deformations.WeightedRootStrictTruncation

set_option maxHeartbeats 1200000

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (p N : ℕ) [Fact p.Prime] [Fact (0 < N)]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

local instance : Nontrivial (TruncatedWittVector p N k) :=
  truncated_witt_nontrivial p N (Fact.out : 0 < N) k

/-- The canonical literal original-coordinate homogeneous representative
of an actual Witt initial class. -/
noncomputable def elementaryPrimeWittInitialPolynomial (r d : ℕ)
    (x : elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r d) :
    weightedRootProduct (Polynomial k) p Polynomial.X r :=
  weightedInitialPolynomial k p (by have := (Fact.out : p.Prime).two_le; omega) r d (elementaryPrimeWittInitialCoordinates p N k r d x)

theorem elementary_prime_witt_initial_polynomial_homogeneous (r d : ℕ)
    (x : elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r d) :
    elementaryPrimeWittInitialPolynomial p N k r d x ∈ weightedRootHomogeneousComponent k p (by have := (Fact.out : p.Prime).two_le; omega) r d :=
  weighted_initial_polynomial_homogeneous k p (by have := (Fact.out : p.Prime).two_le; omega) N r d _
    (elementary_prime_witt_initial_coordinates_supported p N k r d x)

theorem elementary_prime_witt_initial_polynomial_truncation (r d : ℕ)
    (x : elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r d) :
    weightedRootTruncation k p N (Fact.out : 0 < N) r (elementaryPrimeWittInitialPolynomial p N k r d x) =
      elementaryPrimeWittAssociatedMap p N k r d x := rfl

theorem elementary_prime_witt_initial_polynomial_own_degree (r d : ℕ)
    (x : elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r d)
    (alpha : Fin r → Fin p) (degree : (∑ i, (alpha i).val) = d) :
    (weightedRootPolynomialBasis k p (by have := (Fact.out : p.Prime).two_le; omega) r).repr (elementaryPrimeWittInitialPolynomial p N k r d x)
      (0, alpha) = elementaryPrimeWittInitialCoordinates p N k r d x alpha := by
  rw [elementaryPrimeWittInitialPolynomial, weighted_initial_polynomial_coordinate, degree]
  have exponent : basisWeightExponent (p - 1) d d = 0 :=
    Nat.eq_zero_of_le_zero ((basis_weight_exponent_le (p - 1) d d 0 (by have := (Fact.out : p.Prime).two_le; omega)).mpr (by have := (Fact.out : p.Prime).two_le; omega))
  rw [exponent, if_pos rfl]

/-- Below the actual first killed parameter weight, equality in the
actual comparison determines the entire literal initial polynomial. -/
theorem elementary_prime_witt_initial_polynomial_unique (r d : ℕ) (small : d < (p - 1) * N)
    (x : elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r d)
    (Z : weightedRootProduct (Polynomial k) p Polynomial.X r)
    (homogeneous : Z ∈ weightedRootHomogeneousComponent k p (by have := (Fact.out : p.Prime).two_le; omega) r d)
    (image : elementaryPrimeWittAssociatedMap p N k r d x =
      weightedRootTruncation k p N (Fact.out : 0 < N) r Z) :
    elementaryPrimeWittInitialPolynomial p N k r d x = Z := by
  apply sub_eq_zero.mp
  apply weighted_root_homogeneous_strict_truncation_zero k p (by have := (Fact.out : p.Prime).two_le; omega) r N d
    (Fact.out : 0 < N) (by have := (Fact.out : p.Prime).two_le; omega) _
    (Submodule.sub_mem _ (elementary_prime_witt_initial_polynomial_homogeneous p N k r d x) homogeneous)
  rw [map_sub, elementary_prime_witt_initial_polynomial_truncation, image, sub_self]

end Litt3.Deformations
