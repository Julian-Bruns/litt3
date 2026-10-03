import Solutions.Deformations.WeightedRootPolynomialFunctionEvaluation
import Solutions.Deformations.FiniteFieldNormalCoordinates

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (F k : Type*) [Field F] [Fintype F] [DecidableEq F] [Field k]

theorem weighted_root_polynomial_function_normal_basis (ψ : F →+* k) (r : ℕ)
    (alpha : Fin r → Fin (Fintype.card F)) (a : Fin r → F) :
    weightedRootPolynomialFunctionEvaluation F k ψ r
      (weightedRootProductBasis (Fintype.card F) Fintype.one_lt_card Polynomial.X r alpha) a =
      ∏ i, ψ (a i) ^ (alpha i).val := by
  rw [weighted_root_product_basis_apply]
  simp only [map_prod, map_pow, Finset.prod_apply, Pi.pow_apply,
    weighted_root_polynomial_function_parameter]

/-- Every actual original normal coordinate specializes literally;
the full original quotient evaluation is their actual monomial sum. -/
theorem weighted_root_polynomial_function_normal_coordinates (ψ : F →+* k) (r : ℕ)
    (x : weightedRootProduct (Polynomial k) (Fintype.card F) Polynomial.X r)
    (a : Fin r → F) :
    weightedRootPolynomialFunctionEvaluation F k ψ r x a =
      ∑ alpha : Fin r → Fin (Fintype.card F),
        ((weightedRootProductBasis (Fintype.card F) Fintype.one_lt_card Polynomial.X r).repr x alpha).eval (-1) *
          ∏ i, ψ (a i) ^ (alpha i).val := by
  classical
  conv_lhs => rw [← (weightedRootProductBasis (Fintype.card F) Fintype.one_lt_card Polynomial.X r).sum_repr x]
  rw [map_sum]
  simp only [Finset.sum_apply, Algebra.smul_def, map_mul, Pi.mul_apply,
    weighted_root_polynomial_function_coefficient, weighted_root_polynomial_function_normal_basis]

end Litt3.Deformations
