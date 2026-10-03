import Solutions.Deformations.ElementaryWittAssociatedMap
import Solutions.Deformations.WeightedRootStrictTruncation

set_option maxHeartbeats 1200000

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (N : ℕ) [Fact (0 < N)]
variable (k : Type*) [Field k] [Fact (Nat.Prime 5)] [CharP k 5] [PerfectRing k 5]

local instance : Nontrivial (TruncatedWittVector 5 N k) :=
  truncated_witt_nontrivial 5 N (Fact.out : 0 < N) k

/-- The canonical literal original-coordinate homogeneous representative
of an actual Witt initial class. -/
noncomputable def elementaryWittInitialPolynomial (r d : ℕ)
    (x : elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d) :
    weightedRootProduct (Polynomial k) 5 Polynomial.X r :=
  weightedInitialPolynomial k 5 (by omega) r d (elementaryWittInitialCoordinates N k r d x)

theorem elementary_witt_initial_polynomial_homogeneous (r d : ℕ)
    (x : elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d) :
    elementaryWittInitialPolynomial N k r d x ∈ weightedRootHomogeneousComponent k 5 (by omega) r d :=
  weighted_initial_polynomial_homogeneous k 5 (by omega) N r d _
    (elementary_witt_initial_coordinates_supported N k r d x)

theorem elementary_witt_initial_polynomial_truncation (r d : ℕ)
    (x : elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d) :
    weightedRootTruncation k 5 N (Fact.out : 0 < N) r (elementaryWittInitialPolynomial N k r d x) =
      elementaryWittAssociatedMap N k r d x := rfl

theorem elementary_witt_initial_polynomial_own_degree (r d : ℕ)
    (x : elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d)
    (alpha : Fin r → Fin 5) (degree : (∑ i, (alpha i).val) = d) :
    (weightedRootPolynomialBasis k 5 (by omega) r).repr (elementaryWittInitialPolynomial N k r d x)
      (0, alpha) = elementaryWittInitialCoordinates N k r d x alpha := by
  rw [elementaryWittInitialPolynomial, weighted_initial_polynomial_coordinate, degree]
  have exponent : basisWeightExponent 4 d d = 0 :=
    Nat.eq_zero_of_le_zero ((basis_weight_exponent_le 4 d d 0 (by omega)).mpr (by omega))
  rw [exponent, if_pos rfl]

/-- Below the actual first killed parameter weight, equality in the
actual comparison determines the entire literal initial polynomial. -/
theorem elementary_witt_initial_polynomial_unique (r d : ℕ) (small : d < 4 * N)
    (x : elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d)
    (Z : weightedRootProduct (Polynomial k) 5 Polynomial.X r)
    (homogeneous : Z ∈ weightedRootHomogeneousComponent k 5 (by omega) r d)
    (image : elementaryWittAssociatedMap N k r d x =
      weightedRootTruncation k 5 N (Fact.out : 0 < N) r Z) :
    elementaryWittInitialPolynomial N k r d x = Z := by
  apply sub_eq_zero.mp
  apply weighted_root_homogeneous_strict_truncation_zero k 5 (by omega) r N d
    (Fact.out : 0 < N) (by norm_num; omega) _
    (Submodule.sub_mem _ (elementary_witt_initial_polynomial_homogeneous N k r d x) homogeneous)
  rw [map_sub, elementary_witt_initial_polynomial_truncation, image, sub_self]

end Litt3.Deformations
