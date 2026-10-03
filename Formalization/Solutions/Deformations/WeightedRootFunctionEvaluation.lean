import Solutions.Deformations.WeightedRootProductLift
import Solutions.Deformations.ScaledFiniteFieldCoordinates

namespace Litt3.Deformations

open scoped BigOperators

variable (F K : Type*) [Field F] [Fintype F] [DecidableEq F] [Field K]

theorem finite_field_scaled_root_relation (φ : F →+* K) (c : K) (a : F) :
    (c * φ a) ^ Fintype.card F = -(-c ^ (Fintype.card F - 1)) * (c * φ a) := by
  rw [mul_pow, ← map_pow, FiniteField.pow_card a, neg_neg]
  have exponent : Fintype.card F = (Fintype.card F - 1) + 1 :=
    (Nat.sub_add_cancel Fintype.card_pos).symm
  have power : c ^ Fintype.card F = c ^ (Fintype.card F - 1) * c := by
    calc
      _ = c ^ ((Fintype.card F - 1) + 1) := congrArg (fun n => c ^ n) exponent
      _ = _ := pow_succ c _
  rw [power]
  ring

/-- Genuine evaluation of the literal graded quotient factors on all
original finite-field directions, with a chosen scaling root c. -/
noncomputable def weightedRootFunctionEvaluation (φ : F →+* K) (c : K) (r : ℕ) :
    weightedRootProduct K (Fintype.card F) (-c ^ (Fintype.card F - 1)) r →ₐ[K]
      ((Fin r → F) → K) where
  toFun x a := weightedRootProductLift (Fintype.card F) (-c ^ (Fintype.card F - 1)) r
    (fun i => c * φ (a i))
    (fun i => by simpa only [Algebra.algebraMap_self] using finite_field_scaled_root_relation F K φ c (a i)) x
  map_zero' := by ext a; exact map_zero _
  map_one' := by ext a; exact map_one _
  map_add' x y := by ext a; exact map_add _ x y
  map_mul' x y := by ext a; exact map_mul _ x y
  commutes' b := by ext a; exact AlgHom.commutes _ b

@[simp] theorem weighted_root_function_evaluation_parameter (φ : F →+* K) (c : K)
    (r : ℕ) (i : Fin r) (a : Fin r → F) :
    weightedRootFunctionEvaluation F K φ c r
      (weightedRootProductParameter K (Fintype.card F) (-c ^ (Fintype.card F - 1)) r i) a =
        c * φ (a i) := by
  exact weighted_root_product_lift_parameter _ _ _ _ _ _

theorem weighted_root_function_evaluation_basis (φ : F →+* K) (c : K) (r : ℕ)
    (alpha : Fin r → Fin (Fintype.card F)) (a : Fin r → F) :
    weightedRootFunctionEvaluation F K φ c r
      (weightedRootProductBasis (Fintype.card F) Fintype.one_lt_card
        (-c ^ (Fintype.card F - 1)) r alpha) a =
      ∏ i, (c * φ (a i)) ^ (alpha i).val := by
  rw [weighted_root_product_basis_apply, map_prod]
  simp only [map_pow, Finset.prod_apply, Pi.pow_apply, weighted_root_function_evaluation_parameter]

end Litt3.Deformations
