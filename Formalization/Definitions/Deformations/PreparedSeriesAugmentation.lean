import Definitions.Deformations.NilpotentSeriesPreparation
import Definitions.Deformations.CommutingRangeQuotient

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

/-- The actual augmentation action on the cokernel of the distinguished
formal-series operator. Its source is the literal full sequence module. -/
def preparedSeriesQuotientAugmentation (h : ℕ) (parameter : R)
    (correction : Module.End R (CoefficientSeries (K := K)))
    (commute : Commute (preparedSeriesOperator h parameter correction)
      (coefficientSeriesShift 1)) :
    Module.End R (CoefficientSeries (K := K) ⧸
      LinearMap.range (preparedSeriesOperator h parameter correction)) :=
  commutingRangeQuotientEnd (preparedSeriesOperator h parameter correction)
    (coefficientSeriesShift 1) commute

/-- The literal correction on the same quotient, retaining the full
coefficient operator rather than replacing it by a matrix model. -/
def preparedSeriesQuotientCorrection (h : ℕ) (parameter : R)
    (correction : Module.End R (CoefficientSeries (K := K)))
    (commute : Commute (preparedSeriesOperator h parameter correction) correction) :
    Module.End R (CoefficientSeries (K := K) ⧸
      LinearMap.range (preparedSeriesOperator h parameter correction)) :=
  commutingRangeQuotientEnd (preparedSeriesOperator h parameter correction) correction commute

end Litt3.Deformations
