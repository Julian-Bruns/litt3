import Mathlib.LinearAlgebra.FiniteDimensional.Lemmas

namespace Litt3.Deformations

variable {k V : Type*} [DivisionRing k] [AddCommGroup V] [Module k V]

/-- The actual cokernel vector space of a linear endomorphism. -/
abbrev EndomorphismCokernel (T : V →ₗ[k] V) := V ⧸ LinearMap.range T

/-- A genuine successive filtration quotient, rather than a dimension
table supplied by an external computation. -/
abbrev FiltrationLayer (F : ℕ → Submodule k V) (i : ℕ) :=
  F i ⧸ (F (i + 1)).comap (F i).subtype

end Litt3.Deformations
