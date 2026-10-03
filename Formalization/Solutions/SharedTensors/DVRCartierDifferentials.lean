import Solutions.SharedTensors.DVRRegularDifferentials
import Solutions.SharedTensors.DVRCartierRegularity

namespace Litt3.SharedTensors

open Litt3.QuotientGeometry

variable {k R K : Type*} [Field k] [PerfectField k]
  [CommRing R] [IsDomain R] [IsDiscreteValuationRing R] [Algebra k R]
  [Field K] [Algebra R K] [IsFractionRing R K]
  [Algebra k K] [IsScalarTower k R K]
variable {p : ℕ} [Fact p.Prime] [CharP k p] [CharP K p]

/-- Intrinsic Cartier preserves the image of the actual original universal
differential module in the rational module. No supplied lattice, local
differential frame or Cartier regularity assertion occurs in the inputs. -/
theorem actual_dvr_cartier_preserves_universal_differential_image
    (d : DVRCompletionParameters k R)
    (hfg : IntermediateField.FG (F := k) (E := K) ⊤)
    (htrdeg : Algebra.trdeg k K = 1)
    (CK : RationalCartierOperator k K p)
    (omega : KaehlerDifferential k K)
    (hregular : ∃ omegaR : KaehlerDifferential k R,
      KaehlerDifferential.map k k R K omegaR = omega) :
    ∃ omegaR : KaehlerDifferential k R,
      KaehlerDifferential.map k k R K omegaR = CK.toAddHom omega := by
  obtain ⟨eK, heK, hC⟩ := actual_dvr_intrinsic_cartier_preserves_regular_lattice
    d hfg htrdeg CK
  apply (actual_dvr_regular_differential_image_iff (p := p) d hfg htrdeg eK heK _).mpr
  apply hC omega
  exact (actual_dvr_regular_differential_image_iff (p := p) d hfg htrdeg eK heK _).mp hregular

end Litt3.SharedTensors
