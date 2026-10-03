import Definitions.CartierAndSpin.SchemeDifferentialZeros
import Solutions.CartierAndSpin.SmoothEtaleDifferentialRegularity
import Solutions.CartierAndSpin.UnramifiedDifferentialZeros

set_option maxHeartbeats 1000000
set_option synthInstance.maxHeartbeats 100000

open CategoryTheory AlgebraicGeometry

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.QuotientGeometry Litt3.Jacobians

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]

/-- Actual finite etale maps of smooth integral curves reflect and
preserve the genuine original m·Ω zero lattice at every original
closed source point, in ANY characteristic. No zero-set equality or
residue-fiber vanishing compatibility is supplied. -/
theorem actual_smooth_etale_rational_differential_zero_iff
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
    (sY : Y ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sY]
    (f : X ⟶ Y) [IsFinite f] [IsEtale f] [Surjective f]
    (hover : f ≫ sY = sX) (x : ClosedPoint X) :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := (genericBaseFieldHom sY).toAlgebra
    letI := (schemeFunctionFieldPullback f).toAlgebra
    letI := actualFunctionFieldBaseTower f sY sX hover
    ∀ omega : KaehlerDifferential k Y.functionField,
      x ∈ schemeDifferentialZeroSet sX
          (KaehlerDifferential.map k k Y.functionField X.functionField omega) ↔
        mapClosedPoint f x ∈ schemeDifferentialZeroSet sY omega := by
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
  change differentialZeroLattice (R := S)
      (KaehlerDifferential.map k k Y.functionField X.functionField omega) ↔
    differentialZeroLattice (R := R) omega
  exact actual_unramified_differential_zero_iff
    (actualSmoothCurveStalkDifferentialCoordinate sY (f x.val)) omega

/-- The genuine original zero set obeys literal pullback on an actual
finite etale map. Zero support is not assumed finite here. -/
theorem actual_smooth_etale_differential_zero_set_pullback
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
    (sY : Y ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sY]
    (f : X ⟶ Y) [IsFinite f] [IsEtale f] [Surjective f]
    (hover : f ≫ sY = sX) :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := (genericBaseFieldHom sY).toAlgebra
    letI := (schemeFunctionFieldPullback f).toAlgebra
    letI := actualFunctionFieldBaseTower f sY sX hover
    ∀ omega : KaehlerDifferential k Y.functionField,
      schemeDifferentialZeroSet sX
          (KaehlerDifferential.map k k Y.functionField X.functionField omega) =
        (mapClosedPoint f) ⁻¹' schemeDifferentialZeroSet sY omega := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := (genericBaseFieldHom sY).toAlgebra
  letI := (schemeFunctionFieldPullback f).toAlgebra
  letI := actualFunctionFieldBaseTower f sY sX hover
  intro omega
  ext x
  exact actual_smooth_etale_rational_differential_zero_iff sX sY f hover x omega

end Litt3.CartierAndSpin
