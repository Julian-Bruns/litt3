import Solutions.Jacobians.OriginalOpenFunctionRegularity
import Solutions.Jacobians.SchemeSectionValuationBounds
import Solutions.SharedTensors.SmoothCurvePointStrata
import Solutions.SharedTensors.DVRCompletionRegularity

open CategoryTheory AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable {X : Scheme.{u}} [IsIntegral X] [ClosedPointDVRStalks X]

/-- True normalized valuation at an original closed DVR stalk detects
membership in that ORIGINAL stalk, not in a supplied completion model. -/
theorem actual_closed_stalk_regular_iff_value_le_one
    (x : Litt3.SharedTensors.ClosedPoint X) (f : X.functionField) :
    (∃ r : X.presheaf.stalk x.val,
      algebraMap (X.presheaf.stalk x.val) X.functionField r = f) ↔
        closedPointValuation X x f ≤ 1 := by
  constructor
  · rintro ⟨r, rfl⟩
    exact (discreteValuationPlace (X.presheaf.stalk x.val)).valuation_le_one r
  · intro h
    apply IsDedekindDomain.HeightOneSpectrum.mem_integers_of_valuation_le_one
    intro v
    rw [Litt3.SharedTensors.dvr_height_one_place_unique v]
    exact h

variable {k : Type u} [Field k] [IsAlgClosed k]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]

include sX

/-- On every nonempty ORIGINAL open of a true smooth curve, the
original section image consists precisely of rational functions integral
at its original closed points. All point strata and all original sheaf
gluing are derived; no section-surjectivity input is supplied. -/
theorem actual_smooth_curve_open_section_iff_closed_valuation
    (U : X.Opens) [Nonempty U] (f : X.functionField) :
    (∃ a : Γ(X, U), algebraMap Γ(X, U) X.functionField a = f) ↔
      ∀ (x : Litt3.SharedTensors.ClosedPoint X) (hx : x.val ∈ U),
        closedPointValuation X x f ≤ 1 := by
  constructor
  · rintro ⟨a, rfl⟩ x hx
    exact actual_section_function_field_valuation_le_one X U a x hx
  · intro h
    apply (actual_function_field_regular_on_open_iff_section U f).mp
    rintro ⟨x, hx⟩
    rcases Litt3.SharedTensors.actual_smooth_curve_point_closed_or_generic sX x with hc | hg
    · exact (actual_closed_stalk_regular_iff_value_le_one ⟨x, hc⟩ f).mpr (h ⟨x, hc⟩ hx)
    · subst x
      refine ⟨f, ?_⟩
      change (X.presheaf.stalkSpecializes
        ((genericPoint_spec X).specializes trivial)).hom f = f
      rw [X.presheaf.stalkSpecializes_refl]
      rfl

end Litt3.Jacobians
