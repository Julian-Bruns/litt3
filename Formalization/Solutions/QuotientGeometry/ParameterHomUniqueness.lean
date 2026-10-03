import Solutions.QuotientGeometry.ParameterSubstitutionCoefficients
import Mathlib.RingTheory.PowerSeries.Trunc

namespace Litt3.QuotientGeometry

theorem parameter_power_product_coefficient_zero
    {R : Type*} [CommRing R] (b g : PowerSeries R)
    (hb : PowerSeries.constantCoeff b = 0) (m d : ℕ) (hmd : m < d) :
    PowerSeries.coeff m (b ^ d * g) = 0 := by
  obtain ⟨c, hc⟩ := PowerSeries.X_dvd_iff.mpr hb
  rw [hc, mul_pow, mul_assoc, PowerSeries.coeff_X_pow_mul', if_neg (by omega)]

/-- Any actual homomorphism of power-series algebras with a positive
parameter image is genuine substitution on every whole series. The
divisibility of polynomial tails proves this without a continuity input. -/
theorem power_series_algHom_eq_substitution
    {R : Type*} [CommRing R] (b : PowerSeries R)
    (hb : PowerSeries.constantCoeff b = 0)
    (φ : PowerSeries R →ₐ[R] PowerSeries R) (hφ : φ PowerSeries.X = b) :
    φ = PowerSeries.substAlgHom (PowerSeries.HasSubst.of_constantCoeff_zero' hb) := by
  let F : PowerSeries R →ₐ[R] PowerSeries R :=
    PowerSeries.substAlgHom (PowerSeries.HasSubst.of_constantCoeff_zero' hb)
  have hF : F PowerSeries.X = b := PowerSeries.substAlgHom_X _
  have hpoly : φ.toRingHom.comp Polynomial.coeToPowerSeries.ringHom =
      F.toRingHom.comp Polynomial.coeToPowerSeries.ringHom := by
    apply Polynomial.ringHom_ext
    · intro a
      change φ (Polynomial.C a : PowerSeries R) = F (Polynomial.C a : PowerSeries R)
      rw [Polynomial.coe_C]
      exact (φ.commutes a).trans (F.commutes a).symm
    · change φ ((Polynomial.X : Polynomial R) : PowerSeries R) =
        F ((Polynomial.X : Polynomial R) : PowerSeries R)
      rw [Polynomial.coe_X, hφ, hF]
  apply AlgHom.ext
  intro f
  apply PowerSeries.ext
  intro j
  have hf := PowerSeries.eq_X_pow_mul_shift_add_trunc (j + 1) f
  have hφcoeff : PowerSeries.coeff j (φ f) =
      PowerSeries.coeff j (φ (PowerSeries.trunc (j + 1) f : PowerSeries R)) := by
    have h := congrArg φ hf
    rw [map_add, map_mul, map_pow, hφ] at h
    rw [h, map_add, parameter_power_product_coefficient_zero b _ hb j (j + 1) (by omega), zero_add]
  have hFcoeff : PowerSeries.coeff j (F f) =
      PowerSeries.coeff j (F (PowerSeries.trunc (j + 1) f : PowerSeries R)) := by
    have h := congrArg F hf
    rw [map_add, map_mul, map_pow, hF] at h
    rw [h, map_add, parameter_power_product_coefficient_zero b _ hb j (j + 1) (by omega), zero_add]
  rw [hφcoeff, hFcoeff]
  exact congrArg (PowerSeries.coeff j) (RingHom.congr_fun hpoly (PowerSeries.trunc (j + 1) f))

end Litt3.QuotientGeometry
