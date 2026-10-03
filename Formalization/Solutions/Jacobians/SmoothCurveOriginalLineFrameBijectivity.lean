import Solutions.Jacobians.SmoothCurveOriginalLineDivisorMap
import Solutions.Jacobians.SmoothCurveOpenRegularity

open CategoryTheory Opposite AlgebraicGeometry
open scoped WithZero

namespace Litt3.Jacobians

universe u
variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] [QuasiCompact sX]
  (M : X.Modules) (hM : ActualOriginalLineSheaf X M)

/-- The constructed original line-to-divisor map is surjective on
the ENTIRE original section module of EVERY nonempty subopen of EVERY
genuine original frame. Dividing a literal O(D) rational section by the
derived generator produces an ORIGINAL structure section by the true
closed-stalk valuation/gluing criterion. -/
theorem actualSmoothCurveOriginalLineToDivisor_frame_app_surjective
    (U : X.Opens) [Nonempty U]
    (e : M.over U ≅ (SheafOfModules.unit X.ringCatSheaf).over U)
    (V : X.Opens) [Nonempty V] (i : V ⟶ U) :
    letI : ClosedPointDVRStalks X :=
      Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
    Function.Surjective ((actualSmoothCurveOriginalLineToDivisor sX M hM).val.app (op V)) := by
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  intro a
  let g := actualRationalFunctionOpenLinearEquiv X V a.val
  let f := actualOriginalLineFrameRationalGenerator X M hM U e
  have hf : f ≠ 0 := actualOriginalLineFrameRationalGenerator_ne_zero X M hM U e
  have hregular : ∀ (x : Litt3.SharedTensors.ClosedPoint X) (hx : x.val ∈ V),
      closedPointValuation X x (g / f) ≤ 1 := by
    intro x hx
    have hbound := a.property x hx
    change closedPointValuation X x
      (actualRationalFunctionEvaluation X V x.val hx a.val) ≤ _ at hbound
    rw [actualRationalFunctionEvaluation_eq_open] at hbound
    change closedPointValuation X x g ≤
      WithZero.exp (actualSmoothCurveOriginalLineDivisor sX M hM x) at hbound
    have hgen := actualSmoothCurveOriginalLineFrame_generator_valuation sX M hM U e x (i.le hx)
    change closedPointValuation X x f =
      WithZero.exp (actualSmoothCurveOriginalLineDivisor sX M hM x) at hgen
    rw [map_div₀, hgen]
    exact div_le_one_of_le₀ hbound bot_le
  obtain ⟨r, hr⟩ := (actual_smooth_curve_open_section_iff_closed_valuation sX V (g / f)).mpr
    hregular
  let E := actualOriginalLineFrameSectionEquiv X M U e V i
  refine ⟨E.symm r, ?_⟩
  apply Subtype.ext
  apply (actualRationalFunctionOpenLinearEquiv X V).injective
  change actualRationalFunctionOpenLinearEquiv X V
    (actualOriginalLineSheafRationalSectionMap X M hM V (E.symm r)) = g
  rw [actualOriginalLineSheafRationalSectionMap_field_value]
  rw [actualOriginalLineFrameRationalGenerator_apply_subopen X M hM U e V i]
  change algebraMap Γ(X, V) X.functionField (E (E.symm r)) * f = g
  rw [E.apply_symm_apply, hr]
  exact div_mul_cancel₀ g hf

/-- True original local frame maps are actual entire-section
bijections for the constructed line-to-divisor morphism. -/
theorem actualSmoothCurveOriginalLineToDivisor_frame_app_bijective
    (U : X.Opens) [Nonempty U]
    (e : M.over U ≅ (SheafOfModules.unit X.ringCatSheaf).over U)
    (V : X.Opens) [Nonempty V] (i : V ⟶ U) :
    letI : ClosedPointDVRStalks X :=
      Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
    Function.Bijective ((actualSmoothCurveOriginalLineToDivisor sX M hM).val.app (op V)) :=
  ⟨actualSmoothCurveOriginalLineToDivisor_app_injective sX M hM V,
    actualSmoothCurveOriginalLineToDivisor_frame_app_surjective sX M hM U e V i⟩

end Litt3.Jacobians
