import Solutions.QuotientGeometry.SpecStalkCoefficientIso
import Solutions.QuotientGeometry.LocalizedCoefficientBaseMaps

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

universe u

variable {k A R : Type u} [Field k] [CommRing A] [CommRing R]
  [Algebra k A] [Algebra A R] [Algebra k R] [IsScalarTower k A R]

/-- The actual original algebra tower induces the genuine over-k
square of affine Scheme maps. -/
theorem actual_affine_structure_map_square :
    Spec.map (CommRingCat.ofHom (algebraMap A R)) ≫
        actualAffineStructureMap (k := k) (A := A) =
      actualAffineStructureMap (k := k) (A := R) := by
  rw [actualAffineStructureMap, actualAffineStructureMap, ← Spec.map_comp]
  congr 1
  apply CommRingCat.hom_ext
  exact (IsScalarTower.algebraMap_eq k A R).symm

/-- The entire true affine Scheme stalk map, for its actual
structure-map coefficient algebras, is identified with the genuine
localized coordinate-ring map. -/
theorem actual_spec_stalk_base_map_localization (P : PrimeSpectrum R) :
    let f := Spec.map (CommRingCat.ofHom (algebraMap A R))
    let sA := actualAffineStructureMap (k := k) (A := A)
    let sR := actualAffineStructureMap (k := k) (A := R)
    let J := f P
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sA J).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sR P).toAlgebra
    (actualSpecStalkCoefficientAlgEquiv (k := k) P).toAlgHom.comp
        (actualSchemeStalkAlgHom f sR sA actual_affine_structure_map_square P) =
      (localizedCoefficientBaseMap (k := k) J.asIdeal P.asIdeal rfl).comp
        (actualSpecStalkCoefficientAlgEquiv (k := k) J).toAlgHom := by
  let f := Spec.map (CommRingCat.ofHom (algebraMap A R))
  let sA := actualAffineStructureMap (k := k) (A := A)
  let sR := actualAffineStructureMap (k := k) (A := R)
  let J := f P
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sA J).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sR P).toAlgebra
  have hh : f.stalkMap P ≫ (StructureSheaf.stalkIso R P).hom =
      (StructureSheaf.stalkIso A J).hom ≫ CommRingCat.ofHom
        (Localization.localRingHom J.asIdeal P.asIdeal (algebraMap A R) rfl) := by
    rw [← Scheme.localRingHom_comp_stalkIso, Category.assoc,
      Category.assoc, Iso.inv_hom_id, Category.comp_id]
    rfl
  apply AlgHom.ext
  intro r
  exact DFunLike.congr_fun (congrArg CommRingCat.Hom.hom hh) r

end Litt3.QuotientGeometry
