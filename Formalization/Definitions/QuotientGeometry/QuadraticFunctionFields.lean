import Mathlib.FieldTheory.RatFunc.Basic
import Mathlib.RingTheory.AdjoinRoot
import Mathlib.Algebra.MvPolynomial.Eval
import Mathlib.Data.Fin.VecNotation

namespace Litt3.QuotientGeometry

noncomputable def binaryDehomogenization
    {k : Type*} [CommSemiring k] (H : MvPolynomial (Fin 2) k) : Polynomial k :=
  MvPolynomial.aeval ![1, Polynomial.X] H

noncomputable def quadraticFunctionPolynomial
    {k : Type*} [Field k] (f : Polynomial k) : Polynomial (RatFunc k) :=
  Polynomial.X ^ 2 - Polynomial.C (algebraMap (Polynomial k) (RatFunc k) f)

/-- The actual quadratic function algebra. Squarefreeness and
nonconstancy will prove that it is a field, rather than postulate one. -/
abbrev QuadraticFunctionField
    {k : Type*} [Field k] (f : Polynomial k) :=
  AdjoinRoot (quadraticFunctionPolynomial f)

end Litt3.QuotientGeometry
