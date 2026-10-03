import Definitions.QuotientGeometry.WeakTamePolynomial
import Mathlib.Algebra.CharP.Algebra
import Mathlib.Tactic

namespace Litt3.QuotientGeometry

theorem linearized_constant_polynomial_affine_transform
    {k : Type*} [Field k] (p : ℕ) [Fact p.Prime] [CharP k p]
    (α γ ζ b : k) (hζ : ζ ^ p = ζ) (hb : α * b ^ p + γ * b = 0) :
    (linearizedConstantPolynomial p α γ).comp (Polynomial.C ζ * Polynomial.X + Polynomial.C b) =
      Polynomial.C ζ * linearizedConstantPolynomial p α γ := by
  haveI : CharP (Polynomial k) p := charP_of_injective_ringHom Polynomial.C_injective p
  simp only [linearizedConstantPolynomial, Polynomial.add_comp, Polynomial.mul_comp,
    Polynomial.C_comp, Polynomial.pow_comp, Polynomial.X_comp]
  rw [add_pow_char, mul_pow, ← Polynomial.C_pow, hζ]
  have hconstant : (Polynomial.C α : Polynomial k) * Polynomial.C b ^ p +
      Polynomial.C γ * Polynomial.C b = 0 := by
    rw [← map_pow, ← map_mul, ← map_mul, ← map_add, hb, map_zero]
  calc
    _ = Polynomial.C ζ * (Polynomial.C α * Polynomial.X ^ p + Polynomial.C γ * Polynomial.X) +
      (Polynomial.C α * Polynomial.C b ^ p + Polynomial.C γ * Polynomial.C b) := by ring
    _ = _ := by rw [hconstant, add_zero]

theorem weak_tame_polynomial_affine_symmetry
    {k : Type*} [Field k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (α γ ζ b : k) (hζp : ζ ^ p = ζ) (hζh : ζ ^ h = 1)
    (hb : α * b ^ p + γ * b = 0) :
    (weakTamePolynomial p h α γ).comp (Polynomial.C ζ * Polynomial.X + Polynomial.C b) =
      weakTamePolynomial p h α γ := by
  rw [weakTamePolynomial, Polynomial.pow_comp,
    linearized_constant_polynomial_affine_transform p α γ ζ b hζp hb,
    mul_pow, ← Polynomial.C_pow, hζh, Polynomial.C_1, one_mul]

end Litt3.QuotientGeometry
