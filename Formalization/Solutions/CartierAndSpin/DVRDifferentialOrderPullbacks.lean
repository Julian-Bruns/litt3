import Solutions.SharedTensors.DVRDifferentialOrderIndependence
import Solutions.Jacobians.PrincipalPullbacks

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.Jacobians

section Nonzero

variable {k R S F E : Type*} [CommRing k] [CommRing R] [CommRing S]
  [Field F] [Field E]
  [Algebra k R] [Algebra k S] [Algebra k F] [Algebra k E]
  [Algebra R S] [Algebra R F] [Algebra R E] [Algebra S E] [Algebra F E]
  [IsScalarTower k R S] [IsScalarTower k R F] [IsScalarTower k R E]
  [IsScalarTower k S E] [IsScalarTower k F E]
  [IsScalarTower R S E] [IsScalarTower R F E]
  [Algebra.FormallyEtale R S] [Algebra.FormallyEtale R F] [Algebra.FormallyEtale S E]

include S in
/-- The literal universal differential pullback of a nonzero original
field form through a formally-etale coefficient square is nonzero.
Its genuine base-changed coordinate,
rather than a supplied compatible differential map, proves this. -/
theorem actual_formally_etale_differential_square_pullback_ne_zero
    (e : KaehlerDifferential k R ≃ₗ[R] R)
    (omega : KaehlerDifferential k F) (h : omega ≠ 0) :
    KaehlerDifferential.map k k F E omega ≠ 0 := by
  let eF := formallyEtaleDifferentialCoordinate (S := F) e
  let eE := formallyEtaleDifferentialCoordinate (S := E)
    (formallyEtaleDifferentialCoordinate (S := S) e)
  have hc : eF omega ≠ 0 := by
    intro he
    exact h (eF.injective (he.trans (map_zero eF).symm))
  intro he
  have hh := congrArg eE he
  rw [formally_etale_differential_coordinate_square, map_zero] at hh
  exact hc ((algebraMap F E).injective (hh.trans (map_zero (algebraMap F E)).symm))

end Nonzero

section Orders

variable {k R S F E : Type*} [CommRing k]
  [CommRing R] [IsDomain R] [IsDiscreteValuationRing R]
  [CommRing S] [IsDomain S] [IsDiscreteValuationRing S]
  [Field F] [Field E]
  [Algebra k R] [Algebra k S] [Algebra k F] [Algebra k E]
  [Algebra R S] [Algebra R F] [Algebra R E] [Algebra S E] [Algebra F E]
  [IsFractionRing R F] [IsFractionRing S E]
  [IsScalarTower k R S] [IsScalarTower k R F] [IsScalarTower k R E]
  [IsScalarTower k S E] [IsScalarTower k F E]
  [IsScalarTower R S E] [IsScalarTower R F E]
  [IsLocalHom (algebraMap R S)] [Algebra.EssFiniteType R S]
  [Algebra.FormallyEtale R S]

local instance pullbackOrderSourceFractionFormallyEtale : Algebra.FormallyEtale R F :=
  Algebra.FormallyEtale.of_isLocalization (nonZeroDivisors R)

local instance pullbackOrderTargetFractionFormallyEtale : Algebra.FormallyEtale S E :=
  Algebra.FormallyEtale.of_isLocalization (nonZeroDivisors S)

/-- Every original integral frame on each side gives the same normalized
order under a genuine formally-etale local DVR square. The integral
target frame is arbitrary: compatibility of the actual universal map
is derived by base change, and the frame change is an original unit. -/
theorem actual_unramified_differential_order_preserved
    (eR : KaehlerDifferential k R ≃ₗ[R] R)
    (eS : KaehlerDifferential k S ≃ₗ[S] S)
    (omega : KaehlerDifferential k F) (h : omega ≠ 0)
    (hmap : KaehlerDifferential.map k k F E omega ≠ 0) :
    actualDVRDifferentialOrder eS (KaehlerDifferential.map k k F E omega) hmap =
      actualDVRDifferentialOrder eR omega h := by
  let eRS := formallyEtaleDifferentialCoordinate (S := S) eR
  rw [actual_dvr_differential_order_independent eRS eS]
  let eF := formallyEtaleDifferentialCoordinate (S := F) eR
  let eE := formallyEtaleDifferentialCoordinate (S := E) eRS
  have hu : nonzeroLineCoordinateUnit eE (KaehlerDifferential.map k k F E omega) hmap =
      Units.map (algebraMap F E).toMonoidHom (nonzeroLineCoordinateUnit eF omega h) := by
    apply Units.ext
    exact formally_etale_differential_coordinate_square eR omega
  change valuationOrder ((discreteValuationPlace S).valuation E)
    (Additive.ofMul (nonzeroLineCoordinateUnit eE
      (KaehlerDifferential.map k k F E omega) hmap)) = _
  rw [hu]
  exact unramified_dvr_integer_order_preserved (algebraMap F E)
    (fun r => (IsScalarTower.algebraMap_apply R F E r).symm)
    (Additive.ofMul (nonzeroLineCoordinateUnit eF omega h))

end Orders

end Litt3.CartierAndSpin
