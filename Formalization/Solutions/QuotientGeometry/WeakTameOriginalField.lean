import Solutions.QuotientGeometry.WeakTamePolynomial
import Solutions.QuotientGeometry.WeakLaurentLinearization
import Solutions.QuotientGeometry.WeakLaurentCoefficients
import Solutions.QuotientGeometry.ConstantPolynomialMapModel
import Solutions.QuotientGeometry.ConstantPoleFieldTransport
import Solutions.QuotientGeometry.LaurentUnitOrders

namespace Litt3.QuotientGeometry

/-- The original full downstairs embedding is identified with its
genuine degree-ph polynomial field after removing the whole weak
regular tail in an actual h-th root. -/
theorem weak_tame_original_completed_field_model
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ) [CharP k p]
    (hp : 1 < p) (hh : 0 < h)
    (φ : PowerSeries k →ₐ[k] PowerSeries k) (Ψ : LaurentSeries k →+* LaurentSeries k)
    (hΨ : ∀ r : PowerSeries k, Ψ (r : LaurentSeries k) = (φ r : PowerSeries k))
    (ψ : LaurentSeries k) (hroot : ψ ^ h = Ψ (HahnSeries.single (-1) 1))
    (hψorder : ψ.order = -(p : ℤ)) (hψderiv : (LaurentSeries.derivative k ψ).order = -2) :
    ∃ (α γ : k), α ≠ 0 ∧ γ ≠ 0 ∧ α = ψ.coeff (-(p : ℤ)) ∧ γ = ψ.coeff (-1) ∧
      ∃ e : AdjoinRoot (constantPolePolynomial (weakTamePolynomial p h α γ)) ≃+* LaurentSeries k,
        ∀ r : LaurentSeries k,
          e (AdjoinRoot.of (constantPolePolynomial (weakTamePolynomial p h α γ)) r) = Ψ r := by
  obtain ⟨α, γ, w, hα, hγ, hu, hf⟩ :=
    weak_laurent_linearized_normal_form p hp ψ hψorder hψderiv
  have hcoeff := weak_linearized_negative_coefficients p hp α γ w ψ hf
  have hg : 0 < (weakTamePolynomial p h α γ).natDegree := by
    rw [weak_tame_polynomial_degree p h hp α γ hα]
    exact Nat.mul_pos (by omega) hh
  have hnegative : (Ψ (HahnSeries.single (-1) 1)).order < 0 := by
    rw [← hroot, HahnSeries.order_pow, hψorder]
    simp only [nsmul_eq_mul]
    have hh' : (0 : ℤ) < h := by exact_mod_cast hh
    have hp' : (0 : ℤ) < p := by exact_mod_cast (by omega : 0 < p)
    nlinarith
  have hpole : Ψ (HahnSeries.single (-1) 1) =
      (weakTamePolynomial p h α γ).eval₂ HahnSeries.C
        (HahnSeries.single (-1) 1 + (w : LaurentSeries k)) := by
    rw [← hroot, hf]
    simp only [weakTamePolynomial, linearizedConstantPolynomial, Polynomial.eval₂_pow,
      Polynomial.eval₂_add, Polynomial.eval₂_mul, Polynomial.eval₂_C, Polynomial.eval₂_X]
  obtain ⟨e, he⟩ := constant_polynomial_completed_map_model (weakTamePolynomial p h α γ) hg
    (weak_tame_polynomial_constant_zero p h hp hh α γ) w φ Ψ hΨ
    (completed_map_parameter_zero_constant φ Ψ hΨ hnegative) hpole
  exact ⟨α, γ, hα, hγ, hcoeff.1.symm, hcoeff.2.symm, e, he⟩

theorem weak_tame_original_completed_field_degree
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ) [CharP k p]
    (hp : 1 < p) (hh : 0 < h)
    (φ : PowerSeries k →ₐ[k] PowerSeries k) (Ψ : LaurentSeries k →+* LaurentSeries k)
    (hΨ : ∀ r : PowerSeries k, Ψ (r : LaurentSeries k) = (φ r : PowerSeries k))
    (ψ : LaurentSeries k) (hroot : ψ ^ h = Ψ (HahnSeries.single (-1) 1))
    (hψorder : ψ.order = -(p : ℤ)) (hψderiv : (LaurentSeries.derivative k ψ).order = -2) :
    letI : Algebra (LaurentSeries k) (LaurentSeries k) := Ψ.toAlgebra
    letI : SMul (LaurentSeries k) (LaurentSeries k) := Ψ.toAlgebra.toSMul
    letI : Module (LaurentSeries k) (LaurentSeries k) := Algebra.toModule
    FiniteDimensional (LaurentSeries k) (LaurentSeries k) ∧
      Module.finrank (LaurentSeries k) (LaurentSeries k) = p * h := by
  obtain ⟨α, γ, hα, _, _, _, e, he⟩ :=
    weak_tame_original_completed_field_model p h hp hh φ Ψ hΨ ψ hroot hψorder hψderiv
  have hg : 0 < (weakTamePolynomial p h α γ).natDegree := by
    rw [weak_tame_polynomial_degree p h hp α γ hα]
    exact Nat.mul_pos (by omega) hh
  have hdegree := constant_pole_field_model_degree (weakTamePolynomial p h α γ) hg
    (weak_tame_polynomial_constant_zero p h hp hh α γ) Ψ e he
  simpa only [weak_tame_polynomial_degree p h hp α γ hα] using hdegree

end Litt3.QuotientGeometry
