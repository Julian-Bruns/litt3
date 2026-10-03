import Solutions.SharedTensors.SchemeDifferentialSheafInjectivity

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.SharedTensors

open Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] {X : Scheme.{u}} [IsIntegral X]

/-- Every rational form belonging to the ORIGINAL point-stalk module
has a genuine ORIGINAL open universal-differential representative.
The neighborhood and full module element are constructed by actual
affine localization. Smoothness and finite generation are unnecessary. -/
theorem schemeLocalRegularDifferential_open_lift
    (sX : X ⟶ Spec (.of k)) (x : X) :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ omega : KaehlerDifferential k X.functionField,
      omega ∈ schemeLocalRegularDifferentials sX x →
      ∃ (V : X.Opens) (hx : x ∈ V),
        letI : Nonempty V := ⟨⟨x, hx⟩⟩
        ∃ a : (schemeDifferentialPresheaf sX).presheaf.obj (Opposite.op V),
          schemeDifferentialOpenToFunctionField sX V a = omega := by
  letI := (genericBaseFieldHom sX).toAlgebra
  intro omega regular
  obtain ⟨U, hU, hxU, _⟩ :=
    (Opens.isBasis_iff_nbhd.mp X.isBasis_affineOpens) (show x ∈ (⊤ : X.Opens) from trivial)
  let xU : U := ⟨x, hxU⟩
  letI : Nonempty U := ⟨xU⟩
  letI := (chartBaseFieldHom sX U).toAlgebra
  letI := (stalkBaseFieldHom sX x).toAlgebra
  letI := X.presheaf.algebra_section_stalk xU
  letI : IsScalarTower k Γ(X, U) (X.presheaf.stalk x) :=
    IsScalarTower.of_algebraMap_eq'
      (actual_chart_stalk_base_field_compatibility sX U xU).symm
  letI : IsScalarTower k Γ(X, U) X.functionField :=
    IsScalarTower.of_algebraMap_eq'
      (chart_base_field_hom_generic_compatibility sX U).symm
  letI : IsScalarTower k (X.presheaf.stalk x) X.functionField :=
    IsScalarTower.of_algebraMap_eq'
      (stalk_base_field_generic_compatibility sX x).symm
  letI : IsScalarTower Γ(X, U) (X.presheaf.stalk x) X.functionField :=
    IsScalarTower.of_algebraMap_eq' (by
      symm
      change (X.presheaf.germ U x hxU ≫
          X.presheaf.stalkSpecializes ((genericPoint_spec X).specializes trivial)).hom =
        (X.presheaf.germ U (genericPoint X) _).hom
      rw [X.presheaf.germ_stalkSpecializes])
  letI := hU.isLocalization_stalk xU
  change omega ∈ LinearMap.range
    ((KaehlerDifferential.map k k (X.presheaf.stalk x) X.functionField).restrictScalars k) at regular
  obtain ⟨w, hw⟩ := regular
  change KaehlerDifferential.map k k (X.presheaf.stalk x) X.functionField w = omega at hw
  obtain ⟨⟨a, s⟩, hs⟩ := IsLocalizedModule.surj
    (hU.primeIdealOf xU).asIdeal.primeCompl
    (KaehlerDifferential.map k k Γ(X, U) (X.presheaf.stalk x)) w
  change s.val • w = KaehlerDifferential.map k k Γ(X, U) (X.presheaf.stalk x) a at hs
  have hxV : x ∈ X.basicOpen s.val :=
    (X.mem_basicOpen s.val x hxU).mpr (IsLocalization.map_units (X.presheaf.stalk x) s)
  let V := X.basicOpen s.val
  letI : Nonempty V := ⟨⟨x, hxV⟩⟩
  letI := (chartBaseFieldHom sX V).toAlgebra
  letI := hU.isLocalization_basicOpen s.val
  letI : IsScalarTower k Γ(X, U) Γ(X, V) :=
    IsScalarTower.of_algebraMap_eq' (by
      have h := congrArg CommRingCat.Hom.hom
        ((schemeConstantFieldPresheafMap sX).naturality
          (homOfLE (X.basicOpen_le s.val)).op)
      simpa using h)
  letI : IsScalarTower k Γ(X, V) X.functionField :=
    IsScalarTower.of_algebraMap_eq'
      (chart_base_field_hom_generic_compatibility sX V).symm
  letI : IsScalarTower Γ(X, U) Γ(X, V) X.functionField :=
    IsScalarTower.of_algebraMap_eq'
      (actual_section_restriction_function_field (X := X) (X.basicOpen_le s.val)).symm
  have hu : IsUnit (algebraMap Γ(X, U) Γ(X, V) s.val) :=
    IsLocalization.map_units Γ(X, V) ⟨s.val, Submonoid.mem_powers s.val⟩
  let d : Γ(X, V) := hu.unit⁻¹.val
  let b : KaehlerDifferential k Γ(X, V) :=
    d • KaehlerDifferential.map k k Γ(X, U) Γ(X, V) a
  refine ⟨V, hxV, b, ?_⟩
  have hsFF : algebraMap Γ(X, U) X.functionField s.val • omega =
      schemeDifferentialOpenToFunctionField sX U a := by
    have h := congrArg (KaehlerDifferential.map k k (X.presheaf.stalk x) X.functionField) hs
    rw [LinearMap.map_smul_of_tower, hw, kaehler_map_composition] at h
    simpa only [IsScalarTower.algebraMap_smul] using h
  have hcoef : algebraMap Γ(X, V) X.functionField d *
      algebraMap Γ(X, U) X.functionField s.val = 1 := by
    rw [IsScalarTower.algebraMap_apply Γ(X, U) Γ(X, V) X.functionField,
      ← hu.unit_spec, ← map_mul]
    exact (congrArg (algebraMap Γ(X, V) X.functionField) hu.unit.inv_mul).trans (map_one _)
  have hsmul : schemeDifferentialOpenToFunctionField sX V b =
      algebraMap Γ(X, V) X.functionField d • schemeDifferentialOpenToFunctionField sX U a := by
    change KaehlerDifferential.map k k Γ(X, V) X.functionField
      (d • KaehlerDifferential.map k k Γ(X, U) Γ(X, V) a) = _
    rw [map_smul]
    have hr := congrArg (fun f => f.hom a)
      (schemeDifferentialOpenToFunctionField_restriction sX (X.basicOpen_le s.val))
    simpa only [IsScalarTower.algebraMap_smul] using congrArg (fun z => d • z) hr
  rw [hsmul, ← hsFF, smul_smul, hcoef, one_smul]

end Litt3.SharedTensors
