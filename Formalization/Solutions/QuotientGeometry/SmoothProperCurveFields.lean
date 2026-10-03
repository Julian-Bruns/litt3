import Solutions.QuotientGeometry.ProperCurveIsomorphisms
import Solutions.QuotientGeometry.SchemeBaseFields
import Solutions.SharedTensors.SmoothCurvePointStrata

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.QuotientGeometry

open Litt3.SharedTensors

universe u

/-- Every actual smooth-curve stalk is a genuine valuation ring. Closed
points use the derived original DVR; the actual generic stalk is the
original function field. No affine cover or valuation premise is supplied. -/
theorem actual_smooth_curve_valuation_stalks
    {k : Type u} [Field k] [IsAlgClosed k]
    {X : Scheme.{u}} [IsIntegral X]
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
    (x : X) : ValuationRing (X.presheaf.stalk x) := by
  rcases actual_smooth_curve_point_closed_or_generic sX x with hclosed | hgeneric
  · let xc : ClosedPoint X := ⟨x, hclosed⟩
    letI : IsDiscreteValuationRing (X.presheaf.stalk x) :=
      actual_smooth_curve_closed_point_dvr sX xc
    infer_instance
  · subst x
    change ValuationRing X.functionField
    infer_instance

theorem scheme_separated_of_structure_over_field
    {k : Type u} [Field k] {X : Scheme.{u}}
    (sX : X ⟶ Spec (.of k)) [IsSeparated sX] : X.IsSeparated := by
  haveI : IsSeparated (sX ≫ Limits.terminal.from (Spec (.of k))) := inferInstance
  constructor
  simpa using (inferInstance : IsSeparated (sX ≫ Limits.terminal.from (Spec (.of k))))

/-- A TRUE base-field algebra embedding between the actual generic
stalks extends to an original proper surjective curve map. Smoothness
constructs all source valuation stalks, and the algebra embedding derives
the base diagram. The target need only be integral and proper. -/
theorem actual_proper_smooth_curve_field_embedding_realized
    {k : Type u} [Field k] [IsAlgClosed k]
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (sX : X ⟶ Spec (.of k)) (sY : Y ⟶ Spec (.of k))
    [IsSmoothOfRelativeDimension 1 sX] [IsProper sX] [IsProper sY] :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := (genericBaseFieldHom sY).toAlgebra
    ∀ φ : Y.functionField →ₐ[k] X.functionField,
      ∃ (f : X ⟶ Y) (_ : Surjective f), f ≫ sY = sX ∧ IsProper f ∧
        schemeFunctionFieldPullback f = φ.toRingHom := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := (genericBaseFieldHom sY).toAlgebra
  letI : Y.IsSeparated := scheme_separated_of_structure_over_field sY
  intro φ
  have hφ : GenericFieldMapOver sX sY φ.toRingHom := by
    apply (generic_field_map_over_iff_constants sX sY φ.toRingHom).mpr
    ext a
    exact φ.commutes a
  exact proper_curve_field_embedding_realized sX sY φ.toRingHom hφ
    (actual_smooth_curve_valuation_stalks sX)

/-- A TRUE constant-field algebra equivalence extends to an actual
isomorphism between the original proper smooth curves. Both actual
original maps, both base diagrams and both function-field pullbacks are
retained; no valuation charts or abstract curve models are supplied. -/
theorem actual_proper_smooth_curve_function_field_equiv_realized
    {k : Type u} [Field k] [IsAlgClosed k]
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (sX : X ⟶ Spec (.of k)) (sY : Y ⟶ Spec (.of k))
    [IsSmoothOfRelativeDimension 1 sX] [IsSmoothOfRelativeDimension 1 sY]
    [IsProper sX] [IsProper sY] :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := (genericBaseFieldHom sY).toAlgebra
    ∀ e : Y.functionField ≃ₐ[k] X.functionField,
      ∃ i : X ≅ Y, i.hom ≫ sY = sX ∧ i.inv ≫ sX = sY ∧
        schemeFunctionFieldPullback i.hom = e.toRingEquiv.toRingHom ∧
        schemeFunctionFieldPullback i.inv = e.symm.toRingEquiv.toRingHom := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := (genericBaseFieldHom sY).toAlgebra
  letI : X.IsSeparated := scheme_separated_of_structure_over_field sX
  letI : Y.IsSeparated := scheme_separated_of_structure_over_field sY
  intro e
  have he : GenericFieldMapOver sX sY e.toRingEquiv.toRingHom := by
    apply (generic_field_map_over_iff_constants sX sY e.toRingEquiv.toRingHom).mpr
    ext a
    exact e.commutes a
  exact proper_curve_function_field_equiv_realized sX sY e.toRingEquiv he
    (actual_smooth_curve_valuation_stalks sX) (actual_smooth_curve_valuation_stalks sY)

end Litt3.QuotientGeometry
