import Solutions.SharedTensors.IntegralLineCoordinateChanges
import Solutions.CartierAndSpin.FormallyEtaleDifferentialCoordinates

namespace Litt3.SharedTensors

open Litt3.CartierAndSpin

variable {k R S : Type*} [CommRing k] [CommRing R] [CommRing S]
  [Algebra k R] [Algebra k S] [Algebra R S] [IsScalarTower k R S]
  [Algebra.FormallyEtale R S]

/-- Entire original universal-module coordinates through ANY formally
étale algebra compare by the image of the derived ORIGINAL integral unit.
No field, DVR, nonzero-ring or compatible-frame premise is required. -/
theorem actual_formally_etale_differential_coordinate_change
    (e e' : KaehlerDifferential k R ≃ₗ[R] R)
    (omega : KaehlerDifferential k S) :
    formallyEtaleDifferentialCoordinate (S := S) e' omega =
      algebraMap R S (integralLineCoordinateChange e e' : R) *
        formallyEtaleDifferentialCoordinate (S := S) e omega := by
  let eS := formallyEtaleDifferentialCoordinate (S := S) e
  let eS' := formallyEtaleDifferentialCoordinate (S := S) e'
  let nu := KaehlerDifferential.map k k R S (e.symm 1)
  have hnu : eS nu = 1 := by
    rw [formally_etale_differential_coordinate_map]
    simp only [e.apply_symm_apply, map_one]
  have hform : omega = eS omega • nu := by
    apply eS.injective
    rw [map_smul, hnu, smul_eq_mul, mul_one]
  change eS' omega = _
  calc
    eS' omega = eS' (eS omega • nu) := congrArg eS' hform
    _ = eS omega * eS' nu := by rw [map_smul, smul_eq_mul]
    _ = eS omega * algebraMap R S (e' (e.symm 1)) := by
      rw [formally_etale_differential_coordinate_map]
    _ = algebraMap R S (integralLineCoordinateChange e e' : R) * eS omega := mul_comm _ _

end Litt3.SharedTensors
