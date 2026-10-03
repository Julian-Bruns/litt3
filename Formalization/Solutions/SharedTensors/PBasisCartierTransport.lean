import Solutions.SharedTensors.RationalCartierFormula
import Solutions.SharedTensors.FrobeniusCoordinateTransport

namespace Litt3.SharedTensors

variable {k K L : Type*} [CommRing k] [Field K] [Field L]
  [Algebra k K] [Algebra k L] [Algebra K L] [IsScalarTower k K L]
variable {p : ℕ} [Fact p.Prime] [CharP K p] [CharP L p]

/-- Two actual normalized rank-one universal differential coordinates
are compatible through the actual field map. No algebraicity or
separability of the field extension is required. -/
theorem normalized_differential_coordinates_map
    (t : K)
    (eK : KaehlerDifferential k K ≃ₗ[K] K)
    (eL : KaehlerDifferential k L ≃ₗ[L] L)
    (hK : eK (KaehlerDifferential.D k K t) = 1)
    (hL : eL (KaehlerDifferential.D k L (algebraMap K L t)) = 1)
    (omega : KaehlerDifferential k K) :
    eL (KaehlerDifferential.map k k K L omega) = algebraMap K L (eK omega) := by
  have hframe : omega = eK omega • KaehlerDifferential.D k K t := by
    apply eK.injective
    rw [map_smul, hK, smul_eq_mul, mul_one]
  calc
    _ = eL (KaehlerDifferential.map k k K L
        (eK omega • KaehlerDifferential.D k K t)) :=
      congrArg (fun w => eL (KaehlerDifferential.map k k K L w)) hframe
    _ = algebraMap K L (eK omega) *
        eL (KaehlerDifferential.D k L (algebraMap K L t)) := by
      rw [map_smul, KaehlerDifferential.map_D]
      change eL.toLinearMap
        (eK omega • KaehlerDifferential.D k L (algebraMap K L t)) = _
      rw [LinearMap.map_smul_of_tower eL.toLinearMap]
      rw [Algebra.smul_def]
      rfl
    _ = _ := by rw [hL, mul_one]

/-- Full compatible p-bases suffice for intrinsic Cartier transport
through an arbitrary actual field inclusion, including a completion
embedding that need not be algebraic. -/
theorem rational_cartier_compatible_p_basis_transport
    (CK : RationalCartierOperator k K p) (CL : RationalCartierOperator k L p)
    (bK : PowerPBasis K p) (bL : PowerPBasis L p)
    (hparameter : bL.parameter = algebraMap K L bK.parameter)
    (eK : KaehlerDifferential k K ≃ₗ[K] K)
    (eL : KaehlerDifferential k L ≃ₗ[L] L)
    (hK : eK (KaehlerDifferential.D k K bK.parameter) = 1)
    (hL : eL (KaehlerDifferential.D k L bL.parameter) = 1)
    (omega : KaehlerDifferential k K) :
    CL.toAddHom (KaehlerDifferential.map k k K L omega) =
      KaehlerDifferential.map k k K L (CK.toAddHom omega) := by
  have hL' : eL (KaehlerDifferential.D k L
      (algebraMap K L bK.parameter)) = 1 := by rwa [← hparameter]
  have hmap := normalized_differential_coordinates_map bK.parameter eK eL hK hL'
  apply eL.injective
  rw [CL.coordinate_formula bL eL hL, hmap, hmap,
    CK.coordinate_formula bK eK hK,
    rationalCartierCoefficient_map (algebraMap K L) bK bL hparameter]

end Litt3.SharedTensors
