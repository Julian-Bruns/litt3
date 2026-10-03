import Definitions.Deformations.PreparedSeriesAugmentation

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

/-- The actual cyclic group relation on the actual prepared quotient,
retaining the literal augmentation map and the original coefficient module. -/
def preparedSeriesCyclicRelation (h p a : ℕ)
    (correction : Module.End R (CoefficientSeries (K := K)))
    (commute : Commute (preparedSeriesOperator h (p : R) correction)
      (coefficientSeriesShift 1)) :
    Module.End R (CoefficientSeries (K := K) ⧸
      LinearMap.range (preparedSeriesOperator h (p : R) correction)) :=
  (1 + preparedSeriesQuotientAugmentation h (p : R) correction commute) ^ (p ^ a) - 1

end Litt3.Deformations
