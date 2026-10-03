import Solutions.CartierAndSpin.TruncatedHasseFirstDerivation
import Solutions.CartierAndSpin.TruncatedHasseFrobenius
import Solutions.CartierAndSpin.TruncatedHasseParameterProduct
import Solutions.CartierAndSpin.PBasisDerivationKernel

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {L : Type*} [Field L] {p : ℕ} [Fact p.Prime] [CharP L p]

/-- The literal Frobenius affine normal form has no higher tangent
coefficient between orders two and p^r−1. -/
theorem affine_frobenius_hasse_lower_vanish (b : PowerPBasis L p) (e r j : ℕ)
    (hj : j < p ^ e) (hjlower : 2 ≤ j) (hjupper : j < p ^ r) (a c : L) :
    truncatedHasseDerivative b e j (a ^ (p ^ r) + b.parameter * c ^ (p ^ r)) = 0 := by
  have hj0 : j = (j - 1) + 1 := by omega
  rw [map_add, truncated_hasse_frobenius_power b e r j hj]
  have hnd : ¬ p ^ r ∣ j := Nat.not_dvd_of_pos_of_lt (by omega) hjupper
  rw [if_neg hnd, zero_add]
  rw [hj0, truncated_hasse_parameter_product b e (j - 1) (by omega)]
  rw [truncated_hasse_frobenius_power b e r ((j - 1) + 1) (by omega),
    truncated_hasse_frobenius_power b e r (j - 1) (by omega)]
  have hnd' : ¬ p ^ r ∣ j - 1 := Nat.not_dvd_of_pos_of_lt (by omega) (by omega)
  rw [← hj0, if_neg hnd, if_neg hnd', mul_zero, add_zero]

/-- The first possible nonclassical tangent coefficient is the actual
Frobenius power of the two derivatives in its affine normal form. -/
theorem affine_frobenius_hasse_leading
    {k : Type*} [CommRing k] [Algebra k L]
    (b : PowerPBasis L p) (D : Derivation k L L) (ht : D b.parameter = 1)
    (e r : ℕ) (hr : 0 < r) (he : p ^ r < p ^ e) (a c : L) :
    truncatedHasseDerivative b e (p ^ r)
      (a ^ (p ^ r) + b.parameter * c ^ (p ^ r)) =
        D a ^ (p ^ r) + b.parameter * D c ^ (p ^ r) := by
  have hpower : 1 < p ^ r := (Nat.one_lt_pow_iff hr.ne').mpr (Fact.out : p.Prime).one_lt
  have hepos : 0 < e := by
    by_contra h
    have he0 : e = 0 := by omega
    simp only [he0, pow_zero] at he
    omega
  have hcancel : p ^ r - 1 + 1 = p ^ r := by omega
  rw [map_add, truncated_hasse_frobenius_power b e r (p ^ r) he,
    if_pos (dvd_refl _), Nat.div_self (pow_pos (Fact.out : p.Prime).pos r)]
  rw [← hcancel, truncated_hasse_parameter_product b e (p ^ r - 1) (by omega), hcancel]
  rw [truncated_hasse_frobenius_power b e r (p ^ r) he,
    truncated_hasse_frobenius_power b e r (p ^ r - 1) (by omega),
    if_pos (dvd_refl _), Nat.div_self (pow_pos (Fact.out : p.Prime).pos r)]
  rw [if_neg (Nat.not_dvd_of_pos_of_lt (by omega) (by omega)), add_zero,
    truncated_hasse_first_eq_normalized_derivation b e hepos D ht a,
    truncated_hasse_first_eq_normalized_derivation b e hepos D ht c]

end Litt3.CartierAndSpin
