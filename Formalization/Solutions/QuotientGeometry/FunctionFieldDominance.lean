import Solutions.QuotientGeometry.FunctionFieldRationalMaps

open CategoryTheory AlgebraicGeometry TopologicalSpace IsLocalRing

namespace Litt3.QuotientGeometry

universe u

theorem generic_stalk_scheme_map_closed_point
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (φ : Y.functionField →+* X.functionField) :
    genericStalkSchemeMap φ (closedPoint X.functionField) = genericPoint Y := by
  change Y.fromSpecStalk (genericPoint Y)
    (Spec.map (CommRingCat.ofHom φ) (closedPoint X.functionField)) = genericPoint Y
  rw [Subsingleton.elim (Spec.map (CommRingCat.ofHom φ) (closedPoint X.functionField))
    (closedPoint Y.functionField)]
  exact Scheme.fromSpecStalk_closedPoint

theorem generic_stalk_scheme_map_range
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (φ : Y.functionField →+* X.functionField) :
    Set.range (genericStalkSchemeMap φ) = {genericPoint Y} := by
  ext y
  constructor
  · rintro ⟨p, rfl⟩
    have hp : p = closedPoint X.functionField :=
      @Subsingleton.elim (PrimeSpectrum X.functionField) inferInstance _ _
    rw [hp, generic_stalk_scheme_map_closed_point]
    exact Set.mem_singleton _
  · rintro rfl
    exact ⟨closedPoint X.functionField, generic_stalk_scheme_map_closed_point φ⟩

theorem generic_stalk_scheme_map_dominant
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (φ : Y.functionField →+* X.functionField) : IsDominant (genericStalkSchemeMap φ) := by
  constructor
  rw [denseRange_iff_closure_range, generic_stalk_scheme_map_range]
  exact genericPoint_spec Y

theorem function_field_partial_map_generic_map
    {X Y S : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (sX : X ⟶ S) (sY : Y ⟶ S) [LocallyOfFiniteType sY]
    (φ : Y.functionField →+* X.functionField) (hφ : GenericFieldMapOver sX sY φ) :
    (functionFieldPartialMap sX sY φ hφ).fromFunctionField = genericStalkSchemeMap φ :=
  Scheme.PartialMap.fromSpecStalkOfMem_ofFromSpecStalk sX sY (genericStalkSchemeMap φ) hφ

/-- Spreading out the actual field map produces an actual dominant
morphism on a dense open, with its actual base-Scheme diagram retained. -/
theorem function_field_partial_map_dominant
    {X Y S : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (sX : X ⟶ S) (sY : Y ⟶ S) [LocallyOfFiniteType sY]
    (φ : Y.functionField →+* X.functionField) (hφ : GenericFieldMapOver sX sY φ) :
    IsDominant (functionFieldPartialMap sX sY φ hφ).hom := by
  haveI : IsDominant (functionFieldPartialMap sX sY φ hφ).fromFunctionField := by
    rw [function_field_partial_map_generic_map]
    exact generic_stalk_scheme_map_dominant φ
  let p := functionFieldPartialMap sX sY φ hφ
  let a := p.domain.fromSpecStalkOfMem (genericPoint X)
    (function_field_partial_map_contains_generic_point sX sY φ hφ)
  haveI : IsDominant (a ≫ p.hom) :=
    inferInstanceAs (IsDominant p.fromFunctionField)
  exact IsDominant.of_comp a p.hom

end Litt3.QuotientGeometry
