import Definitions.Deformations.NilpotentSeriesPreparation
import Mathlib.LinearAlgebra.Isomorphisms

namespace Litt3.Deformations.Specifications

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

/-- The actual distinguished operator is injective and its full
formal-series cokernel is precisely the low coefficient module. -/
def NilpotentSeriesQuotient (h : ℕ) (parameter : R)
    (correction : CoefficientSeries (K := K) →ₗ[R] CoefficientSeries (K := K)) : Prop :=
  Function.Injective (preparedSeriesOperator h parameter correction) ∧
    ∃ e : (CoefficientSeries (K := K) ⧸ LinearMap.range
      (preparedSeriesOperator h parameter correction)) ≃ₗ[R] (Fin h → K),
      ∀ r, e (Submodule.Quotient.mk (coefficientSeriesPrefixSection (R := R) h r)) = r

end Litt3.Deformations.Specifications
