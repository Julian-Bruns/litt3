import Solutions.QuotientGeometry.NormalIntegralAffineNormalization
import Solutions.QuotientGeometry.GaloisFiberBaseMaps

namespace Litt3.QuotientGeometry

variable {A K L R : Type*} [CommRing A] [IsDomain A] [IsIntegrallyClosed A]
  [CommRing R] [IsDomain R] [IsIntegrallyClosed R]
  [Field K] [Field L] [Algebra A K] [Algebra K L] [Algebra A L]
  [Algebra A R] [Algebra R L] [IsScalarTower A K L] [IsScalarTower A R L]
  [IsFractionRing A K] [IsFractionRing R L] [Algebra.IsIntegral A R]
  [FiniteDimensional K L] [IsGalois K L]

include K L in
/-- The actual finite Galois group acts transitively on every prime
fiber of ANY original normal integral affine coordinate algebra in
its genuine function field. The action and fixed-ring hypothesis
are derived, without assuming that the affine algebra is presented
as an integral closure. The constructed localization equivalences
fix the ENTIRE original downstairs local ring. -/
theorem actual_normal_affine_galois_fiber_local_equivalences
    (J : Ideal A) [J.IsPrime] (P Q : Ideal R) [P.IsPrime] [Q.IsPrime]
    (hJP : J = P.comap (algebraMap A R)) (hJQ : J = Q.comap (algebraMap A R)) :
    ∃ e : Localization.AtPrime P ≃ₐ[A] Localization.AtPrime Q,
      e.toRingHom.comp (Localization.localRingHom J P (algebraMap A R) hJP) =
        Localization.localRingHom J Q (algebraMap A R) hJQ := by
  letI : Finite (R ≃ₐ[A] R) :=
    Finite.of_equiv (L ≃ₐ[K] L) (galRestrict A K L R).toEquiv
  letI : Algebra.IsInvariant A R (R ≃ₐ[A] R) := Algebra.isInvariant_of_isGalois' A K L R
  letI : SMulCommClass (R ≃ₐ[A] R) A R := by
    refine ⟨?_⟩
    intro e a r
    change e (a • r) = a • e r
    simp only [Algebra.smul_def, map_mul, e.commutes]
  obtain ⟨_, e, _, he, _⟩ :=
    galois_fiber_actual_full_base_equivalences (G := R ≃ₐ[A] R) J P Q hJP hJQ
  exact ⟨e, he⟩

end Litt3.QuotientGeometry
