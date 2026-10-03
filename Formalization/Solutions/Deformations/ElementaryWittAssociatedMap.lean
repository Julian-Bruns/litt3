import Solutions.Deformations.ElementaryWittInitialCoordinates
import Solutions.Deformations.WeightedInitialPolynomialMap
import Solutions.Deformations.HomogeneousInitialCoordinates

set_option maxHeartbeats 1000000

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (N : ℕ) [Fact (0 < N)]
variable (k : Type*) [Field k] [Fact (Nat.Prime 5)] [CharP k 5] [PerfectRing k 5]

local instance : Nontrivial (TruncatedWittVector 5 N k) :=
  truncated_witt_nontrivial 5 N (Fact.out : 0 < N) k

theorem elementary_witt_initial_coordinates_supported (r d : ℕ)
    (x : elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d) :
    ∀ alpha, ¬ wittWeightActive 4 d (∑ i, (alpha i).val) N →
      elementaryWittInitialCoordinates N k r d x alpha = 0 :=
  (witt_weighted_coordinates_initial 5 N (Fact.out : 0 < N) k
    (elementaryAugmentationBasis 5 (by omega) r) 4 d (by omega)
    (fun alpha => ∑ i, (alpha i).val) x).1

/-- Actual additive map from the genuine Witt weighted module to the
literal source parameter algebra at exactly the same precision. -/
noncomputable def elementaryWittAssociatedMap (r d : ℕ) :
    elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d →+
      weightedRootProduct (TruncatedCoefficientRing k N) 5 (truncatedParameter k N) r :=
  (weightedRootTruncation k 5 N (Fact.out : 0 < N) r).toAddMonoidHom.comp
    ((weightedInitialPolynomialLinear k 5 (by omega) r d).toAddMonoidHom.comp
      (elementaryWittInitialCoordinates N k r d))

/-- The actual map kills exactly the actual next source weight,
proving faithful identification of genuine associated-weight classes. -/
theorem elementary_witt_associated_map_kernel (r d : ℕ)
    (x : elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d) :
    elementaryWittAssociatedMap N k r d x = 0 ↔
      (x : AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5)) ∈
        elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r (d + 1) := by
  change weightedRootTruncation k 5 N (Fact.out : 0 < N) r
    (weightedInitialPolynomial k 5 (by omega) r d (elementaryWittInitialCoordinates N k r d x)) = 0 ↔ _
  rw [weighted_initial_polynomial_truncation_zero k 5 (by omega) N (Fact.out : 0 < N) r d _
    (elementary_witt_initial_coordinates_supported N k r d x)]
  exact elementary_witt_initial_coordinates_kernel N k r d x

/-- Its range is the entire actual homogeneous parameter class at the
source precision, with both directions supplied by constructed lifts. -/
theorem elementary_witt_associated_map_full_range (r d : ℕ)
    (z : weightedRootProduct (TruncatedCoefficientRing k N) 5 (truncatedParameter k N) r) :
    (∃ x : elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d,
      elementaryWittAssociatedMap N k r d x = z) ↔
    ∃ Z : weightedRootProduct (Polynomial k) 5 Polynomial.X r,
      Z ∈ weightedRootHomogeneousComponent k 5 (by omega) r d ∧
      weightedRootTruncation k 5 N (Fact.out : 0 < N) r Z = z := by
  constructor
  · rintro ⟨x, image⟩
    refine ⟨weightedInitialPolynomial k 5 (by omega) r d
      (elementaryWittInitialCoordinates N k r d x), ?_, image⟩
    exact weighted_initial_polynomial_homogeneous k 5 (by omega) N r d _
      (elementary_witt_initial_coordinates_supported N k r d x)
  · rintro ⟨Z, homogeneous, image⟩
    obtain ⟨x, coordinates⟩ := elementary_witt_initial_coordinates_full_range N k r d
      (homogeneousInitialCoordinates k 5 (by omega) N r d Z)
      (homogeneous_initial_coordinates_supported k 5 (by omega) N r d Z)
    refine ⟨x, ?_⟩
    change weightedRootTruncation k 5 N (Fact.out : 0 < N) r
      (weightedInitialPolynomial k 5 (by omega) r d (elementaryWittInitialCoordinates N k r d x)) = z
    rw [coordinates, homogeneous_initial_coordinates_truncation k 5 (by omega) N (Fact.out : 0 < N)
      r d Z homogeneous, image]

end Litt3.Deformations
