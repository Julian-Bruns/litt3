import Solutions.QuotientGeometry.GaloisFiberLocalizations

namespace Litt3.QuotientGeometry

open scoped Pointwise

variable {A R : Type*} [CommRing A] [CommRing R] [Algebra A R]

/-- Any actual base-algebra equivalence of the local rings over two
primes intertwines the ENTIRE genuine localized base ring, not merely
its global elements or its residue field. -/
theorem prime_localization_equiv_full_base
    (J : Ideal A) [J.IsPrime] (P Q : Ideal R) [P.IsPrime] [Q.IsPrime]
    (hJP : J = P.comap (algebraMap A R)) (hJQ : J = Q.comap (algebraMap A R))
    (e : Localization.AtPrime P ≃ₐ[A] Localization.AtPrime Q) :
    e.toRingHom.comp (Localization.localRingHom J P (algebraMap A R) hJP) =
      Localization.localRingHom J Q (algebraMap A R) hJQ := by
  apply IsLocalization.ringHom_ext J.primeCompl
  apply RingHom.ext
  intro a
  simp only [RingHom.comp_apply, Localization.localRingHom_to_map]
  change e (algebraMap A (Localization.AtPrime P) a) =
    algebraMap A (Localization.AtPrime Q) a
  exact e.commutes a

variable {G : Type*} [Group G] [Finite G] [MulSemiringAction G R]
  [SMulCommClass G A R] [Algebra.IsInvariant A R G]

/-- Actual finite invariant/Galois coordinate rings give genuine local
ring equivalences across the whole fiber, fixing the full downstairs
local ring. Transitivity and every local equivalence are constructed. -/
theorem galois_fiber_actual_full_base_equivalences
    (J : Ideal A) [J.IsPrime] (P Q : Ideal R) [P.IsPrime] [Q.IsPrime]
    (hJP : J = P.comap (algebraMap A R)) (hJQ : J = Q.comap (algebraMap A R)) :
    ∃ (g : G) (e : Localization.AtPrime P ≃ₐ[A] Localization.AtPrime Q),
      Q = g • P ∧
      e.toRingHom.comp (Localization.localRingHom J P (algebraMap A R) hJP) =
        Localization.localRingHom J Q (algebraMap A R) hJQ ∧
      ∀ r : R, e (algebraMap R (Localization.AtPrime P) r) =
        algebraMap R (Localization.AtPrime Q) (g • r) := by
  obtain ⟨g, e, hg, he⟩ := galois_fiber_actual_local_rings_equivalent (G := G) P Q
    (by exact hJP.symm.trans hJQ)
  exact ⟨g, e, hg, prime_localization_equiv_full_base J P Q hJP hJQ e, he⟩

end Litt3.QuotientGeometry
