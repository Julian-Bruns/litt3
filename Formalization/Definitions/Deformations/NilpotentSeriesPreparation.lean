import Definitions.Deformations.CoefficientSeriesSplitting
import Definitions.Deformations.NilpotentPerturbation

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

/-- The actual distinguished shift plus a nilpotent scalar correction.
The coefficient operator can be noncommutative and need not be given
by any bounded matrix or finite-rank calculation. -/
def preparedSeriesOperator (h : ℕ) (parameter : R)
    (correction : CoefficientSeries (K := K) →ₗ[R] CoefficientSeries (K := K)) :
    CoefficientSeries (K := K) →ₗ[R] CoefficientSeries (K := K) :=
  coefficientSeriesShift h + parameter • correction

/-- Reconstruct a formal sequence from a low remainder and a full
quotient under the actual distinguished operator. -/
def preparedSeriesReconstruction (h : ℕ) (parameter : R)
    (correction : CoefficientSeries (K := K) →ₗ[R] CoefficientSeries (K := K)) :
    ((Fin h → K) × CoefficientSeries (K := K)) →ₗ[R] CoefficientSeries (K := K) :=
  (coefficientSeriesPrefixSection h).comp (LinearMap.fst R _ _) +
    (preparedSeriesOperator h parameter correction).comp (LinearMap.snd R _ _)

end Litt3.Deformations
