import Solutions.QuotientGeometry.ParameterHomUniqueness
import Mathlib.Algebra.Polynomial.Div

namespace Litt3.QuotientGeometry

theorem power_series_algHom_polynomial_eval
    {R : Type*} [CommRing R] (φ : PowerSeries R →ₐ[R] PowerSeries R)
    (g : Polynomial R) :
    φ (g : PowerSeries R) = g.eval₂ PowerSeries.C (φ PowerSeries.X) := by
  have heq : φ.toRingHom.comp Polynomial.coeToPowerSeries.ringHom =
      Polynomial.eval₂RingHom PowerSeries.C (φ PowerSeries.X) := by
    apply Polynomial.ringHom_ext
    · intro a
      simpa using φ.commutes a
    · simp
  exact RingHom.congr_fun heq g

/-- A completed algebra homomorphism's displacement on every integral
series is bounded by its literal displacement on the uniformizer. -/
theorem power_series_algHom_displacement_order
    {R : Type*} [CommRing R] (φ : PowerSeries R →ₐ[R] PowerSeries R)
    (hφ : PowerSeries.constantCoeff (φ PowerSeries.X) = 0) (n : ℕ)
    (hn : (n : ℕ∞) ≤ PowerSeries.order (φ PowerSeries.X - PowerSeries.X))
    (f : PowerSeries R) : (n : ℕ∞) ≤ PowerSeries.order (φ f - f) := by
  apply PowerSeries.nat_le_order
  intro j hj
  let g := PowerSeries.trunc (j + 1) f
  have hf := PowerSeries.eq_X_pow_mul_shift_add_trunc (j + 1) f
  have hφcoeff : PowerSeries.coeff j (φ f) = PowerSeries.coeff j (φ (g : PowerSeries R)) := by
    have heq := congrArg φ hf
    rw [map_add, map_mul, map_pow] at heq
    rw [heq, map_add, parameter_power_product_coefficient_zero _ _ hφ j (j + 1) (by omega),
      zero_add]
  have hgcoeff : PowerSeries.coeff j f = PowerSeries.coeff j (g : PowerSeries R) := by
    simp [g, PowerSeries.coeff_trunc, show j < j + 1 by omega]
  have hdvd : φ PowerSeries.X - PowerSeries.X ∣ φ (g : PowerSeries R) - (g : PowerSeries R) := by
    have h := Polynomial.sub_dvd_eval_sub (φ PowerSeries.X) PowerSeries.X (g.map PowerSeries.C)
    rw [Polynomial.eval_map, Polynomial.eval_map] at h
    rw [← power_series_algHom_polynomial_eval φ g] at h
    have hid := power_series_algHom_polynomial_eval (AlgHom.id R (PowerSeries R)) g
    simp only [AlgHom.id_apply] at hid
    rw [← hid] at h
    exact h
  obtain ⟨q, hq⟩ := hdvd
  rw [map_sub, hφcoeff, hgcoeff, ← map_sub, hq]
  apply PowerSeries.coeff_of_lt_order
  exact lt_of_lt_of_le (by exact_mod_cast hj)
    (hn.trans ((le_add_of_nonneg_right (zero_le _)).trans (PowerSeries.le_order_mul _ _)))

theorem power_series_algHom_all_displacement_iff
    {R : Type*} [CommRing R] (φ : PowerSeries R →ₐ[R] PowerSeries R)
    (hφ : PowerSeries.constantCoeff (φ PowerSeries.X) = 0) (n : ℕ) :
    (∀ f : PowerSeries R, (n : ℕ∞) ≤ PowerSeries.order (φ f - f)) ↔
      (n : ℕ∞) ≤ PowerSeries.order (φ PowerSeries.X - PowerSeries.X) :=
  ⟨fun hall => hall PowerSeries.X, fun hx f => power_series_algHom_displacement_order φ hφ n hx f⟩

end Litt3.QuotientGeometry
