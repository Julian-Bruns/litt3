import Definitions.Deformations.FiniteShiftCokernel
import Definitions.Deformations.CoefficientSeriesSplitting

namespace Litt3.Deformations

variable {R K L : Type*} [CommRing R] [AddCommGroup K] [Module R K]
  [AddCommGroup L] [Module R L]

/-- The literal coefficientwise map between two different full series modules. -/
def coefficientSeriesLift (f : K →ₗ[R] L) :
    CoefficientSeries (K := K) →ₗ[R] CoefficientSeries (K := L) where
  toFun v n := f (v n)
  map_add' v w := funext (fun n => f.map_add (v n) (w n))
  map_smul' r v := funext (fun n => f.map_smul r (v n))

/-- Actual coefficient reduction by the original scalar-multiple submodule. -/
def scalarCoefficientReduction (scalar : R) :
    CoefficientSeries (K := K) →ₗ[R]
      CoefficientSeries (K := K ⧸ coefficientScalarRange (K := K) scalar) :=
  coefficientSeriesLift (coefficientScalarRange (K := K) scalar).mkQ

end Litt3.Deformations
