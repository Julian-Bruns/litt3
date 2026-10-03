import Solutions.QuotientGeometry.GaloisNormalizationSameSourceFiber
import Solutions.QuotientGeometry.DVRFieldEquivDifferentialScalars
import Mathlib.AlgebraicGeometry.Morphisms.Etale

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

universe u

variable {k A K L : Type u} [Field k] [IsAlgClosed k]
  [CommRing A] [IsDomain A] [IsDedekindDomain A] [Algebra k A]
  [Algebra.FiniteType k A] [Field K] [Field L]
  [Algebra A K] [Algebra K L] [Algebra A L] [IsScalarTower A K L]
  [Algebra k L] [IsScalarTower k A L]
  [IsFractionRing A K] [FiniteDimensional K L] [IsGalois K L]

include K in
/-- In a true common-source diagram with an actual etale endpoint
leg and actual Galois normalization leg unramified above the selected
fiber, the ORIGINAL endpoint function/differential scalars agree.
The comparison retains BOTH actual Scheme maps from the SAME source
and derives every full completed-field identification through the
original normalization fiber. -/
theorem actual_galois_normalization_same_source_differential_scalars_equal
    (p h m : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hm : 0 < m) (hdiv : h ∣ p - 1)
    (hchar : (h : k) ≠ 0) (hmchar : (m : k) ≠ 0)
    {T Y : Scheme.{u}} [IsIntegral T] [IsIntegral Y]
    (f : T ⟶ Y) (g : T ⟶ Spec (.of (integralClosure A L)))
    (χ : Y ⟶ Spec (.of A)) [IsEtale f] [LocallyOfFiniteType g] [Surjective χ]
    (sT : T ⟶ Spec (.of k)) (sY : Y ⟶ Spec (.of k))
    (hf : f ≫ sY = sT)
    (hg : g ≫ actualAffineStructureMap (k := k) (A := integralClosure A L) = sT)
    (hχ : χ ≫ actualAffineStructureMap (k := k) (A := A) = sY)
    (hcomm : f ≫ χ = g ≫ Spec.map (CommRingCat.ofHom (algebraMap A (integralClosure A L))))
    (t₁ t₂ : T) (J : PrimeSpectrum A) (hJ : J.asIdeal ≠ ⊥)
    (hJP : J = Spec.map (CommRingCat.ofHom (algebraMap A (integralClosure A L))) (g t₁))
    (hJQ : J = Spec.map (CommRingCat.ofHom (algebraMap A (integralClosure A L))) (g t₂))
    (hug₁ : (g.stalkMap t₁).hom.FormallyUnramified)
    (hug₂ : (g.stalkMap t₂).hom.FormallyUnramified)
    [IsDiscreteValuationRing (Y.presheaf.stalk (f t₁))]
    [IsDiscreteValuationRing (Y.presheaf.stalk (f t₂))]
    [IsDiscreteValuationRing (T.presheaf.stalk t₁)]
    [IsDiscreteValuationRing (T.presheaf.stalk t₂)]
    (uJ : (Spec (.of A)).presheaf.stalk J) (huJ : Irreducible uJ)
    (uP : (Spec (.of (integralClosure A L))).presheaf.stalk (g t₁)) (huP : Irreducible uP)
    (uQ : (Spec (.of (integralClosure A L))).presheaf.stalk (g t₂)) (huQ : Irreducible uQ) :
    let sA := actualAffineStructureMap (k := k) (A := A)
    letI := actual_dedekind_affine_scheme_stalk_dvr J hJ
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sA J).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sY (f t₁)).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sY (f t₂)).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sT t₁).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sT t₂).toAlgebra
    let hb₁ : J = χ (f t₁) := hJP.trans (congrArg (fun h : T ⟶ Spec (.of A) => h t₁) hcomm).symm
    let hb₂ : J = χ (f t₂) := hJQ.trans (congrArg (fun h : T ⟶ Spec (.of A) => h t₂) hcomm).symm
    let dJ := actualDedekindSpecCompletionParameters (k := k) J hJ uJ huJ
    ∀ (d₁ : DVRCompletionParameters k (Y.presheaf.stalk (f t₁)))
      (d₂ : DVRCompletionParameters k (Y.presheaf.stalk (f t₂)))
      (dT₁ : DVRCompletionParameters k (T.presheaf.stalk t₁))
      (dT₂ : DVRCompletionParameters k (T.presheaf.stalk t₂))
      (G₁ S₁ : Y.presheaf.stalk (f t₁)) (G₂ S₂ : Y.presheaf.stalk (f t₂))
      (c : k) (_hc : c ≠ 0)
      (_hG₁ : IsUnit G₁) (_hG₂ : IsUnit G₂) (_hS₁ : IsUnit S₁) (_hS₂ : IsUnit S₂),
    actualSchemeFixedBaseStalkMap χ sY sA hχ J (f t₁) hb₁ dJ.parameter * G₁ ^ m =
      d₁.parameter ^ (p * h) →
    actualSchemeFixedBaseStalkMap χ sY sA hχ J (f t₂) hb₂ dJ.parameter * G₂ ^ m =
      d₂.parameter ^ (p * h) →
    KaehlerDifferential.D k (Y.presheaf.stalk (f t₁)) G₁ =
      (algebraMap k (Y.presheaf.stalk (f t₁)) c * d₁.parameter ^ (p - 2) * S₁) •
        KaehlerDifferential.D k (Y.presheaf.stalk (f t₁)) d₁.parameter →
    KaehlerDifferential.D k (Y.presheaf.stalk (f t₂)) G₂ =
      (algebraMap k (Y.presheaf.stalk (f t₂)) c * d₂.parameter ^ (p - 2) * S₂) •
        KaehlerDifferential.D k (Y.presheaf.stalk (f t₂)) d₂.parameter →
    localDifferentialScalar p h m c (dvrResidueValue d₁ G₁) (dvrResidueValue d₁ S₁) =
      localDifferentialScalar p h m c (dvrResidueValue d₂ G₂) (dvrResidueValue d₂ S₂) := by
  let sA := actualAffineStructureMap (k := k) (A := A)
  letI := actual_dedekind_affine_scheme_stalk_dvr J hJ
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sA J).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sY (f t₁)).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sY (f t₂)).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sT t₁).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sT t₂).toAlgebra
  let hb₁ : J = χ (f t₁) := hJP.trans
    (congrArg (fun h : T ⟶ Spec (.of A) => h t₁) hcomm).symm
  let hb₂ : J = χ (f t₂) := hJQ.trans
    (congrArg (fun h : T ⟶ Spec (.of A) => h t₂) hcomm).symm
  let dJ := actualDedekindSpecCompletionParameters (k := k) J hJ uJ huJ
  dsimp only
  intro d₁ d₂ dT₁ dT₂ G₁ S₁ G₂ S₂ c hc hG₁ hG₂ hS₁ hS₂ hpolar₁ hpolar₂ hdiff₁ hdiff₂
  have heq := actual_galois_normalization_same_source_fiber_fields_equivalent
    (k := k) (K := K) f g χ sT sY hf hg hχ hcomm t₁ t₂ J hJ hJP hJQ
    (Litt3.Jacobians.scheme_stalk_map_formallyUnramified f t₁) hug₁
    (Litt3.Jacobians.scheme_stalk_map_formallyUnramified f t₂) hug₂
    uJ huJ uP huP uQ huQ d₁ d₂ dT₁ dT₂
  exact original_dvr_completed_fields_differential_scalars_equal p h m hh hm hdiv hchar hmchar
    dJ d₁ d₂ (actualSchemeFixedBaseStalkMap χ sY sA hχ J (f t₁) hb₁)
    (actualSchemeFixedBaseStalkMap χ sY sA hχ J (f t₂) hb₂)
    (actual_integral_fixed_base_scheme_stalk_injective χ sY sA hχ J (f t₁) hb₁)
    (actual_integral_fixed_base_scheme_stalk_injective χ sY sA hχ J (f t₂) hb₂)
    heq G₁ S₁ G₂ S₂ c hc hG₁ hG₂ hS₁ hS₂ hpolar₁ hpolar₂ hdiff₁ hdiff₂

end Litt3.QuotientGeometry
