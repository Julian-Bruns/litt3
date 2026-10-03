import Solutions.Deformations.WeightedRootHomogeneousCharacter
import Solutions.Deformations.WeightedRootPolynomialFunctionPolynomials
import Solutions.Deformations.WeightedRootPolynomialHomogeneous

namespace Litt3.Deformations

open scoped WeightedRootPolynomialScalars

variable {k : Type*} [Field k] [Fact (Nat.Prime 5)] {r : ℕ}

/-- Division by the quadratic changes the critical character one
into character three, with division at zero interpreted literally. -/
theorem elementary_ratio_character_three (ψ : ZMod 5 →+* k)
    (Z Q : (Fin r → ZMod 5) → k)
    (target : ∀ (u : (ZMod 5)ˣ) a, Z ((u : ZMod 5) • a) = ψ u * Z a)
    (quadratic : ∀ (u : (ZMod 5)ˣ) a, Q ((u : ZMod 5) • a) = ψ u ^ 2 * Q a)
    (u : (ZMod 5)ˣ) (a : Fin r → ZMod 5) :
    Z ((u : ZMod 5) • a) / Q ((u : ZMod 5) • a) = ψ u ^ 3 * (Z a / Q a) := by
  rw [target, quadratic]
  have nonzero : ψ (u : ZMod 5) ≠ 0 := (map_ne_zero ψ).mpr u.ne_zero
  have fourth : ψ (u : ZMod 5) ^ 4 = 1 := by
    simpa only [map_pow, map_one] using congrArg ψ (ZMod.pow_card_sub_one_eq_one u.ne_zero)
  have power : ψ (u : ZMod 5) ^ 2 * ψ u ^ 3 = ψ u := by
    rw [← pow_add, show 2 + 3 = 4 + 1 from rfl, pow_add, fourth, pow_one, one_mul]
  calc
    _ = (ψ u ^ 2 * (ψ u ^ 3 * Z a)) / (ψ u ^ 2 * Q a) := by rw [← mul_assoc, power]
    _ = (ψ u ^ 3 * Z a) / Q a := mul_div_mul_left _ _ (pow_ne_zero 2 nonzero)
    _ = _ := mul_div_assoc _ _ _

/-- The critical original quotient has its character from actual
homogeneous quotient elements; no target-scaling interface is assumed. -/
theorem elementary_actual_critical_ratio_character (k : Type*) [Field k]
    [Fact (Nat.Prime 5)] (ψ : ZMod 5 →+* k) (r : ℕ)
    (q : MvPolynomial (Fin r) k) (quadratic : q.IsHomogeneous 2)
    (Z : weightedRootProduct (Polynomial k) 5 Polynomial.X r)
    (homogeneous : Z ∈ weightedRootHomogeneousComponent k 5 (by omega) r (4 * r + 1))
    (u : (ZMod 5)ˣ) (a : Fin r → ZMod 5) :
    weightedRootPolynomialFunctionEvaluation (ZMod 5) k ψ r Z ((u : ZMod 5) • a) /
      q.eval (fun i => ψ (((u : ZMod 5) • a) i)) =
      ψ u ^ 3 * (weightedRootPolynomialFunctionEvaluation (ZMod 5) k ψ r Z a /
        q.eval (fun i => ψ (a i))) := by
  refine elementary_ratio_character_three ψ
    (weightedRootPolynomialFunctionEvaluation (ZMod 5) k ψ r Z)
    (fun b => q.eval (fun i => ψ (b i))) ?_ ?_ u a
  · intro v b
    have character := weighted_root_homogeneous_function_character (ZMod 5) k ψ r
      (4 * r + 1) Z homogeneous v b
    have fourth : ψ (v : ZMod 5) ^ 4 = 1 := by
      simpa only [map_pow, map_one] using congrArg ψ (ZMod.pow_card_sub_one_eq_one v.ne_zero)
    simpa only [pow_add, pow_mul, fourth, one_pow, pow_one, one_mul] using character
  · intro v b
    have homogeneousQ := weighted_root_polynomial_homogeneous k 5 (by omega) r 2 q quadratic
    have character := weighted_root_homogeneous_function_character (ZMod 5) k ψ r 2
      (weightedRootPolynomialEvaluation 5 Polynomial.X r (MvPolynomial.map Polynomial.C q))
      homogeneousQ v b
    have evaluation (a : Fin r → ZMod 5) :
        weightedRootPolynomialFunctionEvaluation (ZMod 5) k ψ r
          (weightedRootPolynomialEvaluation 5 Polynomial.X r (MvPolynomial.map Polynomial.C q)) a =
          q.eval (fun i => ψ (a i)) := by
      simpa only [ZMod.card] using weighted_root_polynomial_function_polynomial (ZMod 5) k ψ r q a
    rw [evaluation, evaluation] at character
    exact character

end Litt3.Deformations
