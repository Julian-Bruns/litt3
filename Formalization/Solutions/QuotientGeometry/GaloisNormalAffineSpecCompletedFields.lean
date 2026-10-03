import Solutions.QuotientGeometry.GaloisNormalAffineLocalData
import Solutions.QuotientGeometry.GaloisNormalizationDVRs
import Solutions.QuotientGeometry.DedekindAffineCompletionParameters
import Solutions.QuotientGeometry.SpecFixedBaseStalkMaps
import Solutions.QuotientGeometry.DVRCompletedDiagramTransport

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

include K L in
/-- EVERY pair of points in an ORIGINAL normal integral affine
Galois fiber has equivalent entire completed original Scheme stalk
fields over the SAME original base Scheme stalk. No normalization
presentation, independent upstairs finite/Dedekind data, local-ring
equivalence or completed square is assumed. -/
theorem actual_normal_affine_galois_spec_completed_fields_equivalent
    (J : PrimeSpectrum A) (hJ : J.asIdeal ≠ ⊥) (P Q : PrimeSpectrum R)
    (hJP : J = Spec.map (CommRingCat.ofHom (algebraMap A R)) P)
    (hJQ : J = Spec.map (CommRingCat.ofHom (algebraMap A R)) Q)
    (tJ : (Spec (.of A)).presheaf.stalk J) (htJ : Irreducible tJ)
    (tP : (Spec (.of R)).presheaf.stalk P) (htP : Irreducible tP)
    (tQ : (Spec (.of R)).presheaf.stalk Q) (htQ : Irreducible tQ) :
    let f := Spec.map (CommRingCat.ofHom (algebraMap A R))
    let sA := actualAffineStructureMap (k := k) (A := A)
    let sR := actualAffineStructureMap (k := k) (A := R)
    letI := actual_dedekind_affine_scheme_stalk_dvr J hJ
    letI := actual_normal_affine_galois_spec_stalk_dvr (K := K) (L := L)
      J.asIdeal hJ P (congrArg PrimeSpectrum.asIdeal hJP)
    letI := actual_normal_affine_galois_spec_stalk_dvr (K := K) (L := L)
      J.asIdeal hJ Q (congrArg PrimeSpectrum.asIdeal hJQ)
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sA J).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sR P).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sR Q).toAlgebra
    let dJ := actualDedekindSpecCompletionParameters (k := k) J hJ tJ htJ
    let dP := actualNormalAffineGaloisSpecParameters (k := k) (K := K) (L := L)
      J.asIdeal hJ P (congrArg PrimeSpectrum.asIdeal hJP) tP htP
    let dQ := actualNormalAffineGaloisSpecParameters (k := k) (K := K) (L := L)
      J.asIdeal hJ Q (congrArg PrimeSpectrum.asIdeal hJQ) tQ htQ
    let χP := actualSchemeFixedBaseStalkMap f sR sA actual_affine_structure_map_square J P hJP
    let χQ := actualSchemeFixedBaseStalkMap f sR sA actual_affine_structure_map_square J Q hJQ
    ParameterFieldsEquivalent
      (completedDVRLaurentMap dJ dP χP (actual_spec_fixed_base_stalk_map_injective J P hJP
        (actual_normal_affine_fraction_base_injective (A := A) (R := R) (K := K) (L := L))))
      (completedDVRLaurentMap dJ dQ χQ (actual_spec_fixed_base_stalk_map_injective J Q hJQ
        (actual_normal_affine_fraction_base_injective (A := A) (R := R) (K := K) (L := L)))) := by
  let f := Spec.map (CommRingCat.ofHom (algebraMap A R))
  let sA := actualAffineStructureMap (k := k) (A := A)
  let sR := actualAffineStructureMap (k := k) (A := R)
  let hIP := congrArg PrimeSpectrum.asIdeal hJP
  let hIQ := congrArg PrimeSpectrum.asIdeal hJQ
  letI : IsDedekindDomain R := actual_normal_affine_galois_dedekind (A := A) (K := K) (L := L)
  letI : Algebra.FiniteType k R := actual_normal_affine_galois_finiteType (A := A) (K := K) (L := L)
  have hP := actual_normal_affine_galois_prime_ne_bot (K := K) (L := L) J.asIdeal hJ P.asIdeal hIP
  have hQ := actual_normal_affine_galois_prime_ne_bot (K := K) (L := L) J.asIdeal hJ Q.asIdeal hIQ
  letI := actual_dedekind_affine_scheme_stalk_dvr J hJ
  letI := actual_normal_affine_galois_spec_stalk_dvr (K := K) (L := L) J.asIdeal hJ P hIP
  letI := actual_normal_affine_galois_spec_stalk_dvr (K := K) (L := L) J.asIdeal hJ Q hIQ
  letI := actual_dedekind_base_prime_dvr A J.asIdeal hJ
  letI := actual_dedekind_base_prime_dvr R P.asIdeal hP
  letI := actual_dedekind_base_prime_dvr R Q.asIdeal hQ
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sA J).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sR P).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sR Q).toAlgebra
  let dJ := actualDedekindSpecCompletionParameters (k := k) J hJ tJ htJ
  let dP := actualNormalAffineGaloisSpecParameters (k := k) (K := K) (L := L)
    J.asIdeal hJ P hIP tP htP
  let dQ := actualNormalAffineGaloisSpecParameters (k := k) (K := K) (L := L)
    J.asIdeal hJ Q hIQ tQ htQ
  let χP := actualSchemeFixedBaseStalkMap f sR sA actual_affine_structure_map_square J P hJP
  let χQ := actualSchemeFixedBaseStalkMap f sR sA actual_affine_structure_map_square J Q hJQ
  let eJ := actualSpecStalkCoefficientAlgEquiv (k := k) J
  let eP := actualSpecStalkCoefficientAlgEquiv (k := k) P
  let eQ := actualSpecStalkCoefficientAlgEquiv (k := k) Q
  let dJL := actualDedekindAffineParameters (k := k) J.asIdeal hJ (eJ tJ)
    ((MulEquiv.irreducible_iff eJ).mpr htJ)
  let dPL := actualDedekindAffineParameters (k := k) P.asIdeal hP (eP tP)
    ((MulEquiv.irreducible_iff eP).mpr htP)
  let dQL := actualDedekindAffineParameters (k := k) Q.asIdeal hQ (eQ tQ)
    ((MulEquiv.irreducible_iff eQ).mpr htQ)
  let θP := localizedCoefficientBaseMap (k := k) J.asIdeal P.asIdeal hIP
  let θQ := localizedCoefficientBaseMap (k := k) J.asIdeal Q.asIdeal hIQ
  have hi := actual_normal_affine_fraction_base_injective (A := A) (R := R) (K := K) (L := L)
  obtain ⟨e, _⟩ := actual_normal_affine_galois_fiber_local_equivalences
    (K := K) (L := L) J.asIdeal P.asIdeal Q.asIdeal hIP hIQ
  have hfields := dvr_base_equiv_completed_fields dJL dPL dQL θP θQ
    (localizedCoefficientBaseMap_injective hi J.asIdeal P.asIdeal hIP)
    (localizedCoefficientBaseMap_injective hi J.asIdeal Q.asIdeal hIQ)
    (e.restrictScalars k) (localized_equiv_coefficient_base_maps J.asIdeal
      P.asIdeal Q.asIdeal hIP hIQ e)
  exact actual_dvr_completed_field_comparison_transport dJ dJL dP dQ dPL dQL
    χP χQ θP θQ
    (actual_spec_fixed_base_stalk_map_injective J P hJP hi)
    (actual_spec_fixed_base_stalk_map_injective J Q hJQ hi)
    (localizedCoefficientBaseMap_injective hi J.asIdeal P.asIdeal hIP)
    (localizedCoefficientBaseMap_injective hi J.asIdeal Q.asIdeal hIQ)
    eJ eP eQ (actual_spec_fixed_base_stalk_map_localization J P hJP)
    (actual_spec_fixed_base_stalk_map_localization J Q hJQ) hfields

end Litt3.QuotientGeometry
