import Solutions.QuotientGeometry.SchemeFieldFactorization

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.QuotientGeometry

universe u

/-- The actual extension between actual proper Schemes is proper and
surjective, and its actual generic-stalk pullback is exactly the input
field homomorphism.  Finiteness and etaleness are separate claims. -/
theorem proper_curve_field_embedding_realized
    {X Y S : Scheme.{u}} [IsIntegral X] [IsIntegral Y] [Y.IsSeparated] [S.IsSeparated]
    (sX : X ⟶ S) (sY : Y ⟶ S) [IsProper sX] [IsProper sY]
    (φ : Y.functionField →+* X.functionField) (hφ : GenericFieldMapOver sX sY φ)
    (hvaluation : ∀ x : X, ValuationRing (X.presheaf.stalk x)) :
    ∃ (f : X ⟶ Y) (_ : Surjective f),
      f ≫ sY = sX ∧ IsProper f ∧
      Litt3.SharedTensors.schemeFunctionFieldPullback f = φ := by
  obtain ⟨f, hf, -⟩ := proper_function_field_map_extends_to_morphism sX sY φ hφ hvaluation
  haveI : IsProper (f ≫ sY) := by rw [hf.2.1]; infer_instance
  haveI : IsProper f := IsProper.of_comp f sY
  haveI : IsDominant f := hf.2.2
  haveI : Surjective f := inferInstance
  refine ⟨f, inferInstance, hf.2.1, inferInstance, ?_⟩
  apply generic_stalk_scheme_map_injective
  rw [generic_map_of_scheme_function_field_pullback]
  have h := congrArg Scheme.RationalMap.fromFunctionField hf.1
  change f.toPartialMap.fromSpecStalkOfMem (x := genericPoint X) trivial =
    (functionFieldRationalMap sX sY φ hφ).fromFunctionField at h
  simpa only [Scheme.PartialMap.fromSpecStalkOfMem_toPartialMap,
    function_field_rational_map_generic_map] using h

end Litt3.QuotientGeometry
