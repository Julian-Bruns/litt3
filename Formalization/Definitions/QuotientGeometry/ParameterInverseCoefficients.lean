import Mathlib.RingTheory.PowerSeries.Substitution
import Mathlib.Data.Nat.Init

namespace Litt3.QuotientGeometry

/-- Recursive coefficients of the inverse image under actual substitution.
Each stage depends only on the lower coefficients and the genuine powers
of the substituted parameter. -/
noncomputable def parameterInverseCoeff
    {k : Type*} [Field k] (b f : PowerSeries k) (n : ℕ) : k :=
  Nat.strongRecOn' n fun n ih =>
    (PowerSeries.coeff n f - ∑ i : Fin n,
      ih i.val i.isLt * PowerSeries.coeff n (b ^ i.val)) / PowerSeries.coeff 1 b ^ n

noncomputable def parameterInverseSeries
    {k : Type*} [Field k] (b f : PowerSeries k) : PowerSeries k :=
  PowerSeries.mk (parameterInverseCoeff b f)

end Litt3.QuotientGeometry
