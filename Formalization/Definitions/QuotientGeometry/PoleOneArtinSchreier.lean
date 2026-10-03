import Mathlib.RingTheory.LaurentSeries

namespace Litt3.QuotientGeometry

/-- Actual polynomial over the full Laurent base field, with pole-one
right-hand side a/t. In characteristic p and degree p this is an
Artin--Schreier polynomial. -/
noncomputable def poleOneArtinSchreierPolynomial
    {k : Type*} [Field k] (n : ℕ) (a : k) : Polynomial (LaurentSeries k) :=
  Polynomial.X ^ n - Polynomial.X - Polynomial.C (HahnSeries.single (-1) a)

end Litt3.QuotientGeometry
