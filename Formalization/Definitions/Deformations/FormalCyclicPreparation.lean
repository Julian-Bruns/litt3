import Definitions.Deformations.FormalCyclicPresentation

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

/-- The full literal lower-binomial correction for the original
cyclic relation. Every coefficient is the actual integral quotient
of its binomial coefficient by p. -/
def formalCyclicCorrection (p a : ℕ) : Module.End R (CoefficientSeries (K := K)) :=
  ∑ j ∈ Finset.Icc 1 (p ^ a - 1), (((p ^ a).choose j / p : ℕ) : R) • coefficientSeriesShift j

end Litt3.Deformations
