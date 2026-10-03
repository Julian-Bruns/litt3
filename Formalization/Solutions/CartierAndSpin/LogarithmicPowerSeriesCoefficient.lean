import Solutions.CartierAndSpin.LogarithmicLaurentCoefficient
import Mathlib.FieldTheory.IsAlgClosed.AlgebraicClosure

namespace Litt3.CartierAndSpin

variable {k : Type*} [Field k] {p : ℕ} [Fact p.Prime] [CharP k p]

/-- Actual coefficient extension commutes with the entire formal
power-series derivative, over arbitrary coefficient fields. -/
theorem power_series_derivative_coefficient_map
    {E : Type*} [Field E] (f : k →+* E) (a : PowerSeries k) :
    PowerSeries.derivative E (PowerSeries.map f a) =
      PowerSeries.map f (PowerSeries.derivative k a) := by
  ext n
  simp only [PowerSeries.coeff_derivative, PowerSeries.coeff_map, map_mul, map_add,
    map_natCast, map_one]

/-- The logarithmic obstruction identity on true power-series units,
first over perfect constants. No differential-equation solution or
Cartier converse is assumed. -/
theorem logarithmic_power_series_coefficient_frobenius_of_perfect
    [PerfectField k] (u : (PowerSeries k)ˣ) :
    PowerSeries.coeff (p - 1) (PowerSeries.derivative k (u : PowerSeries k) *
      (↑u⁻¹ : PowerSeries k)) =
    (PowerSeries.coeff 0 (PowerSeries.derivative k (u : PowerSeries k) *
      (↑u⁻¹ : PowerSeries k))) ^ p := by
  let a : LaurentSeries k := (u : PowerSeries k)
  have hinv : ((↑u⁻¹ : PowerSeries k) : LaurentSeries k) = a⁻¹ := by
    have h := congrArg (algebraMap (PowerSeries k) (LaurentSeries k)) u.mul_inv
    rw [map_mul, map_one] at h
    exact eq_inv_of_mul_eq_one_right h
  let ell := PowerSeries.derivative k (u : PowerSeries k) * (↑u⁻¹ : PowerSeries k)
  have hemb : (ell : LaurentSeries k) = a⁻¹ * laurentDerivation k a := by
    dsimp [ell, a]
    rw [PowerSeries.coe_mul, hinv, laurentDerivation_apply, laurent_derivative_powerSeries]
    ring
  have h := logarithmic_laurent_coefficient_frobenius (p := p) a
  rw [← hemb, LaurentSeries.coeff_coe_powerSeries] at h
  have hzero : (ell : LaurentSeries k).coeff 0 = PowerSeries.coeff 0 ell := by
    simpa only [Nat.cast_zero] using LaurentSeries.coeff_coe_powerSeries ell 0
  rw [hzero] at h
  exact h

/-- The same exact coefficient identity over EVERY prime-characteristic
field. A literal injective algebraic-closure coefficient extension removes
perfectness, and the coefficient equality descends injectively. -/
theorem logarithmic_power_series_coefficient_frobenius
    (u : (PowerSeries k)ˣ) :
    PowerSeries.coeff (p - 1) (PowerSeries.derivative k (u : PowerSeries k) *
      (↑u⁻¹ : PowerSeries k)) =
    (PowerSeries.coeff 0 (PowerSeries.derivative k (u : PowerSeries k) *
      (↑u⁻¹ : PowerSeries k))) ^ p := by
  let cmap : k →+* AlgebraicClosure k := algebraMap k (AlgebraicClosure k)
  letI : CharP (AlgebraicClosure k) p := charP_of_injective_algebraMap cmap.injective p
  let umap := Units.map (PowerSeries.map cmap).toMonoidHom u
  have h := logarithmic_power_series_coefficient_frobenius_of_perfect (p := p) umap
  have hell : PowerSeries.derivative (AlgebraicClosure k) (umap : PowerSeries (AlgebraicClosure k)) *
      (↑umap⁻¹ : PowerSeries (AlgebraicClosure k)) =
      PowerSeries.map cmap (PowerSeries.derivative k (u : PowerSeries k) *
        (↑u⁻¹ : PowerSeries k)) := by
    simp only [umap, Units.coe_map, ← map_inv, Units.coe_map, map_mul]
    congr 1
    exact power_series_derivative_coefficient_map cmap (u : PowerSeries k)
  rw [hell, PowerSeries.coeff_map, PowerSeries.coeff_map, ← map_pow] at h
  exact cmap.injective h

end Litt3.CartierAndSpin
