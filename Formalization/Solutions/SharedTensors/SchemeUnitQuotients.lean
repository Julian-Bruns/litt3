import Definitions.SharedTensors.SchemeUnitQuotients
import Solutions.SharedTensors.MultiplicativeQuotients
import Solutions.Jacobians.SchemeValuationPullbacks

open AlgebraicGeometry

namespace Litt3.SharedTensors

open Litt3.Jacobians
universe u

variable {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  [ClosedPointDVRStalks X] [ClosedPointDVRStalks Y]
  [FinitePrincipalSupport X] [FinitePrincipalSupport Y]
  (s : FiniteEtaleSpan X Y) [IsIntegral s.source]
  [ClosedPointDVRStalks s.source] [FinitePrincipalSupport s.source]

/-- The genuine principal-divisor map from the original multiplicative
quotient, retaining both actual finite etale maps from the same source. -/
noncomputable def FiniteEtaleSpan.quotientPrincipalDivisorMap :
    s.unitRelationQuotient →+ s.divisorRelations :=
  Litt3.SharedTensors.quotientPrincipalDivisorMap
    (schemeFunctionFieldPullback s.left) (schemeFunctionFieldPullback s.right)
    (schemeDivisorSystem X) (schemeDivisorSystem Y) (schemeDivisorSystem s.source)
    (mapClosedPoint s.left) (mapClosedPoint s.right)
    (mapClosedPoint_finite_preimage s.left) (mapClosedPoint_finite_preimage s.right)
    (scheme_principal_divisor_pullback s.left) (scheme_principal_divisor_pullback s.right)

theorem actual_same_source_unit_quotient_kernel_saturated :
    KernelRootsSaturated s.quotientPrincipalDivisorMap :=
  actual_unit_quotient_principal_kernel_saturated
    (schemeFunctionFieldPullback s.left) (schemeFunctionFieldPullback s.right)
    (schemeDivisorSystem X) (schemeDivisorSystem Y) (schemeDivisorSystem s.source)
    (mapClosedPoint s.left) (mapClosedPoint s.right)
    (mapClosedPoint_finite_preimage s.left) (mapClosedPoint_finite_preimage s.right)
    (scheme_principal_divisor_pullback s.left) (scheme_principal_divisor_pullback s.right)

theorem actual_same_source_unit_quotient_principal_mk
    (u : Additive s.source.functionFieldˣ) :
    s.quotientPrincipalDivisorMap
      (QuotientAddGroup.mk' (unitRelationMap
        (schemeFunctionFieldPullback s.left) (schemeFunctionFieldPullback s.right)).range u) =
      QuotientAddGroup.mk' (divisorRelationMap
        (mapClosedPoint s.left) (mapClosedPoint s.right)
        (mapClosedPoint_finite_preimage s.left) (mapClosedPoint_finite_preimage s.right)).range
        (principalDivisorMap (schemeDivisorSystem s.source) u) := rfl

end Litt3.SharedTensors
