import Solutions.Deformations.PrimeWeightedPolynomialFunction
import Solutions.Deformations.WeightedRootOriginCoordinates

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (p : ℕ) [Fact p.Prime]
variable (k : Type*) [Field k]

/-- Actual augmentation at the origin commutes with actual parameter
specialization and actual original finite-field evaluation. -/
theorem prime_weighted_polynomial_function_origin (ψ : ZMod p →+* k) (r : ℕ)
    (x : weightedRootProduct (Polynomial k) p Polynomial.X r) :
    primeWeightedPolynomialFunction p k ψ r x 0 =
      (weightedRootOrigin p (Fact.out : p.Prime).pos
        (Polynomial.X : Polynomial k) r x).eval (-1) := by
  classical
  let originLinear : weightedRootProduct (Polynomial k) p Polynomial.X r →ₗ[k] k :=
    { toFun := fun z => (weightedRootOrigin p (Fact.out : p.Prime).pos
          (Polynomial.X : Polynomial k) r z).eval (-1)
      map_add' := by intro z w; simp only [map_add, Polynomial.eval_add]
      map_smul' := by
        intro c z
        change (weightedRootOrigin p (Fact.out : p.Prime).pos Polynomial.X r
          (algebraMap (Polynomial k) _ (Polynomial.C c) * z)).eval (-1) = _
        simp only [map_mul, AlgHom.commutes, Algebra.algebraMap_self, RingHom.id_apply,
          Polynomial.eval_mul, Polynomial.eval_C, smul_eq_mul] }
  let functionLinear : weightedRootProduct (Polynomial k) p Polynomial.X r →ₗ[k] k :=
    (LinearMap.proj (0 : Fin r → ZMod p)).comp (primeWeightedPolynomialFunctionLinear p k ψ r)
  have equal : functionLinear = originLinear := by
    apply (weightedRootPolynomialBasis k p (Fact.out : p.Prime).one_lt r).ext
    rintro ⟨j, alpha⟩
    change primeWeightedPolynomialFunction p k ψ r
        (weightedRootPolynomialBasis k p (Fact.out : p.Prime).one_lt r (j, alpha)) 0 =
      (weightedRootOrigin p (Fact.out : p.Prime).pos Polynomial.X r
        (weightedRootPolynomialBasis k p (Fact.out : p.Prime).one_lt r (j, alpha))).eval (-1)
    rw [prime_weighted_polynomial_function_basis, weighted_root_polynomial_basis_apply,
      map_smul, weighted_root_origin_basis]
    have monomialOrigin := weighted_root_origin_basis (R := k)
      p (Fact.out : p.Prime).one_lt (-1) r alpha
    simp only [weighted_root_product_basis_apply, map_prod, map_pow,
      weighted_root_origin_parameter] at monomialOrigin
    simp only [Pi.zero_apply, map_zero, monomialOrigin, smul_eq_mul]
    split_ifs <;> simp [Polynomial.eval_pow]
  exact congrArg (fun f => f x) equal

end Litt3.Deformations
