import Solutions.CartierAndSpin.DVRDifferentialOrderPullbacks
import Solutions.CartierAndSpin.SmoothEtaleDifferentialRegularity
import Solutions.SharedTensors.SmoothCurveDifferentialOrderCalculus
import Solutions.SharedTensors.RationalDifferentialDivisors
import Solutions.SharedTensors.SmoothSchemeDifferentials
import Mathlib.RingTheory.Etale.Field

set_option maxHeartbeats 1000000
set_option synthInstance.maxHeartbeats 100000

open CategoryTheory AlgebraicGeometry

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.QuotientGeometry Litt3.Jacobians

universe u

variable {k : Type u} [Field k]
  {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  (sX : X ⟶ Spec (.of k))
  (sY : Y ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sY]
  (f : X ⟶ Y) [IsFinite f] [IsEtale f] [Surjective f]
  (hover : f ≫ sY = sX)

/-- The original rational universal-differential pullback through an
actual finite etale curve map is injective. Its field separability and
original generic rank-one coordinate are derived from the morphisms. -/
theorem actual_smooth_etale_rational_differential_pullback_injective :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := (genericBaseFieldHom sY).toAlgebra
    letI := (schemeFunctionFieldPullback f).toAlgebra
    letI := actualFunctionFieldBaseTower f sY sX hover
    Function.Injective (KaehlerDifferential.map k k Y.functionField X.functionField) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := (genericBaseFieldHom sY).toAlgebra
  letI := (schemeFunctionFieldPullback f).toAlgebra
  letI := actualFunctionFieldBaseTower f sY sX hover
  letI : Algebra.IsSeparable Y.functionField X.functionField :=
    (actual_unramified_function_field_finite_separable f).2
  letI : Algebra.FormallyEtale Y.functionField X.functionField :=
    Algebra.FormallyEtale.of_isSeparable Y.functionField X.functionField
  let eY := actualSmoothCurveKaehlerCoordinate sY
  let eX := formallyEtaleDifferentialCoordinate (S := X.functionField) eY
  intro a b hab
  have hcoord := congrArg eX hab
  rw [formally_etale_differential_coordinate_map,
    formally_etale_differential_coordinate_map] at hcoord
  exact eY.injective ((algebraMap Y.functionField X.functionField).injective hcoord)

theorem actual_smooth_etale_rational_differential_pullback_ne_zero :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := (genericBaseFieldHom sY).toAlgebra
    letI := (schemeFunctionFieldPullback f).toAlgebra
    letI := actualFunctionFieldBaseTower f sY sX hover
    ∀ (omega : KaehlerDifferential k Y.functionField), omega ≠ 0 →
      KaehlerDifferential.map k k Y.functionField X.functionField omega ≠ 0 := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := (genericBaseFieldHom sY).toAlgebra
  letI := (schemeFunctionFieldPullback f).toAlgebra
  letI := actualFunctionFieldBaseTower f sY sX hover
  intro omega h he
  exact h ((actual_smooth_etale_rational_differential_pullback_injective
    sX sY f hover) (he.trans (map_zero (KaehlerDifferential.map k k
      Y.functionField X.functionField)).symm))

variable [IsAlgClosed k] [IsSmoothOfRelativeDimension 1 sX]

/-- An actual finite etale map preserves the full integer order of
every original rational differential at every closed source point.
The original stalk square, compatible base-changed frame and frame
independence are derived, without any assumed order compatibility. -/
theorem actual_smooth_etale_rational_differential_order_preserved :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := (genericBaseFieldHom sY).toAlgebra
    letI := (schemeFunctionFieldPullback f).toAlgebra
    letI := actualFunctionFieldBaseTower f sY sX hover
    ∀ (omega : KaehlerDifferential k Y.functionField) (h : omega ≠ 0)
      (hmap : KaehlerDifferential.map k k Y.functionField X.functionField omega ≠ 0)
      (x : ClosedPoint X),
      smoothCurveRationalDifferentialOrder sX
          (KaehlerDifferential.map k k Y.functionField X.functionField omega) hmap x =
        smoothCurveRationalDifferentialOrder sY omega h (mapClosedPoint f x) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := (genericBaseFieldHom sY).toAlgebra
  letI := (schemeFunctionFieldPullback f).toAlgebra
  letI := actualFunctionFieldBaseTower f sY sX hover
  intro omega h hmap x
  let R := Y.presheaf.stalk (f x.val)
  let S := X.presheaf.stalk x.val
  letI := (stalkBaseFieldHom sY (f x.val)).toAlgebra
  letI := (stalkBaseFieldHom sX x.val).toAlgebra
  letI : IsDiscreteValuationRing R :=
    actual_smooth_curve_closed_point_dvr sY (mapClosedPoint f x)
  letI : IsDiscreteValuationRing S := actual_smooth_curve_closed_point_dvr sX x
  letI : Algebra R S := (f.stalkMap x.val).hom.toAlgebra
  letI : Algebra R X.functionField :=
    ((algebraMap S X.functionField).comp (f.stalkMap x.val).hom).toAlgebra
  letI : IsScalarTower R S X.functionField := IsScalarTower.of_algebraMap_eq' rfl
  letI : IsScalarTower R Y.functionField X.functionField :=
    IsScalarTower.of_algebraMap_eq fun a =>
      (scheme_function_field_pullback_stalk f x.val a).symm
  letI : IsScalarTower k R S :=
    IsScalarTower.of_algHom (actualSchemeStalkAlgHom f sX sY hover x.val)
  letI : IsScalarTower k R Y.functionField :=
    IsScalarTower.of_algebraMap_eq' (stalk_base_field_generic_compatibility sY (f x.val)).symm
  letI : IsScalarTower k S X.functionField :=
    IsScalarTower.of_algebraMap_eq' (stalk_base_field_generic_compatibility sX x.val).symm
  letI : IsScalarTower k R X.functionField :=
    IsScalarTower.of_algebraMap_eq fun c => by
      rw [IsScalarTower.algebraMap_apply k S X.functionField]
      change algebraMap S X.functionField (algebraMap k S c) =
        algebraMap S X.functionField (algebraMap R S (algebraMap k R c))
      rw [← IsScalarTower.algebraMap_apply k R S]
  letI : IsLocalHom (algebraMap R S) := f.toLRSHom.prop x.val
  letI : Algebra.EssFiniteType R S := scheme_stalk_map_essFiniteType f x.val
  letI : Algebra.FormallyEtale R S := actual_etale_stalk_algebra_formallyEtale f x.val
  exact actual_unramified_differential_order_preserved
    (actualSmoothCurveStalkDifferentialCoordinate sY (f x.val))
    (actualSmoothCurveStalkDifferentialCoordinate sX x.val) omega h hmap

/-- The true finite divisor of the actual pulled differential is the
literal finite-fiber pullback of its true original differential divisor.
Both supports are derived; no canonical divisor degree is asserted. -/
theorem actual_smooth_etale_rational_differential_divisor_pullback
    [CompactSpace X] [CompactSpace Y] :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := (genericBaseFieldHom sY).toAlgebra
    letI := (schemeFunctionFieldPullback f).toAlgebra
    letI := actualFunctionFieldBaseTower f sY sX hover
    ∀ (omega : KaehlerDifferential k Y.functionField) (h : omega ≠ 0),
      actualRationalDifferentialDivisor sX
          (KaehlerDifferential.map k k Y.functionField X.functionField omega)
          (actual_smooth_etale_rational_differential_pullback_ne_zero sX sY f hover omega h) =
        schemeDivisorPullback f (actualRationalDifferentialDivisor sY omega h) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := (genericBaseFieldHom sY).toAlgebra
  letI := (schemeFunctionFieldPullback f).toAlgebra
  letI := actualFunctionFieldBaseTower f sY sX hover
  intro omega h
  ext x
  change smoothCurveRationalDifferentialOrder sX
      (KaehlerDifferential.map k k Y.functionField X.functionField omega) _ x =
    smoothCurveRationalDifferentialOrder sY omega h (mapClosedPoint f x)
  exact actual_smooth_etale_rational_differential_order_preserved sX sY f hover omega h _ x

end Litt3.CartierAndSpin
