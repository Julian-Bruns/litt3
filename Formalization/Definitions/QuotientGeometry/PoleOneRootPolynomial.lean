import Mathlib.RingTheory.LaurentSeries

namespace Litt3.QuotientGeometry

/-- Reciprocal polynomial for z^n-z=a/t. Its coefficients lie in the
actual formal power-series ring. -/
noncomputable def poleOneReciprocalPolynomial
    {k : Type*} [Field k] (n : ℕ) (a : k) : Polynomial (PowerSeries k) :=
  Polynomial.X ^ n +
    Polynomial.C (PowerSeries.C a⁻¹ * PowerSeries.X) * Polynomial.X ^ (n - 1) -
    Polynomial.C (PowerSeries.C a⁻¹ * PowerSeries.X)

end Litt3.QuotientGeometry
