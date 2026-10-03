import Solutions.Deformations.WeightedRootScalarDivisibility
import Solutions.Deformations.WeightedRootHomogeneousNormalConstants
import Solutions.Deformations.ElementaryCriticalExponents

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (k : Type*) [CommRing k] [Nontrivial k] [Fact (Nat.Prime 5)]

/-- Exactly the original r critical coefficients obstruct parameter
divisibility of an actual critical homogeneous preimage. -/
theorem elementary_critical_parameter_divisibility (r : ℕ) (positive : 0 < r)
    (x : weightedRootProduct (Polynomial k) 5 Polynomial.X r)
    (homogeneous : x ∈ weightedRootHomogeneousComponent k 5 (by omega) r (4 * r - 1)) :
    (∃ y : weightedRootProduct (Polynomial k) 5 Polynomial.X r,
      x = (Polynomial.X : Polynomial k) • y) ↔
      ∀ i : Fin r, (weightedRootPolynomialBasis k 5 (by omega) r).repr x
        (0, finiteFieldDetectorExponent (ZMod 5) (by norm_num) i) = 0 := by
  rw [weighted_root_scalar_divisibility]
  constructor
  · intro divisible i
    rw [weighted_root_polynomial_basis_coordinate]
    exact Polynomial.X_dvd_iff.mp (divisible (finiteFieldDetectorExponent (ZMod 5) (by norm_num) i))
  · intro detectors alpha
    apply Polynomial.X_dvd_iff.mpr
    by_cases degree : (∑ i, (alpha i).val) = 4 * r - 1
    · obtain ⟨i, same⟩ := elementary_critical_exponent_classification r positive alpha degree
      subst alpha
      simpa only [weighted_root_polynomial_basis_coordinate] using detectors i
    · exact weighted_root_homogeneous_normal_constant_zero k 5 (by omega) r (4 * r - 1)
        x homogeneous alpha degree

end Litt3.Deformations
