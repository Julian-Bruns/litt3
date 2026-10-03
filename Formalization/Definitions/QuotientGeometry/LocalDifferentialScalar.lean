import Mathlib.Algebra.Field.Defs

namespace Litt3.QuotientGeometry

noncomputable def localDifferentialScalar
    {k : Type*} [Field k] (p h m : ℕ) (c g σ : k) : k :=
  -g ^ ((p : ℤ) - ((m * ((p - 1) / h) : ℕ) : ℤ)) /
    (-(((m : k) / (h : k)) * c * σ)) ^ p

end Litt3.QuotientGeometry
