import Solutions.Deformations.PrimeWeightedRootEvaluation
import Solutions.Deformations.WeightedRootHomogeneousCharacter

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (p : ℕ) [Fact p.Prime]
variable (k : Type*) [Field k]

/-- Literal tau=-1 specialization and evaluation on unchanged F_p tuples. -/
noncomputable def primeWeightedPolynomialFunction (ψ : ZMod p →+* k) (r : ℕ) :
    weightedRootProduct (Polynomial k) p Polynomial.X r →+* ((Fin r → ZMod p) → k) :=
  (primeWeightedRootEvaluationAtTau p k ψ
    ((Polynomial.evalRingHom (-1 : k)) Polynomial.X) (by simp) r).toRingHom.comp
    (weightedRootProductBaseMap (Polynomial.evalRingHom (-1 : k)) p Polynomial.X r)

@[simp] theorem prime_weighted_polynomial_function_parameter (ψ : ZMod p →+* k)
    (r : ℕ) (i : Fin r) (a : Fin r → ZMod p) :
    primeWeightedPolynomialFunction p k ψ r
      (weightedRootProductParameter (Polynomial k) p Polynomial.X r i) a = ψ (a i) := by
  unfold primeWeightedPolynomialFunction
  rw [RingHom.comp_apply, weighted_root_base_map_parameter]
  exact prime_weighted_root_at_tau_parameter p k ψ _ _ r i a

@[simp] theorem prime_weighted_polynomial_function_coefficient (ψ : ZMod p →+* k)
    (r : ℕ) (f : Polynomial k) (a : Fin r → ZMod p) :
    primeWeightedPolynomialFunction p k ψ r
      (algebraMap (Polynomial k) (weightedRootProduct (Polynomial k) p Polynomial.X r) f) a =
      f.eval (-1) := by
  unfold primeWeightedPolynomialFunction
  rw [RingHom.comp_apply, weighted_root_base_map_coefficient]
  change primeWeightedRootEvaluationAtTau p k ψ _ _ r (algebraMap k _ (f.eval (-1))) a = _
  rw [AlgHom.commutes]
  rfl

noncomputable def primeWeightedPolynomialFunctionLinear (ψ : ZMod p →+* k) (r : ℕ) :
    weightedRootProduct (Polynomial k) p Polynomial.X r →ₗ[k] ((Fin r → ZMod p) → k) where
  __ := (primeWeightedPolynomialFunction p k ψ r).toAddMonoidHom
  map_smul' c x := by
    change primeWeightedPolynomialFunction p k ψ r
      (algebraMap (Polynomial k) _ (Polynomial.C c) * x) =
      c • primeWeightedPolynomialFunction p k ψ r x
    rw [map_mul]
    funext a
    simp [prime_weighted_polynomial_function_coefficient]

theorem prime_weighted_polynomial_function_basis (ψ : ZMod p →+* k) (r j : ℕ)
    (alpha : Fin r → Fin p) (a : Fin r → ZMod p) :
    primeWeightedPolynomialFunction p k ψ r
      (weightedRootPolynomialBasis k p (Fact.out : p.Prime).one_lt r (j, alpha)) a =
        (-1 : k) ^ j * ∏ i, ψ (a i) ^ (alpha i).val := by
  rw [weighted_root_polynomial_basis_apply, Algebra.smul_def, map_mul,
    weighted_root_product_basis_apply]
  simp only [map_prod, map_pow, Finset.prod_apply, Pi.pow_apply,
    Pi.mul_apply, prime_weighted_polynomial_function_parameter,
    prime_weighted_polynomial_function_coefficient, Polynomial.eval_pow, Polynomial.eval_X]

theorem prime_weighted_homogeneous_function_zero (ψ : ZMod p →+* k) (r d : ℕ)
    (x : weightedRootProduct (Polynomial k) p Polynomial.X r)
    (homogeneous : x ∈ weightedRootHomogeneousComponent k p (Fact.out : p.Prime).one_lt r d)
    (vanish : primeWeightedPolynomialFunction p k ψ r x = 0) : x = 0 := by
  apply weighted_root_homogeneous_specialization_zero k p (Fact.out : p.Prime).one_lt
    r d (-1) (neg_ne_zero.mpr one_ne_zero) x homogeneous
  apply (prime_weighted_root_at_tau_bijective p k ψ _ _ r).injective
  simpa only [primeWeightedPolynomialFunction, RingHom.comp_apply, map_zero] using vanish

theorem prime_weighted_homogeneous_function_character (ψ : ZMod p →+* k) (r d : ℕ)
    (x : weightedRootProduct (Polynomial k) p Polynomial.X r)
    (homogeneous : x ∈ weightedRootHomogeneousComponent k p (Fact.out : p.Prime).one_lt r d)
    (u : (ZMod p)ˣ) (a : Fin r → ZMod p) :
    primeWeightedPolynomialFunction p k ψ r x ((u : ZMod p) • a) =
      ψ u ^ d * primeWeightedPolynomialFunction p k ψ r x a := by
  classical
  have order : ψ (u : ZMod p) ^ (p - 1) = 1 := by
    simpa only [map_pow, map_one] using congrArg ψ (ZMod.pow_card_sub_one_eq_one u.ne_zero)
  refine Submodule.span_induction (p := fun x _ =>
    primeWeightedPolynomialFunction p k ψ r x ((u : ZMod p) • a) =
      ψ u ^ d * primeWeightedPolynomialFunction p k ψ r x a)
    ?_ ?_ ?_ ?_ homogeneous
  · rintro _ ⟨⟨j, alpha⟩, degree, rfl⟩
    rw [prime_weighted_polynomial_function_basis, prime_weighted_polynomial_function_basis,
      finite_field_normal_monomial_scale]
    have power : ψ (u : ZMod p) ^ (∑ i, (alpha i).val) = ψ u ^ d := by
      dsimp [rootPolynomialWeight] at degree
      rw [← degree, pow_add, pow_mul, order, one_pow, one_mul]
    rw [power]
    ring
  · simp
  · intro x y _ _ hx hy
    simp only [map_add, Pi.add_apply, mul_add, hx, hy]
  · intro c x _ hx
    have scaled := congrArg (fun f : (Fin r → ZMod p) → k => f ((u : ZMod p) • a))
      ((primeWeightedPolynomialFunctionLinear p k ψ r).map_smul c x)
    have original := congrArg (fun f : (Fin r → ZMod p) → k => f a)
      ((primeWeightedPolynomialFunctionLinear p k ψ r).map_smul c x)
    change primeWeightedPolynomialFunction p k ψ r (c • x) ((u : ZMod p) • a) =
      c * primeWeightedPolynomialFunction p k ψ r x ((u : ZMod p) • a) at scaled
    change primeWeightedPolynomialFunction p k ψ r (c • x) a =
      c * primeWeightedPolynomialFunction p k ψ r x a at original
    rw [scaled, original, hx]
    ring

end Litt3.Deformations
