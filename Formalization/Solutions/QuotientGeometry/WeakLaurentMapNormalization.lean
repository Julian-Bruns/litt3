import Solutions.QuotientGeometry.WeakLaurentLinearization
import Solutions.QuotientGeometry.LaurentParameterRecovery
import Solutions.QuotientGeometry.PoleShiftCoordinates
import Solutions.QuotientGeometry.LinearizedParameter
import Solutions.QuotientGeometry.WeakLaurentCoefficients

namespace Litt3.QuotientGeometry

/-- Removes the whole regular tail while preserving the actual
downstairs Laurent map. The coordinate change extends an actual
power-series automorphism; no presumed identification of the fields
or algebraic-generation hypothesis is used. -/
theorem weak_laurent_completed_map_normalization
    {k : Type*} [Field k] [IsAlgClosed k] (p : ℕ) [CharP k p] (hp : 1 < p)
    (φ : PowerSeries k →ₐ[k] PowerSeries k)
    (Ψ : LaurentSeries k →+* LaurentSeries k)
    (hΨ : ∀ r : PowerSeries k, Ψ (r : LaurentSeries k) = (φ r : PowerSeries k))
    (hzero : PowerSeries.constantCoeff (φ PowerSeries.X) = 0)
    (horder : (Ψ (HahnSeries.single (-1) 1)).order = -(p : ℤ))
    (hderiv : (LaurentSeries.derivative k (Ψ (HahnSeries.single (-1) 1))).order = -2) :
    ∃ (α γ : k) (hα : α ≠ 0), γ ≠ 0 ∧
      α = (Ψ (HahnSeries.single (-1) 1)).coeff (-(p : ℤ)) ∧
      γ = (Ψ (HahnSeries.single (-1) 1)).coeff (-1) ∧
      ∃ E : LaurentSeries k ≃ₐ[k] LaurentSeries k,
        ∀ r : LaurentSeries k,
          E (parameterLaurentMap (linearizedParameter p α γ)
            (linearized_parameter_zero p hp α γ)
            (linearized_parameter_injective p hp α γ hα) r) = Ψ r := by
  obtain ⟨α, γ, w, hα, hγ, hu, hf⟩ :=
    weak_laurent_linearized_normal_form p hp (Ψ (HahnSeries.single (-1) 1)) horder hderiv
  obtain ⟨e, E, hE, hpole⟩ := pole_shift_power_series_coordinates w
  let b := linearizedParameter p α γ
  have hb : PowerSeries.constantCoeff b = 0 := linearized_parameter_zero p hp α γ
  let χ : PowerSeries k →ₐ[k] PowerSeries k :=
    e.toAlgHom.comp (PowerSeries.substAlgHom (PowerSeries.HasSubst.of_constantCoeff_zero' hb))
  let Φ := parameterLaurentMap b hb (linearized_parameter_injective p hp α γ hα)
  let Ω : LaurentSeries k →+* LaurentSeries k := E.toRingHom.comp Φ
  have hΩ : ∀ r : PowerSeries k, Ω (r : LaurentSeries k) = (χ r : PowerSeries k) := by
    intro r
    change E (Φ (r : LaurentSeries k)) =
      (e ((PowerSeries.substAlgHom (PowerSeries.HasSubst.of_constantCoeff_zero' hb)) r) : PowerSeries k)
    rw [parameter_laurent_map_power_series, hE]
    congr 1
    exact congrArg e
      (congr_fun (PowerSeries.coe_substAlgHom (PowerSeries.HasSubst.of_constantCoeff_zero' hb)) r).symm
  have hC (a : k) : E (HahnSeries.C a) = HahnSeries.C a := by
    simpa only [LaurentSeries.algebraMap_apply] using E.commutes a
  have heq : Ψ = Ω := by
    apply laurent_field_maps_eq_of_pole_image φ χ Ψ Ω hΨ hΩ hzero
    change Ψ (HahnSeries.single (-1) 1) = E (Φ (HahnSeries.single (-1) 1))
    rw [linearized_parameter_pole_image p hp α γ hα, map_add, map_mul, map_mul,
      map_pow, hC, hC, hpole]
    exact hf
  have hcoeff := weak_linearized_negative_coefficients p hp α γ w
    (Ψ (HahnSeries.single (-1) 1)) hf
  refine ⟨α, γ, hα, hγ, hcoeff.1.symm, hcoeff.2.symm, E, ?_⟩
  intro r
  exact (congr_fun (congrArg DFunLike.coe heq) r).symm

end Litt3.QuotientGeometry
