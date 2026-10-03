import Definitions.QuotientGeometry.QuadraticFunctionFields
import Mathlib.RingTheory.Polynomial.GaussLemma

namespace Litt3.QuotientGeometry

/-- The genuine monic equation in the second variable, over the actual
polynomial ring in the first variable. -/
noncomputable def quadraticAffinePolynomial
    {k : Type*} [Field k] (p : Polynomial k) : Polynomial (Polynomial k) :=
  Polynomial.X ^ 2 - Polynomial.C p

abbrev QuadraticAffineAlgebra
    {k : Type*} [Field k] (p : Polynomial k) := AdjoinRoot (quadraticAffinePolynomial p)

end Litt3.QuotientGeometry
