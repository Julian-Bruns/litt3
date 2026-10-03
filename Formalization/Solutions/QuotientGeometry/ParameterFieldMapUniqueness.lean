import Solutions.QuotientGeometry.ParameterHomUniqueness
import Solutions.QuotientGeometry.ParameterLaurentImages

namespace Litt3.QuotientGeometry

/-- A supplied completed-ring map and its genuine fraction-field map
are uniquely the substitution maps determined by the actual parameter.
Neither continuity nor the substitution conclusion is a hypothesis. -/
theorem laurent_field_map_eq_parameter_substitution
    {k : Type*} [Field k] (b : PowerSeries k)
    (hb : PowerSeries.constantCoeff b = 0)
    (hinj : Function.Injective (PowerSeries.subst b : PowerSeries k → PowerSeries k))
    (φ : PowerSeries k →ₐ[k] PowerSeries k) (hφ : φ PowerSeries.X = b)
    (Ψ : LaurentSeries k →+* LaurentSeries k)
    (hΨ : ∀ f : PowerSeries k, Ψ (f : LaurentSeries k) = (φ f : PowerSeries k)) :
    Ψ = parameterLaurentMap b hb hinj := by
  apply IsFractionRing.ringHom_ext (A := PowerSeries k)
  intro f
  change Ψ (f : LaurentSeries k) = parameterLaurentMap b hb hinj (f : LaurentSeries k)
  rw [hΨ, parameter_laurent_map_power_series,
    power_series_algHom_eq_substitution b hb φ hφ, PowerSeries.coe_substAlgHom]

end Litt3.QuotientGeometry
