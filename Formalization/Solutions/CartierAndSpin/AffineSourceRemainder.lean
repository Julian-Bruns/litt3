import Solutions.CartierAndSpin.AffinePolynomialCoefficients
import Solutions.CartierAndSpin.AffineSourceQuotient
import Mathlib.Algebra.CharP.Lemmas

namespace Litt3.CartierAndSpin

open Polynomial

variable {K : Type*} [Field K]

/-- The actual inseparable factor transforms with weight a^p. -/
theorem affine_source_characteristic_factor (p : ℕ) [CharP K p] (hp : 2 ≤ p)
    (a b q : K) (ha : a ≠ 0) :
    (X ^ p + C (a ^ p * q - b ^ p) : K[X]) =
      C (a ^ p) * (X ^ p + C q).comp (C a⁻¹ * (X - C b)) := by
  letI : Fact p.Prime := ⟨CharP.char_is_prime_of_two_le K p hp⟩
  rw [add_comp, X_pow_comp, C_comp, mul_pow, sub_pow_char]
  rw [mul_add, ← mul_assoc, ← map_pow, ← C_mul, ← mul_pow,
    mul_inv_cancel₀ ha, one_pow, C_1, one_mul]
  simp only [map_sub, map_pow, map_mul]
  ring

/-- The actual transformed source equation retains its precise
normalization, over any positive characteristic and any scale exponent. -/
theorem affine_source_frame_presentation (p : ℕ) [CharP K p] (hp : 2 ≤ p)
    (F H : K[X]) (a b q tau : K) (N : ℕ) (ha : a ≠ 0)
    (hsource : F = (X ^ p + C q) * H + C tau) :
    affineSourceFramePolynomial F a b N =
      (X ^ p + C (a ^ p * q - b ^ p)) *
        (C (a ^ N / a ^ p) * H.comp (C a⁻¹ * (X - C b))) + C (a ^ N * tau) := by
  rw [affineSourceFramePolynomial, hsource, add_comp, mul_comp, C_comp, mul_add,
    affine_source_characteristic_factor p hp a b q ha]
  have hscale : C (a ^ p) * C (a ^ N / a ^ p) = (C (a ^ N) : K[X]) := by
    rw [← C_mul]
    congr 1
    field_simp
  rw [map_mul]
  calc
    _ = (C (a ^ p) * C (a ^ N / a ^ p)) *
        ((X ^ p + C q).comp (C a⁻¹ * (X - C b)) *
          H.comp (C a⁻¹ * (X - C b))) + C (a ^ N) * C tau := by rw [hscale]
    _ = _ := by ring

/-- Monic remainders transform by the same actual inverse affine
substitution and equation scale, including all degree drops. -/
theorem affine_source_remainder (p : ℕ) [CharP K p] (hp : 2 ≤ p)
    (H : K[X]) (a b q scale : K) (ha : a ≠ 0) :
    (C scale * H.comp (C a⁻¹ * (X - C b))) %ₘ
        (X ^ p + C (a ^ p * q - b ^ p)) =
      C scale * (H %ₘ (X ^ p + C q)).comp (C a⁻¹ * (X - C b)) := by
  let phi : K[X] := X ^ p + C q
  let coordinate : K[X] := C a⁻¹ * (X - C b)
  let remainder := C scale * (H %ₘ phi).comp coordinate
  have hmonic : phi.Monic := monic_X_pow_add_C q (by omega)
  have hmonic' : (X ^ p + C (a ^ p * q - b ^ p) : K[X]).Monic :=
    monic_X_pow_add_C (a ^ p * q - b ^ p) (by omega)
  have hfactor : C (a ^ p) * phi.comp coordinate = X ^ p + C (a ^ p * q - b ^ p) :=
    (affine_source_characteristic_factor p hp a b q ha).symm
  have hdivision : remainder + (X ^ p + C (a ^ p * q - b ^ p)) *
      (C (scale / a ^ p) * (H /ₘ phi).comp coordinate) = C scale * H.comp coordinate := by
    have h := congrArg (fun P : K[X] => C scale * P.comp coordinate)
      (modByMonic_add_div H hmonic)
    dsimp only at h
    rw [add_comp, mul_comp, mul_add] at h
    have hscale : C (a ^ p) * C (scale / a ^ p) = C scale := by
      rw [← C_mul]
      congr 1
      field_simp
    rw [← hfactor]
    change C scale * (H %ₘ phi).comp coordinate +
      (C (a ^ p) * phi.comp coordinate) *
        (C (scale / a ^ p) * (H /ₘ phi).comp coordinate) = _
    calc
      _ = C scale * (H %ₘ phi).comp coordinate +
          (C (a ^ p) * C (scale / a ^ p)) *
            (phi.comp coordinate * (H /ₘ phi).comp coordinate) := by ring
      _ = _ := by rw [hscale]; exact h
  have hphine : phi ≠ 1 := by
    intro h
    have := congrArg natDegree h
    simp only [phi, natDegree_X_pow_add_C, natDegree_one] at this
    omega
  have hsmall : (H %ₘ phi).natDegree < p := by
    simpa only [phi, natDegree_X_pow_add_C] using natDegree_modByMonic_lt H hmonic hphine
  have hlinear : coordinate.natDegree ≤ 1 := by
    dsimp only [coordinate]
    have h := natDegree_mul_le (p := C a⁻¹) (q := X - C b)
    simpa only [natDegree_C, natDegree_X_sub_C, zero_add] using h
  have hremainder : remainder.natDegree < p := by
    have hmul := natDegree_mul_le (p := C scale) (q := (H %ₘ phi).comp coordinate)
    have hcomp := natDegree_comp_le (p := H %ₘ phi) (q := coordinate)
    have hcomp' : ((H %ₘ phi).comp coordinate).natDegree ≤ (H %ₘ phi).natDegree := by
      exact hcomp.trans (by simpa using Nat.mul_le_mul_left (H %ₘ phi).natDegree hlinear)
    have hmul' : remainder.natDegree ≤ ((H %ₘ phi).comp coordinate).natDegree := by
      simpa only [remainder, natDegree_C, zero_add] using hmul
    exact hmul'.trans_lt (hcomp'.trans_lt hsmall)
  exact (div_modByMonic_unique _ remainder hmonic'
    ⟨hdivision, by
      rw [degree_X_pow_add_C (by omega : 0 < p)]
      exact degree_le_natDegree.trans_lt (WithBot.coe_lt_coe.mpr hremainder)⟩).2

/-- The canonical affine center is proved for the actual transformed
monic remainder, rather than a separately supplied coefficient tuple. -/
theorem affine_source_remainder_center (p : ℕ) [CharP K p] (hp : 2 ≤ p)
    (H : K[X]) (a b q scale : K) (ha : a ≠ 0) (hscale : scale ≠ 0)
    (hs : (H %ₘ (X ^ p + C q)).coeff (p - 1) ≠ 0) :
    ((C scale * H.comp (C a⁻¹ * (X - C b))) %ₘ
      (X ^ p + C (a ^ p * q - b ^ p))).coeff (p - 2) /
    ((C scale * H.comp (C a⁻¹ * (X - C b))) %ₘ
      (X ^ p + C (a ^ p * q - b ^ p))).coeff (p - 1) =
      a * ((H %ₘ (X ^ p + C q)).coeff (p - 2) /
        (H %ₘ (X ^ p + C q)).coeff (p - 1)) + b := by
  rw [affine_source_remainder p hp H a b q scale ha]
  apply affine_characteristic_remainder_center p hp _ _ a b scale ha hscale hs
  have hnonone : (X ^ p + C q : K[X]) ≠ 1 := by
    intro h
    have := congrArg natDegree h
    simp only [natDegree_X_pow_add_C, natDegree_one] at this
    omega
  simpa only [natDegree_X_pow_add_C] using
    natDegree_modByMonic_lt H (monic_X_pow_add_C q (by omega : p ≠ 0)) hnonone

end Litt3.CartierAndSpin
