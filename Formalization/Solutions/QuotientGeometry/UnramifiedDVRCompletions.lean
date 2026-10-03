import Solutions.QuotientGeometry.PrincipalAdicComparison
import Mathlib.RingTheory.Unramified.LocalRing
import Mathlib.RingTheory.RingHom.Unramified

namespace Litt3.QuotientGeometry

open IsLocalRing

variable {R S : Type*} [CommRing R] [IsDomain R] [IsDiscreteValuationRing R]
  [CommRing S] [IsDomain S] [IsDiscreteValuationRing S]

theorem local_dvr_residue_principal_conditions
    (φ : R →+* S) [IsLocalHom φ] (t : R) (ht : Irreducible t)
    (hmax : (maximalIdeal R).map φ = maximalIdeal S)
    (hres : Function.Surjective (ResidueField.map φ)) :
    φ t ≠ 0 ∧ (∀ r : R, φ t ∣ φ r → t ∣ r) ∧
      (∀ s : S, ∃ r : R, φ t ∣ s - φ r) := by
  have hR : maximalIdeal R = Ideal.span {t} := ht.maximalIdeal_eq
  have hS : maximalIdeal S = Ideal.span {φ t} := by
    rw [hR, Ideal.map_span, Set.image_singleton] at hmax
    exact hmax.symm
  refine ⟨?_, ?_, ?_⟩
  · intro hz
    apply IsDiscreteValuationRing.not_a_field S
    simp [hS, hz]
  · intro r hr
    rw [← Ideal.mem_span_singleton, ← hR]
    apply (residue_eq_zero_iff r).mp
    apply (ResidueField.map φ).injective
    rw [map_zero, ResidueField.map_residue]
    apply (residue_eq_zero_iff (φ r)).mpr
    rw [hS, Ideal.mem_span_singleton]
    exact hr
  · intro s
    obtain ⟨a, ha⟩ := hres (residue S s)
    obtain ⟨r, hr⟩ := residue_surjective (R := R) a
    refine ⟨r, ?_⟩
    rw [← Ideal.mem_span_singleton, ← hS, ← residue_eq_zero_iff, map_sub, sub_eq_zero]
    rw [← ResidueField.map_residue, hr, ha]

theorem local_dvr_adic_quotient_maps_bijective
    (φ : R →+* S) [IsLocalHom φ] (t : R) (ht : Irreducible t)
    (hmax : (maximalIdeal R).map φ = maximalIdeal S)
    (hres : Function.Surjective (ResidueField.map φ)) (n : ℕ) :
    Function.Bijective (Ideal.quotientMap ((maximalIdeal S) ^ n) φ
      (ideal_power_le_comap_of_map_le (maximalIdeal R) (maximalIdeal S) φ hmax.le n)) := by
  obtain ⟨hφt, hinj, hsurj⟩ := local_dvr_residue_principal_conditions φ t ht hmax hres
  have hR : maximalIdeal R = Ideal.span {t} := ht.maximalIdeal_eq
  have hS : maximalIdeal S = Ideal.span {φ t} := by
    rw [hR, Ideal.map_span, Set.image_singleton] at hmax
    exact hmax.symm
  refine ⟨Ideal.quotientMap_injective' ?_, ?_⟩
  · intro r hr
    rw [Ideal.mem_comap, hS, Ideal.span_singleton_pow, Ideal.mem_span_singleton] at hr
    rw [hR, Ideal.span_singleton_pow, Ideal.mem_span_singleton]
    exact principal_power_divisibility_reflects φ t hφt hinj n r hr
  · intro s
    obtain ⟨s, rfl⟩ := Ideal.Quotient.mk_surjective s
    obtain ⟨r, hr⟩ := principal_power_residue_surjectivity φ t hsurj n s
    refine ⟨Ideal.Quotient.mk _ r, ?_⟩
    rw [Ideal.quotientMap_mk, Ideal.Quotient.eq, hS,
      Ideal.span_singleton_pow, Ideal.mem_span_singleton]
    exact dvd_neg.mp (by simpa only [neg_sub] using hr)

/-- A genuine local DVR map with unramified ideal extension and equal
residue fields induces a genuine isomorphism of the actual completions. -/
noncomputable def localDVRCompletionEquiv
    (φ : R →+* S) [IsLocalHom φ] (t : R) (ht : Irreducible t)
    (hmax : (maximalIdeal R).map φ = maximalIdeal S)
    (hres : Function.Surjective (ResidueField.map φ)) :
    AdicCompletion (maximalIdeal R) R ≃+* AdicCompletion (maximalIdeal S) S :=
  adicRingEquiv (maximalIdeal R) (maximalIdeal S) φ hmax.le
    (local_dvr_adic_quotient_maps_bijective φ t ht hmax hres)

@[simp] theorem localDVRCompletionEquiv_of
    (φ : R →+* S) [IsLocalHom φ] (t : R) (ht : Irreducible t)
    (hmax : (maximalIdeal R).map φ = maximalIdeal S)
    (hres : Function.Surjective (ResidueField.map φ)) (r : R) :
    localDVRCompletionEquiv φ t ht hmax hres (AdicCompletion.of _ R r) =
      AdicCompletion.of _ S (φ r) :=
  adicRingEquiv_of _ _ φ hmax.le
    (local_dvr_adic_quotient_maps_bijective φ t ht hmax hres) r

theorem formally_unramified_local_map_maximal_ideal
    (φ : R →+* S) [IsLocalHom φ]
    (hunram : φ.FormallyUnramified) (hfinite : φ.EssFiniteType) :
    (maximalIdeal R).map φ = maximalIdeal S := by
  letI : Algebra R S := φ.toAlgebra
  letI : Algebra.FormallyUnramified R S := hunram
  letI : Algebra.EssFiniteType R S := hfinite
  letI : IsLocalHom (algebraMap R S) := ‹IsLocalHom φ›
  exact Algebra.FormallyUnramified.map_maximalIdeal

theorem unramified_dvr_completion_isomorphism
    (φ : R →+* S) [IsLocalHom φ] (t : R) (ht : Irreducible t)
    (hunram : φ.FormallyUnramified) (hfinite : φ.EssFiniteType)
    (hres : Function.Surjective (ResidueField.map φ)) :
    ∃ e : AdicCompletion (maximalIdeal R) R ≃+* AdicCompletion (maximalIdeal S) S,
      e.toRingHom = adicRingMap (maximalIdeal R) (maximalIdeal S) φ
        (formally_unramified_local_map_maximal_ideal φ hunram hfinite).le ∧
      ∀ r : R, e (AdicCompletion.of _ R r) = AdicCompletion.of _ S (φ r) := by
  let hmax := formally_unramified_local_map_maximal_ideal φ hunram hfinite
  exact ⟨localDVRCompletionEquiv φ t ht hmax hres, rfl,
    localDVRCompletionEquiv_of φ t ht hmax hres⟩

end Litt3.QuotientGeometry
