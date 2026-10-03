import Solutions.CartierAndSpin.ResidueRootCount
import Solutions.CartierAndSpin.PowerSeriesJets
import Mathlib.Algebra.Polynomial.Eval.Defs

namespace Litt3.CartierAndSpin

open Polynomial Lagrange

variable {k ι : Type*} [Field k]

theorem polynomial_map_nodal {R S : Type*} [CommRing R] [CommRing S]
    (f : R →+* S) (s : Finset ι) (node : ι → R) :
    (nodal s node).map f = nodal s (fun i => f (node i)) := by
  classical
  simp only [nodal, Polynomial.map_prod, Polynomial.map_sub, Polynomial.map_X, Polynomial.map_C]

theorem power_series_eval_residue (H : (PowerSeries k)[X]) (w : PowerSeries k)
    (hw : PowerSeries.constantCoeff w = 0) :
    PowerSeries.constantCoeff (H.eval w) = PowerSeries.constantCoeff (H.coeff 0) := by
  rw [← Polynomial.eval_map_apply, hw, ← Polynomial.coeff_zero_eq_eval_zero, Polynomial.coeff_map]

theorem power_series_pow_low_coefficient_zero (w : PowerSeries k)
    (hw : PowerSeries.constantCoeff w = 0) (p j : ℕ) (hj : j < p) :
    PowerSeries.coeff j (w ^ p) = 0 := by
  obtain ⟨v, rfl⟩ := PowerSeries.X_dvd_iff.mpr hw
  rw [mul_pow, PowerSeries.coeff_X_pow_mul', if_neg (by omega : ¬ p ≤ j)]

/-- The first endpoint source relation is derived from the actual root
equation, with no simplicity or nonzero leading jet hypothesis. -/
theorem power_series_small_root_leading_relation (H : (PowerSeries k)[X])
    (w q tau : PowerSeries k) (p m : ℕ) (hm : m < p)
    (hw : PowerSeries.constantCoeff w = 0)
    (hq : ∀ j < m, PowerSeries.coeff j q = 0)
    (hroot : (w ^ p + q) * H.eval w + tau = 0) :
    PowerSeries.coeff m q * PowerSeries.constantCoeff (H.coeff 0) +
      PowerSeries.coeff m tau = 0 := by
  have hlow : ∀ j < m, PowerSeries.coeff j (w ^ p + q) = 0 := by
    intro j hj
    rw [map_add, power_series_pow_low_coefficient_zero w hw p j (by omega), hq j hj, add_zero]
  have hmroot := congrArg (PowerSeries.coeff m) hroot
  rw [map_add, map_zero,
    power_series_leading_product_coefficient _ _ m hlow,
    map_add, power_series_pow_low_coefficient_zero w hw p m hm, zero_add,
    power_series_eval_residue H w hw] at hmroot
  exact hmroot

theorem power_series_small_root_constant_unit (H : (PowerSeries k)[X])
    (w q tau : PowerSeries k) (p m : ℕ) (hm : m < p)
    (hw : PowerSeries.constantCoeff w = 0)
    (hq : ∀ j < m, PowerSeries.coeff j q = 0)
    (htau : PowerSeries.coeff m tau ≠ 0)
    (hroot : (w ^ p + q) * H.eval w + tau = 0) :
    PowerSeries.constantCoeff (H.coeff 0) ≠ 0 := by
  have h := power_series_small_root_leading_relation H w q tau p m hm hw hq hroot
  intro hzero
  rw [hzero, mul_zero, zero_add] at h
  exact htau h

theorem power_series_source_has_small_root (s : Finset ι) (node : ι → PowerSeries k)
    (F H : (PowerSeries k)[X]) (q tau leading : PowerSeries k) (p : ℕ)
    (hp : 0 < p) (hleading : PowerSeries.constantCoeff leading ≠ 0)
    (hq : PowerSeries.constantCoeff q = 0) (htau : PowerSeries.constantCoeff tau = 0)
    (hfactor : F = C leading * nodal s node)
    (hsource : F = (X ^ p + C q) * H + C tau) :
    ∃ i ∈ s, PowerSeries.constantCoeff (node i) = 0 := by
  classical
  have heval : F.eval 0 = q * H.eval 0 + tau := by
    rw [hsource]
    simp [zero_pow (by omega : p ≠ 0)]
  have hresidue : PowerSeries.constantCoeff (F.eval 0) = 0 := by
    rw [heval, map_add, map_mul, hq, htau, zero_mul, add_zero]
  rw [hfactor, eval_mul, eval_C, eval_nodal, map_mul, map_prod] at hresidue
  have hprod : (∏ i ∈ s, PowerSeries.constantCoeff (0 - node i)) = 0 :=
    (mul_eq_zero.mp hresidue).resolve_left hleading
  obtain ⟨i, hi, hzero⟩ := Finset.prod_eq_zero_iff.mp hprod
  refine ⟨i, hi, ?_⟩
  simpa only [zero_sub, map_neg, neg_eq_zero] using hzero

/-- Small roots are counted as indices, so repeated residue roots and
repeated leading coefficients are retained. -/
theorem power_series_source_small_root_count [DecidableEq k] (s : Finset ι) (node : ι → PowerSeries k)
    (F H : (PowerSeries k)[X]) (q tau leading : PowerSeries k) (p : ℕ)
    (hleading : PowerSeries.constantCoeff leading ≠ 0)
    (hq : PowerSeries.constantCoeff q = 0) (htau : PowerSeries.constantCoeff tau = 0)
    (hH : PowerSeries.constantCoeff (H.coeff 0) ≠ 0)
    (hfactor : F = C leading * nodal s node)
    (hsource : F = (X ^ p + C q) * H + C tau) :
    (s.filter (fun i => PowerSeries.constantCoeff (node i) = 0)).card = p := by
  classical
  apply reduced_source_zero_root_count s (fun i => PowerSeries.constantCoeff (node i))
    (H.map PowerSeries.constantCoeff) p (PowerSeries.constantCoeff leading) hleading
  · simpa only [← Polynomial.coeff_zero_eq_eval_zero, Polynomial.coeff_map] using hH
  · have h := congrArg (Polynomial.map PowerSeries.constantCoeff) (hsource.symm.trans hfactor)
    simpa only [Polynomial.map_add, Polynomial.map_mul, Polynomial.map_pow,
      Polynomial.map_X, Polynomial.map_C, hq, htau, map_zero, add_zero,
      polynomial_map_nodal] using h

end Litt3.CartierAndSpin
