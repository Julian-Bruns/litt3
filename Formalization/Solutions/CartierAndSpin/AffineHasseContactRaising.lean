import Solutions.CartierAndSpin.AffineHasseContact

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {k L : Type*} [CommRing k] [Field L] [Algebra k L]
variable {p : ℕ} [Fact p.Prime] [CharP L p]

/-- Vanishing of the first possible nonclassical contact coefficient
forces a genuine additional Frobenius root of both affine coefficients. -/
theorem affine_frobenius_form_raises_of_hasse_zero
    (b : PowerPBasis L p) (D : Derivation k L L) (ht : D b.parameter = 1)
    (e r : ℕ) (hr : 0 < r) (he : p ^ r < p ^ e) (a c : L)
    (hzero : truncatedHasseDerivative b e (p ^ r)
      (a ^ (p ^ r) + b.parameter * c ^ (p ^ r)) = 0) :
    ∃ a' c' : L,
      a ^ (p ^ r) + b.parameter * c ^ (p ^ r) =
        a' ^ (p ^ (r + 1)) + b.parameter * c' ^ (p ^ (r + 1)) := by
  have hleading : D a ^ (p ^ r) + b.parameter * D c ^ (p ^ r) = 0 := by
    rw [← affine_frobenius_hasse_leading b D ht e r hr he a c]
    exact hzero
  have hkill (z : L) : D (z ^ (p ^ r)) = 0 := by
    rw [D.leibniz_pow, nsmul_eq_mul, Nat.cast_pow, CharP.cast_eq_zero,
      zero_pow hr.ne', zero_mul]
  have hd := congrArg D hleading
  rw [map_add, D.leibniz, hkill, hkill, ht, map_zero] at hd
  simp only [smul_eq_mul, mul_one, mul_zero, zero_add] at hd
  have hc : D c = 0 := eq_zero_of_pow_eq_zero hd
  have haPow : D a ^ (p ^ r) = 0 := by
    simpa only [hc, zero_pow (pow_ne_zero r (Fact.out : p.Prime).ne_zero),
      mul_zero, add_zero] using hleading
  have ha : D a = 0 := eq_zero_of_pow_eq_zero haPow
  obtain ⟨a', ha'⟩ :=
    (normalized_p_basis_derivation_zero_iff_pth_power b D ht a).mp ha
  obtain ⟨c', hc'⟩ :=
    (normalized_p_basis_derivation_zero_iff_pth_power b D ht c).mp hc
  refine ⟨a', c', ?_⟩
  rw [← ha', ← hc', ← pow_mul, ← pow_mul, ← pow_succ']

end Litt3.CartierAndSpin
