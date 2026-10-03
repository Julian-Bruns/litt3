import Mathlib.RingTheory.PowerSeries.Trunc
import Mathlib.Algebra.Polynomial.Div

namespace Litt3.QuotientGeometry

open Polynomial

variable {k R : Type*} [CommRing k] [CommRing R]

theorem nilpotent_polynomial_evaluation_trunc
    (κ : k →+* R) (a : R) (n : ℕ) (ha : a ^ n = 0) (P : k[X]) :
    Polynomial.eval₂ κ a (PowerSeries.trunc n (P : PowerSeries k)) =
      Polynomial.eval₂ κ a P := by
  have hd : Polynomial.X ^ n ∣ P - PowerSeries.trunc n (P : PowerSeries k) := by
    apply Polynomial.X_pow_dvd_iff.mpr
    intro i hi
    simp [PowerSeries.coeff_trunc, hi]
  obtain ⟨Q, hQ⟩ := hd
  have hz : Polynomial.eval₂ κ a (P - PowerSeries.trunc n (P : PowerSeries k)) = 0 := by
    rw [hQ, Polynomial.eval₂_mul, Polynomial.eval₂_pow, Polynomial.eval₂_X, ha, zero_mul]
  exact (sub_eq_zero.mp (by simpa only [Polynomial.eval₂_sub] using hz)).symm

/-- Evaluation of the entire formal series at an actual nilpotent
element. The finite truncation is independent of all discarded terms. -/
noncomputable def powerSeriesNilpotentEval
    (κ : k →+* R) (a : R) (n : ℕ) (ha : a ^ n = 0) :
    PowerSeries k →+* R where
  toFun f := Polynomial.eval₂ κ a (PowerSeries.trunc n f)
  map_one' := by
    have h := nilpotent_polynomial_evaluation_trunc κ a n ha (1 : k[X])
    simpa using h
  map_zero' := by simp
  map_add' f g := by simp [map_add, Polynomial.eval₂_add]
  map_mul' f g := by
    have h := nilpotent_polynomial_evaluation_trunc κ a n ha
      (PowerSeries.trunc n f * PowerSeries.trunc n g)
    rw [Polynomial.coe_mul, PowerSeries.trunc_trunc_mul_trunc] at h
    exact h.trans (Polynomial.eval₂_mul κ a)

@[simp] theorem powerSeriesNilpotentEval_coe
    (κ : k →+* R) (a : R) (n : ℕ) (ha : a ^ n = 0) (P : k[X]) :
    powerSeriesNilpotentEval κ a n ha (P : PowerSeries k) =
      Polynomial.eval₂ κ a P :=
  nilpotent_polynomial_evaluation_trunc κ a n ha P

@[simp] theorem powerSeriesNilpotentEval_C
    (κ : k →+* R) (a : R) (n : ℕ) (ha : a ^ n = 0) (c : k) :
    powerSeriesNilpotentEval κ a n ha (PowerSeries.C c) = κ c := by
  simpa using powerSeriesNilpotentEval_coe κ a n ha (Polynomial.C c)

@[simp] theorem powerSeriesNilpotentEval_X
    (κ : k →+* R) (a : R) (n : ℕ) (ha : a ^ n = 0) :
    powerSeriesNilpotentEval κ a n ha PowerSeries.X = a := by
  simpa using powerSeriesNilpotentEval_coe κ a n ha (Polynomial.X : k[X])

theorem powerSeriesNilpotentEval_X_pow
    (κ : k →+* R) (a : R) (n : ℕ) (ha : a ^ n = 0) :
    powerSeriesNilpotentEval κ a n ha (PowerSeries.X ^ n) = 0 := by
  rw [map_pow, powerSeriesNilpotentEval_X, ha]

theorem power_series_ringHom_polynomial_evaluation
    (κ : k →+* R) (φ : PowerSeries k →+* R)
    (hκ : ∀ c : k, φ (PowerSeries.C c) = κ c) (P : k[X]) :
    φ (P : PowerSeries k) = Polynomial.eval₂ κ (φ PowerSeries.X) P := by
  have he : φ.comp Polynomial.coeToPowerSeries.ringHom =
      Polynomial.eval₂RingHom κ (φ PowerSeries.X) := by
    apply Polynomial.ringHom_ext
    · intro c
      simpa using hκ c
    · simp
  exact RingHom.congr_fun he P

/-- Every actual homomorphism sending the parameter to a nilpotent
element is the full-series evaluation constructed above. -/
theorem power_series_nilpotent_evaluation_unique
    (κ : k →+* R) (a : R) (n : ℕ) (ha : a ^ n = 0)
    (φ : PowerSeries k →+* R) (hκ : ∀ c : k, φ (PowerSeries.C c) = κ c)
    (hX : φ PowerSeries.X = a) : φ = powerSeriesNilpotentEval κ a n ha := by
  ext f
  have hf := PowerSeries.eq_X_pow_mul_shift_add_trunc n f
  have hφ := congrArg φ hf
  rw [map_add, map_mul, map_pow, hX, ha, zero_mul, zero_add] at hφ
  rw [hφ, power_series_ringHom_polynomial_evaluation κ φ hκ, hX]
  rfl

end Litt3.QuotientGeometry
