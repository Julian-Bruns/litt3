import Solutions.QuotientGeometry.GaloisFiberCompletedFields
import Solutions.QuotientGeometry.DVRBaseEquivDifferentialScalars

namespace Litt3.QuotientGeometry

variable {k A R G : Type*} [Field k] [IsAlgClosed k]
  [CommRing A] [IsDomain A] [CommRing R] [IsDomain R]
  [Algebra k A] [Algebra A R] [Algebra k R] [IsScalarTower k A R]
  [Group G] [Finite G] [MulSemiringAction G R]
  [SMulCommClass G A R] [Algebra.IsInvariant A R G]

include G in
/-- The entire actual Galois fiber has a common differential scalar.
The local equivalence and all complete expansions are derived from the
original action and the original polar and universal differential
identities at the two actual primes. -/
theorem actual_galois_fiber_original_differential_scalars_equal
    (hinj : Function.Injective (algebraMap A R))
    (p h m : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hm : 0 < m) (hdiv : h ∣ p - 1)
    (hchar : (h : k) ≠ 0) (hmchar : (m : k) ≠ 0)
    (J : Ideal A) [J.IsPrime] (P Q : Ideal R) [P.IsPrime] [Q.IsPrime]
    (hJP : J = P.comap (algebraMap A R)) (hJQ : J = Q.comap (algebraMap A R))
    [IsDiscreteValuationRing (Localization.AtPrime J)]
    [IsDiscreteValuationRing (Localization.AtPrime P)]
    [IsDiscreteValuationRing (Localization.AtPrime Q)]
    (dJ : DVRCompletionParameters k (Localization.AtPrime J))
    (dP : DVRCompletionParameters k (Localization.AtPrime P))
    (dQ : DVRCompletionParameters k (Localization.AtPrime Q))
    (gP sP : Localization.AtPrime P) (gQ sQ : Localization.AtPrime Q)
    (c : k) (hc : c ≠ 0)
    (hgP : IsUnit gP) (hgQ : IsUnit gQ) (hsP : IsUnit sP) (hsQ : IsUnit sQ)
    (hpolarP : localizedCoefficientBaseMap (k := k) J P hJP dJ.parameter * gP ^ m =
      dP.parameter ^ (p * h))
    (hpolarQ : localizedCoefficientBaseMap (k := k) J Q hJQ dJ.parameter * gQ ^ m =
      dQ.parameter ^ (p * h))
    (hdgP : KaehlerDifferential.D k (Localization.AtPrime P) gP =
      (algebraMap k (Localization.AtPrime P) c * dP.parameter ^ (p - 2) * sP) •
        KaehlerDifferential.D k (Localization.AtPrime P) dP.parameter)
    (hdgQ : KaehlerDifferential.D k (Localization.AtPrime Q) gQ =
      (algebraMap k (Localization.AtPrime Q) c * dQ.parameter ^ (p - 2) * sQ) •
        KaehlerDifferential.D k (Localization.AtPrime Q) dQ.parameter) :
    localDifferentialScalar p h m c (dvrResidueValue dP gP) (dvrResidueValue dP sP) =
      localDifferentialScalar p h m c (dvrResidueValue dQ gQ) (dvrResidueValue dQ sQ) := by
  obtain ⟨_, e, _, _, _⟩ := galois_fiber_actual_full_base_equivalences
    (G := G) J P Q hJP hJQ
  exact original_dvr_base_equiv_differential_scalars_equal p h m hh hm hdiv hchar hmchar
    dJ dP dQ (localizedCoefficientBaseMap J P hJP) (localizedCoefficientBaseMap J Q hJQ)
    (localizedCoefficientBaseMap_injective hinj J P hJP)
    (localizedCoefficientBaseMap_injective hinj J Q hJQ) (e.restrictScalars k)
    (localized_equiv_coefficient_base_maps J P Q hJP hJQ e)
    gP sP gQ sQ c hc hgP hgQ hsP hsQ hpolarP hpolarQ hdgP hdgQ

end Litt3.QuotientGeometry
