import Solutions.QuotientGeometry.WeakValuativeClassification
import Solutions.QuotientGeometry.WeakUniformizerIndependence

namespace Litt3.QuotientGeometry

/-- Uniformizer independence from ONLY the genuine original valuation
and trace-different profile. The chosen root's weak orders are derived,
and the ENTIRE coordinate change may have infinite support. -/
theorem weak_valuative_different_uniformizer_scalar_independent
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ) [CharP k p] [Fact p.Prime]
    (hp : 1 < p) (hh : 0 < h) (hdiv : h ∣ p - 1)
    (b : PowerSeries k) (hb : b.order = p * h)
    (hprofile : weakValuativeDifferentProfile p h hp hh b hb)
    (ψ : LaurentSeries k) (hψ : ψ ^ h = (b : LaurentSeries k)⁻¹)
    (e : PowerSeries k ≃ₐ[k] PowerSeries k)
    (E : LaurentSeries k ≃+* LaurentSeries k)
    (hE : ∀ f : PowerSeries k, E (f : LaurentSeries k) = (e f : PowerSeries k)) :
    weakPoleScalar p ψ = weakPoleScalar p (E ψ) := by
  obtain ⟨ho, hd, _, _⟩ :=
    weak_valuative_different_all_roots_normal_form p h hp hh hdiv b hb hprofile ψ hψ
  have hcanonical := positive_parameter_canonical_factor (p * h) b hb
  have hb0 := positive_parameter_constant_zero (p * h) (Nat.mul_pos (by omega) hh) b hb
  let hi := finite_parameter_substitution_injective (p * h)
    (Nat.mul_pos (by omega) hh) b (PowerSeries.divXPowOrder b) hcanonical.1 hcanonical.2
  let Ψ := parameterLaurentMap b hb0 hi
  let φ : PowerSeries k →ₐ[k] PowerSeries k :=
    PowerSeries.substAlgHom (PowerSeries.HasSubst.of_constantCoeff_zero' hb0)
  have hΨ : ∀ f : PowerSeries k, Ψ (f : LaurentSeries k) = (φ f : PowerSeries k) := by
    intro f
    rw [parameter_laurent_map_power_series]
    exact congrArg (fun g : PowerSeries k => (g : LaurentSeries k))
      (congr_fun (PowerSeries.coe_substAlgHom
        (PowerSeries.HasSubst.of_constantCoeff_zero' hb0)) f).symm
  have hroot : ψ ^ h = Ψ (HahnSeries.single (-1) 1) := by
    rw [parameter_laurent_map_pole]
    simpa using hψ
  exact weak_original_uniformizer_scalar_independent p h hh hdiv φ Ψ hΨ ψ hroot ho hd e E hE

end Litt3.QuotientGeometry
