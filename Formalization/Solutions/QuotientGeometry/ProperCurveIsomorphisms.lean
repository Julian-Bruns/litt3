import Solutions.QuotientGeometry.ProperCurveFieldRecovery
import Solutions.QuotientGeometry.FunctionFieldIsomorphisms

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

universe u

/-- A base-compatible actual function-field isomorphism extends to an
actual isomorphism of the two proper integral Schemes with valuation
stalks. Both actual base diagrams and both actual field maps are retained. -/
theorem proper_curve_function_field_equiv_realized
    {X Y S : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    [X.IsSeparated] [Y.IsSeparated] [S.IsSeparated]
    (sX : X ⟶ S) (sY : Y ⟶ S) [IsProper sX] [IsProper sY]
    (e : Y.functionField ≃+* X.functionField) (he : GenericFieldMapOver sX sY e.toRingHom)
    (hvaluationX : ∀ x : X, ValuationRing (X.presheaf.stalk x))
    (hvaluationY : ∀ y : Y, ValuationRing (Y.presheaf.stalk y)) :
    ∃ i : X ≅ Y, i.hom ≫ sY = sX ∧ i.inv ≫ sX = sY ∧
      Litt3.SharedTensors.schemeFunctionFieldPullback i.hom = e.toRingHom ∧
      Litt3.SharedTensors.schemeFunctionFieldPullback i.inv = e.symm.toRingHom := by
  obtain ⟨f, hsurjf, hf⟩ := proper_curve_field_embedding_realized sX sY e.toRingHom he hvaluationX
  obtain ⟨g, hsurjg, hg⟩ := proper_curve_field_embedding_realized sY sX e.symm.toRingHom
    (function_field_equiv_inverse_over_base sX sY e he) hvaluationY
  letI : Surjective f := hsurjf
  letI : Surjective g := hsurjg
  have hfg : f ≫ g = 𝟙 X := by
    apply scheme_morphisms_eq_of_function_field_pullbacks
    rw [scheme_function_field_pullback_comp, hf.2.2, hg.2.2, scheme_function_field_pullback_id]
    ext a
    exact e.apply_symm_apply a
  have hgf : g ≫ f = 𝟙 Y := by
    apply scheme_morphisms_eq_of_function_field_pullbacks
    rw [scheme_function_field_pullback_comp, hg.2.2, hf.2.2, scheme_function_field_pullback_id]
    ext a
    exact e.symm_apply_apply a
  exact ⟨⟨f, g, hfg, hgf⟩, hf.1, hg.1, hf.2.2, hg.2.2⟩

theorem proper_curve_function_field_equiv_of_dedekind_covers
    {X Y S : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    [X.IsSeparated] [Y.IsSeparated] [S.IsSeparated]
    (sX : X ⟶ S) (sY : Y ⟶ S) [IsProper sX] [IsProper sY]
    (e : Y.functionField ≃+* X.functionField) (he : GenericFieldMapOver sX sY e.toRingHom)
    {ι κ : Type*} (U : ι → X.Opens) (V : κ → Y.Opens)
    (hU : ∀ i, IsAffineOpen (U i)) (hV : ∀ j, IsAffineOpen (V j))
    [∀ i, IsDedekindDomain Γ(X, U i)] [∀ j, IsDedekindDomain Γ(Y, V j)]
    (hcoverX : ∀ x : X, ∃ i, x ∈ U i) (hcoverY : ∀ y : Y, ∃ j, y ∈ V j) :
    ∃ i : X ≅ Y, i.hom ≫ sY = sX ∧ i.inv ≫ sX = sY ∧
      Litt3.SharedTensors.schemeFunctionFieldPullback i.hom = e.toRingHom ∧
      Litt3.SharedTensors.schemeFunctionFieldPullback i.inv = e.symm.toRingHom :=
  proper_curve_function_field_equiv_realized sX sY e he
    (Litt3.Jacobians.valuation_stalks_of_dedekind_cover U hU hcoverX)
    (Litt3.Jacobians.valuation_stalks_of_dedekind_cover V hV hcoverY)

end Litt3.QuotientGeometry
