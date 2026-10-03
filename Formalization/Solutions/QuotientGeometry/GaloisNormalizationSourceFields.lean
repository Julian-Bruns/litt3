import Solutions.QuotientGeometry.GaloisNormalizationCompletedFields
import Solutions.QuotientGeometry.ParameterFieldEquivalenceRelation

namespace Litt3.QuotientGeometry

variable {k A K L R₁ R₂ S₁ S₂ : Type*} [Field k] [IsAlgClosed k]
  [CommRing A] [IsDomain A] [IsDedekindDomain A] [Algebra k A]
  [Algebra.FiniteType k A] [Field K] [Field L]
  [Algebra A K] [Algebra K L] [Algebra A L] [IsScalarTower A K L]
  [Algebra k L] [IsScalarTower k A L]
  [IsFractionRing A K] [FiniteDimensional K L] [IsGalois K L]
  [CommRing R₁] [IsDomain R₁] [IsDiscreteValuationRing R₁] [Algebra k R₁]
  [CommRing R₂] [IsDomain R₂] [IsDiscreteValuationRing R₂] [Algebra k R₂]
  [CommRing S₁] [IsDomain S₁] [IsDiscreteValuationRing S₁] [Algebra k S₁]
  [CommRing S₂] [IsDomain S₂] [IsDiscreteValuationRing S₂] [Algebra k S₂]

include K in
/-- Two original local source diagrams, each retaining BOTH actual
unramified maps, identify the two endpoint completed fields through
the ENTIRE actual Galois normalization fiber. Galois transitivity,
normalization DVRs, coefficients and all completed comparisons are
constructed. These local source rings can be two stalks of the same
original global source; no simultaneous Galois closure is used. -/
theorem actual_galois_normalization_two_local_source_fields_equivalent
    (J : Ideal A) [J.IsPrime] (hJ : J ≠ ⊥)
    (P Q : Ideal (integralClosure A L)) [P.IsPrime] [Q.IsPrime]
    (hJP : J = P.comap (algebraMap A (integralClosure A L)))
    (hJQ : J = Q.comap (algebraMap A (integralClosure A L)))
    (tJ : Localization.AtPrime J) (htJ : Irreducible tJ)
    (tP : Localization.AtPrime P) (htP : Irreducible tP)
    (tQ : Localization.AtPrime Q) (htQ : Irreducible tQ)
    (d₁ : DVRCompletionParameters k R₁) (d₂ : DVRCompletionParameters k R₂)
    (dS₁ : DVRCompletionParameters k S₁) (dS₂ : DVRCompletionParameters k S₂)
    (χ₁ : Localization.AtPrime J →ₐ[k] R₁) (χ₂ : Localization.AtPrime J →ₐ[k] R₂)
    (φ₁ : R₁ →ₐ[k] S₁) (φ₂ : R₂ →ₐ[k] S₂)
    (ψP : Localization.AtPrime P →ₐ[k] S₁)
    (ψQ : Localization.AtPrime Q →ₐ[k] S₂)
    [IsLocalHom χ₁.toRingHom] [IsLocalHom χ₂.toRingHom]
    [IsLocalHom φ₁.toRingHom] [IsLocalHom φ₂.toRingHom]
    [IsLocalHom ψP.toRingHom] [IsLocalHom ψQ.toRingHom]
    (hi₁ : Function.Injective χ₁) (hi₂ : Function.Injective χ₂)
    (hu₁ : φ₁.toRingHom.FormallyUnramified) (hf₁ : φ₁.toRingHom.EssFiniteType)
    (hu₂ : φ₂.toRingHom.FormallyUnramified) (hf₂ : φ₂.toRingHom.EssFiniteType)
    (huP : ψP.toRingHom.FormallyUnramified) (hfP : ψP.toRingHom.EssFiniteType)
    (huQ : ψQ.toRingHom.FormallyUnramified) (hfQ : ψQ.toRingHom.EssFiniteType)
    (hbaseP : φ₁.comp χ₁ = ψP.comp (localizedCoefficientBaseMap J P hJP))
    (hbaseQ : φ₂.comp χ₂ = ψQ.comp (localizedCoefficientBaseMap J Q hJQ)) :
    letI := actual_dedekind_base_prime_dvr A J hJ
    let dJ := actualDedekindAffineParameters (k := k) J hJ tJ htJ
    ParameterFieldsEquivalent (completedDVRLaurentMap dJ d₁ χ₁ hi₁)
      (completedDVRLaurentMap dJ d₂ χ₂ hi₂) := by
  letI := actual_dedekind_base_prime_dvr A J hJ
  letI := actual_galois_normalization_prime_dvr A K L J hJ P hJP
  letI := actual_galois_normalization_prime_dvr A K L J hJ Q hJQ
  let dJ := actualDedekindAffineParameters (k := k) J hJ tJ htJ
  let dP := actualGaloisNormalizationParameters (k := k) (K := K) J hJ P hJP tP htP
  let dQ := actualGaloisNormalizationParameters (k := k) (K := K) J hJ Q hJQ tQ htQ
  have heP := same_source_unramified_dvr_laurent_fields_equivalent
    dJ d₁ dP dS₁ χ₁ (localizedCoefficientBaseMap J P hJP) φ₁ ψP hi₁
    (localizedCoefficientBaseMap_injective (galois_integral_closure_base_injective A K L)
      J P hJP) hu₁ hf₁ huP hfP hbaseP
  have heQ := same_source_unramified_dvr_laurent_fields_equivalent
    dJ d₂ dQ dS₂ χ₂ (localizedCoefficientBaseMap J Q hJQ) φ₂ ψQ hi₂
    (localizedCoefficientBaseMap_injective (galois_integral_closure_base_injective A K L)
      J Q hJQ) hu₂ hf₂ huQ hfQ hbaseQ
  have heG := actual_galois_normalization_completed_fields_equivalent (k := k) (K := K)
    J hJ P Q hJP hJQ tJ htJ tP htP tQ htQ
  exact heP.trans (heG.trans heQ.symm)

end Litt3.QuotientGeometry
