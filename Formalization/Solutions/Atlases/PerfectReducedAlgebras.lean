import Mathlib.RingTheory.Etale.Field
import Mathlib.RingTheory.Artinian.Ring
import Mathlib.RingTheory.Ideal.Quotient.Basic

namespace Litt3.Atlases

variable {K A : Type*} [Field K] [PerfectField K] [CommRing A]
  [Algebra K A] [FiniteDimensional K A]

/-- The actual finite reduced algebra is formally etale over every
perfect field, with no finite-field or monogenic hypothesis. -/
theorem finite_reduced_algebra_formallyEtale [IsReduced A] :
    Algebra.FormallyEtale K A := by
  classical
  letI : IsArtinianRing A := isArtinian_of_tower K inferInstance
  letI (I : MaximalSpectrum A) : Field (A ⧸ I.asIdeal) :=
    IsArtinianRing.fieldOfSubtypeIsMaximal A I
  let e : A ≃ₐ[K] (∀ I : MaximalSpectrum A, A ⧸ I.asIdeal) :=
    { __ := IsArtinianRing.equivPi A, commutes' := fun r => rfl }
  apply (Algebra.FormallyEtale.iff_exists_algEquiv_prod K A).mpr
  refine ⟨MaximalSpectrum A, inferInstance, fun I => A ⧸ I.asIdeal,
    (fun _ => inferInstance), (fun _ => inferInstance), e, ?_⟩
  intro I
  infer_instance

include K in
omit [PerfectField K] in
/-- The nilradical of the actual finite algebra is a nilpotent ideal.
The exponent is not supplied by an outside certificate. -/
theorem finite_algebra_nilradical_nilpotent : IsNilpotent (nilradical A) := by
  letI : IsArtinianRing A := isArtinian_of_tower K inferInstance
  exact IsArtinianRing.isNilpotent_nilradical

/-- The nilradical quotient has exactly one actual algebra section.
Its existence and uniqueness are proved from formal etaleness. -/
theorem finite_perfect_algebra_unique_reduced_section :
    ∃! s : (A ⧸ nilradical A) →ₐ[K] A,
      (Ideal.Quotient.mkₐ K (nilradical A)).comp s =
        AlgHom.id K (A ⧸ nilradical A) := by
  letI : IsReduced (A ⧸ nilradical A) :=
    (Ideal.isRadical_iff_quotient_reduced _).mp (Ideal.radical_isRadical ⊥)
  letI : Algebra.FormallyEtale K (A ⧸ nilradical A) :=
    finite_reduced_algebra_formallyEtale
  have hN : IsNilpotent (nilradical A) := finite_algebra_nilradical_nilpotent (K := K)
  refine ⟨Algebra.FormallySmooth.lift (nilradical A) hN
    (AlgHom.id K (A ⧸ nilradical A)), Algebra.FormallySmooth.comp_lift .., ?_⟩
  intro s hs
  exact Algebra.FormallyUnramified.lift_unique (nilradical A) hN s _
    (hs.trans (Algebra.FormallySmooth.comp_lift ..).symm)

end Litt3.Atlases
