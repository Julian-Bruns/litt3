import Definitions.SharedTensors.DifferentialRatios
import Solutions.SharedTensors.SymmetricDifferentials
import Solutions.SharedTensors.SeparableKaehlerCoordinates

namespace Litt3.SharedTensors

variable {k K : Type*} [Field k] [Field K] [Algebra k K]

/-- Literal differential ratios are independent of the actual meromorphic
frame, even on the zero-denominator convention. -/
theorem rationalDifferentialRatio_independent
    (e e' : KaehlerDifferential k K ≃ₗ[K] K)
    (eta theta : KaehlerDifferential k K) :
    rationalDifferentialRatio e eta theta = rationalDifferentialRatio e' eta theta := by
  let c := e' (e.symm 1)
  have hc : c ≠ 0 := rank_one_coordinate_change_nonzero e e'
  unfold rationalDifferentialRatio
  rw [rank_one_coordinate_change e e' eta, rank_one_coordinate_change e e' theta]
  exact (mul_div_mul_left (e eta) (e theta) hc).symm

variable {L : Type*} [Field L] [Algebra k L] [Algebra K L]
  [IsScalarTower k K L] [Algebra.IsSeparable K L]

/-- Ratios transport through the actual universal differential map on
the actual full separable field inclusion. -/
theorem rationalDifferentialRatio_map
    (e : KaehlerDifferential k K ≃ₗ[K] K)
    (eta theta : KaehlerDifferential k K) :
    rationalDifferentialRatio (separableKaehlerCoordinate (L := L) e)
      (KaehlerDifferential.map k k K L eta)
      (KaehlerDifferential.map k k K L theta) =
      algebraMap K L (rationalDifferentialRatio e eta theta) := by
  unfold rationalDifferentialRatio
  rw [separableKaehlerCoordinate_map, separableKaehlerCoordinate_map, map_div₀]

end Litt3.SharedTensors
