import Solutions.Deformations.WeightedRootEvaluationAtTau
import Solutions.Deformations.WeightedRootHomogeneousSpecialization

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (F k : Type*) [Field F] [Fintype F] [DecidableEq F] [Field k]

/-- Literal specialization of the actual parameter at minus one,
followed by evaluation on the unchanged original finite-field tuples. -/
noncomputable def weightedRootPolynomialFunctionEvaluation (ψ : F →+* k) (r : ℕ) :
    weightedRootProduct (Polynomial k) (Fintype.card F) Polynomial.X r →+*
      ((Fin r → F) → k) :=
  (weightedRootEvaluationAtTau F k ψ ((Polynomial.evalRingHom (-1 : k)) Polynomial.X)
    1 (by simp) r).toRingHom.comp
      (weightedRootProductBaseMap (Polynomial.evalRingHom (-1 : k))
        (Fintype.card F) Polynomial.X r)

@[simp] theorem weighted_root_polynomial_function_parameter (ψ : F →+* k)
    (r : ℕ) (i : Fin r) (a : Fin r → F) :
    weightedRootPolynomialFunctionEvaluation F k ψ r
      (weightedRootProductParameter (Polynomial k) (Fintype.card F) Polynomial.X r i) a =
      ψ (a i) := by
  unfold weightedRootPolynomialFunctionEvaluation
  rw [RingHom.comp_apply, weighted_root_base_map_parameter]
  change weightedRootEvaluationAtTau F k ψ ((Polynomial.evalRingHom (-1 : k)) Polynomial.X)
    1 (by simp) r
      (weightedRootProductParameter k (Fintype.card F)
        ((Polynomial.evalRingHom (-1 : k)) Polynomial.X) r i) a = _
  rw [weighted_root_evaluation_at_tau_parameter, one_mul]

@[simp] theorem weighted_root_polynomial_function_coefficient (ψ : F →+* k)
    (r : ℕ) (p : Polynomial k) (a : Fin r → F) :
    weightedRootPolynomialFunctionEvaluation F k ψ r
      (algebraMap (Polynomial k)
        (weightedRootProduct (Polynomial k) (Fintype.card F) Polynomial.X r) p) a =
      p.eval (-1) := by
  unfold weightedRootPolynomialFunctionEvaluation
  rw [RingHom.comp_apply, weighted_root_base_map_coefficient]
  change weightedRootEvaluationAtTau F k ψ ((Polynomial.evalRingHom (-1 : k)) Polynomial.X)
    1 (by simp) r (algebraMap k _ ((Polynomial.evalRingHom (-1 : k)) p)) a = _
  rw [AlgHom.commutes]
  rfl

/-- The constructed evaluation is genuinely linear for the unchanged
coefficient field, although its parameter specialization is not injective
on the entire algebra. -/
noncomputable def weightedRootPolynomialFunctionLinear (ψ : F →+* k) (r : ℕ) :
    weightedRootProduct (Polynomial k) (Fintype.card F) Polynomial.X r →ₗ[k]
      ((Fin r → F) → k) where
  __ := (weightedRootPolynomialFunctionEvaluation F k ψ r).toAddMonoidHom
  map_smul' c x := by
    change weightedRootPolynomialFunctionEvaluation F k ψ r
      (algebraMap (Polynomial k) _ (Polynomial.C c) * x) =
      c • weightedRootPolynomialFunctionEvaluation F k ψ r x
    rw [map_mul]
    funext a
    simp [weighted_root_polynomial_function_coefficient]

/-- Every literal original normal basis vector has its exact evaluation,
including the sign contributed by the original parameter power. -/
theorem weighted_root_polynomial_function_basis (ψ : F →+* k) (r : ℕ)
    (j : ℕ) (alpha : Fin r → Fin (Fintype.card F)) (a : Fin r → F) :
    weightedRootPolynomialFunctionEvaluation F k ψ r
      (weightedRootPolynomialBasis k (Fintype.card F) Fintype.one_lt_card r (j, alpha)) a =
      (-1 : k) ^ j * ∏ i, ψ (a i) ^ (alpha i).val := by
  rw [weighted_root_polynomial_basis_apply, Algebra.smul_def, map_mul]
  rw [weighted_root_product_basis_apply]
  simp only [map_prod, map_pow, Finset.prod_apply, Pi.pow_apply,
    Pi.mul_apply, weighted_root_polynomial_function_parameter,
    weighted_root_polynomial_function_coefficient, Polynomial.eval_pow,
    Polynomial.eval_X]

/-- The actual function evaluation is injective on each genuine
homogeneous component, derived from parameter specialization and the
actual quotient/function equivalence. -/
theorem weighted_root_homogeneous_function_zero (ψ : F →+* k) (r d : ℕ)
    (x : weightedRootProduct (Polynomial k) (Fintype.card F) Polynomial.X r)
    (homogeneous : x ∈ weightedRootHomogeneousComponent k (Fintype.card F)
      Fintype.one_lt_card r d)
    (vanish : weightedRootPolynomialFunctionEvaluation F k ψ r x = 0) : x = 0 := by
  apply weighted_root_homogeneous_specialization_zero k (Fintype.card F)
    Fintype.one_lt_card r d (-1) (neg_ne_zero.mpr one_ne_zero) x homogeneous
  apply (weighted_root_evaluation_at_tau_bijective F k ψ
    ((Polynomial.evalRingHom (-1 : k)) Polynomial.X) 1 (by simp) one_ne_zero r).injective
  simpa only [weightedRootPolynomialFunctionEvaluation, RingHom.comp_apply, map_zero] using vanish

end Litt3.Deformations
