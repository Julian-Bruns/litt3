import Definitions.Deformations.PolynomialCoefficientSeries
import Definitions.Deformations.NilpotentSeriesPreparation

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

def polynomialPreparedSeriesOperator (h : ℕ) (parameter : R)
    (C : Module.End R (CoefficientSeries (K := K)))
    (preserve : ∀ v : polynomialCoefficientSeries (R := R) (K := K),
      C v ∈ polynomialCoefficientSeries (R := R) (K := K)) :
    Module.End R (polynomialCoefficientSeries (R := R) (K := K)) :=
  polynomialSeriesShift h + parameter • polynomialSeriesCorrection C preserve

def polynomialPreparedSeriesReconstruction (h : ℕ) (parameter : R)
    (C : Module.End R (CoefficientSeries (K := K)))
    (preserve : ∀ v : polynomialCoefficientSeries (R := R) (K := K),
      C v ∈ polynomialCoefficientSeries (R := R) (K := K)) :
    ((Fin h → K) × polynomialCoefficientSeries (R := R) (K := K)) →ₗ[R]
      polynomialCoefficientSeries (R := R) (K := K) :=
  (polynomialSeriesPrefixSection h).comp (LinearMap.fst R _ _) +
    (polynomialPreparedSeriesOperator h parameter C preserve).comp (LinearMap.snd R _ _)

end Litt3.Deformations
