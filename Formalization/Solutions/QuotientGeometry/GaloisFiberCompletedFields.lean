import Solutions.QuotientGeometry.LocalizedCoefficientBaseMaps
import Solutions.QuotientGeometry.DVRBaseEquivCompletions

namespace Litt3.QuotientGeometry

open scoped Pointwise

variable {k A R G : Type*} [Field k]
  [CommRing A] [IsDomain A] [CommRing R] [IsDomain R]
  [Algebra k A] [Algebra A R] [Algebra k R] [IsScalarTower k A R]
  [Group G] [Finite G] [MulSemiringAction G R]
  [SMulCommClass G A R] [Algebra.IsInvariant A R G]

include G in
/-- The actual entire completed fields at EVERY pair of points of a
finite invariant/Galois coordinate-ring fiber are equivalent over the
same full downstairs completed field. Every local, completed-ring and
fraction-field equivalence is constructed from the actual ring action. -/
theorem galois_fiber_completed_fields_equivalent
    (hinj : Function.Injective (algebraMap A R))
    (J : Ideal A) [J.IsPrime] (P Q : Ideal R) [P.IsPrime] [Q.IsPrime]
    (hJP : J = P.comap (algebraMap A R)) (hJQ : J = Q.comap (algebraMap A R))
    [IsDiscreteValuationRing (Localization.AtPrime J)]
    [IsDiscreteValuationRing (Localization.AtPrime P)]
    [IsDiscreteValuationRing (Localization.AtPrime Q)]
    (dJ : DVRCompletionParameters k (Localization.AtPrime J))
    (dP : DVRCompletionParameters k (Localization.AtPrime P))
    (dQ : DVRCompletionParameters k (Localization.AtPrime Q)) :
    ParameterFieldsEquivalent
      (completedDVRLaurentMap dJ dP (localizedCoefficientBaseMap J P hJP)
        (localizedCoefficientBaseMap_injective hinj J P hJP))
      (completedDVRLaurentMap dJ dQ (localizedCoefficientBaseMap J Q hJQ)
        (localizedCoefficientBaseMap_injective hinj J Q hJQ)) := by
  obtain ⟨_, e, _, _, _⟩ := galois_fiber_actual_full_base_equivalences
    (G := G) J P Q hJP hJQ
  exact dvr_base_equiv_completed_fields dJ dP dQ
    (localizedCoefficientBaseMap J P hJP) (localizedCoefficientBaseMap J Q hJQ)
    (localizedCoefficientBaseMap_injective hinj J P hJP)
    (localizedCoefficientBaseMap_injective hinj J Q hJQ) (e.restrictScalars k)
    (localized_equiv_coefficient_base_maps J P Q hJP hJQ e)

end Litt3.QuotientGeometry
