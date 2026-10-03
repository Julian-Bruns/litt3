import Solutions.QuotientGeometry.ProperFieldExtension
import Solutions.QuotientGeometry.TotalRationalMap
import Solutions.Jacobians.AffineValuationStalks
import Theorems.QuotientGeometry.ProperCurveFieldMaps

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.QuotientGeometry

universe u

theorem generic_stalk_source_map_dominant
    (X : Scheme.{u}) [IsIntegral X] : IsDominant (X.fromSpecStalk (genericPoint X)) := by
  have h : genericStalkSchemeMap (X := X) (Y := X) (RingHom.id X.functionField) =
      X.fromSpecStalk (genericPoint X) := by
    simp [genericStalkSchemeMap]
  rw [← h]
  exact generic_stalk_scheme_map_dominant _

/-- Proper targets and genuine valuation stalks extend an actual
function-field embedding to a unique actual dominant Scheme morphism.
The original base-Scheme diagram is retained. -/
theorem proper_function_field_map_extends_to_morphism
    {X Y S : Scheme.{u}} [IsIntegral X] [IsIntegral Y] [Y.IsSeparated] [S.IsSeparated]
    (sX : X ⟶ S) (sY : Y ⟶ S) [IsProper sY]
    (φ : Y.functionField →+* X.functionField) (hφ : GenericFieldMapOver sX sY φ)
    (hvaluation : ∀ x : X, ValuationRing (X.presheaf.stalk x)) :
    ∃! f : X ⟶ Y, f.toRationalMap = functionFieldRationalMap sX sY φ hφ ∧
      f ≫ sY = sX ∧ IsDominant f := by
  let r := functionFieldRationalMap sX sY φ hφ
  have hdom : r.domain = ⊤ :=
    proper_function_field_rational_map_domain_eq_top sX sY φ hφ hvaluation
  let f := totalRationalMapMorphism r hdom
  have hf : f.toRationalMap = r := total_rational_map_recovered r hdom
  have hgeneric : X.fromSpecStalk (genericPoint X) ≫ f = genericStalkSchemeMap φ := by
    have h := congrArg Scheme.RationalMap.fromFunctionField hf
    change f.toPartialMap.fromSpecStalkOfMem (x := genericPoint X) trivial =
      (functionFieldRationalMap sX sY φ hφ).fromFunctionField at h
    rw [Scheme.PartialMap.fromSpecStalkOfMem_toPartialMap,
      function_field_rational_map_generic_map] at h
    exact h
  haveI : IsDominant (X.fromSpecStalk (genericPoint X)) := generic_stalk_source_map_dominant X
  have hbase : f ≫ sY = sX := by
    apply ext_of_isDominant (ι := X.fromSpecStalk (genericPoint X))
    rw [← Category.assoc, hgeneric]
    exact hφ
  haveI : IsDominant (X.fromSpecStalk (genericPoint X) ≫ f) := by
    rw [hgeneric]
    exact generic_stalk_scheme_map_dominant φ
  have hdominant : IsDominant f := IsDominant.of_comp (X.fromSpecStalk (genericPoint X)) f
  refine ⟨f, ⟨hf, hbase, hdominant⟩, ?_⟩
  intro g hg
  exact scheme_morphism_rational_map_injective (hg.1.trans hf.symm)

/-- The valuation condition in the extension theorem follows from an
actual affine Dedekind cover; no abstract curve or supplied stalk map
replaces the Scheme. The cover need not be finite. -/
theorem proper_function_field_map_extends_from_dedekind_cover
    {X Y S : Scheme.{u}} [IsIntegral X] [IsIntegral Y] [Y.IsSeparated] [S.IsSeparated]
    (sX : X ⟶ S) (sY : Y ⟶ S) [IsProper sY]
    (φ : Y.functionField →+* X.functionField) (hφ : GenericFieldMapOver sX sY φ)
    {ι : Type*} (U : ι → X.Opens) (hU : ∀ i, IsAffineOpen (U i))
    [∀ i, IsDedekindDomain Γ(X, U i)] (hcover : ∀ x : X, ∃ i, x ∈ U i) :
    ∃! f : X ⟶ Y, f.toRationalMap = functionFieldRationalMap sX sY φ hφ ∧
      f ≫ sY = sX ∧ IsDominant f :=
  proper_function_field_map_extends_to_morphism sX sY φ hφ
    (Litt3.Jacobians.valuation_stalks_of_dedekind_cover U hU hcover)

theorem proper_curve_field_map_extension : Targets.ProperCurveFieldMapExtension.{u} := by
  intro X Y S _ _ _ _ sX sY _ φ hφ hvaluation
  exact proper_function_field_map_extends_to_morphism sX sY φ hφ hvaluation

end Litt3.QuotientGeometry
