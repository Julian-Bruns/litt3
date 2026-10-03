import Solutions.QuotientGeometry.GaloisNormalizationSpecCompletedFields
import Solutions.QuotientGeometry.SchemeFixedSameSourceCompletedFields
import Solutions.QuotientGeometry.SeparableNormalizationSchemeMaps
import Solutions.QuotientGeometry.ParameterFieldEquivalenceRelation

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
/-- BOTH original maps from ONE actual Scheme, unramified at two
selected source points, identify the whole endpoint completed fields
at their images over the SAME base point through the genuine Galois
normalization fiber. No fiber equivalence or completion square is
assumed. The source/endpoint local DVR parameter data remain explicit. -/
theorem actual_galois_normalization_same_source_fiber_fields_equivalent
    {T Y : Scheme.{u}} [IsIntegral T] [IsIntegral Y]
    (f : T ⟶ Y) (g : T ⟶ Spec (.of (integralClosure A L)))
    (χ : Y ⟶ Spec (.of A))
    [LocallyOfFiniteType f] [LocallyOfFiniteType g] [Surjective χ]
    (sT : T ⟶ Spec (.of k)) (sY : Y ⟶ Spec (.of k))
    (hf : f ≫ sY = sT)
    (hg : g ≫ actualAffineStructureMap (k := k) (A := integralClosure A L) = sT)
    (hχ : χ ≫ actualAffineStructureMap (k := k) (A := A) = sY)
    (hcomm : f ≫ χ = g ≫ Spec.map (CommRingCat.ofHom (algebraMap A (integralClosure A L))))
    (t₁ t₂ : T) (J : PrimeSpectrum A) (hJ : J.asIdeal ≠ ⊥)
    (hJP : J = Spec.map (CommRingCat.ofHom (algebraMap A (integralClosure A L))) (g t₁))
    (hJQ : J = Spec.map (CommRingCat.ofHom (algebraMap A (integralClosure A L))) (g t₂))
    (huf₁ : (f.stalkMap t₁).hom.FormallyUnramified)
    (hug₁ : (g.stalkMap t₁).hom.FormallyUnramified)
    (huf₂ : (f.stalkMap t₂).hom.FormallyUnramified)
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
      (dT₂ : DVRCompletionParameters k (T.presheaf.stalk t₂)),
    ParameterFieldsEquivalent
      (completedDVRLaurentMap dJ d₁ (actualSchemeFixedBaseStalkMap χ sY sA hχ J (f t₁) hb₁)
        (actual_integral_fixed_base_scheme_stalk_injective χ sY sA hχ J (f t₁) hb₁))
      (completedDVRLaurentMap dJ d₂ (actualSchemeFixedBaseStalkMap χ sY sA hχ J (f t₂) hb₂)
        (actual_integral_fixed_base_scheme_stalk_injective χ sY sA hχ J (f t₂) hb₂)) := by
  let ν := Spec.map (CommRingCat.ofHom (algebraMap A (integralClosure A L)))
  let sA := actualAffineStructureMap (k := k) (A := A)
  let sC := actualAffineStructureMap (k := k) (A := integralClosure A L)
  letI : Surjective ν := actual_separable_normalization_spec_surjective (K := K)
  letI := actual_dedekind_affine_scheme_stalk_dvr J hJ
  letI := actual_galois_normalization_spec_stalk_dvr (K := K) J.asIdeal hJ (g t₁)
    (congrArg PrimeSpectrum.asIdeal hJP)
  letI := actual_galois_normalization_spec_stalk_dvr (K := K) J.asIdeal hJ (g t₂)
    (congrArg PrimeSpectrum.asIdeal hJQ)
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sA J).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sY (f t₁)).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sY (f t₂)).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sT t₁).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sT t₂).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sC (g t₁)).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sC (g t₂)).toAlgebra
  let hb₁ : J = χ (f t₁) := hJP.trans
    (congrArg (fun h : T ⟶ Spec (.of A) => h t₁) hcomm).symm
  let hb₂ : J = χ (f t₂) := hJQ.trans
    (congrArg (fun h : T ⟶ Spec (.of A) => h t₂) hcomm).symm
  let dJ := actualDedekindSpecCompletionParameters (k := k) J hJ uJ huJ
  let dP := actualGaloisSpecCompletionParameters (k := k) (K := K) J.asIdeal hJ (g t₁)
    (congrArg PrimeSpectrum.asIdeal hJP) uP huP
  let dQ := actualGaloisSpecCompletionParameters (k := k) (K := K) J.asIdeal hJ (g t₂)
    (congrArg PrimeSpectrum.asIdeal hJQ) uQ huQ
  dsimp only
  intro d₁ d₂ dT₁ dT₂
  have h₁ := actual_fixed_same_source_scheme_completed_fields_equivalent
    f g χ ν sT sY sC sA hf hg hχ actual_affine_structure_map_square hcomm
    t₁ J hb₁ hJP huf₁ hug₁ dJ d₁ dP dT₁
  have h₂ := actual_fixed_same_source_scheme_completed_fields_equivalent
    f g χ ν sT sY sC sA hf hg hχ actual_affine_structure_map_square hcomm
    t₂ J hb₂ hJQ huf₂ hug₂ dJ d₂ dQ dT₂
  have hG := actual_galois_normalization_spec_completed_fields_equivalent
    (k := k) (K := K) J hJ (g t₁) (g t₂) hJP hJQ uJ huJ uP huP uQ huQ
  exact (h₁.trans hG).trans h₂.symm

end Litt3.QuotientGeometry
