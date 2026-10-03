import Solutions.SharedTensors.RationalCartierFormula
import Solutions.SharedTensors.FrobeniusCoordinateTransport
import Solutions.SharedTensors.SeparableKaehlerCoordinates

namespace Litt3.SharedTensors

variable {k K L : Type*} [Field k] [Field K] [Field L]
  [Algebra k K] [Algebra k L] [Algebra K L] [IsScalarTower k K L]
  [Algebra.IsSeparable K L]
variable {p : ℕ} [Fact p.Prime] [CharP K p] [CharP L p]

/-- Intrinsic Cartier commutes with a genuine full separable field
inclusion, derived from its standard characterization and literal full
p-bases on the same actual parameter. -/
theorem rational_cartier_separable_base_change
    (CK : RationalCartierOperator k K p) (CL : RationalCartierOperator k L p)
    (bK : PowerPBasis K p) (bL : PowerPBasis L p)
    (hparameter : bL.parameter = algebraMap K L bK.parameter)
    (e : KaehlerDifferential k K ≃ₗ[K] K)
    (hnormalized : e (KaehlerDifferential.D k K bK.parameter) = 1)
    (omega : KaehlerDifferential k K) :
    CL.toAddHom (KaehlerDifferential.map k k K L omega) =
      KaehlerDifferential.map k k K L (CK.toAddHom omega) := by
  let eL := separableKaehlerCoordinate (L := L) e
  have hL : eL (KaehlerDifferential.D k L bL.parameter) = 1 := by
    rw [hparameter, ← KaehlerDifferential.map_D k k K L]
    change separableKaehlerCoordinate e
      (KaehlerDifferential.map k k K L (KaehlerDifferential.D k K bK.parameter)) = 1
    rw [separableKaehlerCoordinate_map, hnormalized, map_one]
  apply eL.injective
  rw [CL.coordinate_formula bL eL hL]
  change rationalCartierCoefficient L p bL
    (separableKaehlerCoordinate e (KaehlerDifferential.map k k K L omega)) =
    separableKaehlerCoordinate e
      (KaehlerDifferential.map k k K L (CK.toAddHom omega))
  rw [separableKaehlerCoordinate_map, separableKaehlerCoordinate_map,
    CK.coordinate_formula bK e hnormalized,
    rationalCartierCoefficient_map (algebraMap K L) bK bL hparameter]

end Litt3.SharedTensors
