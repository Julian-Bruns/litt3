import Solutions.SharedTensors.UnitDivisorGluing
import Solutions.SharedTensors.SchemeUnitQuotients
import Solutions.SharedTensors.ConstantPrincipalDivisors
import Solutions.SharedTensors.ConstantIntersection

open CategoryTheory AlgebraicGeometry

namespace Litt3.SharedTensors

open Litt3.Jacobians Litt3.QuotientGeometry
universe u

variable {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  [ClosedPointDVRStalks X] [ClosedPointDVRStalks Y]
  [FinitePrincipalSupport X] [FinitePrincipalSupport Y]
  (s : FiniteEtaleSpan X Y) [IsIntegral s.source]
  [ClosedPointDVRStalks s.source] [FinitePrincipalSupport s.source]

/-- The divisor presentation retains the actual two maps, actual generic
field units, and actual closed-point divisors of the original span. -/
noncomputable def FiniteEtaleSpan.divisorGluingSquare :=
  unitDivisorGluingSquare
    (schemeFunctionFieldPullback s.left) (schemeFunctionFieldPullback s.right)
    (schemeDivisorSystem X) (schemeDivisorSystem Y) (schemeDivisorSystem s.source)
    (mapClosedPoint s.left) (mapClosedPoint s.right)
    (mapClosedPoint_finite_preimage s.left) (mapClosedPoint_finite_preimage s.right)
    (scheme_principal_divisor_pullback s.left) (scheme_principal_divisor_pullback s.right)

theorem actual_same_source_divisor_gluing_range :
    s.divisorGluingSquare.gluingUnitClass.range = s.quotientPrincipalDivisorMap.ker :=
  DivisorGluingSquare.gluingUnitClass_range _

theorem actual_same_source_divisor_gluing_kernel :
    s.divisorGluingSquare.gluingUnitClass.ker =
      s.divisorGluingSquare.invariantDivisorClass.range :=
  DivisorGluingSquare.gluingUnitClass_kernel _

/-- The literal actual field-intersection hypothesis and genuine stalk
units prove injection of invariant divisor pairs. No Picard-kernel or
short-exact-sequence conclusion is assumed. -/
theorem actual_coreless_invariant_divisor_injection
    {K : Type u} [Field K]
    (sX : X ⟶ Spec (.of K)) (sY : Y ⟶ Spec (.of K))
    (h : EndpointFieldIntersectionConstants
      (genericBaseFieldHom sX) (genericBaseFieldHom sY)
      (schemeFunctionFieldPullback s.left) (schemeFunctionFieldPullback s.right)) :
    Function.Injective s.divisorGluingSquare.invariantDivisorClass := by
  apply DivisorGluingSquare.invariantDivisorClass_injective
  intro v hv
  have heq : rationalUnitPullback (schemeFunctionFieldPullback s.left) v.1 =
      rationalUnitPullback (schemeFunctionFieldPullback s.right) v.2 := sub_eq_zero.mp hv
  obtain ⟨c, hX, hY⟩ := endpoint_units_intersection_constants
    (genericBaseFieldHom sX) (genericBaseFieldHom sY)
    (schemeFunctionFieldPullback s.left) (schemeFunctionFieldPullback s.right) h v.1 v.2 heq
  apply Prod.ext
  · change principalDivisorMap (schemeDivisorSystem X) v.1 = 0
    rw [← hX]
    exact scheme_constant_principal_divisor_zero sX c
  · change principalDivisorMap (schemeDivisorSystem Y) v.2 = 0
    rw [← hY]
    exact scheme_constant_principal_divisor_zero sY c

end Litt3.SharedTensors
