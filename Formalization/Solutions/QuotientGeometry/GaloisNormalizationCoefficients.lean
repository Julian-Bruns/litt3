import Solutions.QuotientGeometry.GaloisNormalizationDVRs
import Solutions.QuotientGeometry.ClosedAffineResidueCoefficients

namespace Litt3.QuotientGeometry

variable {k A K L : Type*} [Field k] [IsAlgClosed k]
  [CommRing A] [IsDomain A] [IsDedekindDomain A] [Algebra k A]
  [Algebra.FiniteType k A] [Field K] [Field L]
  [Algebra A K] [Algebra K L] [Algebra A L] [IsScalarTower A K L]
  [Algebra k L] [IsScalarTower k A L]
  [IsFractionRing A K] [FiniteDimensional K L] [IsGalois K L]

include K in
/-- Every actual normalization prime over a nonzero Dedekind base
prime is nonzero. -/
theorem actual_galois_normalization_prime_ne_bot
    (J : Ideal A) (hJ : J ≠ ⊥)
    (P : Ideal (integralClosure A L))
    (hJP : J = P.comap (algebraMap A (integralClosure A L))) : P ≠ ⊥ := by
  intro hP
  apply hJ
  rw [hJP, hP]
  exact Ideal.comap_bot_of_injective _ (galois_integral_closure_base_injective A K L)

include K in
/-- Finite Galois normalization of an actual finite-type Dedekind
coordinate algebra has the original coefficient field as the actual
residue field at every prime over a nonzero base prime. Both finite
normalization and residue surjectivity are derived. -/
theorem actual_galois_normalization_residue_coefficients_surjective
    (J : Ideal A) (hJ : J ≠ ⊥)
    (P : Ideal (integralClosure A L)) [P.IsPrime]
    (hJP : J = P.comap (algebraMap A (integralClosure A L))) :
    Function.Surjective (algebraMap k P.ResidueField) := by
  letI : IsDedekindDomain (integralClosure A L) := integralClosure.isDedekindDomain A K L
  letI : P.IsMaximal := Ideal.IsPrime.isMaximal inferInstance
    (actual_galois_normalization_prime_ne_bot (K := K) J hJ P hJP)
  letI : Module.Finite A (integralClosure A L) :=
    IsIntegralClosure.finite A K L (integralClosure A L)
  haveI : Algebra.FiniteType k (integralClosure A L) :=
    Algebra.FiniteType.trans (inferInstance : Algebra.FiniteType k A)
      (inferInstance : Algebra.FiniteType A (integralClosure A L))
  exact closed_affine_residue_coefficients_surjective P

include K in
/-- An actual chosen uniformizer of the original normalization local
ring constructs all completion data. The DVR and residue-field
properties follow from the genuine finite Galois normalization. -/
noncomputable def actualGaloisNormalizationParameters
    (J : Ideal A) (hJ : J ≠ ⊥)
    (P : Ideal (integralClosure A L)) [P.IsPrime]
    (hJP : J = P.comap (algebraMap A (integralClosure A L)))
    (t : Localization.AtPrime P) (ht : Irreducible t) :
    letI := actual_galois_normalization_prime_dvr A K L J hJ P hJP
    DVRCompletionParameters k (Localization.AtPrime P) := by
  letI := actual_galois_normalization_prime_dvr A K L J hJ P hJP
  exact ⟨t, ht,
    actual_galois_normalization_residue_coefficients_surjective (K := K) J hJ P hJP⟩

end Litt3.QuotientGeometry
