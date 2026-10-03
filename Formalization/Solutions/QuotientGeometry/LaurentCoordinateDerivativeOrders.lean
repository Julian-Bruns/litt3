import Solutions.QuotientGeometry.LaurentCoordinateDerivative
import Solutions.QuotientGeometry.CompletedAutomorphismOrders

namespace Litt3.QuotientGeometry

open Litt3.SharedTensors

variable {k : Type*} [Field k] [PerfectField k]
  {p : ℕ} [Fact p.Prime] [CharP k p]

noncomputable local instance : Module k (LaurentSeries k) := Algebra.toModule

include p

/-- Every genuine compatible uniformizer coordinate change preserves
the order of EVERY nonzero actual Laurent derivative. Preservation of
the full power-series ring forces a unit derivative of the new parameter;
neither that unit condition nor derivative-order preservation is supplied. -/
theorem compatible_laurent_equiv_derivative_order
    (e : PowerSeries k ≃ₐ[k] PowerSeries k)
    (E : LaurentSeries k ≃+* LaurentSeries k)
    (hE : ∀ f : PowerSeries k, E (f : LaurentSeries k) = (e f : PowerSeries k))
    (f : LaurentSeries k) (hDf : LaurentSeries.derivative k f ≠ 0) :
    (LaurentSeries.derivative k (E f)).order = (LaurentSeries.derivative k f).order := by
  let D := Litt3.CartierAndSpin.laurentDerivation k
  have hb : PowerSeries.order (e PowerSeries.X) = 1 :=
    power_series_ring_equiv_order_X e.toRingEquiv
  have hb1 : PowerSeries.coeff 1 (e PowerSeries.X) ≠ 0 :=
    (PowerSeries.order_eq_nat.mp hb).1
  have hd0 : PowerSeries.constantCoeff
      (PowerSeries.derivative k (e PowerSeries.X)) ≠ 0 := by
    simpa only [← PowerSeries.coeff_zero_eq_constantCoeff,
      PowerSeries.coeff_derivative, Nat.cast_zero, zero_add, mul_one] using hb1
  have ht : laurentParameter k = ((PowerSeries.X : PowerSeries k) : LaurentSeries k) :=
    HahnSeries.ofPowerSeries_X.symm
  have hDE : D (E (laurentParameter k)) =
      ((PowerSeries.derivative k (e PowerSeries.X) : PowerSeries k) : LaurentSeries k) := by
    rw [ht, hE]
    exact Litt3.CartierAndSpin.laurent_derivative_powerSeries _
  have hDE0 : (D (E (laurentParameter k))).order = 0 := by
    rw [hDE]
    exact power_series_coe_unit_order _ hd0
  have hDEnz : D (E (laurentParameter k)) ≠ 0 := by
    rw [hDE]
    intro hz
    have hcoeff := congrArg (fun g : LaurentSeries k => g.coeff 0) hz
    apply hd0
    simpa [PowerSeries.coeff_coe, PowerSeries.coeff_zero_eq_constantCoeff] using hcoeff
  have hED : E (D f) ≠ 0 := by
    simpa only [map_zero] using E.injective.ne hDf
  change (D (E f)).order = (D f).order
  rw [laurent_field_equiv_derivative_chain_rule (p := p) E f,
    HahnSeries.order_mul hED hDEnz,
    compatible_laurent_equiv_order e.toRingEquiv E hE (D f), hDE0, add_zero]

end Litt3.QuotientGeometry
