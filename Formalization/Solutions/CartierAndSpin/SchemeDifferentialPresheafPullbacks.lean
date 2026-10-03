import Solutions.SharedTensors.SchemeDifferentialGenericRealization
import Solutions.SharedTensors.SchemeFieldTowers
import Solutions.QuotientGeometry.FunctionFieldChartTowers
import Solutions.Jacobians.SchemeRationalSectionPullbacks

open CategoryTheory Opposite AlgebraicGeometry

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.QuotientGeometry Litt3.Jacobians

universe u

variable {k : Type u} [Field k] {X Y : Scheme.{u}}
  (sX : X ⟶ Spec (.of k)) (sY : Y ⟶ Spec (.of k))
  (f : X ⟶ Y) (hover : f ≫ sY = sX)

include hover

/-- The ACTUAL open section-ring map preserves the original base
coefficients on EVERY open, including the empty open. -/
theorem actual_scheme_chart_base_field_over (U : Y.Opens) :
    (f.app U).hom.comp (chartBaseFieldHom sY U) =
      chartBaseFieldHom sX (f ⁻¹ᵁ U) := by
  rw [← hover]
  change ((Scheme.ΓSpecIso (.of k)).inv ≫ sY.appTop ≫
      Y.presheaf.map (homOfLE le_top).op ≫ f.app U).hom =
    ((Scheme.ΓSpecIso (.of k)).inv ≫ (f ≫ sY).appTop ≫
      X.presheaf.map (homOfLE le_top).op).hom
  rw [Scheme.Hom.comp_appTop]
  simp only [Category.assoc]
  rw [f.naturality]
  rfl

theorem actual_scheme_differential_constant_square (U : Y.Opens) :
    (𝟙 (CommRingCat.of k)) ≫
        (schemeConstantFieldPresheafMap sX).app (op (f ⁻¹ᵁ U)) =
      (schemeConstantFieldPresheafMap sY).app (op U) ≫ f.app U := by
  apply CommRingCat.hom_ext
  exact (actual_scheme_chart_base_field_over sX sY f hover U).symm

/-- The literal universal-differential map of the original structure
sheaves through the actual section-ring morphism, on EVERY open.
No smoothness, etaleness, integrality or rational realization is input. -/
noncomputable def actualSchemeDifferentialPresheafOpenPullback (U : Y.Opens) :
    (schemeDifferentialPresheaf sY).obj (op U) →+
      (schemeDifferentialPresheaf sX).obj (op (f ⁻¹ᵁ U)) := by
  exact (CommRingCat.KaehlerDifferential.map
    (actual_scheme_differential_constant_square sX sY f hover U)).hom.toAddMonoidHom

/-- This ENTIRE original presheaf pullback carries each original
universal derivative to the derivative of its actual pulled section. -/
theorem actualSchemeDifferentialPresheafOpenPullback_derivative
    (U : Y.Opens) (r : Γ(Y, U)) :
    actualSchemeDifferentialPresheafOpenPullback sX sY f hover U
        (CommRingCat.KaehlerDifferential.d
          (f := (schemeConstantFieldPresheafMap sY).app (op U)) r) =
      CommRingCat.KaehlerDifferential.d
        (f := (schemeConstantFieldPresheafMap sX).app (op (f ⁻¹ᵁ U)))
        (f.app U r) := by
  exact CommRingCat.KaehlerDifferential.map_d
    (actual_scheme_differential_constant_square sX sY f hover U) r

variable [IsIntegral X] [IsIntegral Y] [Surjective f]

/-- The original open-presheaf pullback agrees, on the WHOLE actual
universal module, with the actual generic-stalk rational pullback. -/
theorem actualSchemeDifferentialPresheafOpenPullback_rational
    (U : Y.Opens) [Nonempty U] :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := (genericBaseFieldHom sY).toAlgebra
    letI := (schemeFunctionFieldPullback f).toAlgebra
    letI := actualFunctionFieldBaseTower f sY sX hover
    letI := actualSchemeNonemptyPreimageOpen f U
    ∀ omega : (schemeDifferentialPresheaf sY).obj (op U),
      schemeDifferentialOpenToFunctionField sX (f ⁻¹ᵁ U)
          (actualSchemeDifferentialPresheafOpenPullback sX sY f hover U omega) =
        KaehlerDifferential.map k k Y.functionField X.functionField
          (schemeDifferentialOpenToFunctionField sY U omega) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := (genericBaseFieldHom sY).toAlgebra
  letI := (schemeFunctionFieldPullback f).toAlgebra
  letI := actualFunctionFieldBaseTower f sY sX hover
  letI := actualSchemeNonemptyPreimageOpen f U
  let R := Γ(Y, U)
  let S := Γ(X, f ⁻¹ᵁ U)
  letI := (chartBaseFieldHom sY U).toAlgebra
  letI := (chartBaseFieldHom sX (f ⁻¹ᵁ U)).toAlgebra
  letI : Algebra R S := (f.app U).hom.toAlgebra
  letI : IsScalarTower k R S := IsScalarTower.of_algebraMap_eq'
    (actual_scheme_chart_base_field_over sX sY f hover U).symm
  letI : Algebra R X.functionField :=
    ((schemeFunctionFieldPullback f).comp (algebraMap R Y.functionField)).toAlgebra
  letI : IsScalarTower R Y.functionField X.functionField :=
    IsScalarTower.of_algebraMap_eq' rfl
  letI : IsScalarTower R S X.functionField :=
    IsScalarTower.of_algebraMap_eq' (actual_function_field_pullback_chart f U)
  letI : IsScalarTower k R Y.functionField := IsScalarTower.of_algebraMap_eq'
    (chart_base_field_hom_generic_compatibility sY U).symm
  letI : IsScalarTower k S X.functionField := IsScalarTower.of_algebraMap_eq'
    (chart_base_field_hom_generic_compatibility sX (f ⁻¹ᵁ U)).symm
  letI : IsScalarTower k R X.functionField := IsScalarTower.of_algebraMap_eq fun c => by
    rw [IsScalarTower.algebraMap_apply k Y.functionField X.functionField]
    change algebraMap Y.functionField X.functionField (algebraMap k Y.functionField c) =
      algebraMap Y.functionField X.functionField
        (algebraMap R Y.functionField (algebraMap k R c))
    rw [← IsScalarTower.algebraMap_apply k R Y.functionField]
  intro omega
  change KaehlerDifferential.map k k S X.functionField
      (KaehlerDifferential.map k k R S omega) =
    KaehlerDifferential.map k k Y.functionField X.functionField
      (KaehlerDifferential.map k k R Y.functionField omega)
  rw [kaehler_map_composition, kaehler_map_composition]

end Litt3.CartierAndSpin
