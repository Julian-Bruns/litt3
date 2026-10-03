import Solutions.QuotientGeometry.GaloisIntegralClosureAction

namespace Litt3.QuotientGeometry

variable (A K L : Type*) [CommRing A] [IsDomain A] [Field K] [Field L]
  [Algebra A K] [Algebra K L] [Algebra A L] [IsScalarTower A K L]
  [IsFractionRing A K] [IsIntegrallyClosed A]
  [FiniteDimensional K L] [IsGalois K L]

include K in
theorem galois_integral_closure_base_injective :
    Function.Injective (algebraMap A (integralClosure A L)) := by
  intro a b hab
  have he := congrArg (fun x : integralClosure A L => (x : L)) hab
  change algebraMap A L a = algebraMap A L b at he
  rw [IsScalarTower.algebraMap_apply A K L,
    IsScalarTower.algebraMap_apply A K L] at he
  exact IsFractionRing.injective A K ((algebraMap K L).injective he)

include K in
/-- Across EVERY pair of actual primes in the original normalized
Galois fiber, the actual local rings are equivalent over the ENTIRE
actual downstairs local ring. The finite Galois action, fixed-ring
property, prime transitivity and local equivalences are all derived
from the actual finite Galois fraction-field extension. -/
theorem actual_galois_integral_closure_fiber_local_equivalence
    (J : Ideal A) [J.IsPrime]
    (P Q : Ideal (integralClosure A L)) [P.IsPrime] [Q.IsPrime]
    (hJP : J = P.comap (algebraMap A (integralClosure A L)))
    (hJQ : J = Q.comap (algebraMap A (integralClosure A L))) :
    ∃ e : Localization.AtPrime P ≃ₐ[A] Localization.AtPrime Q,
      e.toRingHom.comp (Localization.localRingHom J P (algebraMap A (integralClosure A L)) hJP) =
        Localization.localRingHom J Q (algebraMap A (integralClosure A L)) hJQ := by
  letI := galoisIntegralClosureAction A K L
  haveI : SMulCommClass (L ≃ₐ[K] L) A (integralClosure A L) :=
    galoisIntegralClosureAction_commutes A K L
  haveI : Algebra.IsInvariant A (integralClosure A L) (L ≃ₐ[K] L) :=
    galoisIntegralClosureAction_isInvariant A K L
  obtain ⟨_, e, _, hbase, _⟩ := galois_fiber_actual_full_base_equivalences
    (G := L ≃ₐ[K] L) J P Q hJP hJQ
  exact ⟨e, hbase⟩

end Litt3.QuotientGeometry
