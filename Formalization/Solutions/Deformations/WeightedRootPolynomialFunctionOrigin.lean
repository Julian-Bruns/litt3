import Solutions.Deformations.WeightedRootPolynomialFunctionEvaluation
import Solutions.Deformations.WeightedRootOriginCoordinates

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (F k : Type*) [Field F] [Fintype F] [DecidableEq F] [Field k]

/-- Actual augmentation at the origin commutes with actual parameter
specialization and actual original finite-field evaluation. -/
theorem weighted_root_polynomial_function_origin (ψ : F →+* k) (r : ℕ)
    (x : weightedRootProduct (Polynomial k) (Fintype.card F) Polynomial.X r) :
    weightedRootPolynomialFunctionEvaluation F k ψ r x 0 =
      (weightedRootOrigin (Fintype.card F) Fintype.card_pos
        (Polynomial.X : Polynomial k) r x).eval (-1) := by
  classical
  let originLinear : weightedRootProduct (Polynomial k) (Fintype.card F) Polynomial.X r →ₗ[k] k :=
    { toFun := fun z => (weightedRootOrigin (Fintype.card F) Fintype.card_pos
          (Polynomial.X : Polynomial k) r z).eval (-1)
      map_add' := by intro z w; simp only [map_add, Polynomial.eval_add]
      map_smul' := by
        intro c z
        change (weightedRootOrigin (Fintype.card F) Fintype.card_pos Polynomial.X r
          (algebraMap (Polynomial k) _ (Polynomial.C c) * z)).eval (-1) = _
        simp only [map_mul, AlgHom.commutes, Algebra.algebraMap_self, RingHom.id_apply,
          Polynomial.eval_mul, Polynomial.eval_C, smul_eq_mul] }
  let functionLinear : weightedRootProduct (Polynomial k) (Fintype.card F) Polynomial.X r →ₗ[k] k :=
    (LinearMap.proj (0 : Fin r → F)).comp (weightedRootPolynomialFunctionLinear F k ψ r)
  have equal : functionLinear = originLinear := by
    apply (weightedRootPolynomialBasis k (Fintype.card F) Fintype.one_lt_card r).ext
    rintro ⟨j, alpha⟩
    change weightedRootPolynomialFunctionEvaluation F k ψ r
        (weightedRootPolynomialBasis k (Fintype.card F) Fintype.one_lt_card r (j, alpha)) 0 =
      (weightedRootOrigin (Fintype.card F) Fintype.card_pos Polynomial.X r
        (weightedRootPolynomialBasis k (Fintype.card F) Fintype.one_lt_card r (j, alpha))).eval (-1)
    rw [weighted_root_polynomial_function_basis, weighted_root_polynomial_basis_apply,
      map_smul, weighted_root_origin_basis]
    have monomialOrigin := weighted_root_origin_basis (R := k)
      (Fintype.card F) Fintype.one_lt_card (-1) r alpha
    simp only [weighted_root_product_basis_apply, map_prod, map_pow,
      weighted_root_origin_parameter] at monomialOrigin
    simp only [Pi.zero_apply, map_zero, monomialOrigin, smul_eq_mul]
    split_ifs <;> simp [Polynomial.eval_pow]
  exact congrArg (fun f => f x) equal

end Litt3.Deformations
