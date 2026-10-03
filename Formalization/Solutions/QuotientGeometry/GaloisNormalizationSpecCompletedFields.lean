import Solutions.QuotientGeometry.GaloisNormalizationSpecParameters
import Solutions.QuotientGeometry.GaloisNormalizationCompletedFields
import Solutions.QuotientGeometry.SpecFixedBaseStalkMaps
import Solutions.QuotientGeometry.DVRCompletedDiagramTransport

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
/-- The ORIGINAL Scheme stalks of any two points in an actual finite
Galois normalization fiber have equivalent entire completed fields
over the SAME original base Scheme stalk. The DVR, residue, action,
fiber transitivity, localizations and full completed squares are all
derived from the actual field extension and original uniformizers. -/
theorem actual_galois_normalization_spec_completed_fields_equivalent
    (J : PrimeSpectrum A) (hJ : J.asIdeal ≠ ⊥)
    (P Q : PrimeSpectrum (integralClosure A L))
    (hJP : J = Spec.map (CommRingCat.ofHom (algebraMap A (integralClosure A L))) P)
    (hJQ : J = Spec.map (CommRingCat.ofHom (algebraMap A (integralClosure A L))) Q)
    (tJ : (Spec (.of A)).presheaf.stalk J) (htJ : Irreducible tJ)
    (tP : (Spec (.of (integralClosure A L))).presheaf.stalk P) (htP : Irreducible tP)
    (tQ : (Spec (.of (integralClosure A L))).presheaf.stalk Q) (htQ : Irreducible tQ) :
    let f := Spec.map (CommRingCat.ofHom (algebraMap A (integralClosure A L)))
    let sA := actualAffineStructureMap (k := k) (A := A)
    let sC := actualAffineStructureMap (k := k) (A := integralClosure A L)
    letI := actual_dedekind_affine_scheme_stalk_dvr J hJ
    letI := actual_galois_normalization_spec_stalk_dvr (K := K) J.asIdeal hJ P
      (congrArg PrimeSpectrum.asIdeal hJP)
    letI := actual_galois_normalization_spec_stalk_dvr (K := K) J.asIdeal hJ Q
      (congrArg PrimeSpectrum.asIdeal hJQ)
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sA J).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sC P).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sC Q).toAlgebra
    let dJ := actualDedekindSpecCompletionParameters (k := k) J hJ tJ htJ
    let dP := actualGaloisSpecCompletionParameters (k := k) (K := K) J.asIdeal hJ P
      (congrArg PrimeSpectrum.asIdeal hJP) tP htP
    let dQ := actualGaloisSpecCompletionParameters (k := k) (K := K) J.asIdeal hJ Q
      (congrArg PrimeSpectrum.asIdeal hJQ) tQ htQ
    let χP := actualSchemeFixedBaseStalkMap f sC sA actual_affine_structure_map_square J P hJP
    let χQ := actualSchemeFixedBaseStalkMap f sC sA actual_affine_structure_map_square J Q hJQ
    ParameterFieldsEquivalent
      (completedDVRLaurentMap dJ dP χP
        (actual_spec_fixed_base_stalk_map_injective J P hJP
          (galois_integral_closure_base_injective A K L)))
      (completedDVRLaurentMap dJ dQ χQ
        (actual_spec_fixed_base_stalk_map_injective J Q hJQ
          (galois_integral_closure_base_injective A K L))) := by
  let f := Spec.map (CommRingCat.ofHom (algebraMap A (integralClosure A L)))
  let sA := actualAffineStructureMap (k := k) (A := A)
  let sC := actualAffineStructureMap (k := k) (A := integralClosure A L)
  let hIP := congrArg PrimeSpectrum.asIdeal hJP
  let hIQ := congrArg PrimeSpectrum.asIdeal hJQ
  letI := actual_dedekind_affine_scheme_stalk_dvr J hJ
  letI := actual_galois_normalization_spec_stalk_dvr (K := K) J.asIdeal hJ P hIP
  letI := actual_galois_normalization_spec_stalk_dvr (K := K) J.asIdeal hJ Q hIQ
  letI := actual_dedekind_base_prime_dvr A J.asIdeal hJ
  letI := actual_galois_normalization_prime_dvr A K L J.asIdeal hJ P.asIdeal hIP
  letI := actual_galois_normalization_prime_dvr A K L J.asIdeal hJ Q.asIdeal hIQ
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sA J).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sC P).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sC Q).toAlgebra
  let dJ := actualDedekindSpecCompletionParameters (k := k) J hJ tJ htJ
  let dP := actualGaloisSpecCompletionParameters (k := k) (K := K) J.asIdeal hJ P hIP tP htP
  let dQ := actualGaloisSpecCompletionParameters (k := k) (K := K) J.asIdeal hJ Q hIQ tQ htQ
  let χP := actualSchemeFixedBaseStalkMap f sC sA actual_affine_structure_map_square J P hJP
  let χQ := actualSchemeFixedBaseStalkMap f sC sA actual_affine_structure_map_square J Q hJQ
  let eJ := actualSpecStalkCoefficientAlgEquiv (k := k) J
  let eP := actualSpecStalkCoefficientAlgEquiv (k := k) P
  let eQ := actualSpecStalkCoefficientAlgEquiv (k := k) Q
  have htJ' : Irreducible (eJ tJ) := (MulEquiv.irreducible_iff eJ).mpr htJ
  have htP' : Irreducible (eP tP) := (MulEquiv.irreducible_iff eP).mpr htP
  have htQ' : Irreducible (eQ tQ) := (MulEquiv.irreducible_iff eQ).mpr htQ
  let dJL := actualDedekindAffineParameters (k := k) J.asIdeal hJ (eJ tJ) htJ'
  let dPL := actualGaloisNormalizationParameters (k := k) (K := K) J.asIdeal hJ
    P.asIdeal hIP (eP tP) htP'
  let dQL := actualGaloisNormalizationParameters (k := k) (K := K) J.asIdeal hJ
    Q.asIdeal hIQ (eQ tQ) htQ'
  let θP := localizedCoefficientBaseMap (k := k) J.asIdeal P.asIdeal hIP
  let θQ := localizedCoefficientBaseMap (k := k) J.asIdeal Q.asIdeal hIQ
  have hi := galois_integral_closure_base_injective A K L
  exact actual_dvr_completed_field_comparison_transport dJ dJL dP dQ dPL dQL
    χP χQ θP θQ
    (actual_spec_fixed_base_stalk_map_injective J P hJP hi)
    (actual_spec_fixed_base_stalk_map_injective J Q hJQ hi)
    (localizedCoefficientBaseMap_injective hi J.asIdeal P.asIdeal hIP)
    (localizedCoefficientBaseMap_injective hi J.asIdeal Q.asIdeal hIQ)
    eJ eP eQ
    (actual_spec_fixed_base_stalk_map_localization J P hJP)
    (actual_spec_fixed_base_stalk_map_localization J Q hJQ)
    (actual_galois_normalization_completed_fields_equivalent (k := k) (K := K)
      J.asIdeal hJ P.asIdeal Q.asIdeal hIP hIQ (eJ tJ) htJ' (eP tP) htP' (eQ tQ) htQ')

end Litt3.QuotientGeometry
