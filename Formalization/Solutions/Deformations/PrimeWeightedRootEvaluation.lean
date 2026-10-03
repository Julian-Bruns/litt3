import Solutions.Deformations.WeightedRootProductLift
import Solutions.Deformations.PrimeNormalFunctionCoordinates

namespace Litt3.Deformations

open scoped BigOperators

variable (p : ℕ) [Fact p.Prime]
variable (k : Type*) [Field k]

/-- Actual evaluation of the literal prime-degree quotient at tau=-1.
The original relations are checked directly on original F_p coordinates. -/
noncomputable def primeWeightedRootEvaluation (ψ : ZMod p →+* k) (r : ℕ) :
    weightedRootProduct k p (-1 : k) r →ₐ[k] ((Fin r → ZMod p) → k) where
  toFun x a := weightedRootProductLift p (-1 : k) r (fun i => ψ (a i))
    (fun i => by
      simpa only [← map_pow, Algebra.algebraMap_self, RingHom.id_apply, neg_neg, one_mul] using
        congrArg ψ (ZMod.pow_card (a i))) x
  map_zero' := by ext a; exact map_zero _
  map_one' := by ext a; exact map_one _
  map_add' x y := by ext a; exact map_add _ x y
  map_mul' x y := by ext a; exact map_mul _ x y
  commutes' b := by ext a; exact AlgHom.commutes _ b

@[simp] theorem prime_weighted_root_evaluation_parameter (ψ : ZMod p →+* k)
    (r : ℕ) (i : Fin r) (a : Fin r → ZMod p) :
    primeWeightedRootEvaluation p k ψ r (weightedRootProductParameter k p (-1) r i) a =
      ψ (a i) := by
  exact weighted_root_product_lift_parameter _ _ _ _ _ _

theorem prime_weighted_root_evaluation_basis (ψ : ZMod p →+* k) (r : ℕ)
    (alpha : Fin r → Fin p) (a : Fin r → ZMod p) :
    primeWeightedRootEvaluation p k ψ r
      (weightedRootProductBasis p (Fact.out : p.Prime).one_lt (-1 : k) r alpha) a =
        ∏ i, ψ (a i) ^ (alpha i).val := by
  rw [weighted_root_product_basis_apply, map_prod]
  simp only [map_pow, Finset.prod_apply, Pi.pow_apply,
    prime_weighted_root_evaluation_parameter]

/-- The actual quotient-to-function map is exactly the constructed
unchanged normal-basis interpolation, so is a genuine full equivalence. -/
theorem prime_weighted_root_evaluation_coordinates (ψ : ZMod p →+* k) (r : ℕ)
    (x : weightedRootProduct k p (-1 : k) r) :
    primeWeightedRootEvaluation p k ψ r x =
      primeNormalFunctionCoordinates p k ψ
        ((weightedRootProductBasis p (Fact.out : p.Prime).one_lt (-1 : k) r).equivFun x) := by
  classical
  let B := weightedRootProductBasis p (Fact.out : p.Prime).one_lt (-1 : k) r
  have original := B.sum_repr x
  conv_lhs => rw [← original]
  rw [map_sum]
  funext a
  rw [prime_normal_function_coordinates_apply]
  simp only [B, Finset.sum_apply, map_smul, Pi.smul_apply, smul_eq_mul,
    prime_weighted_root_evaluation_basis]
  rfl

theorem prime_weighted_root_evaluation_bijective (ψ : ZMod p →+* k) (r : ℕ) :
    Function.Bijective (primeWeightedRootEvaluation p k ψ r) := by
  have equality : (primeWeightedRootEvaluation p k ψ r :
      weightedRootProduct k p (-1 : k) r → ((Fin r → ZMod p) → k)) =
      fun x => primeNormalFunctionCoordinates p k ψ
        ((weightedRootProductBasis p (Fact.out : p.Prime).one_lt (-1 : k) r).equivFun x) :=
    funext (prime_weighted_root_evaluation_coordinates p k ψ r)
  rw [equality]
  exact (primeNormalFunctionCoordinates p k ψ).bijective.comp
    (weightedRootProductBasis p (Fact.out : p.Prime).one_lt (-1 : k) r).equivFun.bijective

/-- The same actual evaluation at any literally equal parameter. This
keeps specialization codomains exact rather than identifying ring types. -/
noncomputable def primeWeightedRootEvaluationAtTau (ψ : ZMod p →+* k)
    (tau : k) (negative : tau = -1) (r : ℕ) :
    weightedRootProduct k p tau r →ₐ[k] ((Fin r → ZMod p) → k) := by
  subst tau
  exact primeWeightedRootEvaluation p k ψ r

@[simp] theorem prime_weighted_root_at_tau_parameter (ψ : ZMod p →+* k)
    (tau : k) (negative : tau = -1) (r : ℕ) (i : Fin r) (a : Fin r → ZMod p) :
    primeWeightedRootEvaluationAtTau p k ψ tau negative r
      (weightedRootProductParameter k p tau r i) a = ψ (a i) := by
  subst tau
  exact prime_weighted_root_evaluation_parameter p k ψ r i a

theorem prime_weighted_root_at_tau_bijective (ψ : ZMod p →+* k)
    (tau : k) (negative : tau = -1) (r : ℕ) :
    Function.Bijective (primeWeightedRootEvaluationAtTau p k ψ tau negative r) := by
  subst tau
  exact prime_weighted_root_evaluation_bijective p k ψ r

end Litt3.Deformations
