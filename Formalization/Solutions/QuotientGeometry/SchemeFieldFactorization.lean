import Solutions.QuotientGeometry.ProperCurveFieldMaps
import Solutions.QuotientGeometry.FunctionFieldRecovery

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.QuotientGeometry

universe u

theorem scheme_morphisms_eq_of_function_field_pullbacks
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y] [Y.IsSeparated]
    (f g : X ⟶ Y) [Surjective f] [Surjective g]
    (h : Litt3.SharedTensors.schemeFunctionFieldPullback f =
      Litt3.SharedTensors.schemeFunctionFieldPullback g) : f = g := by
  haveI : IsDominant (X.fromSpecStalk (genericPoint X)) := generic_stalk_source_map_dominant X
  apply ext_of_isDominant (ι := X.fromSpecStalk (genericPoint X))
  have hmap := congrArg (genericStalkSchemeMap (X := X) (Y := Y)) h
  simpa only [generic_map_of_scheme_function_field_pullback] using hmap

theorem scheme_function_field_pullback_id
    (X : Scheme.{u}) [IsIntegral X] :
    Litt3.SharedTensors.schemeFunctionFieldPullback (𝟙 X) = RingHom.id X.functionField := by
  apply generic_stalk_scheme_map_injective
  rw [generic_map_of_scheme_function_field_pullback]
  simp [genericStalkSchemeMap]

theorem scheme_function_field_pullback_comp
    {X Y Z : Scheme.{u}} [IsIntegral X] [IsIntegral Y] [IsIntegral Z]
    (f : X ⟶ Y) (g : Y ⟶ Z) [Surjective f] [Surjective g] :
    Litt3.SharedTensors.schemeFunctionFieldPullback (f ≫ g) =
      (Litt3.SharedTensors.schemeFunctionFieldPullback f).comp
        (Litt3.SharedTensors.schemeFunctionFieldPullback g) := by
  apply generic_stalk_scheme_map_injective
  rw [generic_map_of_scheme_function_field_pullback]
  change X.fromSpecStalk (genericPoint X) ≫ (f ≫ g) =
    Spec.map (CommRingCat.ofHom (Litt3.SharedTensors.schemeFunctionFieldPullback g) ≫
      CommRingCat.ofHom (Litt3.SharedTensors.schemeFunctionFieldPullback f)) ≫
      Z.fromSpecStalk (genericPoint Z)
  rw [Spec.map_comp, Category.assoc]
  change _ = Spec.map (CommRingCat.ofHom (Litt3.SharedTensors.schemeFunctionFieldPullback f)) ≫
    genericStalkSchemeMap (Litt3.SharedTensors.schemeFunctionFieldPullback g)
  rw [generic_map_of_scheme_function_field_pullback, ← Category.assoc]
  change _ = genericStalkSchemeMap (Litt3.SharedTensors.schemeFunctionFieldPullback f) ≫ g
  rw [generic_map_of_scheme_function_field_pullback, Category.assoc]

/-- Equality of actual field maps proves factorization of actual Scheme
morphisms; every map in the conclusion remains a genuine morphism. -/
theorem scheme_factorization_of_field_factorization
    {X Y Z : Scheme.{u}} [IsIntegral X] [IsIntegral Y] [IsIntegral Z] [Z.IsSeparated]
    (f : X ⟶ Y) (g : Y ⟶ Z) (h : X ⟶ Z)
    [Surjective f] [Surjective g] [Surjective h]
    (hfield : Litt3.SharedTensors.schemeFunctionFieldPullback h =
      (Litt3.SharedTensors.schemeFunctionFieldPullback f).comp
        (Litt3.SharedTensors.schemeFunctionFieldPullback g)) : h = f ≫ g := by
  apply scheme_morphisms_eq_of_function_field_pullbacks
  rw [scheme_function_field_pullback_comp]
  exact hfield

end Litt3.QuotientGeometry
