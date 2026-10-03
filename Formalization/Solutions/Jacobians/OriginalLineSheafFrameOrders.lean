import Solutions.Jacobians.OriginalLineSheafPointFrames
import Solutions.Jacobians.SchemeOriginalUnitValuations
import Solutions.SharedTensors.DivisorSectionOrders

open CategoryTheory AlgebraicGeometry
open scoped WithZero

namespace Litt3.Jacobians

universe u

/-- The true integer order of a nonzero field element depends only
on its actual valuation value. -/
theorem actual_valuation_order_eq_of_value_eq
    {K : Type*} [Field K] (v : Valuation K ℤᵐ⁰) (a b : Kˣ)
    (h : v a.val = v b.val) :
    valuationOrder v (Additive.ofMul a) = valuationOrder v (Additive.ofMul b) := by
  have he := congrArg WithZero.log h
  have ha : v a.val = WithZero.exp (-valuationOrder v (Additive.ofMul a)) :=
    Litt3.SharedTensors.valuation_value_eq_exp_neg_order v (Additive.ofMul a)
  have hb : v b.val = WithZero.exp (-valuationOrder v (Additive.ofMul b)) :=
    Litt3.SharedTensors.valuation_value_eq_exp_neg_order v (Additive.ofMul b)
  rw [ha, hb, WithZero.log_exp, WithZero.log_exp] at he
  exact neg_injective he

variable (X : Scheme.{u}) [IsIntegral X] [ClosedPointDVRStalks X]
  (M : X.Modules) (hM : ActualOriginalLineSheaf X M)

/-- The true closed-stalk orders of rational generators of ANY TWO
original line frames agree on their actual common neighborhood. This is
derived from the actual original unit transition, not a supplied order
compatibility hypothesis. -/
theorem actualOriginalLineFrameRationalGenerator_order_eq
    (U W : X.Opens) [Nonempty U] [Nonempty W]
    (e : M.over U ≅ (SheafOfModules.unit X.ringCatSheaf).over U)
    (f : M.over W ≅ (SheafOfModules.unit X.ringCatSheaf).over W)
    (x : Litt3.SharedTensors.ClosedPoint X) (hxU : x.val ∈ U) (hxW : x.val ∈ W) :
    valuationOrder (closedPointValuation X x)
      (Additive.ofMul (Units.mk0 (actualOriginalLineFrameRationalGenerator X M hM U e)
        (actualOriginalLineFrameRationalGenerator_ne_zero X M hM U e))) =
    valuationOrder (closedPointValuation X x)
      (Additive.ofMul (Units.mk0 (actualOriginalLineFrameRationalGenerator X M hM W f)
        (actualOriginalLineFrameRationalGenerator_ne_zero X M hM W f))) := by
  let V := U ⊓ W
  letI : Nonempty V := ⟨⟨x.val, hxU, hxW⟩⟩
  obtain ⟨c, hc⟩ := actualOriginalLineFrameRationalGenerator_transition X M hM U W V e f
    (homOfLE inf_le_left) (homOfLE inf_le_right)
  apply actual_valuation_order_eq_of_value_eq
  change closedPointValuation X x (actualOriginalLineFrameRationalGenerator X M hM U e) =
    closedPointValuation X x (actualOriginalLineFrameRationalGenerator X M hM W f)
  rw [hc, map_mul, actual_original_open_unit_valuation_one X V c x ⟨hxU, hxW⟩,
    one_mul]

/-- The chosen point-frame order is the true order of EVERY genuine
original frame containing that point. -/
theorem actualOriginalLinePointRationalUnit_order_eq_frame
    (x : Litt3.SharedTensors.ClosedPoint X)
    (U : X.Opens) [Nonempty U]
    (e : M.over U ≅ (SheafOfModules.unit X.ringCatSheaf).over U) (hx : x.val ∈ U) :
    valuationOrder (closedPointValuation X x)
      (Additive.ofMul (actualOriginalLinePointRationalUnit X M hM x.val)) =
    valuationOrder (closedPointValuation X x)
      (Additive.ofMul (Units.mk0 (actualOriginalLineFrameRationalGenerator X M hM U e)
        (actualOriginalLineFrameRationalGenerator_ne_zero X M hM U e))) := by
  letI := actualOriginalLinePointOpen_nonempty X M hM x.val
  exact actualOriginalLineFrameRationalGenerator_order_eq X M hM
    (actualOriginalLinePointOpen X M hM x.val) U
    (actualOriginalLinePointFrame X M hM x.val) e x
    (actualOriginalLinePointOpen_contains X M hM x.val) hx

end Litt3.Jacobians
