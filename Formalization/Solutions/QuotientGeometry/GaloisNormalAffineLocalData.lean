import Solutions.QuotientGeometry.GaloisNormalAffineFibers
import Solutions.QuotientGeometry.SpecDVRCompletionParameters
import Mathlib.RingTheory.DedekindDomain.IntegralClosure

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

universe u

variable {k A K L R : Type u} [Field k] [IsAlgClosed k]
  [CommRing A] [IsDomain A] [IsDedekindDomain A] [Algebra k A]
  [Algebra.FiniteType k A] [CommRing R] [IsDomain R] [IsIntegrallyClosed R]
  [Algebra A R] [Algebra k R] [IsScalarTower k A R]
  [Field K] [Field L] [Algebra A K] [Algebra K L] [Algebra A L]
  [Algebra R L] [IsScalarTower A K L] [IsScalarTower A R L]
  [IsFractionRing A K] [IsFractionRing R L] [Algebra.IsIntegral A R]
  [FiniteDimensional K L] [IsGalois K L]

include A

include K L in
/-- The original inclusion of a normal integral affine coordinate
algebra preserves the actual fraction-field base inclusion. -/
theorem actual_normal_affine_fraction_base_injective :
    Function.Injective (algebraMap A R) := by
  intro a b hab
  have h := congrArg (algebraMap R L) hab
  rw [← IsScalarTower.algebraMap_apply A R L,
    ← IsScalarTower.algebraMap_apply A R L] at h
  rw [IsScalarTower.algebraMap_apply A K L, IsScalarTower.algebraMap_apply A K L] at h
  exact IsFractionRing.injective A K ((algebraMap K L).injective h)

include K L in
/-- Dedekindness of the original normal integral coordinate ring
is derived from the genuine finite Galois function-field extension. -/
theorem actual_normal_affine_galois_dedekind : IsDedekindDomain R :=
  IsIntegralClosure.isDedekindDomain A K L R

include K L in
/-- The original normal integral affine coordinate ring is finite
type over the original coefficient field; finite normalization is
derived rather than supplied. -/
theorem actual_normal_affine_galois_finiteType : Algebra.FiniteType k R := by
  letI : Module.Finite A R := IsIntegralClosure.finite A K L R
  exact Algebra.FiniteType.trans (inferInstance : Algebra.FiniteType k A)
    (inferInstance : Algebra.FiniteType A R)

include K L in
theorem actual_normal_affine_galois_prime_ne_bot
    (J : Ideal A) (hJ : J ≠ ⊥) (P : Ideal R)
    (hJP : J = P.comap (algebraMap A R)) : P ≠ ⊥ := by
  intro hp
  apply hJ
  rw [hJP, hp]
  exact Ideal.comap_bot_of_injective _
    (actual_normal_affine_fraction_base_injective (K := K) (L := L))

include K L in
/-- The ORIGINAL Scheme stalk at every actual point in a normal
integral Galois affine fiber is a DVR. No normalization presentation
or independent upstairs Dedekind hypothesis is assumed. -/
theorem actual_normal_affine_galois_spec_stalk_dvr
    (J : Ideal A) (hJ : J ≠ ⊥) (P : PrimeSpectrum R)
    (hJP : J = P.asIdeal.comap (algebraMap A R)) :
    IsDiscreteValuationRing ((Spec (.of R)).presheaf.stalk P) := by
  letI : IsDedekindDomain R := actual_normal_affine_galois_dedekind (A := A) (K := K) (L := L)
  exact actual_dedekind_affine_scheme_stalk_dvr P
    (actual_normal_affine_galois_prime_ne_bot (K := K) (L := L) J hJ P.asIdeal hJP)

include K L in
/-- The original structure-map coefficients surject onto the true
stalk residue field in every normal integral Galois affine fiber. -/
theorem actual_normal_affine_galois_spec_residue_surjective
    (J : Ideal A) (hJ : J ≠ ⊥) (P : PrimeSpectrum R)
    (hJP : J = P.asIdeal.comap (algebraMap A R)) :
    letI := (Litt3.SharedTensors.stalkBaseFieldHom
      (actualAffineStructureMap (k := k) (A := R)) P).toAlgebra
    Function.Surjective (algebraMap k
      (IsLocalRing.ResidueField ((Spec (.of R)).presheaf.stalk P))) := by
  letI := (Litt3.SharedTensors.stalkBaseFieldHom
    (actualAffineStructureMap (k := k) (A := R)) P).toAlgebra
  letI : IsDedekindDomain R := actual_normal_affine_galois_dedekind (A := A) (K := K) (L := L)
  letI : Algebra.FiniteType k R := actual_normal_affine_galois_finiteType (A := A) (K := K) (L := L)
  letI : P.asIdeal.IsMaximal := Ideal.IsPrime.isMaximal P.isPrime
    (actual_normal_affine_galois_prime_ne_bot (K := K) (L := L) J hJ P.asIdeal hJP)
  exact actual_closed_affine_scheme_stalk_residue_surjective (k := k) P

include K L in
/-- Completion data of the ORIGINAL normal integral affine Scheme
stalk are constructed from its original uniformizer and genuine
function-field extension. -/
noncomputable def actualNormalAffineGaloisSpecParameters
    (J : Ideal A) (hJ : J ≠ ⊥) (P : PrimeSpectrum R)
    (hJP : J = P.asIdeal.comap (algebraMap A R))
    (t : (Spec (.of R)).presheaf.stalk P) (ht : Irreducible t) :
    letI := actual_normal_affine_galois_spec_stalk_dvr (K := K) (L := L) J hJ P hJP
    letI := (Litt3.SharedTensors.stalkBaseFieldHom
      (actualAffineStructureMap (k := k) (A := R)) P).toAlgebra
    DVRCompletionParameters k ((Spec (.of R)).presheaf.stalk P) := by
  letI := actual_normal_affine_galois_spec_stalk_dvr (K := K) (L := L) J hJ P hJP
  letI := (Litt3.SharedTensors.stalkBaseFieldHom
    (actualAffineStructureMap (k := k) (A := R)) P).toAlgebra
  exact ⟨t, ht, actual_normal_affine_galois_spec_residue_surjective
    (K := K) (L := L) J hJ P hJP⟩

end Litt3.QuotientGeometry
