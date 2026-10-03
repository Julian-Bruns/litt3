import Solutions.QuotientGeometry.AffineChartFields
import Solutions.QuotientGeometry.ProperCurveIsomorphisms
import Solutions.QuotientGeometry.SchemeBaseFields

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

universe u

theorem affine_chart_field_equiv_over_base
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y] {K : Type u} [Field K]
    (sX : X ⟶ Spec (.of K)) (sY : Y ⟶ Spec (.of K))
    {U : X.Opens} {V : Y.Opens} (hU : IsAffineOpen U) (hV : IsAffineOpen V)
    [Nonempty U] [Nonempty V] (e : Γ(Y, V) ≃+* Γ(X, U))
    (he : e.toRingHom.comp (chartBaseFieldHom sY V) = chartBaseFieldHom sX U) :
    GenericFieldMapOver sX sY (affineChartFunctionFieldEquiv hU hV e).toRingHom := by
  apply (generic_field_map_over_iff_constants sX sY _).mpr
  ext a
  have hy := DFunLike.congr_fun (chart_base_field_hom_generic_compatibility sY V) a
  have hx := DFunLike.congr_fun (chart_base_field_hom_generic_compatibility sX U) a
  change algebraMap Γ(Y, V) Y.functionField (chartBaseFieldHom sY V a) =
    genericBaseFieldHom sY a at hy
  change algebraMap Γ(X, U) X.functionField (chartBaseFieldHom sX U a) =
    genericBaseFieldHom sX a at hx
  have hc := DFunLike.congr_fun he a
  change e (chartBaseFieldHom sY V a) = chartBaseFieldHom sX U a at hc
  change affineChartFunctionFieldEquiv hU hV e (genericBaseFieldHom sY a) =
    genericBaseFieldHom sX a
  rw [← hy, affine_chart_function_field_equiv_section, hc]
  exact hx

/-- A base-preserving isomorphism of genuine affine chart rings extends
to an actual isomorphism of their actual proper models. The model and
chart data are real Schemes and sections, not abstract curve labels. -/
theorem proper_curve_affine_chart_equiv_realized
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y] [X.IsSeparated] [Y.IsSeparated]
    {K : Type u} [Field K]
    (sX : X ⟶ Spec (.of K)) (sY : Y ⟶ Spec (.of K)) [IsProper sX] [IsProper sY]
    {U : X.Opens} {V : Y.Opens} (hU : IsAffineOpen U) (hV : IsAffineOpen V)
    [Nonempty U] [Nonempty V] (e : Γ(Y, V) ≃+* Γ(X, U))
    (he : e.toRingHom.comp (chartBaseFieldHom sY V) = chartBaseFieldHom sX U)
    (hvaluationX : ∀ x : X, ValuationRing (X.presheaf.stalk x))
    (hvaluationY : ∀ y : Y, ValuationRing (Y.presheaf.stalk y)) :
    ∃ i : X ≅ Y, i.hom ≫ sY = sX ∧ i.inv ≫ sX = sY ∧
      Litt3.SharedTensors.schemeFunctionFieldPullback i.hom =
        (affineChartFunctionFieldEquiv hU hV e).toRingHom ∧
      Litt3.SharedTensors.schemeFunctionFieldPullback i.inv =
        (affineChartFunctionFieldEquiv hU hV e).symm.toRingHom :=
  proper_curve_function_field_equiv_realized sX sY
    (affineChartFunctionFieldEquiv hU hV e)
    (affine_chart_field_equiv_over_base sX sY hU hV e he) hvaluationX hvaluationY

end Litt3.QuotientGeometry
