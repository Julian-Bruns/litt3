import Definitions.QuotientGeometry.SchemeBaseRings
import Solutions.QuotientGeometry.SchemeFieldFactorization

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.QuotientGeometry

open Litt3.SharedTensors

universe u

theorem generic_base_ring_spec_map
    {X : Scheme.{u}} [IsIntegral X] {R : Type u} [CommRing R]
    (sX : X ⟶ Spec (.of R)) :
    Spec.map (CommRingCat.ofHom (genericBaseRingHom sX)) =
      X.fromSpecStalk (genericPoint X) ≫ sX := Spec.map_preimage _

theorem generic_field_map_over_iff_base_ring
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y] {R : Type u} [CommRing R]
    (sX : X ⟶ Spec (.of R)) (sY : Y ⟶ Spec (.of R))
    (φ : Y.functionField →+* X.functionField) :
    GenericFieldMapOver sX sY φ ↔
      φ.comp (genericBaseRingHom sY) = genericBaseRingHom sX := by
  change Spec.map (CommRingCat.ofHom φ) ≫
    (Y.fromSpecStalk (genericPoint Y) ≫ sY) =
      X.fromSpecStalk (genericPoint X) ≫ sX ↔ _
  rw [← generic_base_ring_spec_map sY, ← generic_base_ring_spec_map sX, ← Spec.map_comp]
  constructor
  · intro h
    exact congrArg CommRingCat.Hom.hom (Spec.map_injective h)
  · intro h
    exact congrArg (fun f : R →+* X.functionField => Spec.map (CommRingCat.ofHom f)) h

theorem generic_base_ring_hom_affine_structure
    {R C : Type u} [CommRing R] [CommRing C] [IsDomain C] [Algebra R C] :
    genericBaseRingHom (Spec.map (CommRingCat.ofHom (algebraMap R C))) =
      (StructureSheaf.toStalk C (genericPoint (Spec (.of C)))).hom.comp
        (algebraMap R C) := by
  apply CommRingCat.hom_ext_iff.mp
  apply Spec.map_injective
  change Spec.map (CommRingCat.ofHom
      (genericBaseRingHom (Spec.map (CommRingCat.ofHom (algebraMap R C))))) = _
  rw [generic_base_ring_spec_map, Scheme.Spec_fromSpecStalk', ← Spec.map_comp]
  rfl

theorem generic_base_ring_pullback_affine_compatibility
    {R : Type u} [CommRing R] [IsDomain R]
    {X : Scheme.{u}} [IsIntegral X]
    (sX : X ⟶ Spec (.of R)) [Surjective sX] :
    (schemeFunctionFieldPullback sX).comp
        (StructureSheaf.toStalk R (genericPoint (Spec (.of R)))).hom =
      genericBaseRingHom sX := by
  apply CommRingCat.hom_ext_iff.mp
  apply Spec.map_injective
  change Spec.map (StructureSheaf.toStalk R (genericPoint (Spec (.of R))) ≫
      CommRingCat.ofHom (schemeFunctionFieldPullback sX)) =
    Spec.map (CommRingCat.ofHom (genericBaseRingHom sX))
  rw [generic_base_ring_spec_map, Spec.map_comp]
  change Spec.map (CommRingCat.ofHom (schemeFunctionFieldPullback sX)) ≫
      Spec.map (StructureSheaf.toStalk R _) = _
  rw [← Scheme.Spec_fromSpecStalk' (.of R) (genericPoint (Spec (.of R)))]
  exact generic_map_of_scheme_function_field_pullback sX

end Litt3.QuotientGeometry
