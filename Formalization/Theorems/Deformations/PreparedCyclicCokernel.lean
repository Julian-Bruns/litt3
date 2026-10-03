import Definitions.Deformations.PreparedCyclicCokernel
import Definitions.Deformations.FiniteShiftCokernel

namespace Litt3.Deformations.Specifications

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

/-- The full actual prepared cyclic cokernel, at unrestricted
coefficient-module rank. -/
def PreparedSeriesCyclicCokernel (p a n : ℕ)
    (correction : Module.End R (CoefficientSeries (K := K)))
    (commute : Commute (preparedSeriesOperator (n + 1) (p : R) correction)
      (coefficientSeriesShift 1)) : Prop :=
  Nonempty (((CoefficientSeries (K := K) ⧸ LinearMap.range
    (preparedSeriesOperator (n + 1) (p : R) correction)) ⧸
      LinearMap.range (preparedSeriesCyclicRelation (n + 1) p a correction commute)) ≃ₗ[R]
    K × (Fin n → K ⧸ coefficientScalarRange ((p : R) ^ a)))

end Litt3.Deformations.Specifications
