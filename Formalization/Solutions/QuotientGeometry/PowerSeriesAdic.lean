import Definitions.QuotientGeometry.PowerSeriesAdic
import Mathlib.RingTheory.Henselian

namespace Litt3.QuotientGeometry

theorem power_series_parameter_adic_congruence_iff
    {R : Type*} [CommRing R] (n : ℕ) (f g : PowerSeries R) :
    f ≡ g [SMOD ((powerSeriesParameterIdeal R) ^ n • ⊤ : Submodule (PowerSeries R) (PowerSeries R))] ↔
      ∀ i, i < n → PowerSeries.coeff i f = PowerSeries.coeff i g := by
  rw [SModEq.sub_mem, Ideal.smul_eq_mul, Ideal.mul_top, powerSeriesParameterIdeal,
    Ideal.span_singleton_pow, Ideal.mem_span_singleton, PowerSeries.X_pow_dvd_iff]
  simp only [map_sub, sub_eq_zero]

/-- Formal power series over every commutative coefficient ring are
complete for the actual parameter ideal. The limit is constructed by
the stabilized coefficients, with no numerical convergence input. -/
theorem power_series_parameter_adic_complete
    (R : Type*) [CommRing R] :
    IsAdicComplete (powerSeriesParameterIdeal R) (PowerSeries R) where
  haus' := by
    intro f hf
    ext i
    have h := (power_series_parameter_adic_congruence_iff (i + 1) f 0).mp (hf (i + 1))
      i (Nat.lt_succ_self i)
    simpa using h
  prec' := by
    intro f hf
    let L := PowerSeries.mk (fun i => PowerSeries.coeff i (f (i + 1)))
    refine ⟨L, ?_⟩
    intro n
    apply (power_series_parameter_adic_congruence_iff n (f n) L).mpr
    intro i hi
    have h := (power_series_parameter_adic_congruence_iff (i + 1)
      (f (i + 1)) (f n)).mp (hf (Nat.succ_le_of_lt hi)) i (Nat.lt_succ_self i)
    simpa [L] using h.symm

theorem power_series_parameter_henselian
    (R : Type*) [CommRing R] : HenselianRing (PowerSeries R) (powerSeriesParameterIdeal R) := by
  haveI := power_series_parameter_adic_complete R
  infer_instance

end Litt3.QuotientGeometry
