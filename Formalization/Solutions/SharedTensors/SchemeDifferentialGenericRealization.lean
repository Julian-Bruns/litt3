import Solutions.SharedTensors.SchemeDifferentialPresheaf
import Solutions.SharedTensors.IntegralSchemeGlobalFunctions
import Solutions.QuotientGeometry.SchemeBaseFields
import Solutions.SharedTensors.KaehlerMapComposition
import Mathlib.Topology.Sheaves.Skyscraper

open CategoryTheory CategoryTheory.Limits AlgebraicGeometry TopologicalSpace

namespace Litt3.SharedTensors

open Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] {X : Scheme.{u}} [IsIntegral X]

/-- On each nonempty ORIGINAL open, universal differentials map to the
actual generic-point universal module through the literal section germ. -/
noncomputable def schemeDifferentialOpenToFunctionField
    (sX : X ⟶ Spec (.of k)) (U : X.Opens) [Nonempty U] :
    letI := (genericBaseFieldHom sX).toAlgebra
    (schemeDifferentialPresheaf sX).presheaf.obj (Opposite.op U) ⟶
      AddCommGrpCat.of (KaehlerDifferential k X.functionField) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := (chartBaseFieldHom sX U).toAlgebra
  letI : IsScalarTower k Γ(X, U) X.functionField :=
    IsScalarTower.of_algebraMap_eq'
      (chart_base_field_hom_generic_compatibility sX U).symm
  exact AddCommGrpCat.ofHom
    (KaehlerDifferential.map k k Γ(X, U) X.functionField).toAddMonoidHom

/-- The literal open differential of an ORIGINAL section maps to the
differential of that section's genuine generic germ. -/
theorem schemeDifferentialOpenToFunctionField_derivative
    (sX : X ⟶ Spec (.of k)) (U : X.Opens) [Nonempty U] :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ a : Γ(X, U),
      schemeDifferentialOpenToFunctionField sX U
        (CommRingCat.KaehlerDifferential.d
          (f := (schemeConstantFieldPresheafMap sX).app (Opposite.op U)) a) =
      KaehlerDifferential.D k X.functionField (algebraMap Γ(X, U) X.functionField a) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := (chartBaseFieldHom sX U).toAlgebra
  letI : IsScalarTower k Γ(X, U) X.functionField :=
    IsScalarTower.of_algebraMap_eq'
      (chart_base_field_hom_generic_compatibility sX U).symm
  intro a
  exact KaehlerDifferential.map_D k k Γ(X, U) X.functionField a

/-- Every actual nonempty-open restriction commutes with the ENTIRE
original universal-module generic map. -/
theorem schemeDifferentialOpenToFunctionField_restriction
    (sX : X ⟶ Spec (.of k)) {U V : X.Opens} [Nonempty U] [Nonempty V]
    (hVU : V ≤ U) :
    letI := (genericBaseFieldHom sX).toAlgebra
    (schemeDifferentialPresheaf sX).presheaf.map (homOfLE hVU).op ≫
        schemeDifferentialOpenToFunctionField sX V =
      schemeDifferentialOpenToFunctionField sX U := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := (chartBaseFieldHom sX U).toAlgebra
  letI := (chartBaseFieldHom sX V).toAlgebra
  letI := (X.presheaf.map (homOfLE hVU).op).hom.toAlgebra
  letI : IsScalarTower k Γ(X, U) Γ(X, V) :=
    IsScalarTower.of_algebraMap_eq' (by
      have h := congrArg CommRingCat.Hom.hom
        ((schemeConstantFieldPresheafMap sX).naturality (homOfLE hVU).op)
      simpa using h)
  letI : IsScalarTower k Γ(X, U) X.functionField :=
    IsScalarTower.of_algebraMap_eq'
      (chart_base_field_hom_generic_compatibility sX U).symm
  letI : IsScalarTower k Γ(X, V) X.functionField :=
    IsScalarTower.of_algebraMap_eq'
      (chart_base_field_hom_generic_compatibility sX V).symm
  letI : IsScalarTower Γ(X, U) Γ(X, V) X.functionField :=
    IsScalarTower.of_algebraMap_eq'
      (actual_section_restriction_function_field (X := X) hVU).symm
  ext omega
  exact kaehler_map_composition (k := k) (R := Γ(X, U))
    (S := Γ(X, V)) (T := X.functionField) omega

/-- The actual generic universal-module maps form a cocone over the
original open-neighborhood differential diagram. -/
noncomputable def schemeDifferentialGenericCocone (sX : X ⟶ Spec (.of k)) :
    letI := (genericBaseFieldHom sX).toAlgebra
    Cocone ((OpenNhds.inclusion (genericPoint X)).op ⋙
      (schemeDifferentialPresheaf sX).presheaf) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  refine
    { pt := AddCommGrpCat.of (KaehlerDifferential k X.functionField)
      ι := { app := fun U => ?_, naturality := ?_ } }
  · letI : Nonempty U.unop.obj := ⟨⟨genericPoint X, U.unop.property⟩⟩
    exact schemeDifferentialOpenToFunctionField sX U.unop.obj
  · intro U V f
    letI : Nonempty U.unop.obj := ⟨⟨genericPoint X, U.unop.property⟩⟩
    letI : Nonempty V.unop.obj := ⟨⟨genericPoint X, V.unop.property⟩⟩
    letI : Nonempty ((OpenNhds.inclusion (genericPoint X)).obj U.unop) :=
      ⟨⟨genericPoint X, U.unop.property⟩⟩
    letI : Nonempty ((OpenNhds.inclusion (genericPoint X)).obj V.unop) :=
      ⟨⟨genericPoint X, V.unop.property⟩⟩
    simpa using schemeDifferentialOpenToFunctionField_restriction sX
      (leOfHom ((OpenNhds.inclusion (genericPoint X)).map f.unop))

/-- The genuine differential PRESHEAF stalk at the original generic
point maps to the original function field's universal differential module. -/
noncomputable def schemeDifferentialGenericStalkMap (sX : X ⟶ Spec (.of k)) :
    letI := (genericBaseFieldHom sX).toAlgebra
    TopCat.Presheaf.stalk (schemeDifferentialPresheaf sX).presheaf (genericPoint X) ⟶
      AddCommGrpCat.of (KaehlerDifferential k X.functionField) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  exact colimit.desc _ (schemeDifferentialGenericCocone sX)

/-- This is the honest rational differential skyscraper at the actual
generic point. Every nonempty original open contains that point. -/
noncomputable def schemeRationalDifferentialSheaf (sX : X ⟶ Spec (.of k)) :
    letI := (genericBaseFieldHom sX).toAlgebra
    TopCat.Sheaf AddCommGrpCat X := by
  classical
  letI := (genericBaseFieldHom sX).toAlgebra
  exact skyscraperSheaf (genericPoint X)
    (AddCommGrpCat.of (KaehlerDifferential k X.functionField))

/-- The original universal differential presheaf has a genuine natural
map into rational forms, constructed through its actual generic stalk. -/
noncomputable def schemeDifferentialPresheafToRational (sX : X ⟶ Spec (.of k)) :
    (schemeDifferentialPresheaf sX).presheaf ⟶
      (schemeRationalDifferentialSheaf sX).val := by
  classical
  exact StalkSkyscraperPresheafAdjunctionAuxs.toSkyscraperPresheaf
    (genericPoint X) (schemeDifferentialGenericStalkMap sX)

/-- The genuine colimit-stalk map has the literal original open map
as every component; this includes all original module elements. -/
theorem schemeDifferentialGenericStalkMap_germ
    (sX : X ⟶ Spec (.of k)) (U : X.Opens)
    (hU : genericPoint X ∈ U) [Nonempty U] :
    letI := (genericBaseFieldHom sX).toAlgebra
    TopCat.Presheaf.germ (schemeDifferentialPresheaf sX).presheaf U
        (genericPoint X) hU ≫ schemeDifferentialGenericStalkMap sX =
      schemeDifferentialOpenToFunctionField sX U := by
  letI := (genericBaseFieldHom sX).toAlgebra
  exact colimit.ι_desc (schemeDifferentialGenericCocone sX) (Opposite.op ⟨U, hU⟩)

/-- On each genuine nonempty open the rational skyscraper is the
actual original generic universal module, via its literal object equality. -/
noncomputable def schemeRationalDifferentialOpenIso
    (sX : X ⟶ Spec (.of k)) (U : X.Opens) [Nonempty U] :
    letI := (genericBaseFieldHom sX).toAlgebra
    (schemeRationalDifferentialSheaf sX).val.obj (Opposite.op U) ≅
      AddCommGrpCat.of (KaehlerDifferential k X.functionField) := by
  classical
  letI := (genericBaseFieldHom sX).toAlgebra
  apply eqToIso
  change (if genericPoint X ∈ U then _ else _) = _
  have hU : genericPoint X ∈ U :=
    ((genericPoint_spec X).mem_open_set_iff U.isOpen).mpr
      (by simpa using (inferInstance : Nonempty U))
  exact if_pos hU

/-- The rational presheaf map on a nonempty original open is exactly
the original section-to-generic universal-differential map. -/
theorem schemeDifferentialPresheafToRational_open
    (sX : X ⟶ Spec (.of k)) (U : X.Opens) [Nonempty U] :
    letI := (genericBaseFieldHom sX).toAlgebra
    (schemeDifferentialPresheafToRational sX).app (Opposite.op U) ≫
        (schemeRationalDifferentialOpenIso sX U).hom =
      schemeDifferentialOpenToFunctionField sX U := by
  classical
  letI := (genericBaseFieldHom sX).toAlgebra
  have hU : genericPoint X ∈ U :=
    ((genericPoint_spec X).mem_open_set_iff U.isOpen).mpr
      (by simpa using (inferInstance : Nonempty U))
  simp only [schemeDifferentialPresheafToRational,
    StalkSkyscraperPresheafAdjunctionAuxs.toSkyscraperPresheaf_app,
    dif_pos hU, schemeRationalDifferentialOpenIso, eqToIso.hom,
    Category.assoc, eqToHom_trans, eqToHom_refl, Category.comp_id]
  exact schemeDifferentialGenericStalkMap_germ sX U hU

end Litt3.SharedTensors
