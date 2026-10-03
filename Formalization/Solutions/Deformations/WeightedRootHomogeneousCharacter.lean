import Solutions.Deformations.WeightedRootPolynomialFunctionEvaluation

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (F k : Type*) [Field F] [Fintype F] [DecidableEq F] [Field k]

theorem finite_field_normal_monomial_scale (ψ : F →+* k) (r : ℕ)
    (u : Fˣ) (a : Fin r → F) (alpha : Fin r → ℕ) :
    (∏ i, ψ (((u : F) • a) i) ^ alpha i) =
      ψ u ^ (∑ i, alpha i) * ∏ i, ψ (a i) ^ alpha i := by
  change (∏ i, ψ ((u : F) * a i) ^ alpha i) = _
  simp only [map_mul, mul_pow, Finset.prod_mul_distrib, ← Finset.prod_pow_eq_pow_sum]

/-- Scalar characters of the actual homogeneous quotient are proved
from its genuine basis and literal finite-field evaluation. -/
theorem weighted_root_homogeneous_function_character (ψ : F →+* k) (r d : ℕ)
    (x : weightedRootProduct (Polynomial k) (Fintype.card F) Polynomial.X r)
    (homogeneous : x ∈ weightedRootHomogeneousComponent k (Fintype.card F)
      Fintype.one_lt_card r d) (u : Fˣ) (a : Fin r → F) :
    weightedRootPolynomialFunctionEvaluation F k ψ r x ((u : F) • a) =
      ψ u ^ d * weightedRootPolynomialFunctionEvaluation F k ψ r x a := by
  classical
  have order : ψ (u : F) ^ (Fintype.card F - 1) = 1 := by
    simpa only [map_pow, map_one] using congrArg ψ
      (FiniteField.pow_card_sub_one_eq_one (u : F) u.ne_zero)
  refine Submodule.span_induction (p := fun x _ =>
    weightedRootPolynomialFunctionEvaluation F k ψ r x ((u : F) • a) =
      ψ u ^ d * weightedRootPolynomialFunctionEvaluation F k ψ r x a)
    ?_ ?_ ?_ ?_ homogeneous
  · rintro _ ⟨⟨j, alpha⟩, degree, rfl⟩
    rw [weighted_root_polynomial_function_basis, weighted_root_polynomial_function_basis,
      finite_field_normal_monomial_scale]
    have power : ψ (u : F) ^ (∑ i, (alpha i).val) = ψ u ^ d := by
      dsimp [rootPolynomialWeight] at degree
      rw [← degree, pow_add, pow_mul, order, one_pow, one_mul]
    rw [power]
    ring
  · simp
  · intro x y _ _ hx hy
    simp only [map_add, Pi.add_apply, mul_add, hx, hy]
  · intro c x _ hx
    have atScaled := congrArg (fun f : (Fin r → F) → k => f ((u : F) • a))
      ((weightedRootPolynomialFunctionLinear F k ψ r).map_smul c x)
    have atOriginal := congrArg (fun f : (Fin r → F) → k => f a)
      ((weightedRootPolynomialFunctionLinear F k ψ r).map_smul c x)
    change weightedRootPolynomialFunctionEvaluation F k ψ r (c • x) ((u : F) • a) =
      c * weightedRootPolynomialFunctionEvaluation F k ψ r x ((u : F) • a) at atScaled
    change weightedRootPolynomialFunctionEvaluation F k ψ r (c • x) a =
      c * weightedRootPolynomialFunctionEvaluation F k ψ r x a at atOriginal
    rw [atScaled, atOriginal, hx]
    ring

end Litt3.Deformations
