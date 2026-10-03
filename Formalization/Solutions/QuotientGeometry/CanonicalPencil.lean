import Definitions.QuotientGeometry.CanonicalPencil
import Theorems.QuotientGeometry.CanonicalPencil
import Solutions.QuotientGeometry.HomogeneousEvaluation
import Mathlib.Tactic

namespace Litt3.QuotientGeometry

/-- A homogeneous binary identity is dehomogenized by the actual
fraction B/A. This is valid in every characteristic. -/
theorem homogeneous_binary_fraction_evaluation
    {k L : Type*} [Field k] [Field L] [Algebra k L]
    (H : MvPolynomial (Fin 2) k) (n : ℕ) (hH : H.IsHomogeneous n)
    (A B : L) (hA : A ≠ 0) :
    H.eval₂ (algebraMap k L) ![A, B] =
      A ^ n * H.eval₂ (algebraMap k L) ![1, B / A] := by
  have h := homogeneous_evaluation_scaling H n hH (algebraMap k L) ![1, B / A] A
  have hcoordinates : (fun i : Fin 2 => A * (![1, B / A] : Fin 2 → L) i) = ![A, B] := by
    funext i
    fin_cases i
    · simp
    · change A * (B / A) = B
      field_simp
  rw [hcoordinates] at h
  exact h

theorem homogeneous_binary_double_cover_equation
    {k L : Type*} [Field k] [Field L] [Algebra k L]
    (H : MvPolynomial (Fin 2) k) (n : ℕ) (hH : H.IsHomogeneous (2 * n))
    (A B W : L) (hA : A ≠ 0)
    (hidentity : W ^ 2 = H.eval₂ (algebraMap k L) ![A, B]) :
    (-W / A ^ n) ^ 2 = H.eval₂ (algebraMap k L) ![1, B / A] := by
  rw [div_pow, neg_sq, ← pow_mul, Nat.mul_comm n 2]
  apply (div_eq_iff (pow_ne_zero (2 * n) hA)).mpr
  rw [hidentity, homogeneous_binary_fraction_evaluation H (2 * n) hH A B hA]
  exact mul_comm _ _

theorem canonical_pencil_derivative
    {k L : Type*} [Field k] [Field L] [Algebra k L]
    (D : Derivation k L L) (A B : L) :
    D (canonicalPencilX A B) = -canonicalPencilBracket D A B / A ^ 2 := by
  rw [canonicalPencilX, D.leibniz_div]
  simp only [canonicalPencilBracket, smul_eq_mul, div_eq_mul_inv, inv_pow]
  ring

theorem canonical_pencil_derivative_nonzero
    {k L : Type*} [Field k] [Field L] [Algebra k L]
    (D : Derivation k L L) (A B : L) (hA : A ≠ 0)
    (hbracket : canonicalPencilBracket D A B ≠ 0) :
    D (canonicalPencilX A B) ≠ 0 := by
  rw [canonical_pencil_derivative]
  exact div_ne_zero (neg_ne_zero.mpr hbracket) (pow_ne_zero 2 hA)

/-- The reconstructed x,y recover the ordered canonical differential
coefficients, not just the underlying quadratic-cover equation. -/
theorem canonical_pencil_recovers_ordered_coefficients
    {k L : Type*} [Field k] [Field L] [Algebra k L]
    (D : Derivation k L L) (A B : L) (hA : A ≠ 0)
    (hbracket : canonicalPencilBracket D A B ≠ 0) :
    D (canonicalPencilX A B) / canonicalPencilY A (canonicalPencilBracket D A B) = A ∧
      canonicalPencilX A B *
        (D (canonicalPencilX A B) / canonicalPencilY A (canonicalPencilBracket D A B)) = B := by
  have hfirst : D (canonicalPencilX A B) /
      canonicalPencilY A (canonicalPencilBracket D A B) = A := by
    rw [canonical_pencil_derivative]
    unfold canonicalPencilY
    field_simp
  refine ⟨hfirst, ?_⟩
  rw [hfirst, canonicalPencilX]
  exact div_mul_cancel₀ B hA

theorem canonical_pencil_bracket_constant_scaling
    {k L : Type*} [Field k] [Field L] [Algebra k L]
    (D : Derivation k L L) (A B c : L) (hc : D c = 0) :
    canonicalPencilBracket D (c * A) (c * B) = c ^ 2 * canonicalPencilBracket D A B := by
  simp only [canonicalPencilBracket, D.leibniz, hc, smul_eq_mul, mul_zero, zero_add]
  ring

/-- The cross terms cancel even when the multiplier is not constant. -/
theorem canonical_pencil_bracket_scaling
    {k L : Type*} [Field k] [Field L] [Algebra k L]
    (D : Derivation k L L) (A B c : L) :
    canonicalPencilBracket D (c * A) (c * B) =
      c ^ 2 * canonicalPencilBracket D A B := by
  simp only [canonicalPencilBracket, D.leibniz, smul_eq_mul]
  ring

/-- Changing the differential frame multiplies the cubic bracket by the
cube of its transition function. No assumption on the derivative of
the transition function is needed. -/
theorem canonical_pencil_bracket_frame_change
    {k L : Type*} [Field k] [Field L] [Algebra k L]
    (D : Derivation k L L) (A B c : L) :
    canonicalPencilBracket (c • D) (c * A) (c * B) =
      c ^ 3 * canonicalPencilBracket D A B := by
  simp only [canonicalPencilBracket, Derivation.smul_apply, D.leibniz, smul_eq_mul]
  ring

theorem canonical_pencil_coordinates_frame_independent
    {k L : Type*} [Field k] [Field L] [Algebra k L]
    (D : Derivation k L L) (A B c : L) (hc : c ≠ 0) :
    canonicalPencilX (c * A) (c * B) = canonicalPencilX A B ∧
      canonicalPencilY (c * A) (canonicalPencilBracket (c • D) (c * A) (c * B)) =
        canonicalPencilY A (canonicalPencilBracket D A B) := by
  rw [canonical_pencil_bracket_frame_change]
  simp only [canonicalPencilX, canonicalPencilY, mul_pow]
  constructor <;> field_simp

theorem canonical_pencil_field_reconstruction
    {k L : Type*} [Field k] [Field L] [Algebra k L]
    (D : Derivation k L L) (H : MvPolynomial (Fin 2) k)
    (hH : H.IsHomogeneous 6) (A B : L) (hA : A ≠ 0)
    (hbracket : canonicalPencilBracket D A B ≠ 0)
    (hidentity : (canonicalPencilBracket D A B) ^ 2 =
      H.eval₂ (algebraMap k L) ![A, B]) :
    let x := canonicalPencilX A B
    let y := canonicalPencilY A (canonicalPencilBracket D A B)
    y ^ 2 = H.eval₂ (algebraMap k L) ![1, x] ∧
      D x ≠ 0 ∧ D x / y = A ∧ x * (D x / y) = B := by
  dsimp only
  refine ⟨?_, canonical_pencil_derivative_nonzero D A B hA hbracket,
    canonical_pencil_recovers_ordered_coefficients D A B hA hbracket⟩
  exact homogeneous_binary_double_cover_equation H 3 hH A B
    (canonicalPencilBracket D A B) hA hidentity

theorem canonical_pencil_field_reconstruction_target :
    Targets.CanonicalPencilFieldReconstruction := by
  intro k L _ _ _ D H hH A B hA hbracket hidentity
  exact canonical_pencil_field_reconstruction D H hH A B hA hbracket hidentity

theorem canonical_pencil_scaling_preserves_identity_iff
    {k L : Type*} [Field k] [Field L] [Algebra k L]
    (D : Derivation k L L) (H : MvPolynomial (Fin 2) k)
    (hH : H.IsHomogeneous 6) (A B c : L) (hc : c ≠ 0)
    (hbracket : canonicalPencilBracket D A B ≠ 0)
    (hidentity : (canonicalPencilBracket D A B) ^ 2 =
      H.eval₂ (algebraMap k L) ![A, B]) :
    (canonicalPencilBracket D (c * A) (c * B)) ^ 2 =
      H.eval₂ (algebraMap k L) ![c * A, c * B] ↔ c ^ 2 = 1 := by
  rw [canonical_pencil_bracket_scaling, mul_pow]
  have hscale := homogeneous_evaluation_scaling H 6 hH
    (algebraMap k L) ![A, B] c
  have hcoordinates : (fun i : Fin 2 => c * (![A, B] : Fin 2 → L) i) =
      ![c * A, c * B] := by
    funext i
    fin_cases i <;> rfl
  rw [hcoordinates] at hscale
  rw [hscale, ← hidentity]
  have hW : (canonicalPencilBracket D A B) ^ 2 ≠ 0 := pow_ne_zero 2 hbracket
  constructor
  · intro h
    have hpower : (c ^ 2) ^ 2 = c ^ 6 := (mul_right_cancel₀ hW h)
    have hfactor : c ^ 6 = (c ^ 2) ^ 2 * c ^ 2 := by ring
    rw [hfactor] at hpower
    exact (mul_left_cancel₀ (pow_ne_zero 2 (pow_ne_zero 2 hc))
      (by simpa using hpower.symm))
  · intro h
    have hpower : c ^ 6 = 1 := by
      calc
        c ^ 6 = (c ^ 2) ^ 3 := by ring
        _ = 1 := by rw [h]; simp
    rw [h, hpower]
    simp

end Litt3.QuotientGeometry
