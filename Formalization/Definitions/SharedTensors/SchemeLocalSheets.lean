import Solutions.SharedTensors.FiniteFiberDivisorPushforward
import Definitions.Jacobians.SchemeDivisors
import Definitions.CartierAndSpin.FiniteRootPolynomial
import Definitions.SharedTensors.SchemeFunctionFields

open CategoryTheory AlgebraicGeometry
open scoped WithZero

namespace Litt3.SharedTensors

open Litt3.Jacobians Litt3.CartierAndSpin
universe u v

/-- Literal data of the completed unramified sheets above an actual closed
point. The completion/splitting existence theorem is a separate geometric
obligation. Actual field homomorphisms and their valuation compatibility
are recorded; a coefficient pole-bound conclusion is not an input. -/
structure SchemeLocalSheetFactorization
    {Z X : Scheme.{u}} [IsIntegral Z] [IsIntegral X]
    [ClosedPointDVRStalks Z] [ClosedPointDVRStalks X]
    (f : Z ⟶ X) [IsFinite f] [Surjective f] (x : ClosedPoint X)
    (chi : Z.functionField) (P : Polynomial X.functionField)
    (Ω : Type v) [Field Ω] where
  base : X.functionField →+* Ω
  sheet : PointFiber (mapClosedPoint f) x → Z.functionField →+* Ω
  valuation : Valuation Ω ℤᵐ⁰
  over_actual_map : ∀ z, (sheet z).comp (schemeFunctionFieldPullback f) = base
  base_valuation : ∀ a, valuation (base a) = closedPointValuation X x a
  sheet_valuation : ∀ z a, valuation (sheet z a) = closedPointValuation Z z.val a
  factorization :
    letI := closedPointFiberFintype f x
    P.map base = finiteRootPolynomial (fun z => sheet z chi)

end Litt3.SharedTensors
