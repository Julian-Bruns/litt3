import Solutions.SharedTensors.LaurentIntrinsicCartier

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {k : Type*} [Field k] [PerfectField k]
  {p : ℕ} [Fact p.Prime] [CharP k p]

/-- The top obstruction coefficient of every actual logarithmic
Laurent derivative is the pth power of its constant coefficient. This
uses only the already proved forward Cartier logarithmic identity. -/
theorem logarithmic_laurent_coefficient_frobenius (a : LaurentSeries k) :
    (a⁻¹ * laurentDerivation k a).coeff ((p - 1 : ℕ) : ℤ) =
      ((a⁻¹ * laurentDerivation k a).coeff 0) ^ p := by
  obtain ⟨e, C, heD, hcoeff⟩ := laurent_intrinsic_cartier_exists (k := k) (p := p)
  have h := hcoeff (a⁻¹ • KaehlerDifferential.D k (LaurentSeries k) a) 0
  rw [C.fixes_logarithmic] at h
  simp only [map_smul, heD, smul_eq_mul, mul_zero, zero_add] at h
  have hpow := congrArg (frobeniusEquiv k p) h
  rw [RingEquiv.apply_symm_apply, frobeniusEquiv_def] at hpow
  exact hpow.symm

end Litt3.CartierAndSpin
