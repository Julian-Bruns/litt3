import Mathlib.RingTheory.LaurentSeries
import Mathlib.Algebra.Polynomial.Reverse

namespace Litt3.QuotientGeometry

noncomputable def constantPolePolynomial {k : Type*} [Field k] (g : Polynomial k) :
    Polynomial (LaurentSeries k) :=
  g.map HahnSeries.C - Polynomial.C (HahnSeries.single (-1) 1)

noncomputable def constantPoleReciprocal {k : Type*} [Field k] (g : Polynomial k) :
    Polynomial (PowerSeries k) :=
  Polynomial.X ^ g.natDegree - Polynomial.C PowerSeries.X * g.reverse.map PowerSeries.C

end Litt3.QuotientGeometry
