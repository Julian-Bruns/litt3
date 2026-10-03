import Definitions.QuotientGeometry.GenericFieldPullbacks
import Solutions.QuotientGeometry.FunctionFieldRecovery

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.QuotientGeometry

universe u

theorem actual_generic_field_pullback_scheme_map
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (f : X ⟶ Y) (hgeneric : f (genericPoint X) = genericPoint Y) :
    genericStalkSchemeMap (actualGenericFieldPullback f hgeneric) =
      X.fromSpecStalk (genericPoint X) ≫ f := by
  change Spec.map ((Y.presheaf.stalkCongr (.of_eq hgeneric)).inv ≫
      f.stalkMap (genericPoint X)) ≫ Y.fromSpecStalk (genericPoint Y) = _
  rw [Spec.map_comp, Category.assoc, TopCat.Presheaf.stalkCongr_inv,
    Scheme.SpecMap_stalkSpecializes_fromSpecStalk]
  exact Scheme.SpecMap_stalkMap_fromSpecStalk f

theorem actual_generic_field_pullback_comp
    {X Y Z : Scheme.{u}} [IsIntegral X] [IsIntegral Y] [IsIntegral Z]
    (f : X ⟶ Y) (g : Y ⟶ Z)
    (hf : f (genericPoint X) = genericPoint Y)
    (hg : g (genericPoint Y) = genericPoint Z)
    (hfg : (f ≫ g) (genericPoint X) = genericPoint Z) :
    actualGenericFieldPullback (f ≫ g) hfg =
      (actualGenericFieldPullback f hf).comp (actualGenericFieldPullback g hg) := by
  apply generic_stalk_scheme_map_injective
  rw [actual_generic_field_pullback_scheme_map]
  change X.fromSpecStalk (genericPoint X) ≫ (f ≫ g) =
    Spec.map (CommRingCat.ofHom (actualGenericFieldPullback g hg) ≫
      CommRingCat.ofHom (actualGenericFieldPullback f hf)) ≫
      Z.fromSpecStalk (genericPoint Z)
  rw [Spec.map_comp, Category.assoc]
  change _ = Spec.map (CommRingCat.ofHom (actualGenericFieldPullback f hf)) ≫
    genericStalkSchemeMap (actualGenericFieldPullback g hg)
  rw [actual_generic_field_pullback_scheme_map, ← Category.assoc]
  change _ = genericStalkSchemeMap (actualGenericFieldPullback f hf) ≫ g
  rw [actual_generic_field_pullback_scheme_map, Category.assoc]

theorem actual_generic_field_pullback_congr
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (f g : X ⟶ Y) (hf : f (genericPoint X) = genericPoint Y)
    (hg : g (genericPoint X) = genericPoint Y) (h : f = g) :
    actualGenericFieldPullback f hf = actualGenericFieldPullback g hg := by
  subst g
  rfl

theorem actual_generic_field_pullback_surjective
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (f : X ⟶ Y) [Surjective f] (hf : f (genericPoint X) = genericPoint Y) :
    actualGenericFieldPullback f hf = Litt3.SharedTensors.schemeFunctionFieldPullback f := rfl

theorem actual_generic_field_pullback_open
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (f : X ⟶ Y) [IsOpenImmersion f] (hf : f (genericPoint X) = genericPoint Y) :
    actualGenericFieldPullback f hf = (actualOpenFunctionFieldEquiv f).toRingHom := rfl

end Litt3.QuotientGeometry
