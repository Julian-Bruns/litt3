import Solutions.Deformations.PrimeWeightedPolynomialPolynomials
import Solutions.Deformations.WeightedRootPolynomialHomogeneous

namespace Litt3.Deformations

open scoped WeightedRootPolynomialScalars

variable (p : ℕ) [Fact p.Prime]
variable (k : Type*) [Field k]

/-- Exact division character for every original homogeneous principal
degree, before truncation or interpolation. -/
theorem elementary_prime_homogeneous_ratio_character (ψ : ZMod p →+* k)
    (r d a : ℕ) (large : a ≤ d) (q : MvPolynomial (Fin r) k)
    (principal : q.IsHomogeneous a)
    (Z : weightedRootProduct (Polynomial k) p Polynomial.X r)
    (homogeneous : Z ∈ weightedRootHomogeneousComponent k p (Fact.out : p.Prime).one_lt r d)
    (u : (ZMod p)ˣ) (b : Fin r → ZMod p) :
    primeWeightedPolynomialFunction p k ψ r Z ((u : ZMod p) • b) /
      q.eval (fun i => ψ (((u : ZMod p) • b) i)) =
      ψ u ^ (d - a) * (primeWeightedPolynomialFunction p k ψ r Z b /
        q.eval (fun i => ψ (b i))) := by
  have target := prime_weighted_homogeneous_function_character p k ψ r d Z homogeneous u b
  have homogeneousQ := weighted_root_polynomial_homogeneous k p (Fact.out : p.Prime).one_lt
    r a q principal
  have denominator := prime_weighted_homogeneous_function_character p k ψ r a
    (weightedRootPolynomialEvaluation p Polynomial.X r (MvPolynomial.map Polynomial.C q))
    homogeneousQ u b
  rw [prime_weighted_polynomial_function_polynomial,
    prime_weighted_polynomial_function_polynomial] at denominator
  rw [target, denominator]
  have nonzero : ψ (u : ZMod p) ≠ 0 := (map_ne_zero ψ).mpr u.ne_zero
  have power : ψ (u : ZMod p) ^ d = ψ u ^ a * ψ u ^ (d - a) := by
    rw [← pow_add, Nat.add_sub_of_le large]
  rw [power, mul_assoc, mul_div_mul_left _ _ (pow_ne_zero a nonzero), mul_div_assoc]

end Litt3.Deformations
