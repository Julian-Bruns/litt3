import Solutions.SharedTensors.LaurentCartierRegularity

namespace Litt3.SharedTensors

open scoped LaurentSeries

variable {k : Type*} [Field k] [PerfectField k]
  {p : ℕ} [Fact p.Prime] [CharP k p]

noncomputable local instance : Module k (LaurentSeries k) := Algebra.toModule

/-- The actual embedded power-series Cartier coordinate satisfies the
full integer-exponent coefficient rule, including its zero negative tail. -/
theorem power_series_cartier_coordinate_laurent_coeff (f : PowerSeries k) (n : ℤ) :
    (powerSeriesCartierCoordinate (p := p) f : LaurentSeries k).coeff n =
      (frobeniusEquiv k p).symm
        ((f : LaurentSeries k).coeff ((p : ℤ) * n + (p - 1 : ℕ))) := by
  obtain ⟨e, C, hD, hformula⟩ := laurent_intrinsic_cartier_exists (k := k) (p := p)
  have he : e (KaehlerDifferential.D k (LaurentSeries k) (laurentParameter k)) = 1 :=
    (hD _).trans laurent_derivation_parameter
  have hregular := intrinsic_cartier_power_series_coordinate C e he f
  have hf := hformula (e.symm (f : LaurentSeries k)) n
  rw [hregular, e.apply_symm_apply] at hf
  exact hf

end Litt3.SharedTensors
