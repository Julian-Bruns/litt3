import Mathlib.RingTheory.DedekindDomain.Basic

namespace Litt3.Jacobians

theorem dimension_le_one_of_ring_equiv
    {R S : Type*} [CommRing R] [CommRing S] [Ring.DimensionLEOne R]
    (e : R ≃+* S) : Ring.DimensionLEOne S where
  maximalOfPrime := by
    intro p hpnonzero hpprime
    let q := p.comap e.toRingHom
    have hmap : q.map e.toRingHom = p := Ideal.map_comap_of_surjective _ e.surjective p
    have hqnonzero : q ≠ ⊥ := by
      intro hzero
      apply hpnonzero
      rw [← hmap, hzero, Ideal.map_bot]
    have hqprime : q.IsPrime := hpprime.comap e.toRingHom
    have hqmax : q.IsMaximal := hqprime.isMaximal hqnonzero
    rw [← hmap]
    exact (Ideal.isMaximal_map_iff_of_bijective e.toRingHom e.bijective).mpr hqmax

theorem dedekind_domain_of_ring_equiv
    {R S : Type*} [CommRing R] [CommRing S] [IsDedekindDomain R]
    (e : R ≃+* S) : IsDedekindDomain S := by
  haveI : IsDomain S := Function.Injective.isDomain e.symm.toRingHom e.symm.injective
  haveI : IsNoetherianRing S := isNoetherianRing_of_ringEquiv R e
  haveI : Ring.DimensionLEOne S := dimension_le_one_of_ring_equiv e
  haveI : IsIntegrallyClosed S := IsIntegrallyClosed.of_equiv e
  apply (isDedekindDomain_iff S (FractionRing S)).mpr
  exact ⟨inferInstance, inferInstance, inferInstance,
    (isIntegrallyClosed_iff (FractionRing S)).mp (inferInstance : IsIntegrallyClosed S)⟩

end Litt3.Jacobians
