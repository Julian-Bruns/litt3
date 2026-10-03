import Mathlib.RingTheory.PowerSeries.Inverse
import Mathlib.RingTheory.LaurentSeries

namespace Litt3.QuotientGeometry

/-- Every genuine homomorphism out of a field-coefficient power-series
ring is injective once its parameter image is nonzero. -/
theorem power_series_ringHom_injective_of_parameter_ne_zero
    {k R : Type*} [Field k] [CommRing R] [IsDomain R]
    (φ : PowerSeries k →+* R) (hX : φ PowerSeries.X ≠ 0) : Function.Injective φ := by
  apply (injective_iff_map_eq_zero φ).mpr
  intro f hf
  by_contra hne
  have hfactor := PowerSeries.X_pow_order_mul_divXPowOrder (f := f)
  have hu : IsUnit (φ (PowerSeries.divXPowOrder f)) :=
    (PowerSeries.isUnit_divided_by_X_pow_order hne).map φ
  rw [← hfactor, map_mul, map_pow] at hf
  exact mul_ne_zero (pow_ne_zero _ hX) hu.ne_zero hf

end Litt3.QuotientGeometry
