import Theorems.QuotientGeometry.WeakCompletedDifferentProfile
import Solutions.QuotientGeometry.PositiveParameterOrders

namespace Litt3.QuotientGeometry

/-- The literal original finite-separating trace-different hypothesis
stated using ONLY the actual positive parameter's valuation. The
coefficient unit and its zero constant term are constructed canonically. -/
noncomputable def weakValuativeDifferentProfile
    {k : Type*} [Field k] (p h : ℕ) (hp : 1 < p) (hh : 0 < h)
    (b : PowerSeries k) (hb : b.order = p * h) : Prop :=
  weakCompletedDifferentProfile p h hp hh b (PowerSeries.divXPowOrder b)
    (positive_parameter_canonical_factor (p * h) b hb).1
    (positive_parameter_canonical_factor (p * h) b hb).2
    (positive_parameter_constant_zero (p * h) (Nat.mul_pos (by omega) hh) b hb)

end Litt3.QuotientGeometry
