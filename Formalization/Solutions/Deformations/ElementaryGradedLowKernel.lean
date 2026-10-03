import Solutions.Deformations.WeightedRootHomogeneousComponents
import Solutions.Deformations.ElementaryGradedIntegralKernel

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (k : Type*) [Field k]

/-- Below the actual norm weight, every original top normal coordinate
vanishes as a polynomial, by its literal homogeneous coefficients. -/
theorem weighted_root_homogeneous_top_coordinate_zero (q : ℕ) (large : 1 < q) (r d : ℕ)
    (small : d < (q - 1) * r)
    (x : weightedRootProduct (Polynomial k) q Polynomial.X r)
    (homogeneous : x ∈ weightedRootHomogeneousComponent k q large r d) :
    (weightedRootProductBasis q large Polynomial.X r).repr x (weightedRootTopExponent q large r) = 0 := by
  apply Polynomial.ext
  intro j
  rw [Polynomial.coeff_zero]
  by_contra nonzero
  have originalCoordinate : (weightedRootPolynomialBasis k q large r).repr x
      (j, weightedRootTopExponent q large r) ≠ 0 := by
    rw [weighted_root_polynomial_basis_coordinate]
    exact nonzero
  have degree := (weighted_root_homogeneous_membership k q large r d x).mp homogeneous
    (j, weightedRootTopExponent q large r) originalCoordinate
  simp only [rootPolynomialWeight, weightedRootTopExponent, Finset.sum_const,
    Finset.card_univ, Fintype.card_fin, nsmul_eq_mul] at degree
  change (q - 1) * j + r * (q - 1) = d at degree
  have lower : (q - 1) * r ≤ (q - 1) * j + r * (q - 1) := by
    rw [Nat.mul_comm (q - 1) r]
    exact Nat.le_add_left _ _
  omega

/-- The source anisotropic quadratic is injective on every actual
homogeneous component strictly below the norm weight 4r. -/
theorem elementary_graded_quadratic_low_kernel [CharP k 5] [Fact (Nat.Prime 5)]
    (r d : ℕ) (small : d < 4 * r)
    (q : MvPolynomial (Fin r) k) (quadratic : q.IsHomogeneous 2)
    (anisotropic : ∀ a : Fin r → ZMod 5, a ≠ 0 →
      q.eval (fun i => ZMod.castHom (dvd_refl 5) k (a i)) ≠ 0)
    (x : weightedRootProduct (Polynomial k) 5 Polynomial.X r)
    (homogeneous : x ∈ weightedRootHomogeneousComponent k 5 (by omega) r d)
    (vanish : weightedRootPolynomialEvaluation 5 Polynomial.X r
      (MvPolynomial.map Polynomial.C q) * x = 0) : x = 0 := by
  obtain ⟨b, line⟩ := (elementary_graded_integral_quadratic_kernel k r q quadratic anisotropic x).mp vanish
  have coordinate := congrArg (fun z =>
    (weightedRootProductBasis 5 (by omega) (Polynomial.X : Polynomial k) r).repr z
      (weightedRootTopExponent 5 (by omega) r)) line
  dsimp only at coordinate
  rw [map_smul, Finsupp.smul_apply, smul_eq_mul, weighted_root_norm_top_coordinate,
    mul_one, weighted_root_homogeneous_top_coordinate_zero k 5 (by omega) r d small x homogeneous] at coordinate
  rw [← coordinate, zero_smul] at line
  exact line

end Litt3.Deformations
