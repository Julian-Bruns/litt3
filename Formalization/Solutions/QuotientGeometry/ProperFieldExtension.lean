import Definitions.QuotientGeometry.ProperFieldExtension
import Solutions.QuotientGeometry.FunctionFieldDominance

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.QuotientGeometry

universe u

theorem partial_map_generic_map_from_stalk
    {X Y : Scheme.{u}} [IsIntegral X] (p : X.PartialMap Y) (x : X) (hx : x ∈ p.domain) :
    p.fromFunctionField =
      Spec.map (X.presheaf.stalkSpecializes (genericPoint_specializes x)) ≫
        p.fromSpecStalkOfMem hx := by
  have hgen : genericPoint X ∈ p.domain :=
    (genericPoint_specializes x).mem_open p.domain.2 hx
  have he : Spec.map (X.presheaf.stalkSpecializes (genericPoint_specializes x)) ≫
      p.domain.fromSpecStalkOfMem x hx =
        p.domain.fromSpecStalkOfMem (genericPoint X) hgen := by
    apply (cancel_mono p.domain.ι).mp
    simp only [Category.assoc, Scheme.Opens.fromSpecStalkOfMem_ι]
    exact Scheme.SpecMap_stalkSpecializes_fromSpecStalk _
  change p.domain.fromSpecStalkOfMem (genericPoint X) _ ≫ p.hom = _
  rw [← he, Category.assoc]
  rfl

/-- Properness produces a genuine map from the actual source stalk that
extends the given generic-field map, with the same base diagram. -/
theorem proper_function_field_map_extends_to_valuation_stalk
    {X Y S : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (sX : X ⟶ S) (sY : Y ⟶ S) [IsProper sY]
    (φ : Y.functionField →+* X.functionField) (hφ : GenericFieldMapOver sX sY φ)
    (x : X) [ValuationRing (X.presheaf.stalk x)] :
    ∃ l : Spec (X.presheaf.stalk x) ⟶ Y,
      Spec.map (X.presheaf.stalkSpecializes (genericPoint_specializes x)) ≫ l =
        genericStalkSchemeMap φ ∧
      l ≫ sY = X.fromSpecStalk x ≫ sX := by
  have hproper : ValuativeCriterion sY :=
    (IsProper.eq_valuativeCriterion ▸ (show IsProper sY from inferInstance)).1.1.1
  obtain ⟨l⟩ := hproper (valuationStalkSquare sX sY φ hφ x)
  exact ⟨l.default.l, l.default.fac_left, l.default.fac_right⟩

/-- The actual reconstructed rational map is regular at each point
whose actual stalk is a valuation ring. -/
theorem proper_function_field_rational_map_defined_at
    {X Y S : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (sX : X ⟶ S) (sY : Y ⟶ S) [IsProper sY]
    (φ : Y.functionField →+* X.functionField) (hφ : GenericFieldMapOver sX sY φ)
    (x : X) [ValuationRing (X.presheaf.stalk x)] :
    x ∈ (functionFieldRationalMap sX sY φ hφ).domain := by
  obtain ⟨l, hl, hbase⟩ :=
    proper_function_field_map_extends_to_valuation_stalk sX sY φ hφ x
  let p := Scheme.PartialMap.ofFromSpecStalk sX sY l hbase
  have hx : x ∈ p.domain := Scheme.PartialMap.mem_domain_ofFromSpecStalk sX sY l hbase
  have hgeneric : p.fromFunctionField = genericStalkSchemeMap φ := by
    rw [partial_map_generic_map_from_stalk p x hx]
    rw [Scheme.PartialMap.fromSpecStalkOfMem_ofFromSpecStalk]
    exact hl
  apply Scheme.RationalMap.mem_domain.mpr
  refine ⟨p, hx, ?_⟩
  apply Scheme.RationalMap.eq_of_fromFunctionField_eq
  change p.fromFunctionField = (functionFieldRationalMap sX sY φ hφ).fromFunctionField
  rw [hgeneric, function_field_rational_map_generic_map]

theorem proper_function_field_rational_map_domain_eq_top
    {X Y S : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (sX : X ⟶ S) (sY : Y ⟶ S) [IsProper sY]
    (φ : Y.functionField →+* X.functionField) (hφ : GenericFieldMapOver sX sY φ)
    (hvaluation : ∀ x : X, ValuationRing (X.presheaf.stalk x)) :
    (functionFieldRationalMap sX sY φ hφ).domain = ⊤ := by
  ext x
  letI := hvaluation x
  exact ⟨fun _ => trivial, fun _ =>
    proper_function_field_rational_map_defined_at sX sY φ hφ x⟩

end Litt3.QuotientGeometry
