import Mathlib.RingTheory.LaurentSeries

namespace Litt3.QuotientGeometry

noncomputable def weakPoleScalar {k : Type*} [Field k] (p : ℕ) (ψ : LaurentSeries k) : k :=
  -ψ.coeff (-(p : ℤ)) / ψ.coeff (-1) ^ p

end Litt3.QuotientGeometry
