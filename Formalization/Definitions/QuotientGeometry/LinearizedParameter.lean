import Mathlib.RingTheory.PowerSeries.Inverse

namespace Litt3.QuotientGeometry

/-- The actual inverse parameter for `α t⁻ⁿ + γ t⁻¹`. -/
noncomputable def linearizedParameter
    {k : Type*} [Field k] (n : ℕ) (α γ : k) : PowerSeries k :=
  PowerSeries.X ^ n *
    (PowerSeries.C α + PowerSeries.C γ * PowerSeries.X ^ (n - 1))⁻¹

end Litt3.QuotientGeometry
