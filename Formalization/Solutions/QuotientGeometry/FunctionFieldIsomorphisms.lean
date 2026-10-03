import Solutions.QuotientGeometry.FunctionFieldRationalMaps

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.QuotientGeometry

universe u

theorem function_field_equiv_inverse_over_base
    {X Y S : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (sX : X ⟶ S) (sY : Y ⟶ S) (e : Y.functionField ≃+* X.functionField)
    (he : GenericFieldMapOver sX sY e.toRingHom) :
    GenericFieldMapOver sY sX e.symm.toRingHom := by
  change genericStalkSchemeMap e.symm.toRingHom ≫ sX =
    Y.fromSpecStalk (genericPoint Y) ≫ sY
  change Spec.map (CommRingCat.ofHom e.symm.toRingHom) ≫
    X.fromSpecStalk (genericPoint X) ≫ sX = _
  rw [← he]
  change Spec.map (CommRingCat.ofHom e.symm.toRingHom) ≫
    (Spec.map (CommRingCat.ofHom e.toRingHom) ≫
      Y.fromSpecStalk (genericPoint Y) ≫ sY) = _
  rw [← Category.assoc, ← Spec.map_comp]
  have hc : CommRingCat.ofHom e.toRingHom ≫ CommRingCat.ofHom e.symm.toRingHom =
      𝟙 Y.functionField := by
    ext a
    exact e.symm_apply_apply a
  rw [hc, Spec.map_id, Category.id_comp]

end Litt3.QuotientGeometry
