import Definitions.QuotientGeometry.OpenFunctionFields

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.QuotientGeometry

universe u

/-- Every original stalk element commutes with the ENTIRE generic-field
equivalence of the actual open immersion. -/
theorem actual_open_function_field_stalk_square
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (f : X ⟶ Y) [IsOpenImmersion f] (x : X) :
    (actualOpenFunctionFieldEquiv f).toRingHom.comp
        (algebraMap (Y.presheaf.stalk (f x)) Y.functionField) =
      (algebraMap (X.presheaf.stalk x) X.functionField).comp (f.stalkMap x).hom := by
  change ((Y.presheaf.stalkSpecializes ((genericPoint_spec Y).specializes trivial) ≫
    (Y.presheaf.stalkCongr (.of_eq (genericPoint_eq_of_isOpenImmersion f))).inv ≫
    f.stalkMap (genericPoint X))).hom =
      ((f.stalkMap x ≫ X.presheaf.stalkSpecializes
        ((genericPoint_spec X).specializes trivial))).hom
  dsimp only [TopCat.Presheaf.stalkCongr]
  rw [← Category.assoc, Y.presheaf.stalkSpecializes_comp]
  exact congrArg CommRingCat.Hom.hom
    (f.stalkSpecializes_stalkMap (genericPoint X) x
      ((genericPoint_spec X).specializes trivial))

/-- Every section on the original base chart is preserved through its
actual chart pullback and the actual open generic-field equivalence. -/
theorem actual_open_function_field_chart_square
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (f : X ⟶ Y) [IsOpenImmersion f]
    (U : Y.Opens) [Nonempty U] [Nonempty (f ⁻¹ᵁ U)] :
    (actualOpenFunctionFieldEquiv f).toRingHom.comp
        (algebraMap Γ(Y, U) Y.functionField) =
      (algebraMap Γ(X, f ⁻¹ᵁ U) X.functionField).comp (f.app U).hom := by
  change ((Y.germToFunctionField U ≫
    (Y.presheaf.stalkCongr (.of_eq (genericPoint_eq_of_isOpenImmersion f))).inv ≫
    f.stalkMap (genericPoint X))).hom =
      ((f.app U ≫ X.germToFunctionField (f ⁻¹ᵁ U))).hom
  dsimp only [Scheme.germToFunctionField, TopCat.Presheaf.stalkCongr]
  rw [Y.presheaf.germ_stalkSpecializes_assoc]
  exact congrArg CommRingCat.Hom.hom
    (f.germ_stalkMap U (genericPoint X) _)

end Litt3.QuotientGeometry
