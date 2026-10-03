import Mathlib.RingTheory.LaurentSeries

namespace Litt3.QuotientGeometry

/-- Actual field equivalence over the same fixed parameter field,
expressed by intertwining the two genuine base embeddings. -/
def ParameterFieldsEquivalent
    {k : Type*} [Field k] (φ ψ : LaurentSeries k →+* LaurentSeries k) : Prop :=
  ∃ e : LaurentSeries k ≃+* LaurentSeries k, ∀ r, e (φ r) = ψ r

end Litt3.QuotientGeometry
