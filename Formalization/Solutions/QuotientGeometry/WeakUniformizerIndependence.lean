import Solutions.QuotientGeometry.LaurentCoordinateDerivativeOrders
import Solutions.QuotientGeometry.WeakTameClassification

namespace Litt3.QuotientGeometry

/-- EVERY genuine completed uniformizer change preserves the original
weak scalar. The new root pole and derivative orders are DERIVED from
full ring compatibility and the whole Laurent chain rule. No new
different profile, derivative order or scalar equality is assumed. -/
theorem weak_original_uniformizer_scalar_independent
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ)
    [Fact p.Prime] [CharP k p] (hh : 0 < h) (hdiv : h ∣ p - 1)
    (φ : PowerSeries k →ₐ[k] PowerSeries k)
    (Ψ : LaurentSeries k →+* LaurentSeries k)
    (hΨ : ∀ f : PowerSeries k, Ψ (f : LaurentSeries k) = (φ f : PowerSeries k))
    (ψ : LaurentSeries k) (hroot : ψ ^ h = Ψ (HahnSeries.single (-1) 1))
    (hψorder : ψ.order = -(p : ℤ))
    (hψderiv : (LaurentSeries.derivative k ψ).order = -2)
    (e : PowerSeries k ≃ₐ[k] PowerSeries k)
    (E : LaurentSeries k ≃+* LaurentSeries k)
    (hE : ∀ f : PowerSeries k, E (f : LaurentSeries k) = (e f : PowerSeries k)) :
    weakPoleScalar p ψ = weakPoleScalar p (E ψ) := by
  let χ := e.toAlgHom.comp φ
  let Ω := E.toRingHom.comp Ψ
  have hΩ : ∀ f : PowerSeries k, Ω (f : LaurentSeries k) = (χ f : PowerSeries k) := by
    intro f
    change E (Ψ (f : LaurentSeries k)) = (e (φ f) : PowerSeries k)
    rw [hΨ, hE]
  have hrootE : (E ψ) ^ h = Ω (HahnSeries.single (-1) 1) := by
    change (E ψ) ^ h = E (Ψ (HahnSeries.single (-1) 1))
    rw [← map_pow, hroot]
  have hEorder : (E ψ).order = -(p : ℤ) :=
    (compatible_laurent_equiv_order e.toRingEquiv E hE ψ).trans hψorder
  have hDψ : LaurentSeries.derivative k ψ ≠ 0 := by
    intro hz
    simp [hz] at hψderiv
  have hEderiv : (LaurentSeries.derivative k (E ψ)).order = -2 :=
    (compatible_laurent_equiv_derivative_order (p := p) e E hE ψ hDψ).trans hψderiv
  apply (weak_tame_completed_fields_equiv_iff p h hh hdiv φ χ Ψ Ω hΨ hΩ
    ψ (E ψ) hroot hrootE hψorder hEorder hψderiv hEderiv).mp
  exact ⟨E, fun _ => rfl⟩

end Litt3.QuotientGeometry
