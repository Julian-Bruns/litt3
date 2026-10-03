import Solutions.QuotientGeometry.WeakValuativeUniformizerIndependence
import Solutions.QuotientGeometry.ParameterCoordinates

namespace Litt3.QuotientGeometry

/-- ANY actual uniformizer, supplied only by order one, constructs an
automorphism of the WHOLE completed field and preserves the scalar of
EVERY chosen root of an original valuative different profile. Neither
the coordinate automorphism nor derivative orders are assumptions. -/
theorem weak_valuative_different_every_uniformizer_scalar_independent
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ) [CharP k p] [Fact p.Prime]
    (hp : 1 < p) (hh : 0 < h) (hdiv : h ∣ p - 1)
    (b : PowerSeries k) (hb : b.order = p * h)
    (hprofile : weakValuativeDifferentProfile p h hp hh b hb)
    (ψ : LaurentSeries k) (hψ : ψ ^ h = (b : LaurentSeries k)⁻¹)
    (q : PowerSeries k) (hq : q.order = 1) :
    ∃ E : LaurentSeries k ≃ₐ[k] LaurentSeries k,
      (∀ f : PowerSeries k, E (f : LaurentSeries k) = (PowerSeries.subst q f : PowerSeries k)) ∧
      weakPoleScalar p ψ = weakPoleScalar p (E ψ) := by
  have hq0 : PowerSeries.constantCoeff q = 0 :=
    positive_parameter_constant_zero 1 (by decide) q hq
  have hq1 : PowerSeries.coeff 1 q ≠ 0 := (PowerSeries.order_eq_nat.mp hq).1
  obtain ⟨e, he⟩ := parameter_power_series_automorphism q hq0 hq1
  obtain ⟨E, hEL⟩ := parameter_laurent_automorphism q hq0 hq1
  have hE : ∀ f : PowerSeries k, E (f : LaurentSeries k) = (e f : PowerSeries k) := by
    intro f
    rw [hEL, he]
  exact ⟨E, hEL, weak_valuative_different_uniformizer_scalar_independent p h hp hh hdiv
    b hb hprofile ψ hψ e E.toRingEquiv hE⟩

end Litt3.QuotientGeometry
