import Definitions.Deformations.FormalCyclicPreparation

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

/-- The full actual lower-binomial correction of the original norm. -/
def formalCyclicNormCorrection (p a : ℕ) : Module.End R (CoefficientSeries (K := K)) :=
  ∑ j ∈ Finset.Icc 1 (p ^ a - 1), (((p ^ a).choose j / p : ℕ) : R) •
    coefficientSeriesShift (j - 1)

end Litt3.Deformations
