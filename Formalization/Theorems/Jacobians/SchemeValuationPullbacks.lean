import Definitions.Jacobians.SchemeDivisors
import Definitions.Jacobians.PrincipalPullbacks
import Definitions.SharedTensors.SchemeFunctionFields

open CategoryTheory AlgebraicGeometry

namespace Litt3.Jacobians

universe u

/-- Principal-divisor compatibility for both original finite étale maps
from the SAME actual integral source. Actual closed-point DVRs and global
finite support are explicit remaining curve hypotheses. -/
def SameSourcePrincipalPullbacks
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    [ClosedPointDVRStalks X] [ClosedPointDVRStalks Y]
    [FinitePrincipalSupport X] [FinitePrincipalSupport Y]
    (s : Litt3.SharedTensors.FiniteEtaleSpan X Y)
    [IsIntegral s.source] [ClosedPointDVRStalks s.source] [FinitePrincipalSupport s.source] : Prop :=
  (∀ t : Additive X.functionFieldˣ,
    principalDivisorMap (schemeDivisorSystem s.source)
      (rationalUnitPullback s.leftFunctionField t) =
      Litt3.SharedTensors.schemeDivisorPullback s.left
        (principalDivisorMap (schemeDivisorSystem X) t)) ∧
  (∀ t : Additive Y.functionFieldˣ,
    principalDivisorMap (schemeDivisorSystem s.source)
      (rationalUnitPullback s.rightFunctionField t) =
      Litt3.SharedTensors.schemeDivisorPullback s.right
        (principalDivisorMap (schemeDivisorSystem Y) t))

end Litt3.Jacobians
