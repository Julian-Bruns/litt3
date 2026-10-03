import Solutions.QuotientGeometry.AdicRingMaps
import Mathlib.RingTheory.DiscreteValuationRing.Basic

namespace Litt3.QuotientGeometry

variable {R S : Type*} [CommRing R] [CommRing S] [IsDomain S]

theorem principal_power_divisibility_reflects
    (φ : R →+* S) (t : R) (ht : φ t ≠ 0)
    (hres : ∀ r : R, φ t ∣ φ r → t ∣ r) (n : ℕ) (r : R) :
    φ t ^ n ∣ φ r → t ^ n ∣ r := by
  induction n generalizing r with
  | zero => simp
  | succ n ih =>
    intro hr
    have htr : φ t ∣ φ r := (dvd_pow_self _ (Nat.succ_ne_zero n)).trans hr
    rcases hres r htr with ⟨s, rfl⟩
    rw [map_mul, pow_succ, mul_comm (φ t ^ n) (φ t)] at hr
    have hs : φ t ^ n ∣ φ s := (mul_dvd_mul_iff_left ht).mp hr
    rcases ih s hs with ⟨a, ha⟩
    refine ⟨a, ?_⟩
    rw [ha, pow_succ]
    ring

omit [IsDomain S] in
theorem principal_power_residue_surjectivity
    (φ : R →+* S) (t : R)
    (hres : ∀ s : S, ∃ r : R, φ t ∣ s - φ r) (n : ℕ) (s : S) :
    ∃ r : R, φ t ^ n ∣ s - φ r := by
  induction n generalizing s with
  | zero => exact ⟨0, by simp⟩
  | succ n ih =>
    obtain ⟨r, y, hy⟩ := hres s
    obtain ⟨u, a, ha⟩ := ih y
    refine ⟨r + t * u, a, ?_⟩
    rw [map_add, map_mul, pow_succ]
    calc
      s - (φ r + φ t * φ u) = φ t * (y - φ u) := by
        calc
          _ = (s - φ r) - φ t * φ u := by ring
          _ = _ := by rw [hy]; ring
      _ = φ t * (φ t ^ n * a) := by rw [ha]
      _ = φ t ^ n * φ t * a := by ring

theorem principal_adic_quotient_maps_bijective
    (φ : R →+* S) (t : R) (ht : φ t ≠ 0)
    (hresinj : ∀ r : R, φ t ∣ φ r → t ∣ r)
    (hressurj : ∀ s : S, ∃ r : R, φ t ∣ s - φ r) (n : ℕ) :
    Function.Bijective (Ideal.quotientMap
      ((Ideal.span {φ t}) ^ n) φ
      (ideal_power_le_comap_of_map_le (Ideal.span {t}) (Ideal.span {φ t}) φ
        (by simp [Ideal.map_span]) n)) := by
  refine ⟨Ideal.quotientMap_injective' ?_, ?_⟩
  · intro r hr
    simp only [Ideal.mem_comap, Ideal.span_singleton_pow, Ideal.mem_span_singleton] at hr ⊢
    exact principal_power_divisibility_reflects φ t ht hresinj n r hr
  · intro s
    obtain ⟨s, rfl⟩ := Ideal.Quotient.mk_surjective s
    obtain ⟨r, hr⟩ := principal_power_residue_surjectivity φ t hressurj n s
    refine ⟨Ideal.Quotient.mk _ r, ?_⟩
    rw [Ideal.quotientMap_mk, Ideal.Quotient.eq]
    rw [Ideal.span_singleton_pow, Ideal.mem_span_singleton]
    exact dvd_neg.mp (by simpa only [neg_sub] using hr)

/-- Residue injectivity and surjectivity, together with a nonzero image of
the principal parameter, construct the actual completion isomorphism. -/
noncomputable def principalAdicComparison
    (φ : R →+* S) (t : R) (ht : φ t ≠ 0)
    (hresinj : ∀ r : R, φ t ∣ φ r → t ∣ r)
    (hressurj : ∀ s : S, ∃ r : R, φ t ∣ s - φ r) :
    AdicCompletion (Ideal.span {t}) R ≃+*
      AdicCompletion (Ideal.span {φ t}) S :=
  adicRingEquiv (Ideal.span {t}) (Ideal.span {φ t}) φ
    (by simp [Ideal.map_span])
    (principal_adic_quotient_maps_bijective φ t ht hresinj hressurj)

@[simp] theorem principalAdicComparison_of
    (φ : R →+* S) (t : R) (ht : φ t ≠ 0)
    (hresinj : ∀ r : R, φ t ∣ φ r → t ∣ r)
    (hressurj : ∀ s : S, ∃ r : R, φ t ∣ s - φ r) (r : R) :
    principalAdicComparison φ t ht hresinj hressurj (AdicCompletion.of _ R r) =
      AdicCompletion.of _ S (φ r) := by
  exact adicRingEquiv_of _ _ φ (by simp [Ideal.map_span])
    (principal_adic_quotient_maps_bijective φ t ht hresinj hressurj) r

end Litt3.QuotientGeometry
