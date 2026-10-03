import Solutions.QuotientGeometry.GaloisFiberBaseMaps

namespace Litt3.QuotientGeometry

variable {k A R : Type*} [CommRing k] [CommRing A] [CommRing R]
  [Algebra k A] [Algebra A R] [Algebra k R] [IsScalarTower k A R]

/-- The actual local map above a base prime is a coefficient-algebra
map. Its coefficient compatibility follows from the genuine original
algebra tower, rather than being a separate input. -/
noncomputable def localizedCoefficientBaseMap
    (J : Ideal A) [J.IsPrime] (P : Ideal R) [P.IsPrime]
    (hJP : J = P.comap (algebraMap A R)) :
    Localization.AtPrime J →ₐ[k] Localization.AtPrime P :=
  { Localization.localRingHom J P (algebraMap A R) hJP with
    commutes' := by
      intro c
      change Localization.localRingHom J P (algebraMap A R) hJP (algebraMap k _ c) = _
      rw [IsScalarTower.algebraMap_apply k A (Localization.AtPrime J),
        Localization.localRingHom_to_map]
      rw [← IsScalarTower.algebraMap_apply k A R,
        ← IsScalarTower.algebraMap_apply k R (Localization.AtPrime P)] }

theorem localizedCoefficientBaseMap_ring
    (J : Ideal A) [J.IsPrime] (P : Ideal R) [P.IsPrime]
    (hJP : J = P.comap (algebraMap A R)) (a : A) :
    localizedCoefficientBaseMap (k := k) J P hJP
        (algebraMap A (Localization.AtPrime J) a) =
      algebraMap R (Localization.AtPrime P) (algebraMap A R a) :=
  Localization.localRingHom_to_map J P (algebraMap A R) hJP a

instance localizedCoefficientBaseMap_isLocal
    (J : Ideal A) [J.IsPrime] (P : Ideal R) [P.IsPrime]
    (hJP : J = P.comap (algebraMap A R)) :
    IsLocalHom (localizedCoefficientBaseMap (k := k) J P hJP).toRingHom :=
  Localization.isLocalHom_localRingHom J P (algebraMap A R) hJP

theorem localizedCoefficientBaseMap_injective
    [IsDomain R] (hinj : Function.Injective (algebraMap A R))
    (J : Ideal A) [J.IsPrime] (P : Ideal R) [P.IsPrime]
    (hJP : J = P.comap (algebraMap A R)) :
    Function.Injective (localizedCoefficientBaseMap (k := k) J P hJP) := by
  change Function.Injective (Localization.localRingHom J P (algebraMap A R) hJP)
  exact IsLocalization.map_injective_of_injective' J.primeCompl R (Localization.AtPrime P)
    (Localization.le_comap_primeCompl_iff.mpr hJP.ge) (fun hzero => hzero P.zero_mem) hinj

theorem localized_equiv_coefficient_base_maps
    (J : Ideal A) [J.IsPrime] (P Q : Ideal R) [P.IsPrime] [Q.IsPrime]
    (hJP : J = P.comap (algebraMap A R)) (hJQ : J = Q.comap (algebraMap A R))
    (e : Localization.AtPrime P ≃ₐ[A] Localization.AtPrime Q) :
    (e.restrictScalars k).toAlgHom.comp (localizedCoefficientBaseMap (k := k) J P hJP) =
      localizedCoefficientBaseMap (k := k) J Q hJQ := by
  apply AlgHom.ext
  intro r
  exact RingHom.congr_fun (prime_localization_equiv_full_base J P Q hJP hJQ e) r

end Litt3.QuotientGeometry
