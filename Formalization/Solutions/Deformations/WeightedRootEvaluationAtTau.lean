import Solutions.Deformations.WeightedRootNormKernel
import Solutions.Deformations.WeightedRootNormCoordinates

namespace Litt3.Deformations

variable (F K : Type*) [Field F] [Fintype F] [DecidableEq F] [Field K]

/-- Actual evaluation for an arbitrary parameter whose negative has
a chosen nonzero scaling root. The parameter is retained literally. -/
noncomputable def weightedRootEvaluationAtTau (φ : F →+* K) (tau c : K)
    (root : c ^ (Fintype.card F - 1) = -tau) (r : ℕ) :
    weightedRootProduct K (Fintype.card F) tau r →ₐ[K] ((Fin r → F) → K) where
  toFun x a := weightedRootProductLift (Fintype.card F) tau r (fun i => c * φ (a i))
    (fun i => by
      have relation := finite_field_scaled_root_relation F K φ c (a i)
      rw [neg_neg, root] at relation
      simpa only [Algebra.algebraMap_self] using relation) x
  map_zero' := by ext a; exact map_zero _
  map_one' := by ext a; exact map_one _
  map_add' x y := by ext a; exact map_add _ x y
  map_mul' x y := by ext a; exact map_mul _ x y
  commutes' b := by ext a; exact AlgHom.commutes _ b

@[simp] theorem weighted_root_evaluation_at_tau_parameter (φ : F →+* K) (tau c : K)
    (root : c ^ (Fintype.card F - 1) = -tau) (r : ℕ) (i : Fin r) (a : Fin r → F) :
    weightedRootEvaluationAtTau F K φ tau c root r
      (weightedRootProductParameter K (Fintype.card F) tau r i) a = c * φ (a i) := by
  exact weighted_root_product_lift_parameter _ _ _ _ _ _

theorem weighted_root_evaluation_at_tau_bijective (φ : F →+* K) (tau c : K)
    (root : c ^ (Fintype.card F - 1) = -tau) (nonzero : c ≠ 0) (r : ℕ) :
    Function.Bijective (weightedRootEvaluationAtTau F K φ tau c root r) := by
  have parameter : tau = -c ^ (Fintype.card F - 1) := by
    calc tau = -(-tau) := (neg_neg tau).symm
         _ = -c ^ (Fintype.card F - 1) := congrArg Neg.neg root.symm
  subst tau
  exact weighted_root_function_evaluation_bijective F K φ c nonzero r

/-- The full multiplication kernel of the actual quotient at its
literal parameter, rather than a presumed function-algebra model. -/
theorem weighted_root_direction_kernel_at_tau (φ : F →+* K) (tau c : K)
    (root : c ^ (Fintype.card F - 1) = -tau) (nonzero : c ≠ 0) (r : ℕ)
    (q x : weightedRootProduct K (Fintype.card F) tau r)
    (origin : weightedRootEvaluationAtTau F K φ tau c root r q 0 = 0)
    (directions : ∀ a : Fin r → F, a ≠ 0 →
      weightedRootEvaluationAtTau F K φ tau c root r q a ≠ 0) :
    q * x = 0 ↔ ∃ b : K, x = b • weightedRootProductNorm (Fintype.card F) tau r := by
  have parameter : tau = -c ^ (Fintype.card F - 1) := by
    calc tau = -(-tau) := (neg_neg tau).symm
         _ = -c ^ (Fintype.card F - 1) := congrArg Neg.neg root.symm
  subst tau
  exact weighted_root_direction_kernel F K φ c nonzero r q x origin directions

end Litt3.Deformations
