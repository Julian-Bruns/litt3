import Solutions.QuotientGeometry.GaloisIntegralClosureFibers
import Mathlib.RingTheory.DedekindDomain.IntegralClosure
import Mathlib.RingTheory.DedekindDomain.Dvr

namespace Litt3.QuotientGeometry

variable (A K L : Type*) [CommRing A] [IsDomain A] [IsDedekindDomain A]
  [Field K] [Field L] [Algebra A K] [Algebra K L] [Algebra A L]
  [IsScalarTower A K L] [IsFractionRing A K]
  [FiniteDimensional K L] [IsGalois K L]

include K in
/-- At every prime of the actual normalization over a nonzero base
prime, the original local ring is a DVR. No upstairs DVR hypothesis
is supplied. -/
theorem actual_galois_normalization_prime_dvr
    (J : Ideal A) (hJ : J ≠ ⊥)
    (P : Ideal (integralClosure A L)) [P.IsPrime]
    (hJP : J = P.comap (algebraMap A (integralClosure A L))) :
    IsDiscreteValuationRing (Localization.AtPrime P) := by
  letI : IsDedekindDomain (integralClosure A L) := integralClosure.isDedekindDomain A K L
  have hP : P ≠ ⊥ := by
    intro hP
    apply hJ
    rw [hJP, hP]
    exact Ideal.comap_bot_of_injective _ (galois_integral_closure_base_injective A K L)
  exact IsLocalization.AtPrime.isDiscreteValuationRing_of_dedekind_domain
    (integralClosure A L) hP (Localization.AtPrime P)

/-- The actual downstairs local ring at a nonzero prime of the
Dedekind base is a DVR. -/
theorem actual_dedekind_base_prime_dvr
    (J : Ideal A) [J.IsPrime] (hJ : J ≠ ⊥) :
    IsDiscreteValuationRing (Localization.AtPrime J) :=
  IsLocalization.AtPrime.isDiscreteValuationRing_of_dedekind_domain A hJ _

end Litt3.QuotientGeometry
