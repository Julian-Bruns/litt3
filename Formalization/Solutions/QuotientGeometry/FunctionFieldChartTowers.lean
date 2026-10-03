import Solutions.SharedTensors.SchemeFunctionFields
import Solutions.QuotientGeometry.AffineChartFields

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.QuotientGeometry

universe u

/-- The actual generic stalk pullback preserves EVERY section on the
original base chart through its original chart pullback. -/
theorem actual_function_field_pullback_chart
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (f : X ⟶ Y) [Surjective f]
    (U : Y.Opens) [Nonempty U] [Nonempty (f ⁻¹ᵁ U)] :
    (Litt3.SharedTensors.schemeFunctionFieldPullback f).comp
        (algebraMap Γ(Y, U) Y.functionField) =
      (algebraMap Γ(X, f ⁻¹ᵁ U) X.functionField).comp (f.app U).hom := by
  change ((Y.germToFunctionField U ≫
    (Y.presheaf.stalkCongr (.of_eq
      (Litt3.SharedTensors.scheme_genericPoint_eq_of_surjective f))).inv ≫
    f.stalkMap (genericPoint X))).hom =
      ((f.app U ≫ X.germToFunctionField (f ⁻¹ᵁ U))).hom
  dsimp only [Scheme.germToFunctionField, TopCat.Presheaf.stalkCongr]
  rw [Y.presheaf.germ_stalkSpecializes_assoc]
  exact congrArg CommRingCat.Hom.hom
    (f.germ_stalkMap U (genericPoint X) _)

/-- The true original field inclusion and original affine chart
pullback form a genuine scalar tower. -/
theorem actual_function_field_chart_scalar_tower
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (f : X ⟶ Y) [Surjective f]
    (U : Y.Opens) [Nonempty U] [Nonempty (f ⁻¹ᵁ U)] :
    letI := (f.app U).hom.toAlgebra
    letI := (Litt3.SharedTensors.schemeFunctionFieldPullback f).toAlgebra
    letI : Algebra Γ(Y, U) X.functionField :=
      ((Litt3.SharedTensors.schemeFunctionFieldPullback f).comp
        (algebraMap Γ(Y, U) Y.functionField)).toAlgebra
    IsScalarTower Γ(Y, U) Γ(X, f ⁻¹ᵁ U) X.functionField := by
  letI := (f.app U).hom.toAlgebra
  letI := (Litt3.SharedTensors.schemeFunctionFieldPullback f).toAlgebra
  letI : Algebra Γ(Y, U) X.functionField :=
    ((Litt3.SharedTensors.schemeFunctionFieldPullback f).comp
      (algebraMap Γ(Y, U) Y.functionField)).toAlgebra
  apply IsScalarTower.of_algebraMap_eq'
  exact actual_function_field_pullback_chart f U

end Litt3.QuotientGeometry
