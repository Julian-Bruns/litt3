import Definitions.Jacobians.ValuationDivisors
import Definitions.Jacobians.PrincipalPullbacks
import Solutions.Jacobians.UnramifiedDVRPullbacks
import Solutions.QuotientGeometry.SchemeBaseFields
import Definitions.Jacobians.SchemeDivisors

open CategoryTheory AlgebraicGeometry TopologicalSpace
open scoped WithZero

namespace Litt3.SharedTensors

open Litt3.Jacobians Litt3.QuotientGeometry
universe u

theorem valuationOrder_eq_zero_of_value_one
    {K : Type*} [Field K] (v : Valuation K ℤᵐ⁰) (a : Additive Kˣ)
    (h : v a.toMul.val = 1) : valuationOrder v a = 0 := by
  have hu : Units.map v.toMonoidWithZeroHom.toMonoidHom a.toMul = 1 := Units.ext h
  change -(WithZero.unitsWithZeroEquiv
    (Units.map v.toMonoidWithZeroHom.toMonoidHom a.toMul)).toAdd = 0
  rw [hu, map_one]
  rfl

/-- The actual base map lands in every actual stalk through global sections. -/
noncomputable def stalkBaseFieldHom
    {X : Scheme.{u}} {K : Type u} [Field K]
    (sX : X ⟶ Spec (.of K)) (x : X) : K →+* X.presheaf.stalk x :=
  ((Scheme.ΓSpecIso (.of K)).inv ≫ sX.appTop ≫ X.presheaf.germ ⊤ x trivial).hom

theorem stalk_base_field_generic_compatibility
    {X : Scheme.{u}} [IsIntegral X] {K : Type u} [Field K]
    (sX : X ⟶ Spec (.of K)) (x : X) :
    (algebraMap (X.presheaf.stalk x) X.functionField).comp (stalkBaseFieldHom sX x) =
      genericBaseFieldHom sX := by
  rw [generic_base_field_hom_eq_germ]
  change ((Scheme.ΓSpecIso (.of K)).inv ≫ sX.appTop ≫
    X.presheaf.germ ⊤ x trivial ≫
    X.presheaf.stalkSpecializes ((genericPoint_spec X).specializes trivial)).hom = _
  rw [X.presheaf.germ_stalkSpecializes]

/-- Nonzero constants are actual units of each DVR stalk, hence have
zero normalized order. Properness and algebraic closedness are unnecessary. -/
theorem scheme_constant_valuation_one
    {X : Scheme.{u}} [IsIntegral X] [ClosedPointDVRStalks X]
    {K : Type u} [Field K] (sX : X ⟶ Spec (.of K))
    (x : ClosedPoint X) (a : Kˣ) :
    closedPointValuation X x (genericBaseFieldHom sX a.val) = 1 := by
  have heq := DFunLike.congr_fun (stalk_base_field_generic_compatibility sX x.val) a.val
  rw [← heq]
  change (discreteValuationPlace (X.presheaf.stalk x.val)).valuation X.functionField
    (algebraMap (X.presheaf.stalk x.val) X.functionField (stalkBaseFieldHom sX x.val a.val)) = 1
  rw [IsDedekindDomain.HeightOneSpectrum.valuation_of_algebraMap]
  exact dvr_unit_adic_value_one (a.map (stalkBaseFieldHom sX x.val).toMonoidHom)

theorem scheme_constant_principal_divisor_zero
    {X : Scheme.{u}} [IsIntegral X] [ClosedPointDVRStalks X] [FinitePrincipalSupport X]
    {K : Type u} [Field K] (sX : X ⟶ Spec (.of K)) (a : Additive Kˣ) :
    principalDivisorMap (schemeDivisorSystem X) (rationalUnitPullback (genericBaseFieldHom sX) a) = 0 := by
  ext x
  apply valuationOrder_eq_zero_of_value_one
  exact scheme_constant_valuation_one sX x a.toMul

end Litt3.SharedTensors
