import Mathlib.FieldTheory.Minpoly.Field
import Mathlib.RingTheory.AdjoinRoot
import Mathlib.RingTheory.Ideal.Quotient.Operations

namespace Litt3.CartierAndSpin

open Polynomial

variable {K A : Type*} [Field K] [Ring A] [Algebra K A]

/-- The ORIGINAL polynomial-value algebra is exactly the literal
minpoly quotient, even for a noncommutative target. No integrality,
nontriviality or polynomial representation is supplied. -/
noncomputable def actualPolynomialValueAlgebraEquiv (x : A) :
    AdjoinRoot (minpoly K x) ≃ₐ[K] (aeval x : K[X] →ₐ[K] A).range :=
  (Ideal.quotientEquivAlgOfEq K
    (minpoly.ker_aeval_eq_span_minpoly K x).symm).trans
      (Ideal.quotientKerEquivRange (aeval x : K[X] →ₐ[K] A))

/-- The equivalence evaluates every ORIGINAL polynomial at the actual
element; its codomain is the actual range subalgebra. -/
theorem actual_polynomial_value_algebra_equiv_mk (x : A) (P : K[X]) :
    (actualPolynomialValueAlgebraEquiv x (AdjoinRoot.mk (minpoly K x) P)).val =
      aeval x P := by
  rfl

end Litt3.CartierAndSpin
