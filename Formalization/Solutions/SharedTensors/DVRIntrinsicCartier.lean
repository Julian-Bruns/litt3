import Solutions.SharedTensors.LaurentUniformizerCartier
import Solutions.QuotientGeometry.DVRFunctionFieldDifferentials

namespace Litt3.SharedTensors

open Litt3.QuotientGeometry
open scoped LaurentSeries

variable {k R K : Type*} [Field k] [PerfectField k]
  [CommRing R] [IsDomain R] [IsDiscreteValuationRing R] [Algebra k R]
  [Field K] [Algebra R K] [IsFractionRing R K]
  [Algebra k K] [IsScalarTower k R K]
variable {p : ℕ} [Fact p.Prime] [CharP k p] [CharP K p]

/-- Intrinsic Cartier's full local coefficient formula through the
constructed actual DVR-to-completion field map. No completed chart,
field embedding, differential realization or separability of the
completion is supplied. -/
theorem actual_dvr_intrinsic_cartier_coefficients
    (d : DVRCompletionParameters k R)
    (hfg : IntermediateField.FG (F := k) (E := K) ⊤)
    (htrdeg : Algebra.trdeg k K = 1)
    (CK : RationalCartierOperator k K p) :
    ∃ eK : KaehlerDifferential k K ≃ₗ[K] K,
      eK (KaehlerDifferential.D k K (algebraMap R K d.parameter)) = 1 ∧
      ∀ omega n,
        (dvrFunctionFieldCompletion d (eK (CK.toAddHom omega))).coeff n =
          (frobeniusEquiv k p).symm
            ((dvrFunctionFieldCompletion d (eK omega)).coeff
              ((p : ℤ) * n + (p - 1 : ℕ))) := by
  letI : Algebra K (LaurentSeries k) := dvrFunctionFieldLaurentAlgebra (K := K) d
  have ht : algebraMap K (LaurentSeries k) (algebraMap R K d.parameter) =
      laurentParameter k := by
    change dvrFunctionFieldCompletion d (algebraMap R K d.parameter) = _
    rw [dvrFunctionFieldCompletion_parameter]
    exact HahnSeries.ofPowerSeries_X
  exact one_variable_cartier_laurent_uniformizer hfg htrdeg
    (algebraMap R K d.parameter) ht CK

end Litt3.SharedTensors
