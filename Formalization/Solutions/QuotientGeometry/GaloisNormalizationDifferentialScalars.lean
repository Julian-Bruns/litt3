import Solutions.QuotientGeometry.GaloisNormalizationCompletedFields
import Solutions.QuotientGeometry.GaloisFiberDifferentialScalars

namespace Litt3.QuotientGeometry

variable {k A K L : Type*} [Field k] [IsAlgClosed k]
  [CommRing A] [IsDomain A] [IsDedekindDomain A] [Algebra k A]
  [Algebra.FiniteType k A] [Field K] [Field L]
  [Algebra A K] [Algebra K L] [Algebra A L] [IsScalarTower A K L]
  [Algebra k L] [IsScalarTower k A L]
  [IsFractionRing A K] [FiniteDimensional K L] [IsGalois K L]

include K in
/-- The exact original differential invariant agrees at EVERY pair
of normalization points over the same nonzero base prime. The actual
Galois extension derives the DVRs, residue charts, group action, fiber
transitivity, local equivalence and completed comparison. The supplied
identities are solely in the original rings and their actual Ω modules. -/
theorem actual_galois_normalization_original_differential_scalars_equal
    (p h m : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hm : 0 < m) (hdiv : h ∣ p - 1)
    (hchar : (h : k) ≠ 0) (hmchar : (m : k) ≠ 0)
    (J : Ideal A) [J.IsPrime] (hJ : J ≠ ⊥)
    (P Q : Ideal (integralClosure A L)) [P.IsPrime] [Q.IsPrime]
    (hJP : J = P.comap (algebraMap A (integralClosure A L)))
    (hJQ : J = Q.comap (algebraMap A (integralClosure A L)))
    (tJ : Localization.AtPrime J) (htJ : Irreducible tJ)
    (tP : Localization.AtPrime P) (htP : Irreducible tP)
    (tQ : Localization.AtPrime Q) (htQ : Irreducible tQ) :
    letI := actual_dedekind_base_prime_dvr A J hJ
    letI := actual_galois_normalization_prime_dvr A K L J hJ P hJP
    letI := actual_galois_normalization_prime_dvr A K L J hJ Q hJQ
    let dP := actualGaloisNormalizationParameters (k := k) (K := K) J hJ P hJP tP htP
    let dQ := actualGaloisNormalizationParameters (k := k) (K := K) J hJ Q hJQ tQ htQ
    ∀ (gP sP : Localization.AtPrime P) (gQ sQ : Localization.AtPrime Q)
      (c : k) (_hc : c ≠ 0)
      (_hgP : IsUnit gP) (_hgQ : IsUnit gQ) (_hsP : IsUnit sP) (_hsQ : IsUnit sQ),
    localizedCoefficientBaseMap (k := k) J P hJP tJ * gP ^ m = tP ^ (p * h) →
    localizedCoefficientBaseMap (k := k) J Q hJQ tJ * gQ ^ m = tQ ^ (p * h) →
    KaehlerDifferential.D k (Localization.AtPrime P) gP =
      (algebraMap k (Localization.AtPrime P) c * tP ^ (p - 2) * sP) •
        KaehlerDifferential.D k (Localization.AtPrime P) tP →
    KaehlerDifferential.D k (Localization.AtPrime Q) gQ =
      (algebraMap k (Localization.AtPrime Q) c * tQ ^ (p - 2) * sQ) •
        KaehlerDifferential.D k (Localization.AtPrime Q) tQ →
    localDifferentialScalar p h m c (dvrResidueValue dP gP) (dvrResidueValue dP sP) =
      localDifferentialScalar p h m c (dvrResidueValue dQ gQ) (dvrResidueValue dQ sQ) := by
  letI := actual_dedekind_base_prime_dvr A J hJ
  letI := actual_galois_normalization_prime_dvr A K L J hJ P hJP
  letI := actual_galois_normalization_prime_dvr A K L J hJ Q hJQ
  dsimp only
  intro gP sP gQ sQ c hc hgP hgQ hsP hsQ hpolarP hpolarQ hdgP hdgQ
  letI := galoisIntegralClosureAction A K L
  haveI : SMulCommClass (L ≃ₐ[K] L) A (integralClosure A L) :=
    galoisIntegralClosureAction_commutes A K L
  haveI : Algebra.IsInvariant A (integralClosure A L) (L ≃ₐ[K] L) :=
    galoisIntegralClosureAction_isInvariant A K L
  exact actual_galois_fiber_original_differential_scalars_equal (G := L ≃ₐ[K] L)
    (galois_integral_closure_base_injective A K L) p h m hh hm hdiv hchar hmchar
    J P Q hJP hJQ (actualDedekindAffineParameters (k := k) J hJ tJ htJ)
    (actualGaloisNormalizationParameters (k := k) (K := K) J hJ P hJP tP htP)
    (actualGaloisNormalizationParameters (k := k) (K := K) J hJ Q hJQ tQ htQ)
    gP sP gQ sQ c hc hgP hgQ hsP hsQ hpolarP hpolarQ hdgP hdgQ

end Litt3.QuotientGeometry
