import Solutions.QuotientGeometry.GaloisNormalizationCoefficients
import Solutions.QuotientGeometry.DedekindAffineCompletionParameters
import Solutions.QuotientGeometry.GaloisIntegralClosureCompletedFields

namespace Litt3.QuotientGeometry

variable {k A K L : Type*} [Field k] [IsAlgClosed k]
  [CommRing A] [IsDomain A] [IsDedekindDomain A] [Algebra k A]
  [Algebra.FiniteType k A] [Field K] [Field L]
  [Algebra A K] [Algebra K L] [Algebra A L] [IsScalarTower A K L]
  [Algebra k L] [IsScalarTower k A L]
  [IsFractionRing A K] [FiniteDimensional K L] [IsGalois K L]

include K in
/-- Every pair of original primes in a finite Galois normalization
fiber has equivalent ENTIRE completed fields over the SAME full
downstairs completed field. DVR properties, residue coefficients,
ring action, prime transitivity, actual local equivalences and complete
maps are constructed from the original field extension and actual
uniformizers. No local equivalence or completion data is supplied. -/
theorem actual_galois_normalization_completed_fields_equivalent
    (J : Ideal A) [J.IsPrime] (hJ : J ≠ ⊥)
    (P Q : Ideal (integralClosure A L)) [P.IsPrime] [Q.IsPrime]
    (hJP : J = P.comap (algebraMap A (integralClosure A L)))
    (hJQ : J = Q.comap (algebraMap A (integralClosure A L)))
    (tJ : Localization.AtPrime J) (htJ : Irreducible tJ)
    (tP : Localization.AtPrime P) (htP : Irreducible tP)
    (tQ : Localization.AtPrime Q) (htQ : Irreducible tQ) :
    letI := actual_dedekind_base_prime_dvr A J hJ
    letI := actual_galois_normalization_prime_dvr A K L J hJ P hJP
    letI := actual_galois_normalization_prime_dvr A K L J hJ Q hJQ
    let dJ := actualDedekindAffineParameters (k := k) J hJ tJ htJ
    let dP := actualGaloisNormalizationParameters (k := k) (K := K) J hJ P hJP tP htP
    let dQ := actualGaloisNormalizationParameters (k := k) (K := K) J hJ Q hJQ tQ htQ
    ParameterFieldsEquivalent
      (completedDVRLaurentMap dJ dP (localizedCoefficientBaseMap J P hJP)
        (localizedCoefficientBaseMap_injective
          (galois_integral_closure_base_injective A K L) J P hJP))
      (completedDVRLaurentMap dJ dQ (localizedCoefficientBaseMap J Q hJQ)
        (localizedCoefficientBaseMap_injective
          (galois_integral_closure_base_injective A K L) J Q hJQ)) := by
  letI := actual_dedekind_base_prime_dvr A J hJ
  letI := actual_galois_normalization_prime_dvr A K L J hJ P hJP
  letI := actual_galois_normalization_prime_dvr A K L J hJ Q hJQ
  exact actual_galois_integral_closure_completed_fields_equivalent (K := K) J P Q hJP hJQ
    (actualDedekindAffineParameters (k := k) J hJ tJ htJ)
    (actualGaloisNormalizationParameters (k := k) (K := K) J hJ P hJP tP htP)
    (actualGaloisNormalizationParameters (k := k) (K := K) J hJ Q hJQ tQ htQ)

end Litt3.QuotientGeometry
