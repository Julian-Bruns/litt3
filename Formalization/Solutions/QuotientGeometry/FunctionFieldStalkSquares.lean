import Solutions.SharedTensors.SchemeFunctionFields
import Solutions.QuotientGeometry.SchemeFixedBaseStalkMap

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.QuotientGeometry

universe u

/-- The original generic-stalk field pullback intertwines EVERY element
of EVERY original stalk with the original scheme stalk pullback. -/
theorem actual_function_field_pullback_stalk
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (f : X ⟶ Y) [Surjective f] (x : X) :
    (Litt3.SharedTensors.schemeFunctionFieldPullback f).comp
        (algebraMap (Y.presheaf.stalk (f x)) Y.functionField) =
      (algebraMap (X.presheaf.stalk x) X.functionField).comp (f.stalkMap x).hom := by
  change ((Y.presheaf.stalkSpecializes ((genericPoint_spec Y).specializes trivial) ≫
    (Y.presheaf.stalkCongr (.of_eq
      (Litt3.SharedTensors.scheme_genericPoint_eq_of_surjective f))).inv ≫
    f.stalkMap (genericPoint X))).hom =
      ((f.stalkMap x ≫ X.presheaf.stalkSpecializes
        ((genericPoint_spec X).specializes trivial))).hom
  dsimp only [TopCat.Presheaf.stalkCongr]
  rw [← Category.assoc, Y.presheaf.stalkSpecializes_comp]
  exact congrArg CommRingCat.Hom.hom
    (f.stalkSpecializes_stalkMap (genericPoint X) x
      ((genericPoint_spec X).specializes trivial))

/-- The same ENTIRE original field/stalk square holds at any fixed
original downstairs point, through actual equality with the image. -/
theorem actual_function_field_pullback_fixed_base_stalk
    {k : Type u} [Field k] {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (f : X ⟶ Y) [Surjective f]
    (sX : X ⟶ Spec (.of k)) (sY : Y ⟶ Spec (.of k))
    (hover : f ≫ sY = sX) (b : Y) (x : X) (hb : b = f x) :
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sY b).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sX x).toAlgebra
    (Litt3.SharedTensors.schemeFunctionFieldPullback f).comp
        (algebraMap (Y.presheaf.stalk b) Y.functionField) =
      (algebraMap (X.presheaf.stalk x) X.functionField).comp
        (actualSchemeFixedBaseStalkMap f sX sY hover b x hb).toRingHom := by
  subst b
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sY (f x)).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sX x).toAlgebra
  simpa [actualSchemeFixedBaseStalkMap, actualSchemeStalkPointAlgEquiv,
    actualSchemeStalkAlgHom] using actual_function_field_pullback_stalk f x

end Litt3.QuotientGeometry
