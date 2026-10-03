import Solutions.Deformations.WeightedRootHomogeneousComponents
import Solutions.Deformations.WeightedRootBaseCoordinates
import Solutions.Deformations.HomogeneousPolynomialCoefficient

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (k : Type*) [Field k]

/-- Specialization at any nonzero parameter is injective on each
actual exact-weight component, proved coefficient by coefficient.
No injectivity of the full polynomial specialization is claimed. -/
theorem weighted_root_homogeneous_specialization_zero (q : ℕ) (large : 1 < q) (r d : ℕ)
    (c : k) (nonzero : c ≠ 0)
    (x : weightedRootProduct (Polynomial k) q Polynomial.X r)
    (homogeneous : x ∈ weightedRootHomogeneousComponent k q large r d)
    (vanish : weightedRootProductBaseMap (Polynomial.evalRingHom c) q Polynomial.X r x = 0) : x = 0 := by
  classical
  let φ := Polynomial.evalRingHom c
  let target := weightedRootProductBasis q large (φ Polynomial.X) r
  apply (weightedRootProductBasis q large (Polynomial.X : Polynomial k) r).repr.injective
  apply Finsupp.ext
  intro alpha
  rw [map_zero, Finsupp.zero_apply]
  apply homogeneous_parameter_evaluation_zero _ (q - 1) (∑ i, (alpha i).val) d (by omega)
  · intro j nonzeroCoefficient
    have originalCoordinate : (weightedRootPolynomialBasis k q large r).repr x (j, alpha) ≠ 0 := by
      rw [weighted_root_polynomial_basis_coordinate]
      exact nonzeroCoefficient
    exact (weighted_root_homogeneous_membership k q large r d x).mp homogeneous
      (j, alpha) originalCoordinate
  · exact nonzero
  · have coordinate := congrArg (fun z => target.repr z alpha) vanish
    dsimp only at coordinate
    rw [map_zero, Finsupp.zero_apply, weighted_root_base_map_coordinates] at coordinate
    exact coordinate

end Litt3.Deformations
