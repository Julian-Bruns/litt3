import Definitions.Deformations.CoefficientSeriesMaps

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

/-- The literal finite polynomial in augmentation whose coefficients
are arbitrary original coefficient endomorphisms, retaining their
possibly noncommutative full coefficient algebra. -/
def coefficientPolynomialOperator (q : ℕ) (C : Fin q → Module.End R K) :
    Module.End R (CoefficientSeries (K := K)) :=
  ∑ j : Fin q, coefficientSeriesShift j.val * coefficientSeriesMap (C j)

end Litt3.Deformations
