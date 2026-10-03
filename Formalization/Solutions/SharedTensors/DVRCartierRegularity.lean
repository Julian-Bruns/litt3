import Solutions.SharedTensors.DVRIntrinsicCartier
import Solutions.SharedTensors.DVRCompletionRegularity
import Solutions.SharedTensors.PowerSeriesCartierCoefficients

namespace Litt3.SharedTensors

open Litt3.QuotientGeometry

variable {k R K : Type*} [Field k] [PerfectField k]
  [CommRing R] [IsDomain R] [IsDiscreteValuationRing R] [Algebra k R]
  [Field K] [Algebra R K] [IsFractionRing R K]
  [Algebra k K] [IsScalarTower k R K]
variable {p : ℕ} [Fact p.Prime] [CharP k p] [CharP K p]

/-- Intrinsic Cartier preserves the actual original DVR coefficient
lattice R dt, using the constructed completion and valuation compatibility.
The result concludes original regularity, not just completed regularity. -/
theorem actual_dvr_intrinsic_cartier_preserves_regular_lattice
    (d : DVRCompletionParameters k R)
    (hfg : IntermediateField.FG (F := k) (E := K) ⊤)
    (htrdeg : Algebra.trdeg k K = 1)
    (CK : RationalCartierOperator k K p) :
    ∃ eK : KaehlerDifferential k K ≃ₗ[K] K,
      eK (KaehlerDifferential.D k K (algebraMap R K d.parameter)) = 1 ∧
      ∀ omega : KaehlerDifferential k K,
        eK omega ∈ (algebraMap R K).range →
          eK (CK.toAddHom omega) ∈ (algebraMap R K).range := by
  obtain ⟨eK, heK, hformula⟩ := actual_dvr_intrinsic_cartier_coefficients d hfg htrdeg CK
  refine ⟨eK, heK, ?_⟩
  intro omega hregular
  obtain ⟨r, hr⟩ := hregular
  apply (actual_dvr_regular_iff_completed_power_series d _).mpr
  refine ⟨powerSeriesCartierCoordinate (p := p) (completedDVRStalkEmbedding d r), ?_⟩
  ext n
  rw [power_series_cartier_coordinate_laurent_coeff, hformula]
  rw [← hr, dvrFunctionFieldCompletion_ring]

end Litt3.SharedTensors
