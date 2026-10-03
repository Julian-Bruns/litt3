import Definitions.Deformations.CoefficientSeriesSplitting

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

/-- The literal truncated multiplication by the coefficient parameter. -/
def finiteCoefficientShift (h : ℕ) : Module.End R (Fin h → K) :=
  (coefficientSeriesPrefix h).comp
    ((coefficientSeriesShift 1).comp (coefficientSeriesPrefixSection h))

end Litt3.Deformations
