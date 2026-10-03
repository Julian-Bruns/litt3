import Solutions.CartierAndSpin.EtaleStalkDifferentials
import Solutions.CartierAndSpin.SmoothStalkDifferentialCoordinates
import Solutions.CartierAndSpin.UnramifiedDifferentialLattices
import Solutions.SharedTensors.SchemeRegularDifferentials
import Solutions.SharedTensors.SchemeFieldTowers
import Solutions.QuotientGeometry.SchemeStalkCoefficients

set_option maxHeartbeats 1000000
set_option synthInstance.maxHeartbeats 100000

open CategoryTheory AlgebraicGeometry

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.QuotientGeometry Litt3.Jacobians

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]

/-- An original finite etale map of actual smooth integral curves
reflects and preserves rational differential regularity at EVERY
original closed source point. All local rings, coordinates, DVRs,
valuation compatibility and universal-module base change are derived.
The entire statement is valid in arbitrary characteristic. -/
theorem actual_smooth_etale_rational_differential_regular_iff
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
    (sY : Y ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sY]
    (f : X ⟶ Y) [IsFinite f] [IsEtale f] [Surjective f]
    (hover : f ≫ sY = sX) (x : ClosedPoint X) :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := (genericBaseFieldHom sY).toAlgebra
    letI := (schemeFunctionFieldPullback f).toAlgebra
    letI := actualFunctionFieldBaseTower f sY sX hover
    ∀ omega : KaehlerDifferential k Y.functionField,
      KaehlerDifferential.map k k Y.functionField X.functionField omega ∈
          schemeLocalRegularDifferentials sX x.val ↔
        omega ∈ schemeLocalRegularDifferentials sY (f x.val) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := (genericBaseFieldHom sY).toAlgebra
  letI := (schemeFunctionFieldPullback f).toAlgebra
  letI := actualFunctionFieldBaseTower f sY sX hover
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
  intro omega
  change (∃ omegaS : KaehlerDifferential k S,
      KaehlerDifferential.map k k S X.functionField omegaS =
        KaehlerDifferential.map k k Y.functionField X.functionField omega) ↔
    (∃ omegaR : KaehlerDifferential k R,
      KaehlerDifferential.map k k R Y.functionField omegaR = omega)
  exact actual_unramified_differential_image_iff
    (actualSmoothCurveStalkDifferentialCoordinate sY (f x.val)) omega

end Litt3.CartierAndSpin
