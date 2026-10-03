import Definitions.QuotientGeometry.ParameterInverseCoefficients
import Mathlib.RingTheory.LaurentSeries

namespace Litt3.QuotientGeometry

universe u

/-- The actual substitution by any formal parameter of order one is an
automorphism of the whole power-series ring over the constants. -/
def ParameterPowerSeriesAutomorphism : Prop :=
  ∀ {k : Type u} [Field k] (b : PowerSeries k),
    PowerSeries.constantCoeff b = 0 → PowerSeries.coeff 1 b ≠ 0 →
      ∃ e : PowerSeries k ≃ₐ[k] PowerSeries k,
        ∀ f, e f = PowerSeries.subst b f

/-- The genuine constant-preserving automorphism of the Laurent field
extends actual substitution on every power series. -/
def ParameterLaurentAutomorphism : Prop :=
  ∀ {k : Type u} [Field k] (b : PowerSeries k),
    PowerSeries.constantCoeff b = 0 → PowerSeries.coeff 1 b ≠ 0 →
      ∃ e : LaurentSeries k ≃ₐ[k] LaurentSeries k,
        ∀ f : PowerSeries k, e (f : LaurentSeries k) = (PowerSeries.subst b f : PowerSeries k)

end Litt3.QuotientGeometry
