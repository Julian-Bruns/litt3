import Solutions.QuotientGeometry.UnramifiedDVRCompletions
import Solutions.Jacobians.SchemeValuationPullbacks
import Mathlib.AlgebraicGeometry.Morphisms.Etale

open AlgebraicGeometry CategoryTheory

namespace Litt3.QuotientGeometry

universe u

noncomputable def schemeStalkResidueMap
    {X Y : Scheme.{u}} (f : X ⟶ Y) (x : X) :
    IsLocalRing.ResidueField (Y.presheaf.stalk (f x)) →+*
      IsLocalRing.ResidueField (X.presheaf.stalk x) := by
  letI : IsLocalHom (f.stalkMap x).hom := f.toLRSHom.prop x
  exact IsLocalRing.ResidueField.map (f.stalkMap x).hom

theorem scheme_stalk_maximal_ideal_map_le
    {X Y : Scheme.{u}} (f : X ⟶ Y) (x : X) :
    (IsLocalRing.maximalIdeal (Y.presheaf.stalk (f x))).map (f.stalkMap x).hom ≤
      IsLocalRing.maximalIdeal (X.presheaf.stalk x) :=
  ((IsLocalRing.local_hom_TFAE (f.stalkMap x).hom).out 0 2 rfl rfl).mp
    (f.toLRSHom.prop x)

/-- Completion of the genuine stalk map of an actual scheme morphism. -/
noncomputable def schemeCompletedStalkMap
    {X Y : Scheme.{u}} (f : X ⟶ Y) (x : X) :
    AdicCompletion (IsLocalRing.maximalIdeal (Y.presheaf.stalk (f x)))
      (Y.presheaf.stalk (f x)) →+*
    AdicCompletion (IsLocalRing.maximalIdeal (X.presheaf.stalk x)) (X.presheaf.stalk x) :=
  adicRingMap _ _ (f.stalkMap x).hom (scheme_stalk_maximal_ideal_map_le f x)

theorem schemeCompletedStalkMap_of
    {X Y : Scheme.{u}} (f : X ⟶ Y) (x : X) (r : Y.presheaf.stalk (f x)) :
    schemeCompletedStalkMap f x (AdicCompletion.of _ _ r) =
      AdicCompletion.of _ _ ((f.stalkMap x).hom r) :=
  adicRingMap_of _ _ (f.stalkMap x).hom (scheme_stalk_maximal_ideal_map_le f x) r

/-- Actual unramified scheme maps with DVR stalks and equal residue
fields induce isomorphisms of their actual completed stalk rings. -/
theorem scheme_unramified_dvr_completion_isomorphism
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (f : X ⟶ Y) [AlgebraicGeometry.FormallyUnramified f] [LocallyOfFiniteType f]
    (x : X) [IsDiscreteValuationRing (X.presheaf.stalk x)]
    [IsDiscreteValuationRing (Y.presheaf.stalk (f x))]
    (hres : Function.Surjective (schemeStalkResidueMap f x)) :
    ∃ e : AdicCompletion (IsLocalRing.maximalIdeal (Y.presheaf.stalk (f x)))
        (Y.presheaf.stalk (f x)) ≃+*
      AdicCompletion (IsLocalRing.maximalIdeal (X.presheaf.stalk x)) (X.presheaf.stalk x),
      e.toRingHom = schemeCompletedStalkMap f x ∧
      ∀ r : Y.presheaf.stalk (f x),
        e (AdicCompletion.of _ _ r) = AdicCompletion.of _ _ ((f.stalkMap x).hom r) := by
  letI : IsLocalHom (f.stalkMap x).hom := f.toLRSHom.prop x
  obtain ⟨t, ht⟩ := IsDiscreteValuationRing.exists_irreducible (Y.presheaf.stalk (f x))
  exact unramified_dvr_completion_isomorphism (f.stalkMap x).hom t ht
    (Litt3.Jacobians.scheme_stalk_map_formallyUnramified f x)
    (Litt3.Jacobians.scheme_stalk_map_essFiniteType f x) hres

theorem scheme_etale_dvr_completion_isomorphism
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (f : X ⟶ Y) [IsEtale f] (x : X)
    [IsDiscreteValuationRing (X.presheaf.stalk x)]
    [IsDiscreteValuationRing (Y.presheaf.stalk (f x))]
    (hres : Function.Surjective (schemeStalkResidueMap f x)) :
    ∃ e : AdicCompletion (IsLocalRing.maximalIdeal (Y.presheaf.stalk (f x)))
        (Y.presheaf.stalk (f x)) ≃+*
      AdicCompletion (IsLocalRing.maximalIdeal (X.presheaf.stalk x)) (X.presheaf.stalk x),
      e.toRingHom = schemeCompletedStalkMap f x ∧
      ∀ r : Y.presheaf.stalk (f x),
        e (AdicCompletion.of _ _ r) = AdicCompletion.of _ _ ((f.stalkMap x).hom r) :=
  scheme_unramified_dvr_completion_isomorphism f x hres

end Litt3.QuotientGeometry
