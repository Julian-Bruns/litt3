import Solutions.QuotientGeometry.SchemeStalkCoefficients
import Mathlib.AlgebraicGeometry.AffineScheme

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

universe u

variable {k A : Type u} [Field k] [CommRing A] [Algebra k A]

/-- The genuine affine structure map associated to the original
coefficient algebra. -/
noncomputable def actualAffineStructureMap : Spec (.of A) ⟶ Spec (.of k) :=
  Spec.map (CommRingCat.ofHom (algebraMap k A))

/-- The actual Scheme structure-map coefficient homomorphism on an
affine stalk is the original algebra map followed by the genuine
coordinate-ring germ. -/
theorem actual_spec_stalk_base_field_hom (P : PrimeSpectrum A) :
    Litt3.SharedTensors.stalkBaseFieldHom (actualAffineStructureMap (k := k) (A := A)) P =
      (StructureSheaf.toStalk A P).hom.comp (algebraMap k A) := by
  change ((Scheme.ΓSpecIso (.of k)).inv ≫
    (Spec.map (CommRingCat.ofHom (algebraMap k A))).appTop ≫
      (Spec (.of A)).presheaf.germ ⊤ P trivial).hom = _
  rw [← Category.assoc, ← Scheme.ΓSpecIso_inv_naturality]
  rfl

/-- The actual affine Scheme stalk and the actual prime localization
are equivalent over the original coefficient field, using the literal
structure-map coefficient algebra on the Scheme stalk. -/
noncomputable def actualSpecStalkCoefficientAlgEquiv (P : PrimeSpectrum A) :
    letI := (Litt3.SharedTensors.stalkBaseFieldHom
      (actualAffineStructureMap (k := k) (A := A)) P).toAlgebra
    (Spec (.of A)).presheaf.stalk P ≃ₐ[k] Localization.AtPrime P.asIdeal := by
  letI := (Litt3.SharedTensors.stalkBaseFieldHom
    (actualAffineStructureMap (k := k) (A := A)) P).toAlgebra
  refine { (StructureSheaf.stalkIso A P).commRingCatIsoToRingEquiv with
    commutes' := ?_ }
  intro c
  change StructureSheaf.stalkToFiberRingHom A P
    (Litt3.SharedTensors.stalkBaseFieldHom
      (actualAffineStructureMap (k := k) (A := A)) P c) = algebraMap k _ c
  rw [actual_spec_stalk_base_field_hom]
  change StructureSheaf.stalkToFiberRingHom A P
    (StructureSheaf.toStalk A P (algebraMap k A c)) = algebraMap k _ c
  rw [StructureSheaf.stalkToFiberRingHom_toStalk]
  exact (IsScalarTower.algebraMap_apply k A (Localization.AtPrime P.asIdeal) c).symm

theorem actualSpecStalkCoefficientAlgEquiv_ring (P : PrimeSpectrum A) :
    letI := (Litt3.SharedTensors.stalkBaseFieldHom
      (actualAffineStructureMap (k := k) (A := A)) P).toAlgebra
    (actualSpecStalkCoefficientAlgEquiv (k := k) P).toRingHom =
      (StructureSheaf.stalkIso A P).hom.hom := rfl

end Litt3.QuotientGeometry
