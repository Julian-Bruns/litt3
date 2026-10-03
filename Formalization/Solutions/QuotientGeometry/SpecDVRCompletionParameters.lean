import Solutions.QuotientGeometry.SpecStalkCoefficientIso
import Solutions.QuotientGeometry.LocalCoefficientResidueTransport
import Solutions.QuotientGeometry.ClosedAffineResidueCoefficients
import Mathlib.RingTheory.DedekindDomain.Dvr

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

universe u

variable {k A : Type u} [Field k] [CommRing A] [Algebra k A]

/-- Genuine finite-type affine Scheme stalks at closed points have
the original coefficient field as their actual residue field, for
the literal Scheme structure-map algebra. -/
theorem actual_closed_affine_scheme_stalk_residue_surjective
    [IsAlgClosed k] [Algebra.FiniteType k A]
    (P : PrimeSpectrum A) [P.asIdeal.IsMaximal] :
    letI := (Litt3.SharedTensors.stalkBaseFieldHom
      (actualAffineStructureMap (k := k) (A := A)) P).toAlgebra
    Function.Surjective
      (algebraMap k (IsLocalRing.ResidueField ((Spec (.of A)).presheaf.stalk P))) := by
  letI := (Litt3.SharedTensors.stalkBaseFieldHom
    (actualAffineStructureMap (k := k) (A := A)) P).toAlgebra
  exact actual_local_algEquiv_residue_coefficients_surjective
    (actualSpecStalkCoefficientAlgEquiv (k := k) P)
    (closed_affine_residue_coefficients_surjective P.asIdeal)

/-- The actual Scheme stalk at a nonzero prime of a Dedekind
coordinate ring is itself a DVR. -/
theorem actual_dedekind_affine_scheme_stalk_dvr
    [IsDomain A] [IsDedekindDomain A] (P : PrimeSpectrum A) (hP : P.asIdeal ≠ ⊥) :
    IsDiscreteValuationRing ((Spec (.of A)).presheaf.stalk P) := by
  letI : Algebra A ((Spec (.of A)).presheaf.stalk P) :=
    (StructureSheaf.toStalk A P).hom.toAlgebra
  letI : IsLocalization.AtPrime ((Spec (.of A)).presheaf.stalk P) P.asIdeal :=
    StructureSheaf.IsLocalization.to_stalk A P
  exact IsLocalization.AtPrime.isDiscreteValuationRing_of_dedekind_domain
    A hP ((Spec (.of A)).presheaf.stalk P)

/-- An original uniformizer of a true finite-type Dedekind affine
Scheme stalk provides all completion data, with the actual coefficient
structure map. Neither the DVR nor coefficient residue property is
supplied. -/
noncomputable def actualDedekindSpecCompletionParameters
    [IsAlgClosed k] [IsDomain A] [IsDedekindDomain A] [Algebra.FiniteType k A]
    (P : PrimeSpectrum A) (hP : P.asIdeal ≠ ⊥)
    (t : (Spec (.of A)).presheaf.stalk P) (ht : Irreducible t) :
    letI := actual_dedekind_affine_scheme_stalk_dvr P hP
    letI := (Litt3.SharedTensors.stalkBaseFieldHom
      (actualAffineStructureMap (k := k) (A := A)) P).toAlgebra
    DVRCompletionParameters k ((Spec (.of A)).presheaf.stalk P) := by
  letI := actual_dedekind_affine_scheme_stalk_dvr P hP
  letI := (Litt3.SharedTensors.stalkBaseFieldHom
    (actualAffineStructureMap (k := k) (A := A)) P).toAlgebra
  letI : P.asIdeal.IsMaximal := Ideal.IsPrime.isMaximal P.isPrime hP
  exact ⟨t, ht, actual_closed_affine_scheme_stalk_residue_surjective (k := k) P⟩

end Litt3.QuotientGeometry
