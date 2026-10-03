import Mathlib.FieldTheory.Finite.Basic
import Mathlib.Algebra.Polynomial.Eval.Defs

namespace Litt3.CurveArithmetic

/-- Actual nonsingular fractional linear data on the projective line.
The finite-coordinate formula is used only where its denominator is
nonzero; no arbitrary map is treated as a projectivity. -/
structure FractionalLinearData (L : Type*) [Field L] where
  numeratorLinear : L
  numeratorConstant : L
  denominatorLinear : L
  denominatorConstant : L
  determinant_ne_zero :
    numeratorLinear * denominatorConstant - numeratorConstant * denominatorLinear ≠ 0

def FractionalLinearData.denominator
    {L : Type*} [Field L] (g : FractionalLinearData L) (x : L) : L :=
  g.denominatorLinear * x + g.denominatorConstant

def FractionalLinearData.eval
    {L : Type*} [Field L] (g : FractionalLinearData L) (x : L) : L :=
  (g.numeratorLinear * x + g.numeratorConstant) / g.denominator x

/-- The degree-at-most-two polynomial detecting commutation with
finite-base Frobenius on rational points. -/
noncomputable def FractionalLinearData.frobeniusCrossPolynomial
    {L : Type*} [Field L] (g : FractionalLinearData L) (q : ℕ) : Polynomial L :=
  Polynomial.C (g.numeratorLinear ^ q * g.denominatorLinear -
    g.numeratorLinear * g.denominatorLinear ^ q) * Polynomial.X ^ 2 +
  Polynomial.C (g.numeratorLinear ^ q * g.denominatorConstant +
    g.numeratorConstant ^ q * g.denominatorLinear -
    g.numeratorLinear * g.denominatorConstant ^ q -
    g.numeratorConstant * g.denominatorLinear ^ q) * Polynomial.X +
  Polynomial.C (g.numeratorConstant ^ q * g.denominatorConstant -
    g.numeratorConstant * g.denominatorConstant ^ q)

end Litt3.CurveArithmetic
