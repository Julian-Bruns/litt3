import Solutions.QuotientGeometry.ConstantPolynomialMapCoordinates
import Solutions.QuotientGeometry.WeakNormalizedAutomorphisms
import Solutions.QuotientGeometry.WeakLaurentCoefficients
import Solutions.QuotientGeometry.LaurentUnitOrders

namespace Litt3.QuotientGeometry

theorem weak_tame_original_completed_coordinates
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h)
    (φ : PowerSeries k →ₐ[k] PowerSeries k) (Ψ : LaurentSeries k →+* LaurentSeries k)
    (hΨ : ∀ r : PowerSeries k, Ψ (r : LaurentSeries k) = (φ r : PowerSeries k))
    (ψ : LaurentSeries k) (hroot : ψ ^ h = Ψ (HahnSeries.single (-1) 1))
    (hψorder : ψ.order = -(p : ℤ)) (hψderiv : (LaurentSeries.derivative k ψ).order = -2) :
    ∃ (α γ : k) (hα : α ≠ 0), γ ≠ 0 ∧
      α = ψ.coeff (-(p : ℤ)) ∧ γ = ψ.coeff (-1) ∧
      ∃ (e : PowerSeries k ≃ₐ[k] PowerSeries k) (E : LaurentSeries k ≃ₐ[k] LaurentSeries k),
        (∀ f : PowerSeries k, E (f : LaurentSeries k) = (e f : PowerSeries k)) ∧
        (∀ r : LaurentSeries k, E (weakNormalizedEmbedding p h hh α γ hα r) = Ψ r) := by
  have hp : 1 < p := (Fact.out : p.Prime).one_lt
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
  obtain ⟨e, E, hE, hbase⟩ := constant_polynomial_completed_map_coordinates
    (weakTamePolynomial p h α γ) hg w φ Ψ hΨ
    (completed_map_parameter_zero_constant φ Ψ hΨ hnegative) hpole
  exact ⟨α, γ, hα, hγ, hcoeff.1.symm, hcoeff.2.symm, e, E, hE, hbase⟩

end Litt3.QuotientGeometry
