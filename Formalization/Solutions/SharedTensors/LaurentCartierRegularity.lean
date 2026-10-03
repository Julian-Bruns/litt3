import Solutions.SharedTensors.LaurentIntrinsicCartier

namespace Litt3.SharedTensors

open scoped LaurentSeries

variable {k : Type*} [Field k] [PerfectField k]
  {p : ℕ} [Fact p.Prime] [CharP k p]

noncomputable local instance : Module k (LaurentSeries k) := Algebra.toModule

/-- The actual power series prescribed by Cartier's coefficient rule. -/
noncomputable def powerSeriesCartierCoordinate (f : PowerSeries k) : PowerSeries k :=
  PowerSeries.mk fun n =>
    (frobeniusEquiv k p).symm (PowerSeries.coeff (p * n + (p - 1)) f)

/-- Exact coefficient support transport; the input may have any finite
pole and need not be a power series or a Laurent polynomial. -/
theorem intrinsic_cartier_coefficient_support
    (C : RationalCartierOperator k (LaurentSeries k) p)
    (e : KaehlerDifferential k (LaurentSeries k) ≃ₗ[LaurentSeries k] LaurentSeries k)
    (he : e (KaehlerDifferential.D k (LaurentSeries k) (laurentParameter k)) = 1)
    (omega : KaehlerDifferential k (LaurentSeries k)) (b n : ℤ)
    (hvanish : ∀ r < b, (e omega).coeff r = 0)
    (hn : (p : ℤ) * n + (p - 1 : ℕ) < b) :
    (e (C.toAddHom omega)).coeff n = 0 := by
  rw [intrinsic_cartier_laurent_coefficient C e he,
    hvanish _ hn, map_zero]

/-- Intrinsic Cartier preserves the entire regular differential
lattice represented by k[[t]] dt. -/
theorem intrinsic_cartier_power_series_coordinate
    (C : RationalCartierOperator k (LaurentSeries k) p)
    (e : KaehlerDifferential k (LaurentSeries k) ≃ₗ[LaurentSeries k] LaurentSeries k)
    (he : e (KaehlerDifferential.D k (LaurentSeries k) (laurentParameter k)) = 1)
    (f : PowerSeries k) :
    e (C.toAddHom (e.symm (f : LaurentSeries k))) =
      (powerSeriesCartierCoordinate (p := p) f : LaurentSeries k) := by
  ext n
  rw [intrinsic_cartier_laurent_coefficient C e he, e.apply_symm_apply]
  by_cases hn : n < 0
  · have hp : 1 ≤ p := (Fact.out : p.Prime).pos
    have hindex : (p : ℤ) * n + ((p - 1 : ℕ) : ℤ) < 0 := by
      have hle : n ≤ -1 := by omega
      have hmul := mul_le_mul_of_nonneg_left hle (show 0 ≤ (p : ℤ) by omega)
      rw [Int.natCast_sub hp]
      omega
    rw [PowerSeries.coeff_coe, if_pos hindex, map_zero,
      PowerSeries.coeff_coe, if_pos hn]
  · obtain ⟨m, rfl⟩ := Int.eq_ofNat_of_zero_le (show 0 ≤ n by omega)
    have hindex : (p : ℤ) * (m : ℤ) + ((p - 1 : ℕ) : ℤ) =
        ((p * m + (p - 1) : ℕ) : ℤ) := by push_cast; rfl
    rw [hindex, LaurentSeries.coeff_coe_powerSeries,
      LaurentSeries.coeff_coe_powerSeries, powerSeriesCartierCoordinate,
      PowerSeries.coeff_mk]

end Litt3.SharedTensors
