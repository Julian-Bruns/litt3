import Mathlib.RingTheory.LaurentSeries

namespace Litt3.QuotientGeometry

/-- The scalar from the actual coefficients in a chosen Laurent
coordinate, with the downstairs pole map supplied literally. -/
noncomputable def weakLaurentInvariant {k : Type*} [Field k] (p : ℕ)
    (Ψ : LaurentSeries k →+* LaurentSeries k) : k :=
  -(Ψ (HahnSeries.single (-1) 1)).coeff (-(p : ℤ)) /
    (Ψ (HahnSeries.single (-1) 1)).coeff (-1) ^ p

end Litt3.QuotientGeometry
