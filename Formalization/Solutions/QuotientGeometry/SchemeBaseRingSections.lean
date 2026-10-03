import Solutions.QuotientGeometry.SchemeBaseRings

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.QuotientGeometry

universe u

/-- The generic original base-ring map is the literal pullback of
base sections followed by the genuine generic germ. -/
theorem generic_base_ring_hom_eq_germ
    {X : Scheme.{u}} [IsIntegral X] {R : Type u} [CommRing R]
    (sX : X ⟶ Spec (.of R)) :
    genericBaseRingHom sX =
      ((Scheme.ΓSpecIso (.of R)).inv ≫ sX.appTop ≫
        X.presheaf.germ ⊤ (genericPoint X) trivial).hom := by
  have hmap : Spec.map ((Scheme.ΓSpecIso (.of R)).inv ≫ sX.appTop ≫
      X.presheaf.germ ⊤ (genericPoint X) trivial) =
      X.fromSpecStalk (genericPoint X) ≫ sX := by
    rw [Spec.map_comp, Spec.map_comp, ← Scheme.fromSpecStalk_toSpecΓ]
    simp only [Category.assoc]
    rw [← Scheme.toSpecΓ_naturality_assoc]
    simp
  have h := Spec.map_injective ((generic_base_ring_spec_map sX).trans hmap.symm)
  exact congrArg CommRingCat.Hom.hom h

/-- A true original affine chart's structure map has EXACTLY its
original section inclusion into the true generic stalk. -/
theorem generic_base_ring_hom_original_affine_chart
    {X : Scheme.{u}} [IsIntegral X] (U : X.Opens)
    (hU : IsAffineOpen U) [Nonempty U] :
    genericBaseRingHom hU.isoSpec.hom =
      (U.topIso.inv ≫ U.toScheme.presheaf.germ ⊤
        (genericPoint U.toScheme) trivial).hom := by
  rw [generic_base_ring_hom_eq_germ, hU.isoSpec_hom_appTop]
  simp only [Category.assoc, Iso.inv_hom_id_assoc]

end Litt3.QuotientGeometry
