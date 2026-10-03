import Definitions.SharedTensors.SchemeFunctionFields
import Definitions.Jacobians.SchemeDivisors
import Theorems.Jacobians.SchemeValuationPullbacks
import Solutions.Jacobians.PrincipalPullbacks
import Mathlib.AlgebraicGeometry.Morphisms.FormallyUnramified
import Mathlib.AlgebraicGeometry.Morphisms.FiniteType
import Mathlib.RingTheory.EssentialFiniteness

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.Jacobians

universe u

theorem formally_unramified_localRingHom
    {R S : Type*} [CommRing R] [CommRing S] (φ : R →+* S)
    (hφ : φ.FormallyUnramified) (J : Ideal S) [J.IsPrime] :
    (Localization.localRingHom (J.comap φ) J φ rfl).FormallyUnramified := by
  algebraize [φ]
  letI : Algebra (Localization.AtPrime (J.comap φ)) (Localization.AtPrime J) :=
    (Localization.localRingHom (J.comap φ) J φ rfl).toAlgebra
  haveI : IsScalarTower R (Localization.AtPrime (J.comap φ)) (Localization.AtPrime J) :=
    IsScalarTower.of_algebraMap_eq fun x =>
      (Localization.localRingHom_to_map _ _ _ rfl x).symm
  change Algebra.FormallyUnramified (Localization.AtPrime (J.comap φ))
    (Localization.AtPrime J)
  exact Algebra.FormallyUnramified.of_restrictScalars R _ _

theorem finiteType_localRingHom_essFiniteType
    {R S : Type*} [CommRing R] [CommRing S] (φ : R →+* S)
    (hφ : φ.FiniteType) (J : Ideal S) [J.IsPrime] :
    (Localization.localRingHom (J.comap φ) J φ rfl).EssFiniteType := by
  algebraize [φ]
  letI : Algebra (Localization.AtPrime (J.comap φ)) (Localization.AtPrime J) :=
    (Localization.localRingHom (J.comap φ) J φ rfl).toAlgebra
  haveI : IsScalarTower R (Localization.AtPrime (J.comap φ)) (Localization.AtPrime J) :=
    IsScalarTower.of_algebraMap_eq fun x =>
      (Localization.localRingHom_to_map _ _ _ rfl x).symm
  change Algebra.EssFiniteType (Localization.AtPrime (J.comap φ)) (Localization.AtPrime J)
  exact Algebra.EssFiniteType.of_comp R _ _

theorem essFiniteType_respectsIso : RingHom.RespectsIso RingHom.EssFiniteType := by
  have hcomp : RingHom.StableUnderComposition RingHom.EssFiniteType := by
    intro R S T _ _ _ φ ψ hφ hψ
    algebraize [φ, ψ, ψ.comp φ]
    exact Algebra.EssFiniteType.comp R S T
  apply hcomp.respectsIso
  intro R S _ _ e
  exact (RingHom.FiniteType.of_surjective e.toRingHom e.surjective).essFiniteType

/-- Formal unramifiedness of the actual map passes to its actual stalk maps. -/
theorem scheme_stalk_map_formallyUnramified
    {X Y : Scheme.{u}} (f : X ⟶ Y) [AlgebraicGeometry.FormallyUnramified f] (x : X) :
    (f.stalkMap x).hom.FormallyUnramified := by
  apply HasRingHomProperty.stalkMap (P := @AlgebraicGeometry.FormallyUnramified)
    (hf := inferInstance)
  intro R S _ _ φ hφ J hJ
  letI := hJ
  exact formally_unramified_localRingHom φ hφ J

/-- Local finite type gives essential finite type on stalks, without
assuming that a localization itself is of finite type. -/
theorem scheme_stalk_map_essFiniteType
    {X Y : Scheme.{u}} (f : X ⟶ Y) [LocallyOfFiniteType f] (x : X) :
    (f.stalkMap x).hom.EssFiniteType := by
  have hQi := essFiniteType_respectsIso
  wlog h : IsAffine X ∧ IsAffine Y generalizing X Y f
  · obtain ⟨U, hU, hfx, _⟩ := Opens.isBasis_iff_nbhd.mp Y.isBasis_affineOpens
      (Opens.mem_top <| f x)
    obtain ⟨V, hV, hx, e⟩ := Opens.isBasis_iff_nbhd.mp X.isBasis_affineOpens
      (show x ∈ f ⁻¹ᵁ U from hfx)
    rw [← hQi.arrow_mk_iso_iff (Scheme.Hom.resLEStalkMap f e ⟨x, hx⟩)]
    exact this (f.resLE U V e) ⟨x, hx⟩ ⟨hV, hU⟩
  obtain ⟨hX, hY⟩ := h
  wlog hXY : ∃ R S, Y = Spec R ∧ X = Spec S generalizing X Y
  · have : (((X.isoSpec.inv ≫ f ≫ Y.isoSpec.hom).stalkMap (X.isoSpec.hom x)).hom).EssFiniteType := by
      apply this (X.isoSpec.inv ≫ f ≫ Y.isoSpec.hom) (X.isoSpec.hom x)
        inferInstance inferInstance
      exact ⟨_, _, rfl, rfl⟩
    rw [Scheme.Hom.stalkMap_comp, Scheme.Hom.stalkMap_comp, CommRingCat.hom_comp,
      hQi.cancel_right_isIso, CommRingCat.hom_comp, hQi.cancel_left_isIso] at this
    have heq : X.isoSpec.inv (X.isoSpec.hom x) = x := by simp
    rwa [hQi.arrow_mk_iso_iff (f.arrowStalkMapIsoOfEq heq)] at this
  obtain ⟨R, S, rfl, rfl⟩ := hXY
  obtain ⟨φ, rfl⟩ := Spec.map_surjective f
  rw [hQi.arrow_mk_iso_iff (Scheme.arrowStalkMapSpecIso φ _)]
  have hφ : φ.hom.FiniteType :=
    HasRingHomProperty.Spec_iff (P := @LocallyOfFiniteType) |>.mp inferInstance
  exact finiteType_localRingHom_essFiniteType φ.hom hφ x.asIdeal

/-- The generic-stalk pullback commutes with the actual local-to-function
field maps at every point. -/
theorem scheme_function_field_pullback_stalk
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (f : X ⟶ Y) [Surjective f] (x : X) (a : Y.presheaf.stalk (f x)) :
    Litt3.SharedTensors.schemeFunctionFieldPullback f
        (algebraMap (Y.presheaf.stalk (f x)) Y.functionField a) =
      algebraMap (X.presheaf.stalk x) X.functionField ((f.stalkMap x).hom a) := by
  change f.stalkMap (genericPoint X)
      ((Y.presheaf.stalkCongr (.of_eq
        (Litt3.SharedTensors.scheme_genericPoint_eq_of_surjective f))).inv
        (Y.presheaf.stalkSpecializes ((genericPoint_spec Y).specializes trivial) a)) = _
  rw [TopCat.Presheaf.stalkCongr_inv]
  have hc := Y.presheaf.stalkSpecializes_comp (z := f x)
    (Inseparable.of_eq (Litt3.SharedTensors.scheme_genericPoint_eq_of_surjective f)).le
    ((genericPoint_spec Y).specializes trivial)
  have hc' := DFunLike.congr_fun (CommRingCat.hom_ext_iff.mp hc) a
  simp only [CommRingCat.hom_comp, RingHom.comp_apply] at hc'
  rw [hc']
  exact f.stalkSpecializes_stalkMap_apply (genericPoint X) x
    ((genericPoint_spec X).specializes trivial) a

/-- Actual unramified scheme maps preserve the normalized valuations at
points whose actual local rings are DVRs. No valuation compatibility is
taken as an assumption. -/
theorem scheme_unramified_dvr_valuation_preserved
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (f : X ⟶ Y) [Surjective f] [AlgebraicGeometry.FormallyUnramified f]
    [LocallyOfFiniteType f] (x : X)
    [IsDiscreteValuationRing (X.presheaf.stalk x)]
    [IsDiscreteValuationRing (Y.presheaf.stalk (f x))] (t : Y.functionField) :
    (discreteValuationPlace (X.presheaf.stalk x)).valuation X.functionField
        (Litt3.SharedTensors.schemeFunctionFieldPullback f t) =
      (discreteValuationPlace (Y.presheaf.stalk (f x))).valuation Y.functionField t := by
  let R := Y.presheaf.stalk (f x)
  let S := X.presheaf.stalk x
  letI : Algebra R S := (f.stalkMap x).hom.toAlgebra
  letI : Algebra R X.functionField :=
    ((algebraMap S X.functionField).comp (f.stalkMap x).hom).toAlgebra
  haveI : IsScalarTower R S X.functionField := IsScalarTower.of_algebraMap_eq' rfl
  haveI : IsLocalHom (algebraMap R S) := f.toLRSHom.prop x
  haveI : Algebra.EssFiniteType R S := scheme_stalk_map_essFiniteType f x
  haveI : Algebra.FormallyUnramified R S := scheme_stalk_map_formallyUnramified f x
  exact unramified_dvr_fraction_field_valuation_preserved
    (Litt3.SharedTensors.schemeFunctionFieldPullback f)
    (scheme_function_field_pullback_stalk f x) t

theorem scheme_closed_point_valuation_pullback
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    [ClosedPointDVRStalks X] [ClosedPointDVRStalks Y]
    (f : X ⟶ Y) [IsFinite f] [Surjective f]
    [AlgebraicGeometry.FormallyUnramified f] [LocallyOfFiniteType f]
    (x : Litt3.SharedTensors.ClosedPoint X) (t : Y.functionField) :
    closedPointValuation X x (Litt3.SharedTensors.schemeFunctionFieldPullback f t) =
      closedPointValuation Y (Litt3.SharedTensors.mapClosedPoint f x) t := by
  haveI : IsDiscreteValuationRing (Y.presheaf.stalk (f x.val)) :=
    ClosedPointDVRStalks.dvr_stalk (Litt3.SharedTensors.mapClosedPoint f x)
  exact scheme_unramified_dvr_valuation_preserved f x.val t

/-- The actual closed-point pullback carries principal divisors to principal
divisors through the actual generic-stalk function-field map. -/
theorem scheme_principal_divisor_pullback
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    [ClosedPointDVRStalks X] [ClosedPointDVRStalks Y]
    [FinitePrincipalSupport X] [FinitePrincipalSupport Y]
    (f : X ⟶ Y) [IsFinite f] [Surjective f]
    [AlgebraicGeometry.FormallyUnramified f] [LocallyOfFiniteType f]
    (t : Additive Y.functionFieldˣ) :
    principalDivisorMap (schemeDivisorSystem X)
        (rationalUnitPullback (Litt3.SharedTensors.schemeFunctionFieldPullback f) t) =
      Litt3.SharedTensors.schemeDivisorPullback f
        (principalDivisorMap (schemeDivisorSystem Y) t) := by
  exact principal_divisor_pullback (schemeDivisorSystem Y) (schemeDivisorSystem X)
    (Litt3.SharedTensors.mapClosedPoint f) (Litt3.SharedTensors.mapClosedPoint_finite_preimage f)
    (Litt3.SharedTensors.schemeFunctionFieldPullback f)
    (scheme_closed_point_valuation_pullback f) t

noncomputable def schemeDivisorClassPullback
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    [ClosedPointDVRStalks X] [ClosedPointDVRStalks Y]
    [FinitePrincipalSupport X] [FinitePrincipalSupport Y]
    (f : X ⟶ Y) [IsFinite f] [Surjective f]
    [AlgebraicGeometry.FormallyUnramified f] [LocallyOfFiniteType f] :
    DivisorClassGroup (schemeDivisorSystem Y) →+ DivisorClassGroup (schemeDivisorSystem X) :=
  divisorClassPullback (schemeDivisorSystem Y) (schemeDivisorSystem X)
    (Litt3.SharedTensors.mapClosedPoint f) (Litt3.SharedTensors.mapClosedPoint_finite_preimage f)
    (Litt3.SharedTensors.schemeFunctionFieldPullback f)
    (scheme_closed_point_valuation_pullback f)

theorem scheme_divisor_class_pullback_representative
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    [ClosedPointDVRStalks X] [ClosedPointDVRStalks Y]
    [FinitePrincipalSupport X] [FinitePrincipalSupport Y]
    (f : X ⟶ Y) [IsFinite f] [Surjective f]
    [AlgebraicGeometry.FormallyUnramified f] [LocallyOfFiniteType f]
    (D : Divisor (Litt3.SharedTensors.ClosedPoint Y)) :
    schemeDivisorClassPullback f (divisorClassMap (schemeDivisorSystem Y) D) =
      divisorClassMap (schemeDivisorSystem X) (Litt3.SharedTensors.schemeDivisorPullback f D) := rfl

theorem same_source_principal_pullbacks
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    [ClosedPointDVRStalks X] [ClosedPointDVRStalks Y]
    [FinitePrincipalSupport X] [FinitePrincipalSupport Y]
    (s : Litt3.SharedTensors.FiniteEtaleSpan X Y)
    [IsIntegral s.source] [ClosedPointDVRStalks s.source] [FinitePrincipalSupport s.source] :
    SameSourcePrincipalPullbacks s :=
  ⟨scheme_principal_divisor_pullback s.left, scheme_principal_divisor_pullback s.right⟩

end Litt3.Jacobians
