import Solutions.Deformations.ElementaryCriticalQuotientCharacter

namespace Litt3.Deformations

open scoped WeightedRootPolynomialScalars

variable (k : Type*) [Field k] [Fact (Nat.Prime 5)]

/-- Exact division character in arbitrary weight, before any original
tuple interpolation or finite-precision lifting. -/
theorem elementary_homogeneous_ratio_character (ψ : ZMod 5 →+* k) (r d : ℕ)
    (large : 2 ≤ d) (q : MvPolynomial (Fin r) k) (quadratic : q.IsHomogeneous 2)
    (Z : weightedRootProduct (Polynomial k) 5 Polynomial.X r)
    (homogeneous : Z ∈ weightedRootHomogeneousComponent k 5 (by omega) r d)
    (u : (ZMod 5)ˣ) (a : Fin r → ZMod 5) :
    weightedRootPolynomialFunctionEvaluation (ZMod 5) k ψ r Z ((u : ZMod 5) • a) /
      q.eval (fun i => ψ (((u : ZMod 5) • a) i)) =
      ψ u ^ (d - 2) * (weightedRootPolynomialFunctionEvaluation (ZMod 5) k ψ r Z a /
        q.eval (fun i => ψ (a i))) := by
  have target := weighted_root_homogeneous_function_character (ZMod 5) k ψ r d
    Z homogeneous u a
  have homogeneousQ := weighted_root_polynomial_homogeneous k 5 (by omega) r 2 q quadratic
  have denominator := weighted_root_homogeneous_function_character (ZMod 5) k ψ r 2
    (weightedRootPolynomialEvaluation 5 Polynomial.X r (MvPolynomial.map Polynomial.C q))
    homogeneousQ u a
  have evaluation (a : Fin r → ZMod 5) :
      weightedRootPolynomialFunctionEvaluation (ZMod 5) k ψ r
        (weightedRootPolynomialEvaluation 5 Polynomial.X r (MvPolynomial.map Polynomial.C q)) a =
        q.eval (fun i => ψ (a i)) := by
    simpa only [ZMod.card] using weighted_root_polynomial_function_polynomial (ZMod 5) k ψ r q a
  rw [evaluation, evaluation] at denominator
  rw [target, denominator]
  have nonzero : ψ (u : ZMod 5) ≠ 0 := (map_ne_zero ψ).mpr u.ne_zero
  have power : ψ (u : ZMod 5) ^ d = ψ u ^ 2 * ψ u ^ (d - 2) := by
    rw [← pow_add, Nat.add_sub_of_le large]
  rw [power, mul_assoc]
  rw [mul_div_mul_left _ _ (pow_ne_zero 2 nonzero), mul_div_assoc]

end Litt3.Deformations
