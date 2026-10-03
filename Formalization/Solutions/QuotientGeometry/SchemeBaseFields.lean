import Definitions.QuotientGeometry.SchemeBaseFields
import Solutions.QuotientGeometry.FunctionFieldRationalMaps

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.QuotientGeometry

universe u

theorem generic_base_field_spec_map
    {X : Scheme.{u}} [IsIntegral X] {K : Type u} [Field K]
    (sX : X ⟶ Spec (.of K)) :
    Spec.map (CommRingCat.ofHom (genericBaseFieldHom sX)) =
      X.fromSpecStalk (genericPoint X) ≫ sX := Spec.map_preimage _

theorem generic_field_map_over_iff_constants
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y] {K : Type u} [Field K]
    (sX : X ⟶ Spec (.of K)) (sY : Y ⟶ Spec (.of K))
    (φ : Y.functionField →+* X.functionField) :
    GenericFieldMapOver sX sY φ ↔
      φ.comp (genericBaseFieldHom sY) = genericBaseFieldHom sX := by
  change Spec.map (CommRingCat.ofHom φ) ≫
    (Y.fromSpecStalk (genericPoint Y) ≫ sY) =
      X.fromSpecStalk (genericPoint X) ≫ sX ↔ _
  rw [← generic_base_field_spec_map sY, ← generic_base_field_spec_map sX, ← Spec.map_comp]
  constructor
  · intro h
    exact congrArg CommRingCat.Hom.hom (Spec.map_injective h)
  · intro h
    exact congrArg (fun f : K →+* X.functionField => Spec.map (CommRingCat.ofHom f)) h

theorem generic_base_field_hom_eq_germ
    {X : Scheme.{u}} [IsIntegral X] {K : Type u} [Field K]
    (sX : X ⟶ Spec (.of K)) :
    genericBaseFieldHom sX =
      ((Scheme.ΓSpecIso (.of K)).inv ≫ sX.appTop ≫
        X.presheaf.germ ⊤ (genericPoint X) trivial).hom := by
  have hmap : Spec.map ((Scheme.ΓSpecIso (.of K)).inv ≫ sX.appTop ≫
      X.presheaf.germ ⊤ (genericPoint X) trivial) =
      X.fromSpecStalk (genericPoint X) ≫ sX := by
    rw [Spec.map_comp, Spec.map_comp, ← Scheme.fromSpecStalk_toSpecΓ]
    simp only [Category.assoc]
    rw [← Scheme.toSpecΓ_naturality_assoc]
    simp
  have h := Spec.map_injective ((generic_base_field_spec_map sX).trans hmap.symm)
  exact congrArg CommRingCat.Hom.hom h

theorem chart_base_field_hom_generic_compatibility
    {X : Scheme.{u}} [IsIntegral X] {K : Type u} [Field K]
    (sX : X ⟶ Spec (.of K)) (U : X.Opens) [Nonempty U] :
    (algebraMap Γ(X, U) X.functionField).comp (chartBaseFieldHom sX U) =
      genericBaseFieldHom sX := by
  rw [generic_base_field_hom_eq_germ]
  change ((Scheme.ΓSpecIso (.of K)).inv ≫ sX.appTop ≫
    X.presheaf.map (homOfLE le_top).op ≫
      X.presheaf.germ U (genericPoint X) _).hom = _
  rw [X.presheaf.germ_res]

end Litt3.QuotientGeometry
