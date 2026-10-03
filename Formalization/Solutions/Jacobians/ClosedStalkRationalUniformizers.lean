import Definitions.Jacobians.SchemeDivisors
import Solutions.Jacobians.ValuationDivisorClasses

open CategoryTheory AlgebraicGeometry TopologicalSpace
open scoped WithZero

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u}) [IsIntegral X] [ClosedPointDVRStalks X]

/-- The original generic point is not closed when all original closed
stalks are true DVRs: its actual stalk is the actual function FIELD. -/
theorem actual_generic_point_not_closed :
    ¬IsClosed ({genericPoint X} : Set X) := by
  intro h
  let x : Litt3.SharedTensors.ClosedPoint X := ⟨genericPoint X, h⟩
  haveI : IsDiscreteValuationRing X.functionField := ClosedPointDVRStalks.dvr_stalk x
  exact IsDiscreteValuationRing.not_isField X.functionField (Field.toIsField _)

/-- Every actual integer order at an ORIGINAL closed point is realized
by an ORIGINAL rational function, derived from its actual normalized DVR
uniformizer and the genuine integer-power/order homomorphism. -/
theorem actual_closed_point_rational_order_exists
    (x : Litt3.SharedTensors.ClosedPoint X) (n : ℤ) :
    ∃ f : X.functionFieldˣ, valuationOrder (closedPointValuation X x) (Additive.ofMul f) = n := by
  obtain ⟨pi, hpi⟩ :=
    (discreteValuationPlace (X.presheaf.stalk x.val)).valuation_exists_uniformizer X.functionField
  have hpi0 : pi ≠ 0 := (Valuation.ne_zero_iff (closedPointValuation X x)).mp
    (hpi.trans_ne WithZero.coe_ne_zero)
  let p : X.functionFieldˣ := Units.mk0 pi hpi0
  have hp : valuationOrder (closedPointValuation X x) (Additive.ofMul p) = 1 := by
    simpa only [neg_neg] using
      valuation_order_of_value_exp (closedPointValuation X x) (Additive.ofMul p) (-1) hpi
  refine ⟨p ^ n, ?_⟩
  change valuationOrder (closedPointValuation X x) (n • Additive.ofMul p) = n
  rw [map_zsmul, hp]
  simp

end Litt3.Jacobians
