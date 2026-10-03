import Solutions.QuotientGeometry.GaloisIntegralClosureFibers
import Solutions.QuotientGeometry.GaloisFiberCompletedFields

namespace Litt3.QuotientGeometry

variable {k A K L : Type*} [Field k] [CommRing A] [IsDomain A] [Field K] [Field L]
  [Algebra k A] [Algebra A K] [Algebra K L] [Algebra A L] [IsScalarTower A K L]
  [Algebra k L] [IsScalarTower k A L]
  [IsFractionRing A K] [IsIntegrallyClosed A]
  [FiniteDimensional K L] [IsGalois K L]

include K in
/-- The original finite Galois fraction-field extension constructs
equivalences of the ENTIRE completed fields over the SAME downstairs
completed field at every pair of primes of its actual normalization.
Every ring action, invariant condition, prime transitivity, local-ring
equivalence, completion chart and full completed-field map is derived. -/
theorem actual_galois_integral_closure_completed_fields_equivalent
    (J : Ideal A) [J.IsPrime]
    (P Q : Ideal (integralClosure A L)) [P.IsPrime] [Q.IsPrime]
    (hJP : J = P.comap (algebraMap A (integralClosure A L)))
    (hJQ : J = Q.comap (algebraMap A (integralClosure A L)))
    [IsDiscreteValuationRing (Localization.AtPrime J)]
    [IsDiscreteValuationRing (Localization.AtPrime P)]
    [IsDiscreteValuationRing (Localization.AtPrime Q)]
    (dJ : DVRCompletionParameters k (Localization.AtPrime J))
    (dP : DVRCompletionParameters k (Localization.AtPrime P))
    (dQ : DVRCompletionParameters k (Localization.AtPrime Q)) :
    ParameterFieldsEquivalent
      (completedDVRLaurentMap dJ dP (localizedCoefficientBaseMap J P hJP)
        (localizedCoefficientBaseMap_injective
          (galois_integral_closure_base_injective A K L) J P hJP))
      (completedDVRLaurentMap dJ dQ (localizedCoefficientBaseMap J Q hJQ)
        (localizedCoefficientBaseMap_injective
          (galois_integral_closure_base_injective A K L) J Q hJQ)) := by
  letI := galoisIntegralClosureAction A K L
  haveI : SMulCommClass (L ≃ₐ[K] L) A (integralClosure A L) :=
    galoisIntegralClosureAction_commutes A K L
  haveI : Algebra.IsInvariant A (integralClosure A L) (L ≃ₐ[K] L) :=
    galoisIntegralClosureAction_isInvariant A K L
  exact galois_fiber_completed_fields_equivalent (G := L ≃ₐ[K] L)
    (galois_integral_closure_base_injective A K L) J P Q hJP hJQ dJ dP dQ

end Litt3.QuotientGeometry
