import Solutions.CartierAndSpin.PBasisDerivationKernel

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {k L : Type*} [CommRing k] [Field L] [Algebra k L]
variable {p : ℕ} [Fact p.Prime] [CharP L p]

/-- The exact second-derivative kernel over a literal full p-basis.
Neither perfectness nor a separability premise is needed. -/
theorem normalized_second_derivation_zero_iff (b : PowerPBasis L p)
    (D : Derivation k L L) (ht : D b.parameter = 1) (v : L) :
    D (D v) = 0 ↔ ∃ a c : L, v = a ^ p + b.parameter * c ^ p := by
  have hpderivative (x : L) : D (x ^ p) = 0 := by
    simp only [D.leibniz_pow, nsmul_eq_mul, CharP.cast_eq_zero, zero_mul]
  constructor
  · intro hsecond
    obtain ⟨c, hc⟩ :=
      (normalized_p_basis_derivation_zero_iff_pth_power b D ht (D v)).mp hsecond
    have hzero : D (v - b.parameter * c ^ p) = 0 := by
      rw [map_sub, D.leibniz, ht, hpderivative]
      simp only [smul_eq_mul, mul_one, mul_zero, zero_add, hc, sub_self]
    obtain ⟨a, ha⟩ :=
      (normalized_p_basis_derivation_zero_iff_pth_power b D ht _).mp hzero
    refine ⟨a, c, ?_⟩
    linear_combination -ha
  · rintro ⟨a, c, rfl⟩
    have hfirst : D (a ^ p + b.parameter * c ^ p) = c ^ p := by
      rw [map_add, D.leibniz, ht, hpderivative, hpderivative]
      simp only [smul_eq_mul, mul_one, mul_zero, zero_add]
    rw [hfirst, hpderivative]

end Litt3.CartierAndSpin
