import Solutions.QuotientGeometry.ClosedAffineResidueCoefficients
import Mathlib.RingTheory.DedekindDomain.Dvr

namespace Litt3.QuotientGeometry

variable {k A : Type*} [Field k] [IsAlgClosed k] [CommRing A]
  [IsDomain A] [IsDedekindDomain A] [Algebra k A] [Algebra.FiniteType k A]

/-- At every nonzero point of a genuine finite-type affine Dedekind
algebra, an original uniformizer constructs all completion parameters.
The DVR and coefficient residue data are derived. -/
noncomputable def actualDedekindAffineParameters
    (J : Ideal A) [J.IsPrime] (hJ : J ≠ ⊥)
    (t : Localization.AtPrime J) (ht : Irreducible t) :
    letI := IsLocalization.AtPrime.isDiscreteValuationRing_of_dedekind_domain
      A hJ (Localization.AtPrime J)
    DVRCompletionParameters k (Localization.AtPrime J) := by
  letI := IsLocalization.AtPrime.isDiscreteValuationRing_of_dedekind_domain
    A hJ (Localization.AtPrime J)
  letI : J.IsMaximal := Ideal.IsPrime.isMaximal inferInstance hJ
  exact ⟨t, ht, closed_affine_residue_coefficients_surjective J⟩

end Litt3.QuotientGeometry
