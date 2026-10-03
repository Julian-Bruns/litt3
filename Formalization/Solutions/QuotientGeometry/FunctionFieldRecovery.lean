import Solutions.QuotientGeometry.FunctionFieldRationalMaps

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.QuotientGeometry

universe u

theorem generic_map_of_scheme_function_field_pullback
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (f : X ⟶ Y) [Surjective f] :
    genericStalkSchemeMap (Litt3.SharedTensors.schemeFunctionFieldPullback f) =
      X.fromSpecStalk (genericPoint X) ≫ f := by
  change Spec.map ((Y.presheaf.stalkCongr (.of_eq
    (Litt3.SharedTensors.scheme_genericPoint_eq_of_surjective f))).inv ≫
      f.stalkMap (genericPoint X)) ≫ Y.fromSpecStalk (genericPoint Y) = _
  rw [Spec.map_comp, Category.assoc, TopCat.Presheaf.stalkCongr_inv,
    Scheme.SpecMap_stalkSpecializes_fromSpecStalk]
  exact Scheme.SpecMap_stalkMap_fromSpecStalk f

theorem actual_scheme_function_field_map_over_base
    {X Y S : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (sX : X ⟶ S) (sY : Y ⟶ S) (f : X ⟶ Y) [Surjective f]
    (hbase : f ≫ sY = sX) :
    GenericFieldMapOver sX sY (Litt3.SharedTensors.schemeFunctionFieldPullback f) := by
  change genericStalkSchemeMap _ ≫ sY = _
  rw [generic_map_of_scheme_function_field_pullback, Category.assoc, hbase]

/-- The field-to-rational-map construction recovers the rational map of
the original actual Scheme morphism, with the same actual base diagram. -/
theorem actual_scheme_map_recovered_rationally
    {X Y S : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (sX : X ⟶ S) (sY : Y ⟶ S) [LocallyOfFiniteType sY]
    (f : X ⟶ Y) [Surjective f] (hbase : f ≫ sY = sX) :
    functionFieldRationalMap sX sY (Litt3.SharedTensors.schemeFunctionFieldPullback f)
      (actual_scheme_function_field_map_over_base sX sY f hbase) = f.toRationalMap := by
  apply Scheme.RationalMap.eq_of_fromFunctionField_eq
  rw [function_field_rational_map_generic_map, generic_map_of_scheme_function_field_pullback]
  exact (Scheme.PartialMap.fromSpecStalkOfMem_toPartialMap f (genericPoint X)).symm

end Litt3.QuotientGeometry
