import Definitions.Jacobians.DVRDivisors
import Definitions.SharedTensors.SchemeDivisors
import Mathlib.AlgebraicGeometry.FunctionField

namespace Litt3.Jacobians

open AlgebraicGeometry
open scoped WithZero

universe u

/-- An explicit local regularity condition on actual closed-point stalks.
Its derivation from the usual smooth proper curve hypotheses is a remaining
geometric bridge. The generic stalk is not incorrectly required to be a DVR. -/
class ClosedPointDVRStalks (X : Scheme.{u}) [IsIntegral X] : Prop where
  dvr_stalk (x : Litt3.SharedTensors.ClosedPoint X) :
    IsDiscreteValuationRing (X.presheaf.stalk x.val)

attribute [instance] ClosedPointDVRStalks.dvr_stalk

noncomputable def closedPointValuation
    (X : Scheme.{u}) [IsIntegral X] [ClosedPointDVRStalks X]
    (x : Litt3.SharedTensors.ClosedPoint X) : Valuation X.functionField ℤᵐ⁰ :=
  (discreteValuationPlace (X.presheaf.stalk x.val)).valuation X.functionField

/-- Finiteness of principal-divisor support is a global obligation, separate
from the proved local unramified valuation compatibility. -/
class FinitePrincipalSupport (X : Scheme.{u}) [IsIntegral X] [ClosedPointDVRStalks X] : Prop where
  finite_support (f : Additive X.functionFieldˣ) :
    (Function.support (fun x => valuationOrder (closedPointValuation X x) f)).Finite

noncomputable def schemeDivisorSystem
    (X : Scheme.{u}) [IsIntegral X] [ClosedPointDVRStalks X] [FinitePrincipalSupport X] :
    ValuationDivisorSystem X.functionField (Litt3.SharedTensors.ClosedPoint X) where
  valuation := closedPointValuation X
  finite_support := FinitePrincipalSupport.finite_support

end Litt3.Jacobians
