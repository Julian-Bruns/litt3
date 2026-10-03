import Solutions.Deformations.WeightedRootScalarDivisibility
import Solutions.Deformations.WeightedRootHomogeneousNormalConstants
import Solutions.Deformations.ElementaryPrimeCriticalExponents

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (p : ℕ) [Fact p.Prime]
variable (k : Type*) [CommRing k] [Nontrivial k]

/-- Exactly the original r critical coefficients obstruct parameter
divisibility of an actual critical homogeneous preimage. -/
theorem elementary_prime_critical_parameter_divisibility (large : 2 < p) (r : ℕ) (positive : 0 < r)
    (x : weightedRootProduct (Polynomial k) p Polynomial.X r)
    (homogeneous : x ∈ weightedRootHomogeneousComponent k p (by have := (Fact.out : p.Prime).two_le; omega) r ((p - 1) * r - 1)) :
    (∃ y : weightedRootProduct (Polynomial k) p Polynomial.X r,
      x = (Polynomial.X : Polynomial k) • y) ↔
      ∀ i : Fin r, (weightedRootPolynomialBasis k p (by have := (Fact.out : p.Prime).two_le; omega) r).repr x
        (0, primeDetectorExponent p large i) = 0 := by
  rw [weighted_root_scalar_divisibility]
  constructor
  · intro divisible i
    rw [weighted_root_polynomial_basis_coordinate]
    exact Polynomial.X_dvd_iff.mp (divisible (primeDetectorExponent p large i))
  · intro detectors alpha
    apply Polynomial.X_dvd_iff.mpr
    by_cases degree : (∑ i, (alpha i).val) = (p - 1) * r - 1
    · obtain ⟨i, same⟩ := elementary_prime_critical_exponent_classification p large r positive alpha degree
      subst alpha
      simpa only [weighted_root_polynomial_basis_coordinate] using detectors i
    · exact weighted_root_homogeneous_normal_constant_zero k p (by have := (Fact.out : p.Prime).two_le; omega) r ((p - 1) * r - 1)
        x homogeneous alpha degree

end Litt3.Deformations
