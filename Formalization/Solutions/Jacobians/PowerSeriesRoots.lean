import Solutions.QuotientGeometry.PowerSeriesLifting
import Mathlib.Algebra.Ring.GeomSum

namespace Litt3.Jacobians

/-- Invertibility of the exponent and the prescribed constant makes an
nth root unique, over any commutative coefficient ring. -/
theorem power_series_nth_root_unique
    {R : Type*} [CommRing R] (n : ℕ) (hn : IsUnit (n : R))
    (w v : PowerSeries R) (hconstant : PowerSeries.constantCoeff w =
      PowerSeries.constantCoeff v) (hunit : IsUnit (PowerSeries.constantCoeff w))
    (hpower : w ^ n = v ^ n) : w = v := by
  let s : PowerSeries R := ∑ i ∈ Finset.range n, w ^ i * v ^ (n - 1 - i)
  have hsconstant : PowerSeries.constantCoeff s =
      (n : R) * PowerSeries.constantCoeff w ^ (n - 1) := by
    simp only [s, map_sum, map_mul, map_pow, ← hconstant]
    exact geom_sum₂_self _ _
  have hs : IsUnit s := PowerSeries.isUnit_iff_constantCoeff.mpr (by
    rw [hsconstant]
    exact hn.mul (hunit.pow _))
  have hzero : s * (w - v) = 0 := by
    rw [show s * (w - v) = w ^ n - v ^ n from geom_sum₂_mul w v n, hpower]
    exact sub_self _
  exact sub_eq_zero.mp ((hs.mul_right_eq_zero).mp hzero)

/-- Every simple nonzero constant nth root lifts to a genuine formal
power series, with the prescribed constant coefficient. -/
theorem power_series_nth_root_with_constant
    {k : Type*} [Field k] (n : ℕ) (hn : 0 < n) (hchar : (n : k) ≠ 0)
    (r : PowerSeries k) (a₀ : k) (ha₀ : a₀ ≠ 0)
    (hroot : a₀ ^ n = PowerSeries.constantCoeff r) :
    ∃ w : PowerSeries k, w ^ n = r ∧ PowerSeries.constantCoeff w = a₀ := by
  let f : Polynomial (PowerSeries k) := Polynomial.X ^ n - Polynomial.C r
  have hf : f.Monic := Polynomial.monic_X_pow_sub_C r hn.ne'
  have heval : f.eval₂ PowerSeries.constantCoeff a₀ = 0 := by
    simp [f, hroot]
  have hsimple : f.derivative.eval₂ PowerSeries.constantCoeff a₀ ≠ 0 := by
    simpa [f, Polynomial.derivative_X_pow] using mul_ne_zero hchar (pow_ne_zero (n - 1) ha₀)
  obtain ⟨w, hw, hconstant⟩ := Litt3.QuotientGeometry.power_series_simple_root_lift
    f hf a₀ heval hsimple
  refine ⟨w, ?_, hconstant⟩
  simpa [f, Polynomial.IsRoot, sub_eq_zero] using hw

/-- Algebraic closedness supplies the initial root. Positive degree
and invertibility of n ensure an actual unit nth root of every unit
power series, without coefficient truncation or binomial division. -/
theorem power_series_unit_nth_root
    {k : Type*} [Field k] [IsAlgClosed k] (n : ℕ) (hn : 0 < n) (hchar : (n : k) ≠ 0)
    (r : PowerSeries k) (hr : PowerSeries.constantCoeff r ≠ 0) :
    ∃ w : PowerSeries k, w ^ n = r ∧ IsUnit w := by
  obtain ⟨a₀, ha₀⟩ := IsAlgClosed.exists_pow_nat_eq (PowerSeries.constantCoeff r) hn
  have ha₀zero : a₀ ≠ 0 := by
    intro hzero
    apply hr
    rw [← ha₀, hzero, zero_pow hn.ne']
  obtain ⟨w, hw, hconstant⟩ := power_series_nth_root_with_constant n hn hchar r a₀ ha₀zero ha₀
  refine ⟨w, hw, PowerSeries.isUnit_iff_constantCoeff.mpr ?_⟩
  rw [hconstant]
  exact isUnit_iff_ne_zero.mpr ha₀zero

end Litt3.Jacobians
