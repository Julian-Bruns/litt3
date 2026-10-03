import Definitions.Deformations.PreparedCyclicLogNorm
import Definitions.Deformations.CoefficientSeriesSplitting
import Definitions.Deformations.NilpotentSeriesPreparation
import Definitions.Deformations.CommutingRangeQuotient

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

/-- The full original cyclic relation on actual coefficient series. -/
def formalCyclicRelation (p a : ℕ) : Module.End R (CoefficientSeries (K := K)) :=
  (1 + coefficientSeriesShift 1) ^ (p ^ a) - 1

/-- The full original norm on the same actual coefficient series. -/
def formalCyclicNorm (p a : ℕ) : Module.End R (CoefficientSeries (K := K)) :=
  integralCyclicNormValue (R := R) p a (coefficientSeriesShift 1)

/-- The literal distinguished operator after imposing the original
full cyclic relation. -/
def formalPreparedCyclicOperator (h p a : ℕ)
    (correction : Module.End R (CoefficientSeries (K := K)))
    (commute : Commute (formalCyclicRelation (R := R) (K := K) p a)
      (preparedSeriesOperator h (p : R) correction)) :
    Module.End R (CoefficientSeries (K := K) ⧸
      LinearMap.range (formalCyclicRelation (R := R) (K := K) p a)) :=
  commutingRangeQuotientEnd (formalCyclicRelation (R := R) (K := K) p a)
    (preparedSeriesOperator h (p : R) correction) commute

/-- The literal original constant coefficient in the full sequence module. -/
def coefficientSeriesConstant : K →ₗ[R] CoefficientSeries (K := K) where
  toFun eta n := if n = 0 then eta else 0
  map_add' eta theta := by
    funext n
    by_cases zero : n = 0 <;> simp [zero]
  map_smul' r eta := by
    funext n
    by_cases zero : n = 0 <;> simp [zero]

end Litt3.Deformations
