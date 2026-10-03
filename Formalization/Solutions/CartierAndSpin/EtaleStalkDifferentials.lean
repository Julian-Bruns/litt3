import Solutions.Jacobians.SchemeValuationPullbacks
import Mathlib.AlgebraicGeometry.Morphisms.Smooth
import Mathlib.AlgebraicGeometry.Morphisms.Etale
import Mathlib.RingTheory.RingHom.Smooth
import Mathlib.RingTheory.Etale.Kaehler

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.CartierAndSpin

universe u

theorem formally_smooth_localRingHom
    {R S : Type*} [CommRing R] [CommRing S] (phi : R →+* S)
    (hphi : phi.FormallySmooth) (J : Ideal S) [J.IsPrime] :
    (Localization.localRingHom (J.comap phi) J phi rfl).FormallySmooth := by
  algebraize [phi]
  letI : Algebra (Localization.AtPrime (J.comap phi)) (Localization.AtPrime J) :=
    (Localization.localRingHom (J.comap phi) J phi rfl).toAlgebra
  letI : IsScalarTower R (Localization.AtPrime (J.comap phi)) (Localization.AtPrime J) :=
    IsScalarTower.of_algebraMap_eq fun x =>
      (Localization.localRingHom_to_map _ _ _ rfl x).symm
  letI : Algebra.FormallySmooth S (Localization.AtPrime J) :=
    Algebra.FormallySmooth.of_isLocalization J.primeCompl
  letI : Algebra.FormallySmooth R (Localization.AtPrime J) :=
    Algebra.FormallySmooth.comp R S (Localization.AtPrime J)
  change Algebra.FormallySmooth (Localization.AtPrime (J.comap phi))
    (Localization.AtPrime J)
  exact Algebra.FormallySmooth.of_restrictScalars R _ _

/-- Genuine scheme smoothness gives formal smoothness on every actual
stalk map, without falsely asserting stalk finite presentation. -/
theorem actual_smooth_stalk_map_formallySmooth
    {X Y : Scheme.{u}} (f : X ⟶ Y) [IsSmooth f] (x : X) :
    (f.stalkMap x).hom.FormallySmooth := by
  have hQi := RingHom.FormallySmooth.respectsIso
  wlog h : IsAffine X ∧ IsAffine Y generalizing X Y f
  · obtain ⟨U, hU, hfx, _⟩ := Opens.isBasis_iff_nbhd.mp Y.isBasis_affineOpens
      (Opens.mem_top (f x))
    obtain ⟨V, hV, hx, e⟩ := Opens.isBasis_iff_nbhd.mp X.isBasis_affineOpens
      (show x ∈ f ⁻¹ᵁ U from hfx)
    rw [← hQi.arrow_mk_iso_iff (Scheme.Hom.resLEStalkMap f e ⟨x, hx⟩)]
    letI hlocal : IsSmooth (f.resLE U V e) :=
      IsZariskiLocalAtSource.resLE _ (inferInstance : IsSmooth f)
    exact this (f.resLE U V e) ⟨x, hx⟩ ⟨hV, hU⟩
  obtain ⟨hX, hY⟩ := h
  wlog hXY : ∃ R S, Y = Spec R ∧ X = Spec S generalizing X Y
  · have : (((X.isoSpec.inv ≫ f ≫ Y.isoSpec.hom).stalkMap (X.isoSpec.hom x)).hom).FormallySmooth := by
      apply this (X.isoSpec.inv ≫ f ≫ Y.isoSpec.hom) (X.isoSpec.hom x)
        inferInstance inferInstance
      exact ⟨_, _, rfl, rfl⟩
    rw [Scheme.Hom.stalkMap_comp, Scheme.Hom.stalkMap_comp, CommRingCat.hom_comp,
      hQi.cancel_right_isIso, CommRingCat.hom_comp, hQi.cancel_left_isIso] at this
    have heq : X.isoSpec.inv (X.isoSpec.hom x) = x := by simp
    rwa [hQi.arrow_mk_iso_iff (f.arrowStalkMapIsoOfEq heq)] at this
  obtain ⟨R, S, rfl, rfl⟩ := hXY
  obtain ⟨phi, rfl⟩ := Spec.map_surjective f
  rw [hQi.arrow_mk_iso_iff (Scheme.arrowStalkMapSpecIso phi _)]
  have hloc : RingHom.Locally RingHom.IsStandardSmooth phi.hom :=
    HasRingHomProperty.Spec_iff (P := @IsSmooth) |>.mp inferInstance
  have hlocsmooth : RingHom.Locally RingHom.Smooth phi.hom := by
    apply RingHom.locally_of_locally _ hloc
    intro R S _ _ psi hpsi
    algebraize [psi]
    change Algebra.Smooth R S
    infer_instance
  have hsmooth : phi.hom.Smooth := by
    exact (RingHom.locally_iff_of_localizationSpanTarget
      RingHom.Smooth.propertyIsLocal.respectsIso RingHom.Smooth.ofLocalizationSpanTarget
      phi.hom).mp hlocsmooth
  exact formally_smooth_localRingHom phi.hom
    (RingHom.smooth_def.mp hsmooth).1 x.asIdeal

/-- BOTH formal directions of genuine étaleness pass to the original
stalk algebra. In particular full universal differential base change
is available in every characteristic. -/
theorem actual_etale_stalk_algebra_formallyEtale
    {X Y : Scheme.{u}} (f : X ⟶ Y) [IsEtale f] (x : X) :
    letI := (f.stalkMap x).hom.toAlgebra
    Algebra.FormallyEtale (Y.presheaf.stalk (f x)) (X.presheaf.stalk x) := by
  letI := (f.stalkMap x).hom.toAlgebra
  letI : Algebra.FormallySmooth (Y.presheaf.stalk (f x)) (X.presheaf.stalk x) :=
    actual_smooth_stalk_map_formallySmooth f x
  letI : Algebra.FormallyUnramified (Y.presheaf.stalk (f x)) (X.presheaf.stalk x) :=
    Litt3.Jacobians.scheme_stalk_map_formallyUnramified f x
  exact Algebra.FormallyEtale.of_formallyUnramified_and_formallySmooth

end Litt3.CartierAndSpin
