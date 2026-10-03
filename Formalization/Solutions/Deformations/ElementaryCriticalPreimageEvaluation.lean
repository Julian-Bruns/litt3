import Solutions.Deformations.ElementaryCriticalHomogeneousDivision

namespace Litt3.Deformations

open scoped WeightedRootPolynomialScalars

variable (k : Type*) [Field k] [Fact (Nat.Prime 5)]

/-- Every actual critical homogeneous preimage evaluates to the
literal quotient on all original directions, including the origin. -/
theorem elementary_critical_preimage_evaluation (ψ : ZMod 5 →+* k) (r : ℕ)
    (positive : 0 < r) (q : MvPolynomial (Fin r) k) (quadratic : q.IsHomogeneous 2)
    (anisotropic : ∀ a : Fin r → ZMod 5, a ≠ 0 → q.eval (fun i => ψ (a i)) ≠ 0)
    (x Z : weightedRootProduct (Polynomial k) 5 Polynomial.X r)
    (homogeneous : x ∈ weightedRootHomogeneousComponent k 5 (by omega) r (4 * r - 1))
    (preimage : weightedRootPolynomialEvaluation 5 Polynomial.X r (MvPolynomial.map Polynomial.C q) * x = Z)
    (a : Fin r → ZMod 5) :
    weightedRootPolynomialFunctionEvaluation (ZMod 5) k ψ r x a =
      weightedRootPolynomialFunctionEvaluation (ZMod 5) k ψ r Z a / q.eval (fun i => ψ (a i)) := by
  by_cases atOrigin : a = 0
  · subst a
    have origin : weightedRootPolynomialFunctionEvaluation (ZMod 5) k ψ r x 0 = 0 := by
      have compare : weightedRootPolynomialFunctionEvaluation (ZMod 5) k ψ r x 0 =
          (weightedRootOrigin 5 (by omega) (Polynomial.X : Polynomial k) r x).eval (-1) := by
        simpa only [ZMod.card] using weighted_root_polynomial_function_origin (ZMod 5) k ψ r x
      rw [compare, weighted_root_homogeneous_origin_zero k 5 (by omega) r (4 * r - 1)
        (by omega) x homogeneous]
      simp
    have qOrigin : q.eval (fun i => ψ ((0 : Fin r → ZMod 5) i)) = 0 := by
      simp only [Pi.zero_apply, map_zero]
      exact homogeneous_positive_polynomial_origin (RingHom.id k) q 2 quadratic (by omega)
    rw [origin, qOrigin, div_zero]
  · apply (eq_div_iff (anisotropic a atOrigin)).mpr
    have evaluated := congrArg
      (fun z : weightedRootProduct (Polynomial k) 5 Polynomial.X r =>
        weightedRootPolynomialFunctionEvaluation (ZMod 5) k ψ r z a) preimage
    dsimp only at evaluated
    rw [map_mul, Pi.mul_apply] at evaluated
    have qEvaluation : weightedRootPolynomialFunctionEvaluation (ZMod 5) k ψ r
        (weightedRootPolynomialEvaluation 5 Polynomial.X r (MvPolynomial.map Polynomial.C q)) a =
        q.eval (fun i => ψ (a i)) := by
      simpa only [ZMod.card] using weighted_root_polynomial_function_polynomial (ZMod 5) k ψ r q a
    rw [qEvaluation, mul_comm] at evaluated
    exact evaluated

end Litt3.Deformations
