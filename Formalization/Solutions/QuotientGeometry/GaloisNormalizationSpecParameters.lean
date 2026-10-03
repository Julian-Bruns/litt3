import Solutions.QuotientGeometry.GaloisNormalizationCoefficients
import Solutions.QuotientGeometry.SpecDVRCompletionParameters

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
/-- The ORIGINAL normalization Scheme stalk over a nonzero base
prime is a DVR, derived from the actual finite Galois field extension. -/
theorem actual_galois_normalization_spec_stalk_dvr
    (J : Ideal A) (hJ : J ≠ ⊥) (P : PrimeSpectrum (integralClosure A L))
    (hJP : J = P.asIdeal.comap (algebraMap A (integralClosure A L))) :
    IsDiscreteValuationRing ((Spec (.of (integralClosure A L))).presheaf.stalk P) := by
  letI : IsDedekindDomain (integralClosure A L) := integralClosure.isDedekindDomain A K L
  exact actual_dedekind_affine_scheme_stalk_dvr P
    (actual_galois_normalization_prime_ne_bot (K := K) J hJ P.asIdeal hJP)

include K in
/-- The genuine structure-map coefficients surject onto every
original normalization Scheme stalk residue field above a nonzero
base prime. -/
theorem actual_galois_normalization_spec_stalk_residue_surjective
    (J : Ideal A) (hJ : J ≠ ⊥) (P : PrimeSpectrum (integralClosure A L))
    (hJP : J = P.asIdeal.comap (algebraMap A (integralClosure A L))) :
    letI := (Litt3.SharedTensors.stalkBaseFieldHom
      (actualAffineStructureMap (k := k) (A := integralClosure A L)) P).toAlgebra
    Function.Surjective (algebraMap k (IsLocalRing.ResidueField
      ((Spec (.of (integralClosure A L))).presheaf.stalk P))) := by
  letI := (Litt3.SharedTensors.stalkBaseFieldHom
    (actualAffineStructureMap (k := k) (A := integralClosure A L)) P).toAlgebra
  exact actual_local_algEquiv_residue_coefficients_surjective
    (actualSpecStalkCoefficientAlgEquiv (k := k) P)
    (actual_galois_normalization_residue_coefficients_surjective (K := K) J hJ P.asIdeal hJP)

include K in
/-- A uniformizer of the ORIGINAL normalization Scheme stalk gives
all literal completion parameters; its DVR and residue properties
are consequences, rather than independent inputs. -/
noncomputable def actualGaloisSpecCompletionParameters
    (J : Ideal A) (hJ : J ≠ ⊥) (P : PrimeSpectrum (integralClosure A L))
    (hJP : J = P.asIdeal.comap (algebraMap A (integralClosure A L)))
    (t : (Spec (.of (integralClosure A L))).presheaf.stalk P) (ht : Irreducible t) :
    letI := actual_galois_normalization_spec_stalk_dvr (K := K) J hJ P hJP
    letI := (Litt3.SharedTensors.stalkBaseFieldHom
      (actualAffineStructureMap (k := k) (A := integralClosure A L)) P).toAlgebra
    DVRCompletionParameters k ((Spec (.of (integralClosure A L))).presheaf.stalk P) := by
  letI := actual_galois_normalization_spec_stalk_dvr (K := K) J hJ P hJP
  letI := (Litt3.SharedTensors.stalkBaseFieldHom
    (actualAffineStructureMap (k := k) (A := integralClosure A L)) P).toAlgebra
  exact ⟨t, ht, actual_galois_normalization_spec_stalk_residue_surjective
    (K := K) J hJ P hJP⟩

end Litt3.QuotientGeometry
