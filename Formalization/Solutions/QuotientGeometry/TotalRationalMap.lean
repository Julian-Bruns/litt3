import Definitions.QuotientGeometry.TotalRationalMap

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

universe u

theorem total_rational_map_partial_map
    {X Y : Scheme.{u}} [IsReduced X] [Y.IsSeparated]
    (r : X.RationalMap Y) (hdom : r.domain = ⊤) :
    r.toPartialMap = (totalRationalMapMorphism r hdom).toPartialMap := by
  apply Scheme.PartialMap.ext _ _ hdom
  change r.toPartialMap.hom = (X.isoOfEq hdom).hom ≫
    X.topIso.hom ≫ (X.topIso.inv ≫ (X.isoOfEq hdom).inv ≫ r.toPartialMap.hom)
  simp

theorem total_rational_map_recovered
    {X Y : Scheme.{u}} [IsReduced X] [Y.IsSeparated]
    (r : X.RationalMap Y) (hdom : r.domain = ⊤) :
    (totalRationalMapMorphism r hdom).toRationalMap = r := by
  change (totalRationalMapMorphism r hdom).toPartialMap.toRationalMap = r
  rw [← total_rational_map_partial_map, Scheme.RationalMap.toRationalMap_toPartialMap]

theorem scheme_morphism_rational_map_injective
    {X Y : Scheme.{u}} [IsReduced X] [Y.IsSeparated] :
    Function.Injective (Scheme.Hom.toRationalMap : (X ⟶ Y) → X.RationalMap Y) := by
  intro f g h
  have hp : f.toPartialMap = g.toPartialMap :=
    (Scheme.PartialMap.equiv_iff_of_domain_eq_of_isSeparated (S := ⊤_ _)
      (f := f.toPartialMap) (g := g.toPartialMap) rfl).mp
      (Scheme.PartialMap.toRationalMap_eq_iff.mp h)
  obtain ⟨e, hhom⟩ := (Scheme.PartialMap.ext_iff _ _).mp hp
  simp only [Scheme.isoOfEq_rfl, Iso.refl_hom, Category.id_comp] at hhom
  exact (cancel_epi X.topIso.hom).mp hhom

end Litt3.QuotientGeometry
