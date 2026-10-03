import Mathlib.RingTheory.PowerSeries.Order
import Mathlib.Algebra.Algebra.Equiv

namespace Litt3.QuotientGeometry

/-- The usual lower ramification condition on every actual integral
element of k[[t]], using its additive DVR valuation, including infinity
for the zero displacement. -/
def completedLowerRamificationCondition
    (k : Type*) [Field k] (n : ℕ) (e : PowerSeries k ≃ₐ[k] PowerSeries k) : Prop :=
  ∀ f : PowerSeries k, ((n + 1 : ℕ) : ℕ∞) ≤ PowerSeries.order (e f - f)

end Litt3.QuotientGeometry
