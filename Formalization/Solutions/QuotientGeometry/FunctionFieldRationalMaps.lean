import Definitions.QuotientGeometry.FunctionFieldRationalMaps

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.QuotientGeometry

universe u

theorem function_field_partial_map_contains_generic_point
    {X Y S : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (sX : X ⟶ S) (sY : Y ⟶ S) [LocallyOfFiniteType sY]
    (φ : Y.functionField →+* X.functionField) (hφ : GenericFieldMapOver sX sY φ) :
    genericPoint X ∈ (functionFieldPartialMap sX sY φ hφ).domain :=
  Scheme.PartialMap.mem_domain_ofFromSpecStalk sX sY (genericStalkSchemeMap φ) hφ

theorem function_field_partial_map_over_base
    {X Y S : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (sX : X ⟶ S) (sY : Y ⟶ S) [LocallyOfFiniteType sY]
    (φ : Y.functionField →+* X.functionField) (hφ : GenericFieldMapOver sX sY φ) :
    (functionFieldPartialMap sX sY φ hφ).hom ≫ sY =
      (functionFieldPartialMap sX sY φ hφ).domain.ι ≫ sX :=
  Scheme.PartialMap.ofFromSpecStalk_comp sX sY (genericStalkSchemeMap φ) hφ

theorem function_field_rational_map_generic_map
    {X Y S : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (sX : X ⟶ S) (sY : Y ⟶ S) [LocallyOfFiniteType sY]
    (φ : Y.functionField →+* X.functionField) (hφ : GenericFieldMapOver sX sY φ) :
    (functionFieldRationalMap sX sY φ hφ).fromFunctionField = genericStalkSchemeMap φ :=
  Scheme.RationalMap.fromFunctionField_ofFunctionField sX sY (genericStalkSchemeMap φ) hφ

theorem function_field_rational_map_over_base
    {X Y S : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (sX : X ⟶ S) (sY : Y ⟶ S) [LocallyOfFiniteType sY]
    (φ : Y.functionField →+* X.functionField) (hφ : GenericFieldMapOver sX sY φ) :
    (functionFieldRationalMap sX sY φ hφ).compHom sY = sX.toRationalMap :=
  (Scheme.RationalMap.equivFunctionField sX sY
    ⟨genericStalkSchemeMap φ, hφ⟩).property

theorem generic_stalk_scheme_map_injective
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y] :
    Function.Injective (genericStalkSchemeMap (X := X) (Y := Y)) := by
  intro φ ψ h
  have hSpec : Spec.map (CommRingCat.ofHom φ) = Spec.map (CommRingCat.ofHom ψ) :=
    (cancel_mono (Y.fromSpecStalk (genericPoint Y))).mp h
  exact congrArg CommRingCat.Hom.hom (Spec.map_injective hSpec)

/-- The actual rational map retains and determines the original field
embedding. Distinct embeddings are not collapsed into a numerical map. -/
theorem function_field_rational_map_faithful
    {X Y S : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (sX : X ⟶ S) (sY : Y ⟶ S) [LocallyOfFiniteType sY]
    (φ ψ : Y.functionField →+* X.functionField)
    (hφ : GenericFieldMapOver sX sY φ) (hψ : GenericFieldMapOver sX sY ψ)
    (heq : functionFieldRationalMap sX sY φ hφ = functionFieldRationalMap sX sY ψ hψ) :
    φ = ψ := by
  apply generic_stalk_scheme_map_injective
  have h := congrArg Scheme.RationalMap.fromFunctionField heq
  simpa only [function_field_rational_map_generic_map] using h

end Litt3.QuotientGeometry
