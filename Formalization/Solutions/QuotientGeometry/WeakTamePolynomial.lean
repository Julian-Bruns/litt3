import Definitions.QuotientGeometry.WeakTamePolynomial
import Solutions.QuotientGeometry.ConstantPoleIrreducibility
import Solutions.QuotientGeometry.ConstantPolynomialParameter

namespace Litt3.QuotientGeometry

theorem linearized_constant_polynomial_degree
    {k : Type*} [Field k] (p : ℕ) (hp : 1 < p) (α γ : k) (hα : α ≠ 0) :
    (linearizedConstantPolynomial p α γ).natDegree = p := by
  apply Polynomial.natDegree_eq_of_degree_eq_some
  have hlower : (Polynomial.C γ * Polynomial.X : Polynomial k).degree <
      (Polynomial.C α * Polynomial.X ^ p : Polynomial k).degree := by
    rw [Polynomial.degree_C_mul_X_pow p hα]
    exact lt_of_le_of_lt (Polynomial.degree_C_mul_X_le γ) (by exact_mod_cast hp)
  rw [linearizedConstantPolynomial, Polynomial.degree_add_eq_left_of_degree_lt hlower,
    Polynomial.degree_C_mul_X_pow p hα]

theorem weak_tame_polynomial_degree
    {k : Type*} [Field k] (p h : ℕ) (hp : 1 < p) (α γ : k) (hα : α ≠ 0) :
    (weakTamePolynomial p h α γ).natDegree = p * h := by
  rw [weakTamePolynomial, Polynomial.natDegree_pow, linearized_constant_polynomial_degree p hp α γ hα]
  exact Nat.mul_comm h p

theorem weak_tame_polynomial_constant_zero
    {k : Type*} [Field k] (p h : ℕ) (hp : 1 < p) (hh : 0 < h) (α γ : k) :
    (weakTamePolynomial p h α γ).coeff 0 = 0 := by
  rw [weakTamePolynomial, Polynomial.coeff_zero_eq_eval_zero]
  simp [linearizedConstantPolynomial, show p ≠ 0 by omega, hh.ne']

theorem weak_tame_polynomial_pole_irreducible
    {k : Type*} [Field k] (p h : ℕ) (hp : 1 < p) (hh : 0 < h)
    (α γ : k) (hα : α ≠ 0) : Irreducible (constantPolePolynomial (weakTamePolynomial p h α γ)) :=
  constant_pole_polynomial_irreducible _
    (by rw [weak_tame_polynomial_degree p h hp α γ hα]; exact Nat.mul_pos (by omega) hh)
    (weak_tame_polynomial_constant_zero p h hp hh α γ)

theorem weak_tame_parameter_pole_image
    {k : Type*} [Field k] (p h : ℕ) (hp : 1 < p) (hh : 0 < h) (α γ : k) (hα : α ≠ 0) :
    let g := weakTamePolynomial p h α γ
    let hg : 0 < g.natDegree := by
      rw [weak_tame_polynomial_degree p h hp α γ hα]
      exact Nat.mul_pos (by omega) hh
    parameterLaurentMap (constantPolynomialParameter g) (constant_polynomial_parameter_zero g hg)
      (constant_polynomial_parameter_injective g hg) (HahnSeries.single (-1) 1) =
      (HahnSeries.C α * (HahnSeries.single (-1) 1) ^ p +
        HahnSeries.C γ * HahnSeries.single (-1) 1) ^ h := by
  dsimp only
  rw [constant_polynomial_parameter_pole_image _
    (by rw [weak_tame_polynomial_degree p h hp α γ hα]; exact Nat.mul_pos (by omega) hh)]
  simp only [weakTamePolynomial, linearizedConstantPolynomial, Polynomial.eval₂_pow,
    Polynomial.eval₂_add, Polynomial.eval₂_mul, Polynomial.eval₂_C, Polynomial.eval₂_X]

end Litt3.QuotientGeometry
